sudo su
MAC_ADDR=$(ethtool -P eth0 | awk ‘{print $NF}’)
modprobe ec_master main_devices=MAC_ADDR
modprobe ec_genet
echo fd580000.ethernet > /sys/bus/platform/drivers/bcmgenet/unbind
echo fd580000.ethernet > /sys/bus/platform/drivers/ec_bcmgenet/bind
chmod 666 /dev/EtherCAT0
