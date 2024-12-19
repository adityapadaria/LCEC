#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # Custom Code
echo " Updating Code:
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Download Custom Source Code: "
echo " "

sudo rm -r /home/cnc/linuxcnc

git clone https://github.com/adityapadaria/lcec-project /home/cnc/linuxcnc

echo " "
echo ">> Starting CNC: "
echo " "

/usr/bin/linuxcnc '/home/cnc/linuxcnc/configs/ethercatqt/ethercatqt.ini' &
