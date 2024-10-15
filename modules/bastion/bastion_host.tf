data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_bastion_host" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                 = "publicIpConfiguration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = var.ip_allocation_method
  sku                 = var.ip_sku
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "ip_sku" {
  type    = string
  default = "Standard"
}
