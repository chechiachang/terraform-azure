resource "vault_auth_backend" "main" {
  type = "approle"
  path = var.approle_path
}
