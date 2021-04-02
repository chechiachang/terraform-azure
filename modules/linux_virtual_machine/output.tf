output "public_ip_id" {
  value = azurerm_public_ip.main[0].id
}

output "public_ip_address" {
  value = azurerm_public_ip.main[0].ip_address
}

output "network_interface_id" {
  value = azurerm_network_interface.main.id
}

output "id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "name" {
  value = azurerm_linux_virtual_machine.main.name
}
