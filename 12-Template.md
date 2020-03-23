# Templates

Templates are **data resources** used to template a file, like jinja files for ansible.

They are mostly used with provisioners and are defined as follow:

```terraform
data "template_file" "database_config" {
  template = "${file("${path.module}/db.ini.tpl")}"
  vars = {
    connection_ip = "${openstack_compute_instance_v2.workshop_worker[0].network.1.fixed_ip_v4}"
  }
}
```

**db.ini.tpl** can refer to the **connection_ip** variable using the syntax `${connection_ip}`.

Your provisioners can now refer to `data.template_file.database_config.rendered` to copy the content of the template.

Starting from the previous step, provision all of the worker VMs with a config file containing the IP of the first VM.
