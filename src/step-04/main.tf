terraform {
  required_version = ">= 0.12"
}

provider "openstack" {
  user_name   = var.os_username
  project_name = var.os_project
  password    = var.os_password
  auth_url    = var.os_auth_url
  region      = var.os_region
}
