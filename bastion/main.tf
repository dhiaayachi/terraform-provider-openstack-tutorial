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

resource "openstack_networking_network_v2" "network_1" {
  name           = "network_1"
  admin_state_up = "true"
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "my_router"
  external_network_id = "27d52f2b-fb3d-4628-9dd1-a567afd7b63c"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "192.168.199.0/24"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}

resource "openstack_compute_keypair_v2" "workshop-jb-keypair" {
  name       = "workshop-jb-keypair"
  public_key = "${file("${path.module}/id_rsa.pub")}"
}


resource "openstack_compute_instance_v2" "workshopbastion" {
  name        = "workshopbastion"
  image_id    = "{{ image_id }}"
  flavor_name  = "m1.medium"
  key_pair    = "workshop-jb-keypair"
  network {
    uuid = openstack_networking_network_v2.network_1.id
  }
  depends_on = [
    openstack_networking_subnet_v2.subnet_1,
  ]
}


resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip  = var.host
  instance_id = openstack_compute_instance_v2.workshopbastion.id
  fixed_ip     = openstack_compute_instance_v2.workshopbastion.network.0.fixed_ip_v4
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = openstack_compute_instance_v2.workshopbastion.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = var.host
    user        = "centos"
    private_key = file("id_rsa")
    timeout     = "20s"
  }

  provisioner "file" {
    source      = "user_provision.sh"
    destination = "/tmp/user_provision.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/user_provision.sh",
      "/tmp/user_provision.sh",
    ]
  }
  depends_on = [
    openstack_compute_floatingip_associate_v2.fip_1,
  ]
}
