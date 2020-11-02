terraform {
  source = "../../../modules//kubernetes_cluster"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  kubernetes_cluster_name = "general"
  default_node_pool_vm_size = "Standard_D2_v2"
  node_pools = {
    general = {
      name = "base"
      vm_size = "Standard_D2_v2"
      node_count = 1
      priority = "Regular"

      # Spot
      # priority = "Spot"
      # eviction_policy = "Delete"
      # spot_max_price = 0.5

      node_labels = {
        "kubernetes.azure.com/scalesetpriority" = "spot"
      }
      node_taints = [
      #  "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
      ]
    }
  }
  spot_node_pools = {}
}
