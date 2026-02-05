output "project_id" {
  value = module.bootstrap.project_id
}

output "service_user_name" {
  value = module.bootstrap.service_user_name
}

output "service_user_password" {
  value     = module.bootstrap.service_user_password
  sensitive = true
}