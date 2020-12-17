output "azure_application_id" {
  value = azuread_application.main.id
}

output "azure_application_application_id" {
  value = azuread_application.main.application_id
}

output "azure_application_password" {
  value     = random_string.password.result
  sensitive = true
}
