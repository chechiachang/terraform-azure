output "id" {
  value = azurerm_redis_cache.main.id
}

output "name" {
  value = azurerm_redis_cache.main.name
}

output "hostname" {
  value = azurerm_redis_cache.main.hostname
}

output "port" {
  value = azurerm_redis_cache.main.port
}

output "primary_connection_string" {
  value = azurerm_redis_cache.main.primary_connection_string
  sensitive = true
}
