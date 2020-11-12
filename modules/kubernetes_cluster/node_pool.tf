resource "azurerm_kubernetes_cluster_node_pool" "main" {
  for_each              = var.node_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  priority              = each.value.priority
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints

  depends_on = [
    azurerm_kubernetes_cluster.main
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  for_each              = var.spot_node_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  priority              = each.value.priority
  eviction_policy       = each.value.eviction_policy
  spot_max_price        = each.value.spot_max_price
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints

  depends_on = [
    azurerm_kubernetes_cluster.main
  ]
}

