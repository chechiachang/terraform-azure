terraform {
  source = "../../..//modules/storage_blob"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/storage_blob?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

dependency "foundation" {
  config_path = "../foundation"
}

inputs = {
  name = "chia"
  storage_account_name = dependency.foundation.outputs.storage_account_name

  subnet_id = "/subscriptions/6fce7237-7e8e-4053-8e7d-ecf8a7c392ce/resourceGroups/base/providers/Microsoft.Network/virtualNetworks/base-network/subnets/base-external"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
}
