variable "web_resources" {
  type = object({ type=string, cores=number, memory = number, core_fraction=number, preemptible=bool })

  default = {
    type  = "standard-v2"
    cores = 2,
    memory = 1,
    core_fraction = 5,
    preemptible = true
  }

  description = "VM resources"
}

variable "metadata" {
  type = object({ serial-port-enable=number, ssh-keys=string })
  default = {
    serial-port-enable = 1
    ssh-keys           = ""
  }
  description = "Instance metadata"
}

resource "yandex_compute_instance" "web" {
  depends_on = [ yandex_compute_instance.db ]
  count = 2
  name = "web-${count.index + 1}"
  platform_id = var.web_resources.type
  zone        = var.default_zone

  resources {
    cores         = var.web_resources.cores
    memory        = var.web_resources.memory
    core_fraction = var.web_resources.core_fraction
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
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = merge(var.metadata, { ssh-keys: "ubuntu:${local.ssh-keys}" })
}
