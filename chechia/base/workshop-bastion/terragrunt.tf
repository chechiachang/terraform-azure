terraform {
  backend "azurerm" {}
  #required_version = "~> 1.9.0"

  required_providers {
    azurerm = "~> 4.1.0"
  }
}

