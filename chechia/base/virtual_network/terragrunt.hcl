terraform {
  source = "../../..//modules/virtual_network"
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../security_group"
}

inputs = {
  virtual_network_space = ["10.0.0.0/16"]
  subnets = {
    base-external = {
      name                      = "base-external"
      address_prefixes          = ["10.0.2.0/24"]
      network_security_group_id = dependency.sg.outputs.security_group_id
      #network_security_group_id = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/base/providers/Microsoft.Network/networkSecurityGroups/chechia-home"
    },
    bastion-subnet = {
      name                      = "AzureBastionSubnet"
      address_prefixes          = ["10.0.3.0/24"]
      network_security_group_id = dependency.sg.outputs.security_group_id
      #network_security_group_id = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/base/providers/Microsoft.Network/networkSecurityGroups/chechia-home"
    }
  }
  private_dns_zones = {
    private-blob = {
      name = "privatelink.blob.core.windows.net"
    }
  }
}
