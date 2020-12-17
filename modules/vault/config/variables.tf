variable "name" {
  type = string
}

# auth azure

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

# auth kubernetes

variable "kubeconfig_file_path" {
  type = string
}
