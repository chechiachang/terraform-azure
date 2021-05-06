resource "azurerm_managed_disk" "data" {
  count                = length(var.data_disks)

  name                 = "${var.virtual_machine_name}-${var.data_disks[count.index].name}"
  location             = var.location
  create_option        = "Empty"
  disk_size_gb         = var.data_disks[count.index].size
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disks[count.index].storage_account_type
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  count              = length(var.data_disks)

  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  lun                = count.index
  caching            = "None"
}
