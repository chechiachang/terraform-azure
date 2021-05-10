resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

#data "azurerm_client_config" "current" {}

#resource "azurerm_key_vault" "main" {
#  name                = var.storage_account_name
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  tenant_id           = data.azurerm_client_config.current.tenant_id
#  sku_name            = "standard"
#
#  purge_protection_enabled = true
#}

#resource "azurerm_key_vault_access_policy" "storage" {
#  key_vault_id = azurerm_key_vault.main.id
#  tenant_id    = data.azurerm_client_config.current.tenant_id
#  object_id    = azurerm_storage_account.main.identity.0.principal_id
#
#  key_permissions    = ["get", "create", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
#  secret_permissions = ["get"]
#}

#resource "azurerm_key_vault_access_policy" "client" {
#  key_vault_id = azurerm_key_vault.main.id
#  tenant_id    = data.azurerm_client_config.current.tenant_id
#  object_id    = data.azurerm_client_config.current.object_id
#
#  key_permissions    = ["get", "create", "delete", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
#  secret_permissions = ["get"]
#}

#resource "azurerm_storage_account_customer_managed_key" "main" {
#  storage_account_id = azurerm_storage_account.main.id
#  key_vault_id       = azurerm_key_vault.main.id
#  key_name           = azurerm_key_vault_key.main.name
#}

#resource "azurerm_key_vault_key" "main" {
#  name         = var.storage_container_name
#  key_vault_id = azurerm_key_vault.main.id
#  key_type     = "RSA"
#  key_size     = 2048
#  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
#
#  depends_on = [
#    azurerm_key_vault_access_policy.client,
#    #azurerm_key_vault_access_policy.storage,
#  ]
#}

resource "azurerm_storage_container" "main" {
  name                  = var.storage_container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}
