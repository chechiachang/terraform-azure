terraform {
  source = "../../../..//modules/key_vault_certificate"
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git//modules/kubernetes_cluster?ref=v0.1.2"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = yamldecode(file("${find_in_parent_folders("locals/common.yaml")}"))
}

inputs = {
  # key vault
  certificate_name    = "general-chechia-net"
  location            = local.common.location
  resource_group_name = local.common.resource_group_name

  # certificate
  subject_alternative_dns_names = ["grafana.chechia.net", "loki.chechia.net"]
  subject                       = "CN=chechia-net"
  validity_in_months            = 12
}
