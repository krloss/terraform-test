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
}
