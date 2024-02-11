###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### project vars

variable "env-name" {
  type = string
  default = "dev"
  description = "Environment name"
  validation {
    condition = contains(["prod", "stage", "dev"], var.env-name)
    error_message = "The variable can be prod, stage or dev"
  }
}

variable "vms" {
  type = list(map(string))
  default = [
    { name: "markenting", count: 1 },
    { name: "analytics", count: 1 },
  ]

  description = "Project vm instances"
}
