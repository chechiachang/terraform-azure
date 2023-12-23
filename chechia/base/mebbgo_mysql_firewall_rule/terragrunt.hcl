terraform {
  source = "../../..//modules/mysql_firewall_rule"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/mysql_firewall_rule?ref=v0.1.3"
}

include {
  path = find_in_parent_folders()
}

dependency "mysql" {
  config_path = "../mebbgo_mysql"
}

dependency "vm" {
  config_path = "../mebbgo"
}

locals {
  common = yamldecode(file("${find_in_parent_folders("locals/common.yaml")}"))
}

inputs = {
  mysql_server_name = dependency.mysql.outputs.name
  firewall_rules = {
    allow-mebbgo-bh = {
      name             = "allow-${dependency.vm.outputs.name}"
      start_ip_address = dependency.vm.outputs.public_ip_address
      end_ip_address   = dependency.vm.outputs.public_ip_address
    }
  }
}
