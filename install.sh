clear

echo "\n------------------------------------------------------------------------------------------------------" # Update Repository
echo "[Step:1] Update APT Repository:"
echo "------------------------------------------------------------------------------------------------------\n"

sudo apt update

echo "\n\n"

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

sudo apt update

echo "\n\n"

if [ -e /etc/apt/sources.list.d/kcjengr.list ]
then
    echo "\n>> Remove /etc/apt/sources.list.d/kcjengr.list \n "
    sudo rm /etc/apt/sources.list.d/kcjengr.list
fi

if [ -e /etc/apt/trusted.gpg.d/kcjengr.gpg ]
then
    echo "\n>> Remove /etc/apt/trusted.gpg.d/kcjengr.gpg \n "
    sudo rm /etc/apt/trusted.gpg.d/kcjengr.gpg
fi

echo "\n>> Install curl: \n "
sudo apt install -y curl

# Install updated repository
echo "\n>> Install QtPyVCP Repository \n "
echo 'deb [arch=arm64] https://repository.qtpyvcp.com/apt stable main' | sudo tee /etc/apt/sources.list.d/kcjengr.list
curl -sS https://repository.qtpyvcp.com/repo/kcjengr.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kcjengr.gpg
gpg --keyserver keys.openpgp.org --recv-key 2DEC041F290DF85A

echo "\n>> Verify Repository: \n"

sudo apt update

echo "\n\n"

while true; do
    read -p "\n >> Do you wish to continue?   " yn
    case $yn in
        [Yy]* ) clear; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# echo "\n------------------------------------------------------------------------------------------------------" # LinuxCNC QtPyVCP
# echo "[Step:2] Install QtPyVCP:"
# echo "------------------------------------------------------------------------------------------------------\n"

# echo "\n>> Install python3-qtpyvcp: \n "
# sudo apt install -y python3-qtpyvcp &> /dev/null

# while true; do
#     read -p "\n >> Do you wish to continue?   " yn
#     case $yn in
#         [Yy]* ) clear; break;;
#         [Nn]* ) exit;;
#         * ) echo "Please answer yes or no.";;
#     esac
# done

# echo "\n------------------------------------------------------------------------------------------------------" # IgH EtherCAT Master
# echo "[Step:3] Installing IgH EtherCAT Master:"
# echo "------------------------------------------------------------------------------------------------------\n"

# echo "\n>> Installing libtool: \n "
# sudo apt install -y libtool &> /dev/null

# echo "\n>> Download Ethercat Master Source Code: \n "
# sudo rm -r /root/ethercat
# cd ~
# git clone https://gitlab.com/etherlab.org/ethercat

# cd /root/ethercat
# sudo autoupdate 

# echo "\n>> Bootstrap with Warning: \n "
# sudo ./bootstrap

# sudo autoupdate 

# echo "\n>> Bootstrap: \n "
# sudo ./bootstrap

# echo "\n>> Configure: \n "
# sudo ./configure --sysconfdir=/etc/ --disable-eoe --disable-8139too --enable-genet

# echo "\n>> Compile and Install Ethercat Master: \n "

# sudo make
# sudo make modules
# sudo make install
# sudo make modules_install
# sudo depmod

# while true; do
#     read -p "\n >> Do you wish to continue?   " yn
#     case $yn in
#         [Yy]* ) clear; break;;
#         [Nn]* ) exit;;
#         * ) echo "Please answer yes or no.";;
#     esac
# done

echo "\n------------------------------------------------------------------------------------------------------" # LinuxCNC EtherCAT Support Layer
echo "[Step:4] Install linuxcnc-ethercat:"
echo "Important Note: "
echo "Trying to install without installing “ethercat-master” package, but script will install it anyways. "
echo "At the end of this build process, script will notify they it is already installed. "
echo "User needs to answer “NO” to this prompt to maintain the manually installed version without EoE. "
echo "------------------------------------------------------------------------------------------------------\n"

echo "\n>> Install linuxcnc-ethercat: \n "
sudo apt install -y linuxcnc-ethercat

while true; do
    read -p "\n >> Do you wish to continue?   " yn
    case $yn in
        [Yy]* ) clear; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n------------------------------------------------------------------------------------------------------" # LinuxCNC EtherCAT CIA402 Motor Support Layer
echo "[Step:5] Install hal-cia402:"
echo "------------------------------------------------------------------------------------------------------\n"

echo "\n>> Download hal-cia402 Source Code: \n "
cd ~
git clone https://github.com/dbraun1981/hal-cia402

echo "\n>> Install hal-cia402:"
cd hal-cia402
sudo halcompile --install cia402.comp

while true; do
    read -p "\n >> Do you wish to continue?   " yn
    case $yn in
        [Yy]* ) clear; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n------------------------------------------------------------------------------------------------------" # Set Permission for EtherCAT Ports from Startup
echo "[Step:6] Set Permission for EtherCAT Ports:"
echo "------------------------------------------------------------------------------------------------------\n"

touch /etc/udev/rules.d/99-ethercat.rules
echo "KERNEL=="EtherCAT[0-9]", MODE="0777"" > /etc/udev/rules.d/99-ethercat.rules
udevadm control --reload-rules

while true; do
    read -p "\n >> Do you wish to continue?   " yn
    case $yn in
        [Yy]* ) clear; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n------------------------------------------------------------------------------------------------------" # Custom Code
echo "[Step:6] Download Custom Code:"
echo "------------------------------------------------------------------------------------------------------\n"

echo ">> Download hal-cia402 Source Code: \n "
cd ~
git clone https://github.com/adityapadaria/lcec-project linuxcnc

while true; do
    read -p "\n >> Do you wish to continue?   " yn
    case $yn in
        [Yy]* ) clear; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n------------------------------------------------------------------------------------------------------" # EtherCAT Master Init Config
echo "[Step:7] Config Init:"
echo "------------------------------------------------------------------------------------------------------\n"

# echo "\n>> Remove /etc/init.d/ethercat \n "
# sudo rm /etc/init.d/ethercat

# echo "\n>> Installing ethtool: \n "
# sudo apt install -y ethtool &> /dev/null

# cat > /etc/init.d/lcec <<EOL
# #! /bin/bash

# # MAC_ADDR=$(sudo ethtool -P eth0 | awk ‘{print $NF}’)

# MAC_ADDR=$(ip link show eth0 | awk '/ether/ {print $2}')
# modprobe ec_master main_devices=MAC_ADDR
# modprobe ec_genet
# echo fd580000.ethernet > /sys/bus/platform/drivers/bcmgenet/unbind
# echo fd580000.ethernet > /sys/bus/platform/drivers/ec_bcmgenet/bind
# chmod 666 /dev/EtherCAT0

# exit 0
# EOL

# cp /root/lcec-install/startup.sh /etc/init.d/lcec
# chmod 755 /etc/init.d/lcec
# update-rc.d lcec defaults

clear

echo "\n------------------------------------------------------------------------------------------------------" # End of Process
echo " SUCCESS! "
echo "------------------------------------------------------------------------------------------------------\n"
