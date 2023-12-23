resource "azurerm_private_dns_zone" "main" {
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = var.resource_group_name
}
