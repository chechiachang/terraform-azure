terraform {
  source = "../../..//modules/security_group"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/security_group?ref=v0.1.2"
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
      source_address_prefix                      = "59.125.102.45"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    }
    maicoinport22 = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "22"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "Maicoin_Port_22"
      priority                                   = 100
      protocol                                   = "*"
      source_address_prefix                      = ""
      source_address_prefixes = [
        "118.169.75.176",
        "118.169.87.240"
      ]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      source_port_ranges                    = []
    }
    maicoinport22 = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      destination_port_ranges                    = ["22", "3389"]
      direction                                  = "Inbound"
      name                                       = "nsg-rule-allow-ssh-rdp"
      priority                                   = 250
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    }
  }
}
