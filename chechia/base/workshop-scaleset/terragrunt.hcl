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
  config_path = "../workshop-blob"
}

inputs = {
  name = "workshop"

  # az vm list-skus --location southeastasia --size Standard_B --all --output table
  #sku       = "Standard_B1s" # 1cpu 1GiB memory $0.3212/d
  sku = "Standard_B2s" # 2cpu 4GiB memory $0.3212/d
  #sku       = "Standard_B4ms" # 4cpu 16GiB memory $0.3212/d
  instances = 0
  #instances = 45

  network = dependency.virtual_network.outputs.virtual_network_name
  subnet  = "base-external"

  priority = "Regular"

  # https://documentation.ubuntu.com/azure/en/latest/azure-how-to/instances/find-ubuntu-images/
  source_image_publisher = "canonical"
  source_image_offer     = "ubuntu-24_04-lts"
  source_image_sku       = "server"

  admin_username                  = "workshop"
  admin_password                  = "workshop1234!"
  disable_password_authentication = false
  ssh_key_file_path               = "~/.ssh/workshop.pub"
  allowed_ssh_cidr_blocks = [
    "10.0.3.0/24"
  ]

  os_disk_size_gb = 30

  # cloud config

  storage_account_name   = dependency.foundation.outputs.storage_account_name
  storage_container_name = dependency.blob.outputs.storage_container_name
  storage_container_fqdn = dependency.blob.outputs.storage_account_private_endpoint_fqdn

  cloudconfig_file = "../../templates/cloud_config/2025-workshop.yaml"
}
