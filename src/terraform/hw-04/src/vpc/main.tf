resource "yandex_vpc_network" "net" {
  name = var.name
}
resource "yandex_vpc_subnet" "net" {
  name           = var.name
  zone           = var.zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = var.cidr
}

