module "network" {
  source = "./vpc"
  name = "develop"
  zone = var.default_zone
  cidr = var.default_cidr
}
