terraform {
  backend "local" {
    workspace_dir = "../states/mitm-certs"
  }

  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "~> 3.1.0"
    }
  }
}

provider "tls" { }

data "terraform_remote_state" "get_ca_certs" {
  backend = "local"

  config = {
    path = "../states/ca-certs/${terraform.workspace}/terraform.tfstate"
  }
}

data "tls_certificate" "get_subjects" {
  count = length(var.url_list)

  url = "https://${var.url_list[count.index]}"
  
  depends_on = [data.terraform_remote_state.get_ca_certs]
}
locals {
  subjects_map = {for i,v in data.tls_certificate.get_subjects: var.url_list[i] => v.certificates[*].subject}
  ca_certs_out = data.terraform_remote_state.get_ca_certs.outputs
}

module "get_private_keys" {
  source = "../modules/private-keys-map"

  ids_list = var.url_list

  depends_on = [data.terraform_remote_state.get_ca_certs]
}

module "get_locally_signed_cert" {
  source = "../modules/locally-signed-cert-request"

  for_each = local.subjects_map

  private_key_pem = module.get_private_keys.keys_map[each.key]
  
  ca_private_key_pem = local.ca_certs_out.keys_map[var.issuer]
  ca_cert_pem = local.ca_certs_out.certs_map[var.issuer]
  
  subject = {
    organization = each.key
    common_name = replace(each.value[length(each.value) - 1],"/.*CN=([^,]+).*/","$1")
  }
}
