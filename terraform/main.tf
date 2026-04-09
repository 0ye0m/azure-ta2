terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateom12345"   # keep as is (already created)
    container_name       = "tfstate"
    key                  = "shruti-terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
}

# Random for unique storage name
resource "random_id" "rand" {
  byte_length = 4
}

# Resource Group (Shruti)
resource "azurerm_resource_group" "demo" {
  name     = "shruti-ta2-rg"
  location = "East Asia"
}

# Storage Account (Shruti)
resource "azurerm_storage_account" "demo_sa" {
  name                     = "shrutitf${random_id.rand.hex}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
