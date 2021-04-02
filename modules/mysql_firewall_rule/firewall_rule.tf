resource "azurerm_mysql_firewall_rule" "rule" {
  for_each            = var.firewall_rules
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = each.value["start_ip_address"] 
  end_ip_address      = each.value["end_ip_address"] 
}
