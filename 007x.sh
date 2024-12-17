#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # Set Permission for EtherCAT Ports from Startup
echo "[Step:6] Set Permission for EtherCAT Ports:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

echo " "
echo ">> Generate .rules file: "
echo " "

touch /etc/udev/rules.d/99-ethercat.rules
echo "KERNEL=="EtherCAT[0-9]", MODE="0777"" > /etc/udev/rules.d/99-ethercat.rules

echo " "
echo ">> Reload .rules files: "
echo " "

udevadm control --reload-rules
