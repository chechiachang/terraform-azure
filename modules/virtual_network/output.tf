output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "subnet_names" {
  value = toset([
    for subnet in azurerm_subnet.internal : subnet.name
  ])
}
