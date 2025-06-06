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
    disk_size_gb         = var.os_disk_size_gb
    # diff_disk_settings {}
  }

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_key_file_path)
  }

  # Spot instance
  priority        = var.priority
  max_bid_price   = var.priority == "Spot" ? var.max_bid_price : null
  eviction_policy = var.priority == "Spot" ? "Deallocate" : null

  network_interface {
    name    = "main"
    primary = true
    #network_security_group_id = var.network_security_group_id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.network}/subnets/${var.subnet}"

      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
      load_balancer_inbound_nat_rules_ids    = var.load_balancer_inbound_nat_rules_ids
    }
  }

  custom_data = data.template_cloudinit_config.config.rendered

  tags = {
    environment = var.environment
  }
}
