terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.50.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "openquestion-tfstate"
    storage_account_name = "openquestiontfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
