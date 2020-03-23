terraform {
  required_version = ">= 0.12"
  backend "local" {
  }
}

provider "openstack" {
  user_name   = var.os_username
  project_name = var.os_project
  password    = var.os_password
  auth_url    = var.os_auth_url
  region      = var.os_region
}

resource "openstack_compute_keypair_v2" "workshop-worker-keypair" {
  name       = "${terraform.workspace}-workshop-worker-keypair"
  public_key = "${file("${path.module}/id_rsa.pub")}"
}

resource "openstack_networking_network_v2" "network_external" {
  name           = "${terraform.workspace}-network_external"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_external" {
  network_id = openstack_networking_network_v2.network_external.id
  cidr       = "10.1.1.0/24"
}

resource "openstack_compute_instance_v2" "workshop_worker" {
  name        = "${terraform.workspace}-workshop_worker"
  image_id    = "{{ image_id }}"
  flavor_name  = "m1.medium"
  key_pair    = openstack_compute_keypair_v2.workshop-worker-keypair.id
  
  network {
    name = var.internal_net_name
  }

  network {
    uuid = openstack_networking_network_v2.network_external.id
  }
}
