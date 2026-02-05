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