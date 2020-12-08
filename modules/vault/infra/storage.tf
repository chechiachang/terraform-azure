resource "azurerm_storage_container" "vault_storage" {
  name                  = var.storage_container_name
  resource_group_name   = var.resource_group_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}
