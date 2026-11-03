# environments/dev/main.tf – og environments/prod/main.tf skal være IDENTISK
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

//Navne metode
locals {
  name_prefix = "${var.kortnavn}-${var.project}"
}

//Oppretter Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}

//Kaller på Stack for metoder og ressurser.
module "stack" {
  source              = "../../stacks"
  project             = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

output "resource_group_name" {  #Bør kanskje legges i en egen Outputs fil
  value = azurerm_resource_group.main.name
}

output "subnet_id" {  #Bør kanskje legges i en egen Outputs fil
  value = module.stack.subnet_id
}