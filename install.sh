#------------------------------------------------------------------------------------------- Update Repository

echo "--------------------------------------------------"
echo "[Step:0] Update APT Repository:"
echo "--------------------------------------------------"
echo 

sudo apt update

# Removing old repository if exists
if [ -e /etc/apt/sources.list.d/ighvh.sources ]
then
    echo ">> Remove /etc/apt/sources.list.d/ighvh.sources \n "
    sudo rm /etc/apt/sources.list.d/ighvh.sources
fi

if [ -e /etc/apt/sources.list.d/kcjengr.list ]
then
    echo ">> Remove /etc/apt/sources.list.d/kcjengr.list \n "
    sudo rm /etc/apt/sources.list.d/kcjengr.list
fi

if [ -e /etc/apt/trusted.gpg.d/kcjengr.gpg ]
then
    echo ">> Remove /etc/apt/trusted.gpg.d/kcjengr.gpg \n "
    sudo rm /etc/apt/trusted.gpg.d/kcjengr.gpg
fi

# Install updated repository
echo ">> Install EtherCAT Repository \n "
mkdir -p /usr/local/share/keyrings/
wget -O- https://build.opensuse.org/projects/science:EtherLab/signing_keys/download?kind=gpg | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/science_EtherLab.gpg
tee -a /etc/apt/sources.list.d/ighvh.sources > /dev/null <<EOT
Types: deb
Signed-By: /etc/apt/trusted.gpg.d/science_EtherLab.gpg
Suites: ./
URIs: http://download.opensuse.org/repositories/science:/EtherLab/Debian_12/
EOT

echo ">> Installing curl: \n"
sudo apt install -y curl

# Install updated repository
echo ">> Install QtPyVCP Repository \n "
echo 'deb [arch=arm64] https://repository.qtpyvcp.com/apt stable main' | sudo tee /etc/apt/sources.list.d/kcjengr.list
curl -sS https://repository.qtpyvcp.com/repo/kcjengr.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kcjengr.gpg
gpg --keyserver keys.openpgp.org --recv-key 2DEC041F290DF85A

sudo apt update

#------------------------------------------------------------------------------------------- EtherCAT Master

echo "--------------------------------------------------"
echo "[Step:1] Installing IgH EtherCAT Master:"
echo "--------------------------------------------------"
echo 

echo ">> Installing libtool: \n"
sudo apt install -y libtool

echo ">> Download Ethercat Master Source Code:"
cd ~
git clone https://gitlab.com/etherlab.org/ethercat
cd ethercat

echo ">> Compile and Install Ethercat Master:"
sudo autoupdate
sudo ./bootstrap
sudo ./configure --sysconfdir=/etc/ --disable-eoe --disable-8139too --enable-genet
sudo make
sudo make modules
sudo make install
sudo make modules_install
sudo depmod

#------------------------------------------------------------------------------------------- LinuxCNC EtherCAT Support Layer

echo "--------------------------------------------------"
echo "[Step:2] Install linuxcnc-ethercat:"
echo "--------------------------------------------------"
echo 

echo " Important Note: "
echo " Trying to install without installing “ethercat-master” package, but script will install it anyways."
echo " At the end of this build process, script will notify they it is already installed."
echo " User needs to answer “NO” to this prompt to maintain the manually installed version without EoE."
echo

sudo apt install -y linuxcnc-ethercat

#------------------------------------------------------------------------------------------- LinuxCNC EtherCAT CIA402 Motor Support Layer

echo "--------------------------------------------------"
echo "[Step:3] Install hal-cia402:"
echo "--------------------------------------------------"
echo 

cd ~

echo ">> Download hal-cia402 Source Code:"
git clone https://github.com/dbraun1981/hal-cia402
cd hal-cia402

echo ">> Install hal-cia402:"
sudo halcompile --install cia402.comp

#------------------------------------------------------------------------------------------- Set Permission for EtherCAT Ports from Startup

echo "--------------------------------------------------"
echo "[Step:4] Set Permission for EtherCAT Ports:"
echo "--------------------------------------------------"
echo 

touch /etc/udev/rules.d/99-ethercat.rules
echo "KERNEL=="EtherCAT[0-9]", MODE="0777"" > /etc/udev/rules.d/99-ethercat.rules
udevadm control --reload-rules

#------------------------------------------------------------------------------------------- LinuxCNC QtPyVCP

echo "--------------------------------------------------" 
echo "[Step:4] Install QtPyVCP:"
echo "--------------------------------------------------"
echo 

sudo apt install -y python3-qtpyvcp

#------------------------------------------------------------------------------------------- Custom Code

echo "--------------------------------------------------"
echo "[Step:5] Download Custom Code:"
echo "--------------------------------------------------"
echo 

cd ~

mkdir linuxcnc
mkdir ./linuxcnc/configs
cd ./linuxcnc/configs

echo ">> Download hal-cia402 Source Code:"
git clone https://github.com/adityapadaria/lcec-project

#-------------------------------------------------------------------------------------------

sudo /etc/init.d/ethercat start
sudo chmod 666 /dev/EtherCAT0

