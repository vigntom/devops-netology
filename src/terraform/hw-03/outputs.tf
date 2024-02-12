output "vm-resources" {
  value = [for vm in local.vms-instances: {
    name   = vm.name,
    id     = vm.id,
    fqdn   = vm.fqdn
  }]
  description = "VM resources"
}
