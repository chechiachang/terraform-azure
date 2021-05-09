terraform {
  source = "../../..//modules/linux_virtual_machine"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_virtual_machine?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  virtual_machine_name = "chia"
  network = "base-network"
  subnet = "base-external"
  use_public_ip = true
  size = "Standard_D2s_v4"
  #priority = "Spot"
  network_security_group_id = "chechia-home"

  source_image_publisher = "canonical"
  source_image_offer = "0001-com-ubuntu-server-focal"
  source_image_sku = "20_04-lts-gen2"

  # https://github.com/Chia-Network/chia-blockchain/wiki/k-sizes#storage-requirements
  data_disks = [
    {
      name                 = "k32"
      size                 = 2000   # >108.9 GB
      storage_account_type = "Standard_LRS"
    },
  ]
  tmp_disks = {
    name                 = "tmp"
    number               = 3
    size                 = 128
    storage_account_type = "Premium_LRS"
  }
}
