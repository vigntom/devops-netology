resource "yandex_compute_disk" "storage" {
  count = 3
  name = "storage-${count.index + 1}"
  type = "network-hdd"
  zone = var.default_zone
  size = 1
}

resource "yandex_compute_instance" "storage" {
  depends_on = [ yandex_compute_disk.storage ]

  name = "storage"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.web_resources.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  metadata = merge(var.metadata, { ssh-keys: "ubuntu:${local.ssh-keys}" })

  dynamic "secondary_disk" {
    for_each = range(3)
    content {
      disk_id = yandex_compute_disk.storage[secondary_disk.value].id
    }
  }
}
