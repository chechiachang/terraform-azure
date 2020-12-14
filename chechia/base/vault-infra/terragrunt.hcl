terraform {
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/vault/infra?ref=v0.1.0"
  source = "/Users/che-chia/workspace/terraform-azure//modules/vault/infra"
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
