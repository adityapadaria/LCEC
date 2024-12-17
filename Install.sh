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

#------------------------------------------------------------------------------------------- 

echo 
echo "[Step:2] Installing linuxcnc-ethercat:"

echo " Important Note: "
echo " Trying to install without installing “ethercat-master” package, but script will install it anyways."
echo " At the end of this build process, script will notify they it is already installed."
echo " User needs to answer “NO” to this prompt to maintain the manually installed version without EoE."

cd ~
apt install -y linuxcnc-ethercat

#-------------------------------------------------------------------------------------------

echo 
echo "[Step:3] Installing hal-cia402:"

cd ~

echo ">> Download hal-cia402 Source Code:"
git clone https://github.com/dbraun1981/hal-cia402
cd hal-cia402

echo ">> Install hal-cia402:"
sudo halcompile --install cia402.comp




