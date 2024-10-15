terraform {
  source = "../../..//modules/bastion"
}

include {
  path = find_in_parent_folders()
}

dependency "virtual_network" {
  config_path = "../virtual_network"
}

inputs = {
  resource_group_name = "base"

  name                   = "workshop-bastion"
  network                = dependency.virtual_network.outputs.virtual_network_name
  subnet                 = "AzureBastionSubnet"
  sku                    = "Standard"
  shareable_link_enabled = true
}
