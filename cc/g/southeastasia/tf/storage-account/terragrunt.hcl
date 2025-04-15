terraform {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount.git//?ref=v0.5.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name     = "tfstate3153986756286"
  location = "southeastasia"

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  # https://developer.hashicorp.com/terraform/language/backend/azurerm
  public_network_access_enabled = true
  shared_access_key_enabled     = true
  network_rules = {
    default_action = "Deny"
    ip_rules = [
      "59.125.102.45", # office
    ]
    virtual_network_subnet_ids = []
  }

  containers = {
    tfstate = {
      name        = "tfstate"
      access_type = "private"
    }
  }

  enable_telemetry = false
}
