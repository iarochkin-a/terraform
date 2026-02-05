####################################################################
#                    SELECTEL VARS FOR AUTH
####################################################################
variable "selectel_domain_name" {
    description = "Selectel account ID"
}
variable "selectel_username" {
    description = "Selectel service user"
}
variable "selectel_password" {
    description = "Selectel service user`s password"
}
variable "selectel_auth_region" {
    description = "Selectel auth region (default = ru-7)"
    default = "ru-7"
}
variable "provider_auth_url" {
    description = "Selectel account ID"
    default = "https://cloud.api.selcloud.ru/identity/v3/"
}

####################################################################
#                    SELECTEL PROJECT VARS
####################################################################
variable "project_name" {
    description = "Terraform project"
    default = "terraform-test-project"    
}

variable "service_user_name" {
    description = "Service user for Terraform"
    default = "test-service-user"   
}

variable "service_user_password" {
    description = "Password for service user"  
}
