terraform {
  source = "../../../..//modules/virtual_network"
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../security_group"
}

inputs = {
  name = "ntuchorus"
  virtual_network_space = ["10.1.0.0/16"]
  subnets = {
    ntuchorus-external = {
      name                      = "ntuchorus-external"
      address_prefixes          = ["10.1.2.0/24"]
      network_security_group_id = dependency.sg.outputs.security_group_id
      #network_security_group_id = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/base/providers/Microsoft.Network/networkSecurityGroups/chechia-home"
    }
  }
  private_dns_zones = {
    ntuchorus-blob = {
      name = "ntuchorus.blob.core.windows.net"
    }
  }
}
