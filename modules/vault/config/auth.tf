module "auth-kubernetes" {
  source = "./auth-methods/kubernetes"

  kubeconfig_file_path = var.kubeconfig_file_path
}
