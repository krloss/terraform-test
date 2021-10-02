resource "tls_private_key" "keys_map" {
  count = length(var.ids_list)

  algorithm = var.key_algorithm
  rsa_bits = var.rsa_bits
}
