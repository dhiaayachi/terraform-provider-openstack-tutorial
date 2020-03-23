#!/bin/bash
for i in {1..5}
do
  sudo useradd  -m "workshop${i}"
done

# Prevents the creation of host keys
{
  echo "Host *"
  echo "    ServerAliveInterval 30"
  echo "    StrictHostKeyChecking no"
  echo "    UserKnownHostsFile /dev/null"
} >/home/centos/.ssh/config

chown centos:centos /home/centos/.ssh/config
chmod 600 /home/centos/.ssh/config
