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

locals {
  common_tags = {
    owner      = var.kortnavn
    course     = "iac"
    module     = "modul7"
    managed_by = "pipeline"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${var.kortnavn}-${var.project}-rg"
  location = var.location
}

module "network" {
  source = "git::https://github.com/teaNwhiskey/tisip-iac.git//modules/network?ref=network-v1.1.0"

  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}
