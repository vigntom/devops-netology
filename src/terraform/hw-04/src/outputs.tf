output "vpc-dev" {
  value = {
    net = module.vpc-dev.network,
    subnet = module.vpc-dev.subnet
  }
}
