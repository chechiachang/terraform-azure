terraform {
  source = "../../..//modules/storage_blob"
  # source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/storage_blob?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name = "chia"
  storage_account_name = "7d65a5b0ed66f589127c6f07"
}
