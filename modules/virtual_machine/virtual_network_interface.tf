resource "azurerm_network_interface" "main" {
  name                = "${var.virtual_machine_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.virtual_machine_name}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}
