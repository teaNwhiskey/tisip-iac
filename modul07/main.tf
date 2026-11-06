terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {} # tom – fylles ved init
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.kortnavn}-${var.project}-rg"
  location = var.location
}

module "network" {
  source              = "./modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}