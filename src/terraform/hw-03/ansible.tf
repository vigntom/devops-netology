resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.web,
      databases  = yandex_compute_instance.db,
      storage    = [yandex_compute_instance.storage]
    }
  )

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "random_password" "each" {
  for_each    = toset(local.vms-instances.*.name)
  length = 17
}

resource "null_resource" "store_host_provision" {
  depends_on = [yandex_compute_instance.db, yandex_compute_instance.web, yandex_compute_instance.storage]

  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${jsonencode( {for k,v in random_password.each: k=>v.result})} }'"

    # for complex cases instead  --extra-vars "key=value", use --extra-vars "@some_file.json"

    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    # always_run        = "${timestamp()}"                         #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    password_change = jsonencode( {for k,v in random_password.each: k=>v.result})
  }
}

