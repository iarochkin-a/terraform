terraform {
  required_version = ">= 1.6"

  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 6.0.0"
    }
  }
}