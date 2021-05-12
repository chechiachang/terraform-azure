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
}
