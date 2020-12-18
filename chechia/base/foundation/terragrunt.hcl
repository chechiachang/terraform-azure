terraform {
  # source = "../../../modules/foundation"
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/foundation?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  # terraform backend
  storage_container_name = "base"
  storage_account_name = "7d65a5b0ed66f589127c6f07"
}
