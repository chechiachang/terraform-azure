resource "vault_mount" "main" {
  count = var.enable ? 1 : 0
  path  = var.name
  type  = "generic"
  description = "key value secrets for ${var.name}"
}