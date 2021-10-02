resource "tls_cert_request" "get_request" {
  key_algorithm = var.key_algorithm
  private_key_pem = var.private_key_pem

  subject {
    common_name = var.subject.common_name
    organization = var.subject.organization
  }
}

resource "tls_locally_signed_cert" "get_cert" {
  allowed_uses = var.allowed_uses
  is_ca_certificate = var.is_ca

  ca_cert_pem = var.ca_cert_pem
  ca_private_key_pem = var.ca_private_key_pem
  ca_key_algorithm = var.key_algorithm
  validity_period_hours = 24 * var.validity_days

  cert_request_pem = tls_cert_request.get_request.cert_request_pem
}
