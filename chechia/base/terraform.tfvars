terragrunt = {
  terraform {
    extra_arguments "env" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      arguments = [
      ]
      required_var_files = [
        "${get_parent_tfvars_dir()}/env.tfvars",
      ]
    }
  }
}
