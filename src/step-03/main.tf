terraform {
  required_version = ">= 0.12"
}

provider "openstack" {
  user_name   = "workshop"
  project_name = "Wireless_terraform-playgroud-workshop_ssz"
  password    = "{{ password }}"
  auth_url    = "{{ auth_url }}"
  region      = "{{ region }}"
}
