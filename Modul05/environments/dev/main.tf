//Hente moduler fra stack
module "stack" {
  source   = "../../stacks"
  kortnavn = var.kortnavn
  project  = var.project
  location = var.location
}