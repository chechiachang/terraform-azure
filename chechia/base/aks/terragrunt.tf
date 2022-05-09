terraform {
  backend "azurerm" {}
  required_version = "~> 1.0.1"

  required_providers {
    azurerm = "~> 3.5.0"
  }
}

