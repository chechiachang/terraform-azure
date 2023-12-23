data "vault_policy_document" "main" {
  rule {
    path         = "/${var.path}/*"
    capabilities = var.permissions
    description  = "allow kv ${var.path} to be accessed"
  }
}

resource "vault_policy" "main" {
  name = var.name
  # Allow input overwrite
  policy = (var.policy == "") ? data.vault_policy_document.main.hcl : var.policy
}
