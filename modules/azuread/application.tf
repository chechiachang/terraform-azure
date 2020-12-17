# Create an application
resource "azuread_application" "main" {
  name = var.name

  homepage                   = "http://chechia.net"
  identifier_uris            = ["http://chechia.net"]
  reply_urls                 = ["http://127.0.0.1:8200"] # vault azure auth method
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false

  #oauth2_permissions {
  #  admin_consent_description  = "Allow the application to access vault on behalf of the signed-in user."
  #  admin_consent_display_name = "Access vault"
  #  id                         = "db33a8a9-e288-46e5-b872-77a4eccd2b71"
  #  is_enabled                 = true
  #  type                       = "User"
  #  user_consent_description   = "Allow the application to access vault on your behalf."
  #  user_consent_display_name  = "Access vault"
  #  value                      = "user_impersonation"
  #}

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "19dbc75e-c2e2-444c-a770-ec69d8559fc7"
      type = "Role"
    }
    resource_access {
      id   = "1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9"
      type = "Role"
    }
  }
}

resource "random_string" "password" {
  length  = 32
  special = false
}

resource "azuread_application_password" "main" {
  application_object_id = azuread_application.main.id
  #description           = "My managed password"
  value                 = random_string.password.result
  end_date              = "2099-01-01T01:02:03Z"
}

# Create a service principal
resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id

  app_role_assignment_required = false

  tags = [
    "apiConsumer",
    "webApp",
  ]

  #oauth2_permissions {
  #  admin_consent_description  = "Allow the application to access vault on behalf of the signed-in user."
  #  admin_consent_display_name = "Access vault"
  #  id                         = "db33a8a9-e288-46e5-b872-77a4eccd2b71"
  #  is_enabled                 = true
  #  type                       = "User"
  #  user_consent_description   = "Allow the application to access vault on your behalf."
  #  user_consent_display_name  = "Access vault"
  #  value                      = "user_impersonation"
  #}
}
