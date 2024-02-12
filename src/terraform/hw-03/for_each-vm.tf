variable "db-vms" {
  type    = map(object({  cpu=number, fraction=number, ram=number, disk_volume=number }))
  default = {
    main = {
      cpu         = 4,
      fraction    = 5,
      ram         = 2,
      disk_volume = 12,
    },
    replica = {
      cpu         = 2,
      fraction    = 5,
      ram         = 1,
      disk_volume = 8,
  }}

  description = "VM resources"
}

resource "yandex_compute_instance" "db" {
  for_each = var.db-vms //toset(["main", "replica"])

  name        = each.key
  platform_id = "standard-v2"
  zone        = var.default_zone
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(var.metadata, { ssh-keys: "ubuntu:${local.ssh-keys}" })
}
