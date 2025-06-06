# state to use existing resources in foundation
remote_state {
  backend = "azurerm"

  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "base"
    storage_account_name = "7d65a5b0ed66f589127c6f07"
    container_name       = "base"
  }
}

# inputs to manage foundation module
inputs = {
  subscription_id = "${get_env("SUBSCRIPTION_ID")}"
}

terraform {
  extra_arguments "env" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = [
      "${get_parent_terragrunt_dir()}/env.tfvars",
    ]
  }
}

# Indicate what region to deploy the resources into
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
  #variable "subscription_id" {
  #  type = string
  #}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
EOF
}
