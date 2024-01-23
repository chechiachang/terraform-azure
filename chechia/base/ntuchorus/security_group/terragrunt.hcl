terraform {
  source = "../../../..//modules/security_group"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/security_group?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "ntuchorus-wordpress"
  rules = {
    chechia = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["22", "80", "443"]
      direction                                  = "Inbound"
      name                                       = "Chechia"
      priority                                   = 100
      protocol                                   = "*"
      source_address_prefixes                    = ["59.125.102.45/32"]
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    zen_home = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["22", "80", "443"]
      direction                                  = "Inbound"
      name                                       = "Zen_home"
      priority                                   = 110
      protocol                                   = "*"
      source_address_prefixes                    = ["123.194.157.6/32"]
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    chechia_tmp = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["22", "80", "443"]
      direction                                  = "Inbound"
      name                                       = "Chechia_tmp"
      priority                                   = 130
      protocol                                   = "*"
      source_address_prefixes                    = ["111.125.132.182/32"] # TPE free
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    public_80_443 = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["80", "443"]
      direction                                  = "Inbound"
      name                                       = "Public_80_443"
      priority                                   = 200
      protocol                                   = "*"
      source_address_prefixes                    = ["0.0.0.0/0"]
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
  }
}
