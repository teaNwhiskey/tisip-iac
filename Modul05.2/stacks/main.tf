module "network" {
  source              = "../modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "random_password" "demo" {
  length  = 24
  special = true
}