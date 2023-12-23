terraform {
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/vault/config?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "vault"

  tenant_id = "5dc1c3ed-d350-4c3b-ba3d-db5ac4bfe072"

  kubeconfig_file_path = "/Users/che-chia/.kube/azure-aks"
}
