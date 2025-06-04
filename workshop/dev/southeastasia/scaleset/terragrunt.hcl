terraform {
  source = "../../../..//modules/linux_virtual_machine_scale_set"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/linux_scale_set?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

dependency "virtual_network" {
  config_path = "../virtual_network"
}

dependency "blob" {
  config_path = "../blob"
}

dependency "sg" {
  config_path = "../security_group"
}

inputs = {
  environment = "dev"
  location    = "southeastasia"

  name                      = "workshop"
  security_gruop_name       = dependency.sg.outputs.resource.resource_group_name
  network_security_group_id = dependency.sg.outputs.resource.id

  # az vm list-skus --location southeastasia --size Standard_B --all --output table
  #sku = "Standard_B1ms" # 1cpu 2GiB memory $0.0207/hr
  #sku = "Standard_B2ms" # 2cpu 8GiB memory $0.0832/hr
  sku = "Standard_B4ms" # 4cpu 16GiB memory $0.1660/hr 60 nodes
  #sku = "Standard_B8ms" # 8cpu 32GiB memory $0.3330/hr
  instances = 0
  #instances = 60

  network = dependency.virtual_network.outputs.resource.name
  subnet  = "Workshop"

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
    "10.0.2.0/24"
  ]

  os_disk_size_gb = 30

  # cloud config

  storage_account_name   = "workshoptfstate31539"
  storage_container_name = dependency.blob.outputs.storage_container_name
  storage_container_fqdn = dependency.blob.outputs.storage_account_private_endpoint_fqdn

  cloudconfig_file = "../../templates/cloud_config/2025-workshop.yaml"
}
