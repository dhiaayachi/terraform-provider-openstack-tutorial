# Create a network

Using a **openstack_networking_network_v2** resource, we can create our own network and attach it to the VM we created.

To create a network, proceed as follow. This will also create a subnet and attach it to the network.

```terraform
resource "openstack_networking_network_v2" "network_name" {
  name           = "${terraform.workspace}-network_name"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_external" {
  network_id = openstack_networking_network_v2.network_external.id
  cidr       = "10.1.1.0/24"
}
```

All that remains is to attach the new network to our VM. Give it a try!!

[Next: Virtual Machine Provisioning](09-Provisioning.md)
