resource "azurerm_redis_firewall_rule" "rule" {
  for_each            = var.firewall_rules
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  redis_cache_name    = var.redis_cache_name
  start_ip            = each.value["start_ip"]
  end_ip              = each.value["end_ip"]
}
