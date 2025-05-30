terraform {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-networksecuritygroup.git//?ref=v0.4.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "dev"
  location    = "southeastasia"

  name = "workshop"

  security_rules = {
    # Inbound rules
    bastion-in = {
      access                     = "Allow"
      description                = ""
      destination_address_prefix = "*"
      #destination_address_prefixes               = ["*"]
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["443"]
      direction                                  = "Inbound"
      name                                       = "bastion-in"
      priority                                   = 100
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      #source_address_prefixes                    = ["*"]
      source_application_security_group_ids = []
      source_port_range                     = "*"
      #source_port_ranges                         = ["*"]
    }
    bastion-control-plane = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "VirtualNetwork"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["8080", "5701"]
      direction                                  = "Inbound"
      name                                       = "bastion-control-plane"
      priority                                   = 110
      protocol                                   = "*"
      source_address_prefix                      = "VirtualNetwork"
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    # Outbound rules
    bastion-out-vm = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "VirtualNetwork"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["22", "3389"]
      direction                                  = "Outbound"
      name                                       = "bastion-out-vm"
      priority                                   = 100
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    bastion-out-data-plane = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "VirtualNetwork"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["8080", "5701"]
      direction                                  = "Outbound"
      name                                       = "bastion-out-data-plane"
      priority                                   = 110
      protocol                                   = "Tcp"
      source_address_prefix                      = "VirtualNetwork"
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    bastion-out-cloud = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "AzureCloud"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["443"]
      direction                                  = "Outbound"
      name                                       = "bastion-out-cloud"
      priority                                   = 130
      protocol                                   = "*"
      source_address_prefix                      = "*"
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
    bastion-out-internet = {
      access                                     = "Allow"
      description                                = ""
      destination_address_prefix                 = "Internet"
      destination_application_security_group_ids = []
      destination_port_ranges                    = ["80"]
      direction                                  = "Outbound"
      name                                       = "bastion-out-internet"
      priority                                   = 140
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_application_security_group_ids      = []
      source_port_range                          = "*"
    }
  }
}
