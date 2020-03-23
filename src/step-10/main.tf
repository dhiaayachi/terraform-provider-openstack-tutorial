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
  cidr = "10.1.1.0/24"
}

resource "openstack_blockstorage_volume_v2" "volume_config" {
  size = 1
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

  block_device {
    uuid                  = "{{ image_id }}"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v2.volume_config.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 1
  }
}

resource "null_resource" "provisions" {
  # Changes to  instance requires re-provisioning
  triggers = {
    cluster_instance_ids = openstack_compute_instance_v2.workshop_worker.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host         = openstack_compute_instance_v2.workshop_worker.network.0.fixed_ip_v4
    user         = "centos"
    private_key  = file("id_rsa")
    bastion_host = var.bastion
    timeout      = "20s"
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/provision.sh",
      "sudo /tmp/provision.sh",
    ]
  }
  depends_on = [
    openstack_compute_instance_v2.workshop_worker,
  ]
}
