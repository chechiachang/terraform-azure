resource "vault_azure_auth_backend_role" "main" {
  backend                = var.path
  role                   = var.role
  bound_subscription_ids = var.bound_subscription_ids
  bound_resource_groups  = var.bound_resource_groups
  token_ttl              = var.token_ttl
  token_max_ttl          = var.token_max_ttl
  token_policies         = var.token_policies
}
