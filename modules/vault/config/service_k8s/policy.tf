module "kv_policy" {
  source = "../policy/kv"

  name        = local.k8s_service_account
  path        = local.kv_secret_path
  permissions = var.kv_permissions
  policy      = var.kv_policy
}
