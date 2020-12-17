data "vault_policy_document" "main" {
  rule {
    path         = "/database/creds/${var.name}-*"
    capabilities = ["read"]
    description  = "allow ${var.name} to get dynamic db credentials"
  }
}
