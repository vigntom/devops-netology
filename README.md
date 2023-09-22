# devops-netology

First edit

# terraform .gitignore

**/.terraform/* - все директории .terraform во всех подпапках
*.tfstate       - все файлы c расширением оканичающиеся на .tfstate
*.tfstate.*     - все файлы оканивающиеся на .tfstate после которой . и какие то символы
crash.log       - все файлы crash.log
crash.*.log     - все файлы с именем crash за которым следует . и какие то симолы и заканчивающиеся на .log
*.tfvars        - файлы заканчивающиеся на .tfvars
*.tfvars.json   - файлы заканчивающиеся на .tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf      - файлы override.tf
override.tf.json - файлы override.tf.json
*_override.tf    - файлы заканчивающиеся на _override.tf
*_override.tf.json - файлы заканчивающиеся на _override.tf.json

!example_override.tf - не игнорировать файл example_override.tf

.terraformrc - файл .terraformrc
terraform.rc - файл terraform.rc

New line from fix branch
