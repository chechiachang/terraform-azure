terraform {
  source = "../../../..//modules/linux_virtual_machine"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_virtual_machine?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

dependency "foundation" {
  config_path = find_in_parent_folders("base/foundation")
}

dependency "virtual_network" {
  config_path = find_in_parent_folders("ntuchorus/virtual_network")
}

dependency "security_group" {
  config_path = find_in_parent_folders("ntuchorus/security_group")
  #config_path = find_in_parent_folders("base/security_group")
}

inputs = {
  virtual_machine_name = "ntuchorus-wordpress-prod"
  network              = dependency.virtual_network.outputs.virtual_network_name
  subnet               = dependency.virtual_network.outputs.subnet_names[0]
  use_public_ip        = true
  size                 = "Standard_B2ls_v2" # 2 cpu 4gb memory $59.7140/month
  #priority = "Spot"
  network_security_group_id = dependency.security_group.outputs.security_group_id

  source_image_offer = "0001-com-ubuntu-server-jammy"
  source_image_sku   = "22_04-lts-gen2"

  enable_cloudconfig_file = false
  cloudconfig_file        = ".../../../..//templates/cloud_config/wordpress.yaml"

  storage_account_name = dependency.foundation.outputs.storage_account_name
}
