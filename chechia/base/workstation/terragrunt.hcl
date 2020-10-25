terraform {
  source = "../../../modules//virtual_machine"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_machine_name = "workstation"
  subnet_id = "/subscriptions/700b89a2-ac00-4b9c-8f04-5fb265598c2e/resourceGroups/base/providers/Microsoft.Network/virtualNetworks/base-network/subnets/general-purpose"
  use_public_ip = true
  vm_size = "Standard_B1ls" # $0.1984/hr
}
