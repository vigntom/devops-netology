module "vpc-dev" {
  source = "./vpc"
  name = var.vpc_name
  zone = var.default_zone
  cidr = var.default_cidr
}

module "vm" {
  count = length(var.vms)

  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=1.0.0"
  env_name       = var.env-name
  network_id     = module.vpc-dev.network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc-dev.subnet.id]
  instance_name  = "vm-${local.project-name}-${var.env-name}-${var.vms[count.index].name}"
  instance_count = var.vms[count.index].count
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  labels         = { project: local.project-name, use: var.vms[count.index].name }
  metadata = {
    user-data          = data.cloudinit_config.cloudinit.rendered
    serial-port-enable = 1
  }
}

# module "vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "develop"
#   network_id     = module.vpc-dev.network.id
#   subnet_zones   = ["ru-central1-a"]
#   subnet_ids     = [module.vpc-dev.subnet.id]
#   instance_name  = "web"
#   instance_count = 1
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true
#   labels         = { project: "markenting" }

#   metadata = {
#     user-data          = data.cloudinit_config.cloudinit.rendered // data.template_file.cloudinit.rendered #Для демонстрации №3
#     serial-port-enable = 1
#   }

# }

# module "vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "stage"
#   network_id     = module.vpc-dev.network.id
#   subnet_zones   = ["ru-central1-a"]
#   subnet_ids     = [module.vpc-dev.subnet.id]
#   instance_name  = "web-stage"
#   instance_count = 1
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true
#   labels         = { project: "analytics" }

#   metadata = {
#     user-data          = data.cloudinit_config.cloudinit.rendered // data.template_file.cloudinit.rendered #Для демонстрации №3
#     serial-port-enable = 1
#   }

# }

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
