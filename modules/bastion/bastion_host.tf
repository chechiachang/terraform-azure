data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_bastion_host" "main" {
  name                   = var.name
  location               = data.azurerm_resource_group.main.location
  resource_group_name    = data.azurerm_resource_group.main.name
  sku                    = var.sku
  shareable_link_enabled = var.shareable_link_enabled

  ip_configuration {
    name                 = "publicIpConfiguration"
    subnet_id            = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.network}/subnets/${var.subnet}"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = var.ip_allocation_method
  sku                 = var.ip_sku
}
