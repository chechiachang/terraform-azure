# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/transit_secret_backend_key
resource "vault_transit_secret_backend_key" "key" {
  backend = var.transit_backend_path
  name    = var.transit_backend_key_name
  type    = var.transit_backend_key_type
}
