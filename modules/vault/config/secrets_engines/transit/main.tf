# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/transit_secret_backend_key
resource "vault_mount" "transit" {
  path                      = var.transit_backend_path
  type                      = "transit"
  description               = "Transit backend"
}
