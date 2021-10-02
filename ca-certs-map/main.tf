terraform {
  backend "local" {
    workspace_dir = "../states/ca-certs"
  }

  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "~> 3.1.0"
    }
  }
}

provider "tls" { }

module "get_private_keys" {
  source = "../modules/private-keys-map"

  ids_list = var.ids_list
}

resource "tls_self_signed_cert" "get_root_cert" {
  is_ca_certificate = true
  key_algorithm = var.key_algorithm
  allowed_uses = var.allowed_uses
  validity_period_hours = 24 * var.validity_days

  private_key_pem = module.get_private_keys.keys_map["root"]

  subject {
    common_name = var.issuers["root"].common_name
    organization = var.issuers["root"].organization
  }
}

module "get_locally_signed_cert" {
  source = "../modules/locally-signed-cert-request"

  is_ca = true
  validity_days = var.validity_days - 1
  key_algorithm = var.key_algorithm
  allowed_uses = var.allowed_uses
  
  subject = var.issuers["ca"]
  private_key_pem = module.get_private_keys.keys_map["ca"]
  
  ca_private_key_pem = module.get_private_keys.keys_map["root"]
  ca_cert_pem = tls_self_signed_cert.get_root_cert.cert_pem
}
