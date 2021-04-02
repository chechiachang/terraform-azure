terraform {
  # source = "../../../modules/linux_virtual_machine"
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_virtual_machine?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_machine_name = "mebbgo-bh"
  network = "base-network"
  subnet = "base-external"
  use_public_ip = true
  size = "Standard_D1_v2"
  #priority = "Spot"
  network_security_group_id = "chechia-home"
}
