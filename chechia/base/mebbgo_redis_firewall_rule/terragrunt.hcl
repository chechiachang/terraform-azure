terraform {
  source = "../../..//modules/redis_firewall_rule"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/redis_firewall_rule?ref=v0.1.3"
}

include {
  path = find_in_parent_folders()  
}

dependency "redis" {
  config_path = "../mebbgo_redis"
}

dependency "vm" {
  config_path = "../mebbgo_bh"
}

locals {
  common      = yamldecode(file("${find_in_parent_folders("locals/common.yaml")}"))
}

inputs = {
  redis_cache_name = dependency.redis.outputs.name
  firewall_rules = {
    allow-mebbgo-bh = {
      name     = "allow_mebbgo_bh"
      start_ip = dependency.vm.outputs.public_ip_address
      end_ip   = dependency.vm.outputs.public_ip_address
    }
  }
}
