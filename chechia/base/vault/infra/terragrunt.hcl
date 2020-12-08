terraform {
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git/modules//vault/infra?ref=v0.1.0"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  cluster_name = "chechia-home-vault"
}
