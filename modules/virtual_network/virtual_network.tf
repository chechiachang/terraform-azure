resource "azurerm_virtual_network" "main" {
  name                = var.name == "" ? "${var.environment}-network" : var.name
  address_space       = var.virtual_network_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "internal" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value.address_prefixes
}
