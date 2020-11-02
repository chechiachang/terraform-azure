variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

# Cluster

variable "kubernetes_cluster_name" {
  type = string
}

# Cluster::default_node_pool

variable "default_node_pool_vm_size" {
  type    = string
  default = "Standard_D1ls"
}

variable "node_pools" {
  type = map
}

variable "spot_node_pools" {
  type    = map
  default = {}
}

# Cluster::log

variable "log_analytics_workspace_sku" {
  type = string
  default = "PerGB2018"
}
