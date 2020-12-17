# Create an application
resource "azuread_application" "main" {
  name = var.name

  #required_resource_access {
  #  resource_app_id = "00000003-0000-0000-c000-000000000000"

  #  resource_access {
  #    id   = "..."
  #    type = "Role"
  #  }

  #  resource_access {
  #    id   = "..."
  #    type = "Scope"
  #  }

  #  resource_access {
  #    id   = "..."
  #    type = "Scope"
  #  }
  #}
}

# Create a service principal
resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
}
