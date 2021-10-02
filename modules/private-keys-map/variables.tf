variable "ids_list" {
  type = list(string)
}

variable "key_algorithm" {
  type = string
  default = "RSA"
}

variable "rsa_bits" {
  type = number
  default = 2048
}
