#! /bin/bash

# MAC_ADDR=$(sudo ethtool -P eth0 | awk ‘{print $NF}’)

MAC_ADDR=$(ip link show eth0 | awk '/ether/ {print $2}')
modprobe ec_master main_devices=MAC_ADDR
modprobe ec_genet
echo fd580000.ethernet > /sys/bus/platform/drivers/bcmgenet/unbind
echo fd580000.ethernet > /sys/bus/platform/drivers/ec_bcmgenet/bind
chmod 666 /dev/EtherCAT0

exit 0
