resource "azurerm_mysql_virtual_network_rule" "rule" {
  for_each = var.virtual_network_rules
  name                                 = each.value["name"]
  resource_group_name                  = var.resource_group_name
  server_name                          = azurerm_mysql_server.main.name
  subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value["network"]}/subnets/${each.value["subnet"]}"
}
