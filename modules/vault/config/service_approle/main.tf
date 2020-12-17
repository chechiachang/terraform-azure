# Service-approle is
# - an kv secret engine
# and a approle that binds
# - the kv path
# - a role
# - a policy

module "kv" {
  source  = "../secrets_engines/kv"
  enable  = true
  name    = var.approle_role_name
}

# kv policy for approle role to bind
module "kv_policy" {
  source = "../policy/kv"
  
  name        = var.approle_role_name
  path        = var.kv_secret_path
  permissions = var.kv_permissions
  policy      = var.kv_policy
}

# An approle backend role bind to a new kv (and policy) with the same name
resource "vault_approle_auth_backend_role" "main" {
  backend        = var.auth_approle_path
  role_name      = var.approle_role_name
  token_policies = [var.approle_role_name]
}

