resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = var.scale_set_name
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
      name      = "internal"
      primary   = true
      subnet_id = var.subnet
    }
  }

  tags = {
    environment = var.environment
  }
}
