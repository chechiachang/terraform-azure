resource "azurerm_public_ip" "main" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  public_ip_address_allocation = "static"
  domain_name_label            = var.cluster_name
}

resource "azurerm_lb" "main" {
  name                = "${var.cluster_name}_access"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.name
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_nat_pool" "main" {
  resource_group_name            = var.resource_group_name
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port_start            = 2200
  frontend_port_end              = 2299
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "main" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.main.id
  name                = var.name
  port                = var.api_port
}

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.main.id
  name                = var.name
}

resource "azurerm_lb_rule" "main" {
  resource_group_name            = var.resource_group_name
  name                           = var.name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = var.api_port
  backend_port                   = var.api_port
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.main.id
  probe_id                       = azurerm_lb_probe.main.id
}

