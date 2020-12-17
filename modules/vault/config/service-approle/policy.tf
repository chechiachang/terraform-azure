# A policy to use/auth as/access approle
module "admin_policy" {
  source = "../policy/default"

  name        = "${var.approle_role_name}_admin"
  path        = "auth/approle/role/${var.approle_role_name}/*"
  description = "Allow update with auth method approle at path: auth/approle/role/${var.approle_role_name}/*"
  permissions = [ "read", "update", "create" ]
}
