locals {
  k8s_service_account = (var.k8s_service_account == "") ? "${var.k8s_namespace}-${var.service_name}" : var.k8s_service_account
  kv_secret_path      = (var.kv_secret_path == "") ? "${var.k8s_namespace}/${var.service_name}" : var.kv_secret_path
}