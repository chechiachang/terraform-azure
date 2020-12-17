data "local_file" "kubeconfig" {
  filename = var.kubeconfig_file_path
}

locals {
  kubernetes_name       = yamldecode(data.local_file.kubeconfig.content)["clusters"][0]["name"]
  kubernetes_host       = yamldecode(data.local_file.kubeconfig.content)["clusters"][0]["cluster"]["server"]
  kubernetes_cluster_ca = base64decode(yamldecode(data.local_file.kubeconfig.content)["clusters"][0]["cluster"]["certificate-authority-data"])
  kubernetes_client_ca  = base64decode(yamldecode(data.local_file.kubeconfig.content)["users"][0]["user"]["client-certificate-data"])
  kubernetes_client_key = base64decode(yamldecode(data.local_file.kubeconfig.content)["users"][0]["user"]["client-key-data"])
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  path = "${local.kubernetes_name}-k8s"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend            = vault_auth_backend.kubernetes.path
  kubernetes_host    = local.kubernetes_host
  kubernetes_ca_cert = data.kubernetes_secret.vault_auth.data["ca.crt"]
  token_reviewer_jwt = data.kubernetes_secret.vault_auth.data["token"]
}
