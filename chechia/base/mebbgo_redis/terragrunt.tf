terraform {
  backend "azurerm" {}
  #required_version = "~> 0.13.5"

  required_providers {
    azurerm = "~> 2.97.0"
  }
}
