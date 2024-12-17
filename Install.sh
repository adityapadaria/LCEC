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


