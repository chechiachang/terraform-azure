terraform {
  source = "../../../modules/linux_virtual_machine"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_machine_name = "algo-vpn"
  network = "base-network"
  subnet = "base-external"
  use_public_ip = true
  size = "Standard_D2_v2"
}
