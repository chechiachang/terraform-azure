module "chechia" {
  source = "./service_k8s"

  service_name        = "chechia"
  k8s_namespace       = "chechia"
  k8s_service_account = "chechia"
  k8s_auth_path       = module.auth_kubernetes.path # Depends on module.auth_kubernetes
  enable_kv           = true
}
