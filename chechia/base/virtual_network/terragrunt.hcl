terraform {
  source = "../../../modules//virtual_network"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_network_space= ["10.0.0.0/16"]
  subnets = {
    general-purpose = {
      name              = "general-purpose"
      address_prefixes  = ["10.0.2.0/24"]
    }
  }
}
