terraform {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-virtualnetwork.git//?ref=v0.8.1"
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../security_group"
}

inputs = {
  environment = "dev"
  location    = "southeastasia"

  name             = "workshop"
  address_space    = ["10.0.0.0/16"]
  enable_telemetry = false

  subnets = {
    workshop = {
      name                      = "Workshop"
      address_prefixes          = ["10.0.2.0/24"]
      network_security_group_id = dependency.sg.outputs.resource.id
      default_outbound_access_enabled = true
    },
    bastion-subnet = {
      name                      = "AzureBastionSubnet"
      address_prefixes          = ["10.0.3.0/24"]
      network_security_group_id = dependency.sg.outputs.resource.id
    }
  }

  #private_dns_zones = {
  #  private-blob = {
  #    name = "privatelink.blob.core.windows.net"
  #  }
  #}
}
