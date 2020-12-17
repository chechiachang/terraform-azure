resource "vault_auth_backend" "main" {
  type = "azure"
  path = var.path
}

resource "vault_azure_auth_backend_config" "main" {
  backend       = vault_auth_backend.main.path
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
  resource      = "https://vault.hashicorp.com"
}
