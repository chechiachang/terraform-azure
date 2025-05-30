terraform {
  source = "../../../..//modules/storage_blob"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/storage_blob?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

dependency "virtual_network" {
  config_path = "../virtual_network"
}

dependency "private_dns_zone" {
  config_path = "../private_dns_zone/"
}

inputs = {
  environment = "dev"
  location    = "southeastasia"

  name                 = "workshop"
  storage_account_name = "workshoptfstate31539"

  subnet_id = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/workshop/providers/Microsoft.Network/virtualNetworks/${dependency.virtual_network.outputs.resource.name}/subnets/Workshop"

  private_dns_zone_name = dependency.private_dns_zone.outputs.resource.name
}
