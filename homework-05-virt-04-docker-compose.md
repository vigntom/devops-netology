# Задача 1

Создайте собственный образ любой операционной системы (например, debian-11) с
помощью Packer версии 1.7.0 . Перед выполнением задания изучите (инструкцию!!!).
В инструкции указана минимальная версия 1.5, но нужно использовать 1.7, так как
там есть нужный нам функционал.

Ответ:
    ![скриншот](./images/packer-debian-11.jpg)


# Задача 2

2.1. Создайте вашу первую виртуальную машину в YandexCloud с помощью web-интерфейса YandexCloud.

Ответ:
Так как не ясно что за свойства сделал несколько скринов.
    ![скриншот1](./images/yc-vm-debian-1.jpg)
    ![скриншот2](./images/yc-vm-debian-2.jpg)
    ![скриншот3](./images/yc-vm-debian-3.jpg)
    ![скриншот4](./images/yc-vm-debian-4.jpg)
    ![скриншот5](./images/yc-vm-debian-5.jpg)
    ![скриншот6](./images/yc-vm-debian-6.jpg)
    ![скриншот7](./images/yc-vm-debian-7.jpg)

2.2.* (Необязательное задание)
    Создайте вашу первую виртуальную машину в YandexCloud с помощью Terraform
    (вместо использования веб-интерфейса YandexCloud).
    Используйте Terraform-код в директории (src/terraform).

```bash
➜  terraform git:(main) ✗ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFA7H1kOJ8NtQkf7zu2FBeS3oTIb59DVFWKSvsIj9TvM vigntom@gmail.com
            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd87so7r8veba60u3nvg"
              + name        = "root-node01"
              + size        = 50
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 8
          + memory        = 8
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01_yandex_cloud = (known after apply)
  + internal_ip_address_node01_yandex_cloud = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.default: Creation complete after 2s [id=enpuqt6e5h5b9bnque70]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 1s [id=e9b5tu7v3lae4j6sh5cf]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Creation complete after 45s [id=fhmfe025g41qt3h2bbus]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "51.250.13.205"
internal_ip_address_node01_yandex_cloud = "192.168.101.15"

```

# Задача 3

С помощью Ansible и Docker Compose разверните на виртуальной машине из предыдущего задания систему
мониторинга на основе Prometheus/Grafana. Используйте Ansible-код в директории (src/ansible).

Ответ:
    ![скриншот1](./images/docker-ps.jpg)

# Задача 4

  1. Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
  1. Используйте для авторизации логин и пароль из .env-file.
  1. Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose-панели с графиками(dashboards).
  1. Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.


Ответ:
    ![скриншот1](./images/graphana.jpg)


