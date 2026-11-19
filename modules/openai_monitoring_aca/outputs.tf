output "container_app_environment_id" {
  value = azurerm_container_app_environment.this.id
}

output "container_app_id" {
  value = azurerm_container_app.this.id
}

output "container_app_fqdn" {
  value = azurerm_container_app.this.latest_revision_fqdn
}

output "scrape_config_yaml" {
  value = local.scrape_config_yaml
}
