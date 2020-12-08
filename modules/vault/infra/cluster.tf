resource "azurerm_virtual_machine_scale_set" "vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  upgrade_policy_mode = "Manual"

  sku {
    name     = var.instance_size
    tier     = var.instance_tier
    capacity = var.cluster_size
  }

  os_profile {
    computer_name_prefix = var.name
    admin_username       = var.username

    #This password is unimportant as it is disabled below in the os_profile_linux_config
    admin_password = "Passwword1234"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vault_admin_user_name}/.ssh/authorized_keys"
      key_data = var.key_data
    }
  }

  network_profile {
    name    = "VaultNetworkProfile"
    primary = true

    ip_configuration {
      name                                   = "VaultIPConfiguration"
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
      load_balancer_inbound_nat_rules_ids    = [element(azurerm_lb_nat_pool.main.*.id, count.index)]
    }
  }

  storage_profile_image_reference {
    id = var.image_id
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    os_type           = "Linux"
    managed_disk_type = "Standard_LRS"
  }

  tags {
    scaleSetName = var.name
  }
}
