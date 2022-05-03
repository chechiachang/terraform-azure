data "azurerm_storage_account" "main" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "template_file" "cloudconfig" {
  template = file(var.cloudconfig_file)
  vars = {
    account_name   = var.storage_account_name
    account_key    = data.azurerm_storage_account.main.primary_access_key
    container_name = var.storage_container_name
    container_fqdn = var.storage_container_fqdn
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloudconfig.rendered
  }
}
