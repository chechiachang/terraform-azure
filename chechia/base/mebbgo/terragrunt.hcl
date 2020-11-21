terraform {
  source = "../../../modules//linux_virtual_machine"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_machine_name = "mebbgo"
  network = "base-network"
  subnet = "base-external"
  use_public_ip = true
  size = "Standard_D1_v2"
  #priority = "Spot"
  network_security_group_id = "chechia-home"
}
