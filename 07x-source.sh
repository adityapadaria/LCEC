#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # Custom Code
echo "[Step:6] Download Custom Code:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Download Custom Source Code: "
echo " "

sudo rm -r /home/cnc/linuxcnc

git clone https://github.com/adityapadaria/lcec-project /home/cnc/linuxcnc

# sudo apt purge firefox-esr*
# sudo apt purge golang
# sudo apt autoremove
# sudo apt autoclean

# sudo systemctl disable NetworkManager-wait-online.service
