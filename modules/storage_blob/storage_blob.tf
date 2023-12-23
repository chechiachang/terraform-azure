data "azurerm_private_dns_zone" "main" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "main" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_container" "main" {
  name                  = var.name
  storage_account_name  = data.azurerm_storage_account.main.name
  container_access_type = "private"
}

# https://github.com/andrewCluey/terraform-azurerm-storage-account/blob/master/main.tf#L30
resource "azurerm_private_endpoint" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.name
    is_manual_connection           = false
    private_connection_resource_id = data.azurerm_storage_account.main.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.main.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.main.id]
  }

  tags = {
    environment = var.environment
  }
}
