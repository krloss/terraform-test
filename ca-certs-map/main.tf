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
