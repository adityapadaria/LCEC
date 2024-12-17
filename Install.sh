#------------------------------------------------------------------------------------------- Update Repository

echo 
echo "[Step:0] Update APT Repository:"

apt update

# Removing old repo if it exists
if [ -e /etc/apt/sources.list.d/ighvh.sources ]
then
    echo "removing ethercat repository file\n"
    rm /etc/apt/sources.list.d/ighvh.sources
fi

# Install ethercat repositories
echo "Install ethercat repository"
mkdir -p /usr/local/share/keyrings/
wget -O- https://build.opensuse.org/projects/science:EtherLab/signing_keys/download?kind=gpg | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/science_EtherLab.gpg
tee -a /etc/apt/sources.list.d/ighvh.sources > /dev/null <<EOT
Types: deb
Signed-By: /etc/apt/trusted.gpg.d/science_EtherLab.gpg
Suites: ./
URIs: http://download.opensuse.org/repositories/science:/EtherLab/Debian_12/
EOT

# Install qtpyvcp repositories

apt install curl
echo 'deb [arch=arm64] https://repository.qtpyvcp.com/apt stable main' | sudo tee /etc/apt/sources.list.d/kcjengr.list
curl -sS https://repository.qtpyvcp.com/repo/kcjengr.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kcjengr.gpg
gpg --keyserver keys.openpgp.org --recv-key 2DEC041F290DF85A

apt update

while true; do
    read -p "Do you wish to install this program? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#------------------------------------------------------------------------------------------- EtherCAT Master

echo 
echo "[Step:1] Installing IgH EtherCAT Master:"

echo ">> Installing libtool:"
apt install libtool

echo ">> Download Ethercat Master Source Code:"
cd ~
git clone https://gitlab.com/etherlab.org/ethercat
cd ethercat

echo ">> Compile and Install Ethercat Master:"
autoupdate
./bootstrap
./configure --sysconfdir=/etc/ --disable-eoe --disable-8139too --enable-genet
make
make modules
make install
make modules_install
depmod

#------------------------------------------------------------------------------------------- LinuxCNC EtherCAT Support Layer

echo 
echo "[Step:2] Install linuxcnc-ethercat:"

echo " Important Note: "
echo " Trying to install without installing “ethercat-master” package, but script will install it anyways."
echo " At the end of this build process, script will notify they it is already installed."
echo " User needs to answer “NO” to this prompt to maintain the manually installed version without EoE."

cd ~
apt install -y linuxcnc-ethercat

#------------------------------------------------------------------------------------------- LinuxCNC EtherCAT CIA402 Motor Support Layer

echo 
echo "[Step:3] Install hal-cia402:"

cd ~

echo ">> Download hal-cia402 Source Code:"
git clone https://github.com/dbraun1981/hal-cia402
cd hal-cia402

echo ">> Install hal-cia402:"
sudo halcompile --install cia402.comp

#------------------------------------------------------------------------------------------- Set Permission for EtherCAT Ports from Startup

echo 
echo "[Step:4] Set Permission for EtherCAT Ports:"

touch /etc/udev/rules.d/99-ethercat.rules
echo "KERNEL=="EtherCAT[0-9]", MODE="0777"" > /etc/udev/rules.d/99-ethercat.rules
udevadm control --reload-rules

#------------------------------------------------------------------------------------------- LinuxCNC QtPyVCP

echo 
echo "[Step:4] Install QtPyVCP:"

apt install python3-qtpyvcp
