terraform {
  source = "../../..//modules/redis_cache"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/redis_cahce?ref=v0.1.3"
}

include {
  path = find_in_parent_folders()  
}

locals {
  common      = yamldecode(file("${find_in_parent_folders("locals/common.yaml")}"))
}

inputs = {
  name      = "mebbgo"
  sku_name  = "Standard"
  family    = "C"
  capacity  =  0
  enable_non_ssl_port = true
}
