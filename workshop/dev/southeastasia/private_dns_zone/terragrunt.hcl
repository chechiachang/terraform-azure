terraform {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-privatednszone.git//?ref=v0.3.3"
}

include {
  path = find_in_parent_folders()
}

dependency "virtual_network" {
  config_path = "../virtual_network"
}

inputs = {
  environment = "dev"
  location    = "southeastasia"

  name = "workshop"
  #storage_account_name = "workshoptfstate31539"
  #subnet_id             = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/workshop/providers/Microsoft.Network/virtualNetworks/${dependency.virtual_network.outputs.resource.name}/subnets/Workshop"

  domain_name = "privatelink.blob.core.windows.net"

  enable_telemetry = false
}
