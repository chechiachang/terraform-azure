module "auth_azure" {
  source = "./auth_methods/azure"

  tenant_id     = var.tenant_id
  client_id     = module.azuread.azure_application_application_id
  client_secret = module.azuread.azure_application_password
}

module "auth_azure_chechia" {
  source = "./auth_methods/azure/role"

  role = "chechia"
  bound_subscription_ids = [
    var.subscription_id
  ]
  bound_resource_groups = []
  token_policies = [
    "chechia"
  ]
}
