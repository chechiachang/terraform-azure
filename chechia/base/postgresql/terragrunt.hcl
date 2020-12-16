terraform {
  source = "../../../modules/postgresql"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name                  = "chechia-general"
  administrator_login   = "chechia"
  sku_name              = "GP_Gen5_2"
  storage_mb            = 5120
  auto_grow_enabled     = false

  databases = {
    vault = {
      name = "vault"
    }
  }
  virtual_network_rules = {
    vault = {
      name = "vault"
      network = "base-network"
      subnet = "base-external"
    }
  }
}
