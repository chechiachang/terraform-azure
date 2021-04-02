resource "azurerm_redis_cache" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  minimum_tls_version = var.ssl_minimal_tls_version
  enable_non_ssl_port = var.enable_non_ssl_port

  redis_configuration {
  }
}
