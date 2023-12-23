resource "azurerm_postgresql_virtual_network_rule" "rule" {
  for_each                             = var.virtual_network_rules
  name                                 = each.value["name"]
  resource_group_name                  = var.resource_group_name
  server_name                          = azurerm_postgresql_server.main.name
  subnet_id                            = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value["network"]}/subnets/${each.value["subnet"]}"
  ignore_missing_vnet_service_endpoint = true
}
