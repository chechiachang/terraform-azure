resource "azurerm_network_security_group" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "main" {
  for_each                     = var.rules
  name                         = each.value.name
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix        = each.value.source_address_prefix
  #source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefix   = each.value.destination_address_prefix
  #destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = var.name

  depends_on = [azurerm_network_security_group.main]
}
