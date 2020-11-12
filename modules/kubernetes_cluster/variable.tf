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
  default = "Standard_D2_v2" # 2 cpu 8Gi memory
}

variable "default_node_pool_count" {
  type    = number
  default = 1
}

# Cluster::node_pool

variable "node_pools" {
  type    = map
  default = {}
}

variable "spot_node_pools" {
  type    = map
  default = {}
}

# Cluster::log

variable "log_enabled" {
  type = bool
  description = "Enavle log analytics"
  default = false
}

variable "log_analytics_workspace_sku" {
  type    = string
  default = "PerGB2018"
}
