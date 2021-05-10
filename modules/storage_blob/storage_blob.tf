resource "azurerm_storage_container" "main" {
  name                  = var.name
  storage_account_name   = var.storage_account_name
  container_access_type = "private"
}

#resource "azurerm_storage_blob" "main" {
#  name                   = var.name
#  storage_account_name   = var.storage_account_name
#  storage_container_name = azurerm_storage_container.main.name
#  type                   = var.type
#  blob_source            = var.blob_source
#}
