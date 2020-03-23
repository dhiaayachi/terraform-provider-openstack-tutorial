# Volume

To create a volume, we can use the resource **openstack_blockstorage_volume_v2** as follow:

```terraform
resource "openstack_blockstorage_volume_v2" "volume_config" {
  size        = 1
}
```

The only mandatory parameter is the size, in GB.

Next step is to attach the volume to the worker VM. How will you do it?

By default the volume is only attached to the VM. To mount the volume and create a file system in it we will use the provision script as follow:

```bash
config_volume_device="/dev/vdb"
mkdir -p /config-data
grep "/config-data" /etc/fstab || echo "$config_volume_device /config-data xfs defaults 0 2" >> /etc/fstab
mount /config-data
```

[More about Terraform Openstack Volume](https://www.terraform.io/docs/providers/openstack/d/blockstorage_volume_v2.html)

[Next: Creating multiple resources](11-Count.md)
