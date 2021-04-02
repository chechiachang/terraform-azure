resource "azurerm_mysql_server" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                     = var.sku_name
  storage_mb                   = var.storage_mb
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = var.auto_grow_enabled

  administrator_login          = var.administrator_login
  administrator_login_password = random_string.password-admin.result
  version                      = "5.7"

  #public_network_access_enabled    = false
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
}

resource "azurerm_mysql_database" "db" {
  for_each            = var.databases
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.main.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
