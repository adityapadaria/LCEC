#! /bin/bash

if lsmod | grep -wq ec_genet; then
  rmmod ec_genet
fi

if lsmod | grep -wq ec_master; then
#  rmmod ec_master
  /etc/init.d/ethercat stop
fi

modprobe ec_master main_devices=
modprobe ec_genet
echo fd580000.ethernet > /sys/bus/platform/drivers/bcmgenet/unbind
echo fd580000.ethernet > /sys/bus/platform/drivers/ec_bcmgenet/bind
chmod 666 /dev/EtherCAT0
