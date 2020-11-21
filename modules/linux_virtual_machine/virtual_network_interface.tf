resource "azurerm_public_ip" "main" {
  count                   = var.use_public_ip ? 1 : 0
  name                    = "${var.virtual_machine_name}-nic"
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = var.public_ip_address_allocation
  idle_timeout_in_minutes = 30

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.virtual_machine_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.virtual_machine_name}-nic"
    subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.network}/subnets/${var.subnet}"
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = var.use_public_ip ? azurerm_public_ip.main[0].id : null
  }

  depends_on = [
    azurerm_public_ip.main[0]
  ]
}
