module "auth_kubernetes" {
  source = "./auth_methods/kubernetes"

  kubeconfig_file_path = var.kubeconfig_file_path
}
