terraform {
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/vault/config?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name = "chechia-home-vault"
  network = "base-network"
  subnet = "base-external"
  allowed_ssh_cidr_blocks = [
  ]
}
