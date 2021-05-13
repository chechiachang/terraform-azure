output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "virtual_network_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_names" {
  value = toset([
    for subnet in azurerm_subnet.internal : subnet.name
  ])
}

output "subnet_ids" {
  value = toset([
    for subnet in azurerm_subnet.internal : subnet.id
  ])
}
