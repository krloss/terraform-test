output "ca_certs_list" {
  value = values(data.terraform_remote_state.get_ca_certs.outputs.certs_map)
}
