resource "azurerm_network_security_group" "main" {
  count = var.security_gruop_name == "" ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "ssh" {
  count = length(var.allowed_ssh_cidr_blocks)

  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH${count.index}"
  network_security_group_name = var.security_gruop_name != "" ? var.security_gruop_name : azurerm_network_security_group.main[0].name
  priority                    = 1000
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = element(var.allowed_ssh_cidr_blocks, count.index)
  source_port_range           = "*"
}

