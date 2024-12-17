#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # IgH EtherCAT Master
echo "[Step:3] Installing IgH EtherCAT Master:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Installing libtool: "
echo " "

sudo apt install -y libtool

echo " "
echo ">> Download Ethercat Master Source Code: "
echo " "

# sudo rm -r /root/ethercat

cd ~
git clone https://gitlab.com/etherlab.org/ethercat

cd /root/ethercat
sudo autoupdate 

echo " "
echo ">> Bootstrap with Warning: "
echo " "

sudo ./bootstrap

sudo autoupdate 

echo " "
echo ">> Bootstrap: "
echo " "

sudo ./bootstrap

echo " "
echo ">> Configure: "
echo " "

sudo ./configure --sysconfdir=/etc/ --disable-eoe --disable-8139too # --enable-genet

echo " "
echo ">> Compile Library: "
echo " "

sudo make

echo " "
echo ">> Compile Modules: "
echo " "

sudo make modules

echo " "
echo ">> Install Library: "
echo " "

sudo make install

echo " "
echo ">> Install Modules: "
echo " "

sudo make modules_install

echo " "
echo ">> Generate Module Dependency Files: "
echo " "

sudo depmod
