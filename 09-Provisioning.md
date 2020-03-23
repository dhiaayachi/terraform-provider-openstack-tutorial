# Provisioning a VM

If you log in to the VM, you will notice that the second network (external network) is not configured at the os level

To apply any configuration to the VM (such as the external network configuration), we need to use terraform provisioners.

The following will copy the script file `provision.sh` to the `/tmp/` folder on your VM.

```terraform
resource "null_resource" "provisions" {
  # Changes to instance requires re-provisioning
  triggers = {
    cluster_instance_ids = openstack_compute_instance_v2.workshop_worker.id
  }

  connection {
    host = openstack_compute_instance_v2.workshop_worker.network.0.fixed_ip_v4
    user = "centos"
    private_key = file("id_rsa")
    bastion_host = var.bastion
    timeout = "20s"
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }
}
```

Note: you will need to run `terraform init` again because of the new plugin **null_resource**

Now that the script is copied over, you need to execute it. How will you do that?

Hint: `remote-exec` provisioner

[More about Terraform Provisioner](https://www.terraform.io/docs/provisioners/index.html)

[Next: Openstack Volumes](10-Volume.md)
