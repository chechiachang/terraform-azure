terraform {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-resources-resourcegroup.git//?ref=0.2.1"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  name             = "workshop"
  location         = "southeastasia" # where the metadata is stored
  enable_telemetry = false
}
