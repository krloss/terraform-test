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
