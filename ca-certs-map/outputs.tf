output "keys_map" {
  value = module.get_private_keys.keys_map
  sensitive = true
}
