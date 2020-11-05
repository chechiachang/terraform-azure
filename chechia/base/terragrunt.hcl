# state to use existing resources in foundation
remote_state {
  backend = "azurerm"

  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name = "base"
    storage_account_name = "baseec31eee5"
    container_name = "base"
  }
}

# inputs to manage foundation module
inputs = {
}

terraform {
  extra_arguments "env" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = [
      "${get_parent_terragrunt_dir()}/env.tfvars",
    ]
  }
}
