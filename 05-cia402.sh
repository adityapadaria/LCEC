#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # LinuxCNC EtherCAT CIA402 Motor Support Layer
echo "[Step:5] Install hal-cia402:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Download hal-cia402 Source Code: "
echo " "

cd ~
git clone https://github.com/dbraun1981/hal-cia402

echo " "
echo ">> Install hal-cia402: "
echo " "

cd hal-cia402
sudo halcompile --install cia402.comp
