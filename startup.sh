#! /bin/bash

if lsmod | grep -wq ec_genet; then
  sudo rmmod ec_genet
fi

if lsmod | grep -wq ec_master; then
#  sudo rmmod ec_master
  sudo /etc/init.d/ethercat stop
fi

sudo modprobe ec_master main_devices=e4:5f:01:82:96:36
sudo modprobe ec_genet

echo fd580000.ethernet > /sys/bus/platform/drivers/bcmgenet/unbind
echo fd580000.ethernet > /sys/bus/platform/drivers/ec_bcmgenet/bind

sudo chmod 666 /dev/EtherCAT0

/usr/bin/linuxcnc '/home/cnc/linuxcnc/configs/ethercatqt/ethercatqt.ini'
