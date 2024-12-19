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


sudo systemctl stop start-ec.service
sudo systemctl stop start-lc.service

sudo rm -r /etc/systemd/system/start-ec.service
sudo rm -r /etc/systemd/system/start-lc.service

sudo cp /home/cnc/scripts/start-ec.service /etc/systemd/system/
sudo cp /home/cnc/scripts/start-lc.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable start-ec.service
sudo systemctl enable start-lc.service

sudo systemctl start start-ec.service
sudo systemctl start start-lc.service

# sudo apt purge firefox-esr*
# sudo apt purge golang
# sudo apt autoremove
# sudo apt autoclean

# sudo systemctl disable NetworkManager-wait-online.service
