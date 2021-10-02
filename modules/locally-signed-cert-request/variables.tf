variable "allowed_uses" {
  type = list(string)
  default = ["key_encipherment","digital_signature","server_auth"]
}

variable "ca_cert_pem" {
  type = string
}

variable "ca_private_key_pem" {
  type = string
}

variable "is_ca" {
  type = bool
  default = false
}

variable "key_algorithm" {
  type = string
  default = "RSA"
}

variable "private_key_pem" {
  type = string
}

variable "subject" {
  type = object({
   common_name = string
   organization = string
  })
}

variable "validity_days" {
  type = number
  default = 390
}
