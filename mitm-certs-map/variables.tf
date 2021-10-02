variable "issuer" {
  type = string
  default = "ca"

  validation {
    condition = contains(["root","ca"],var.issuer)
    error_message = "Issuer Incorret."
  }
}

variable "url_list" {
  type = list(string)
  default = ["google.com"]
}
