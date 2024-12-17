#! /bin/bash

echo "\n------------------------------------------------------------------------------------------------------" # Update Repository
echo "[Step:1] Update APT Repository:"
echo "------------------------------------------------------------------------------------------------------\n"

# Removing old repository if exists
if [ -e /etc/apt/sources.list.d/ighvh.sources ]
then
    echo "\n>> Remove /etc/apt/sources.list.d/ighvh.sources \n "
    sudo rm /etc/apt/sources.list.d/ighvh.sources
fi

# Install updated repository
echo "\n>> Install EtherCAT Repository \n "
mkdir -p /usr/local/share/keyrings/
wget -O- https://build.opensuse.org/projects/science:EtherLab/signing_keys/download?kind=gpg | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/science_EtherLab.gpg
tee -a /etc/apt/sources.list.d/ighvh.sources > /dev/null <<EOT
Types: deb
Signed-By: /etc/apt/trusted.gpg.d/science_EtherLab.gpg
Suites: ./
URIs: http://download.opensuse.org/repositories/science:/EtherLab/Debian_12/
EOT

echo "\n>> Verify Repository: \n"
sudo apt update
