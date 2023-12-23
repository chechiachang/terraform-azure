terraform {
  source = "../../..//modules/mysql"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/mysql?ref=v0.1.3"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = yamldecode(file("${find_in_parent_folders("locals/common.yaml")}"))
}

inputs = {
  name                             = "mebbgo"
  administrator_login              = "chechia"
  sku_name                         = "B_Gen5_1"
  storage_mb                       = 5120
  auto_grow_enabled                = false
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  databases = {
    bbgo = {
      name = "bbgo"
    }
  }
  #virtual_network_rules = {
  #  allow-base-external = {
  #    name = "allow-base-external"
  #    network = "base-network"
  #    subnet = "base-external"
  #  }
  #}
}
