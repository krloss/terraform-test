output "certs_map" {
  value = {
      "root" = tls_self_signed_cert.get_root_cert.cert_pem
      "ca" = module.get_locally_signed_cert.cert_pem
  }
}

output "keys_map" {
  value = module.get_private_keys.keys_map
  sensitive = true
}
