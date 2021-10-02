variable "allowed_uses" {
  type = list(string)
  default = ["key_encipherment","digital_signature","server_auth"]
}

variable "ids_list" {
  type = list(string)
  default = ["root","ca"]
}

variable "key_algorithm" {
  type = string
  default = "RSA"
}

variable "issuers" {
  type = map(object({
    common_name = string
    organization = string
  }))

  default = {
    "root" = {
      common_name = "root.cs.br"
      organization = "Root"
    }
    "ca" = {
      common_name = "ca.cs.br"
      organization = "CA"
    }
  }
}

variable "validity_days" {
  type = number
  default = 400
}
