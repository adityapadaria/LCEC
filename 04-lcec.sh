#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # LinuxCNC EtherCAT Support Layer
echo "[Step:4] Install linuxcnc-ethercat:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Installing libethercat-dev: "
echo " "

sudo apt install -y libethercat-dev

echo " "
echo ">> Download linuxcnc-ethercat: "
echo " "

cd ~
git clone https://github.com/linuxcnc-ethercat/linuxcnc-ethercat

echo " "
echo ">> Compile Library: "
echo " "

cd /root/linuxcnc-ethercat
sudo make build

echo " "
echo ">> Install Library: "
echo " "

sudo make install

# sudo apt install -y linuxcnc-ethercat
