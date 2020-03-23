# Count

The `count` parameter is present for all terraform resources and allows to define how many of this resource is needed. For example:

```terraform
resource "openstack_blockstorage_volume_v2" "volume_config" {
  count = 5
  size  = 1
}
```

This mean that **5** volumes of size 1GB would be created under the resource `volume_config`.

Let's create the following setup:

``` text
                                     +--------------+
                                     |              |
                                     | Bastion box  |
                                     |              |
                                     +-----+--------+
                                           |
                                           |
                                       XX  +XX XXX
                                   XXX           XX
                                 XXX              XX
                                XX  network_1       X
                     +---------+XX  192.168.199.0/24XX+----------+
                     |           XX                  X           |
                     |             X              XXXX           |
                     |             XX        XXXXXX              |
                     |               XXX XXXX                    |
                     |                                           |
                     |                                           |
+------+      +------+-------+                           +-------+--------+       +-------+
|      |      |              |                           |                |       |       |
| vol 1+------+   workshop   |                           |    workshop    +-------+ vol 2 |
|      |      |   worker 1   |                           |    worker 2    |       |       |
+------+      |              |                           |                |       +-------+
              +-----+--------+                           +---------+------+
                    |                                              |
                    |                                              |
                    |                XXXXXXX                       |
                    |            XXXXX      XXXXXXXX               |
                    |          XXX                  X XX           |
                    |         XX                        XX         |
                    +--------+X                          XX        |
                               X       external network  XX+-------+
                                XXXX   10.1.1.0/24       X
                                   XX                   X
                                     XX                X
                                      XX              X
                                        XXXXX       XX
                                             XXXXXXX
```

Using what we have learned so far, can you create the terraform definition for it?
[Next: Using templates](12-Template.md)
