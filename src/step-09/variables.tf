variable "os_auth_url" {
  default = "{{ auth_url }}"
}

variable "os_password" {
  default = "{{ password }}"
}

variable "os_region" {
  default = "{{ region }}"
}

variable "os_project" {
  default = "Wireless_terraform-playgroud-workshop_ssz"
}

variable "os_username" {
  default = "workshop"
}

variable "internal_net_name" {
  default = "network_1"
}

variable "bastion" {
  default = "10.55.201.122"
}
