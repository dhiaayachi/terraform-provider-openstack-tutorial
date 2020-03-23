#!/bin/bash
function configure_config_volume() {
    config_volume_device="/dev/vdb"
    mkdir -p /config-data
    grep "/config-data" /etc/fstab || echo "$config_volume_device /config-data xfs defaults 0 2" >> /etc/fstab
    declare -i COUNT
    COUNT=0
    until mount /config-data; do
        if [[ $COUNT -eq 2 ]]; then exit 1; fi
        mkfs.xfs "$config_volume_device" || echo "Filesystem already present"
        COUNT+=1
        sleep 5
    done
    df -h
}

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
configure_config_volume
