terraform {
  source = "../../../modules//security_group"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name = "chechia-home"
  rules = {
    port22 = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "22"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Port_22"
      priority                                   = 100
      protocol                                   = "*"
      source_address_prefix                      = "123.194.159.122"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    }
  }
}
