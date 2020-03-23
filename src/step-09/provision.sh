function configure_network() {
    IFCFG='DEVICE="eth1"
    BOOTPROTO="dhcp"
    ONBOOT="yes"
    TYPE="Ethernet"
    USERCTL="yes"
    PEERDNS="yes"
    IPV6INIT="no"
    PERSISTENT_DHCLIENT="1"'
    echo $IFCFG > /etc/sysconfig/network-scripts/ifcfg-eth1
    ifup eth1
    route
    ifconfig
    ip a
}
configure_network
