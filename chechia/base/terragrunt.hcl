locals {
  environment = "base"
  location = "southeastasia"
  storage_account_name = "baseec31eee5" # env(random hex)
  storage_container_name = "base"
}

###

# state to use existing resources in foundation
remote_state {
  backend = "azurerm"

  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name = local.environment
    storage_account_name = local.storage_account_name
    container_name = local.storage_container_name
  }
}

# inputs to manage foundation module
inputs = {
  environment = local.environment
  location = local.location
  resource_group_name = local.environment
  storage_account_name = local.storage_account_name
  storage_container_name = local.storage_container_name
}

terraform {
  extra_arguments "env" {
    commands = get_terraform_commands_that_need_vars()
  }
}
