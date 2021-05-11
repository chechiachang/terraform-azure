data "azurerm_storage_account" "main" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

locals {
  custom_data = <<EOL

  sudo mkdir -p /chia/tmp
  echo -e "n\np\n1\n\n\nw" | sudo fdisk /dev/nvme0n1
  sudo mkfs.ext4 /dev/nvme0n1p1
  echo "/dev/nvme0n1p1 /chia/tmp ext4" | tee -a /etc/fstab
  sudo mount /chia/tmp
  sudo chown chechia:chechia /chia/tmp

  wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && sudo dpkg -i packages-microsoft-prod.deb \
    && sudo apt-get update \
    && sudo apt-get upgrade -y \
    && sudo apt-get install -y blobfuse git \
    && sudo mkdir /mnt/resource/blobfusetmp -p \
    && sudo chown chechia /mnt/resource/blobfusetmp

  echo "accountName ${var.storage_account_name}" | tee -a /home/chechia/fuse_connection.cfg
  echo "accountKey ${data.azurerm_storage_account.main.primary_access_key}" | tee -a /home/chechia/fuse_connection.cfg
  echo "containerName ${var.storage_container_name}" | tee -a /home/chechia/fuse_connection.cfg
  chmod 600 fuse_connection.cfg

  mkdir -p /chia/final
  sudo blobfuse /chia/final \
    --tmp-path=/mnt/resource/blobfusetmp \
    --config-file=/home/chechia/fuse_connection.cfg \
    -o attr_timeout=240 \
    -o entry_timeout=240 \
    -o negative_timeout=120
  sudo chown chechia:chechia /chia/final

  git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules \
    && cd chia-blockchain \
    && sh install.sh

  # Start farmer
  EOL
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  instances           = var.instances

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    #disk_size_gb = var.disk_size_gb
    # diff_disk_settings {}
  }

  admin_username                  = var.username
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_key_file_path)
  }

  # Spot instance
  priority        = var.priority
  max_bid_price   = var.priority == "Spot" ? var.max_bid_price : null
  eviction_policy = var.priority == "Spot" ? "Deallocate" : null

  network_interface {
    name    = "main"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.network}/subnets/${var.subnet}"

      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
      load_balancer_inbound_nat_rules_ids    = var.load_balancer_inbound_nat_rules_ids
    }
  }

  #custom_data = base64encode(local.custom_data)
  custom_data = data.template_cloudinit_config.config.rendered

  tags = {
    environment = var.environment
  }
}
