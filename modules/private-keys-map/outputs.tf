output "keys_map" {
  value = {for i,v in tls_private_key.keys_map: var.ids_list[i] => v.private_key_pem}
  sensitive = true
}
