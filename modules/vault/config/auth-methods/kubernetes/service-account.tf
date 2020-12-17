# Kubernetes provider
provider "kubernetes" {
  version = "1.11.1"

  load_config_file       = "false"
  host                   = local.kubernetes_host
  cluster_ca_certificate = local.kubernetes_cluster_ca
  client_certificate     = local.kubernetes_client_ca
  client_key             = local.kubernetes_client_key
}

# Kubernetes service account
resource "kubernetes_service_account" "vault_auth" {
  metadata {
    name      = "vault-auth"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "vault_auth" {
  metadata {
    name      = "vault-auth"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "vault-auth"
    namespace = "kube-system"
  }
}

# Kubernetes service account secret
data "kubernetes_secret" "vault_auth" {
  metadata {
    name = kubernetes_service_account.vault_auth.default_secret_name
    namespace = "kube-system"
  }
}