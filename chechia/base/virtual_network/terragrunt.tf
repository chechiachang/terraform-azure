terraform {
  backend "azurerm" {}
  required_version = "> 1.4.0"

  required_providers {
    azurerm = ">= 3.85.0"
  }
}

