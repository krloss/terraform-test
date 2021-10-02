output "ca_certs_list" {
  value = values(local.ca_certs_out.certs_map)
}

output "certs_map" {
  value = {for k,v in module.get_locally_signed_cert: k => v.cert_pem}
}

output "keys_map" {
  value = module.get_private_keys.keys_map
  sensitive = true
}

output "subjects_map" {
  value = local.subjects_map
}
