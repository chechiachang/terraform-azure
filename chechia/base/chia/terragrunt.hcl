terraform {
  source = "../../..//modules/linux_virtual_machine"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_virtual_machine?ref=v0.1.2"
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
  virtual_machine_name = "chia"
  network = dependency.virtual_network.outputs.virtual_network_name
  subnet = "base-external"
  use_public_ip = true

  size          = "Standard_L8s_v2"

  priority = "Regular"
  max_bid_price = "0.16" # > 0.15708

  network_security_group_id = "chechia-home"

  source_image_publisher = "canonical"
  source_image_offer = "0001-com-ubuntu-server-focal"
  source_image_sku = "20_04-lts-gen2"

  ssh_key_file_path = "~/.ssh/chia.pub"

  #data_disks = [
  #  {
  #    name                 = "chia-blob-tmp"
  #    size                 = 200   # >108.9 GB
  #    storage_account_type = "Standard_LRS"
  #  },
  #]

  cloudconfig_file = "../../templates/cloud_config/l8sv2-farmer.yaml"

  # Chia

  storage_account_name = dependency.foundation.outputs.storage_account_name
  storage_container_name = dependency.blob.outputs.storage_container_name
  storage_container_fqdn = dependency.blob.outputs.storage_account_private_endpoint_fqdn
}
