#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = { project: "markenting" }

  metadata = {
    user-data          = data.cloudinit_config.cloudinit.rendered // data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = { project: "analytics" }

  metadata = {
    user-data          = data.cloudinit_config.cloudinit.rendered // data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

# Переписал так как template_file не доступен для платформы arm
# Использовал проавйдер cloudinit_config
# https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs

#Пример передачи cloud-config в ВМ для демонстрации №3
# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yml")
# }

data "cloudinit_config" "cloudinit" {
  # Для проверки результата преобразования шаблона
  # base64_encode = false
  # gzip = false

  part {
    filename = "cloud-init.yml"
    content_type = "text/cloud-config"
    content = templatefile("./cloud-init.tftpl", { ssh_public_keys: [file("~/.ssh/id_ed25519.pub")]})
  }
}
