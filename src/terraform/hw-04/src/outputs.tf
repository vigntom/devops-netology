output "test-net" {
  value = {
    net = module.network.network,
    subnet = module.network.subnet
  }
}
