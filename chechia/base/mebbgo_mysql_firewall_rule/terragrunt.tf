terraform {
  backend "azurerm" {}
  #required_version = "~> 0.13.5"

  required_providers {
    azurerm = {
      version = "~> 2.37.0"
    }
  }
}
