##########################################################
# Модуль для создания проекта и сервисного пользователя
# Данные лежат в ~/bootstrap/terraform.tfvars
##########################################################
module "bootstrap" {
    source = "../modules/bootstrap"

    project_name          = var.project_name
    service_user_name     = var.service_user_name
    service_user_password = var.service_user_password
}