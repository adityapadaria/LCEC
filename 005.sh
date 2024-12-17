#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # LinuxCNC EtherCAT Support Layer
echo "[Step:4] Install linuxcnc-ethercat:"
echo " "
echo "Important Note: "
echo "Trying to install without installing “ethercat-master” package, but script will install it anyways. "
echo "At the end of this build process, script will notify they it is already installed. "
echo "User needs to answer “NO” to this prompt to maintain the manually installed version without EoE. "
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Install linuxcnc-ethercat: "
echo " "

sudo apt install -y linuxcnc-ethercat
