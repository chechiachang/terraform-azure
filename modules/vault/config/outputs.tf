output "azure_application_id" {
  value = module.azuread.azure_application_id
}

output "azure_application_application_id" {
  value = module.azuread.azure_application_application_id
}

output "azure_application_password" {
  value     = module.azuread.azure_application_password
  sensitive = true
}
