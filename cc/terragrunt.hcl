# state to use existing resources in foundation
remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    resource_group_name  = "cc"
    storage_account_name = "tfstate3153986756286"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
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

#generate "backend" {
#  path      = "backend.tf"
#  if_exists = "overwrite"
#  contents  = <<EOF
#terraform {
#  backend "azurerm" {
#    resource_group_name  = "cc"
#    storage_account_name = "tfstate3153986756286"
#    container_name       = "tfstate"
#    key                  = "${path_relative_to_include()}/terraform.tfstate"
#  }
#}
#EOF
#}

# Indicate what region to deploy the resources into
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "subscription_id" {
  type = string
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
EOF
}
