output "cert_pem" {
  value = tls_locally_signed_cert.get_cert.cert_pem
}
