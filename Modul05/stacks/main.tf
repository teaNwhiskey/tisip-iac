terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

//Resource group med kortnavn og prosjekt som navn
resource "azurerm_resource_group" "main" {
  name = "${var.kortnavn}-${var.project}-rg"
  location = var.location
}

//Hente nettverks modul fra modules
module "network" {
  source              = "../modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}