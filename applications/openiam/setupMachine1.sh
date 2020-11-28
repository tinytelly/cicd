#!/bin/bash

## NOTE: you will need to be logged in as root to run these commands

echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 =1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

sudo sysctl -p
sysctl vm.max_map_count

yum update -y
yum install nano -y
yum install git -y

# Install docker
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io  

systemctl start docker
