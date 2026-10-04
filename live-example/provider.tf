terraform {
  required_version = "1.16.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  backend "azurerm" {
    storage_account_name = "tfstatedevi854"
    container_name       = "tfstate"
    key                  = "platform-dev.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}

  storage_use_azuread = true
}
