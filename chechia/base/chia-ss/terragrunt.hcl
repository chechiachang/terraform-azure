terraform {
  source = "../../..//modules/linux_virtual_machine_scale_set"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_scale_set?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

dependency "foundation" {
  config_path = "../foundation"
}

dependency "virtual_network" {
  config_path = "../virtual_network"
}

dependency "blob" {
  config_path = "../chia-blob"
}

inputs = {
  name = "chia"

  sku       = "Standard_L8s_v2"
  instances = 1

  network = dependency.virtual_network.outputs.virtual_network_name
  subnet = "base-external"

  priority = "Spot"
  max_bid_price = "0.16" # > 0.15708

  source_image_publisher = "canonical"
  source_image_offer = "0001-com-ubuntu-server-focal"
  source_image_sku = "20_04-lts-gen2"

  ssh_key_file_path = "~/.ssh/chia.pub"
  allowed_ssh_cidr_blocks = [
    "10.0.2.0/24"
  ]

  # https://github.com/Chia-Network/chia-blockchain/wiki/k-sizes#storage-requirements
  #data_disks = [
  #  {
  #    name                 = "k32"
  #    size                 = 2000   # >108.9 GB
  #    storage_account_type = "Standard_LRS"
  #  },
  #]

  cloudconfig_file = "../../templates/cloud_config/l8sv2.yaml"

  # Chia

  storage_account_name = dependency.foundation.outputs.storage_account_name
  storage_container_name = dependency.blob.outputs.storage_container_name
}
