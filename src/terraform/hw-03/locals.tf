locals {
  vms-instances = concat(yandex_compute_instance.web, values(yandex_compute_instance.db))
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
