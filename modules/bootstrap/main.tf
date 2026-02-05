###########################################################
#            CREATING PROJECT & SERVICE USER
###########################################################
resource "selectel_vpc_project_v2" "project" {
    name = var.project_name
}

resource "selectel_iam_serviceuser_v1" "service_user" {
    name         = var.service_user_name
    password     = var.service_user_password
    role {
        role_name  = "member"
        scope      = "project"
        project_id = selectel_vpc_project_v2.project.id
    }
}