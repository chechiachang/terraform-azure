terraform {
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/vault/infra?ref=v0.1.0"
  source = "/Users/che-chia/workspace/terraform-azure//modules/vault/infra"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name = "chechia-home-vault"
  subnet = "base-external"
  storage_account_name = "7d65a5b0ed66f589127c6f07"
  storage_container_name = "base"
  allowed_ssh_cidr_blocks = [
  ]
}
