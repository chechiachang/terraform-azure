terraform {
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/vault/config?ref=v0.1.0"
  source = "/Users/che-chia/workspace/terraform-azure//modules/vault/config"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  name = "vault"
  
  kubeconfig_file_path = "/Users/che-chia/.kube/azure-aks"
}
