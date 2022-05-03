terraform {
  source = "../../..//modules/kubernetes_cluster"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/kubernetes_cluster?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  kubernetes_cluster_name   = "general"
  default_node_pool_vm_size = "Standard_D2_v2"
  default_node_pool_count   = 1

  network = "base-network"
  subnet  = "base-external"

  kubeconfig_output_path = "/Users/che-chia/.kube/azure-aks"

  # Additional node pool

  #node_pools = {
  #  ondemand = {
  #    name       = "spot"
  #    vm_size    = "Standard_D2_v2"
  #    node_count = 1
  #    mode       = "System"
  #  }
  #}

  #spot_node_pools = {
  #  spot = {
  #    name       = "spot"
  #    vm_size    = "Standard_D2_v2"
  #    node_count = 1
  #    mode       = "System"

  #    # Spot
  #    priority = "Spot"
  #    eviction_policy = "Delete"
  #    spot_max_price = -1 # Default on-demand price

  #    node_labels = {
  #      "kubernetes.azure.com/scalesetpriority" = "spot"
  #    }
  #    node_taints = [
  #    #  "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  #    ]
  #  }
  #}
}
