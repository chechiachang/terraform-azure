resource "vault_kubernetes_auth_backend_role" "main" {
  backend                          = var.k8s_auth_path
  role_name                        = local.k8s_service_account
  bound_service_account_names      = [var.k8s_service_account]
  bound_service_account_namespaces = [var.k8s_namespace]
  token_ttl                        = 3600
  token_policies                   = ["default", module.kv_policy.name]
}