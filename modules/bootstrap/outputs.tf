output "project_id" {
  value = selectel_vpc_project_v2.project.id
}

output "service_user_name" {
  value = selectel_iam_serviceuser_v1.service_user.name
}

output "service_user_password" {
  value     = var.service_user_password
  sensitive = true
}
