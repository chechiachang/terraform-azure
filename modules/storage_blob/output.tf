output "storage_container_name" {
  value = azurerm_storage_container.main.name
}

#output "storage_blob_name" {
#  value = acurerm_storage_blob.main.name
#}

output "storage_account_private_endpoint_fqdn" {
  value = azurerm_private_endpoint.main.private_dns_zone_configs[0].record_sets[0].fqdn
}
