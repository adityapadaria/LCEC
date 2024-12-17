echo 
echo "[Step:1] Installing IgH EtherCAT Master:"
echo

echo 
echo ">> Installing libtool:"

apt install libtool

echo 
echo ">> Download Ethercat Master Source Code:"
echo

cd ~
git clone https://gitlab.com/etherlab.org/ethercat
cd ethercat

echo 
echo ">> Compile and Install Ethercat Master:"
echo

autoupdate

./bootstrap
./configure --sysconfdir=/etc/ --disable-eoe --disable-8139too --enable-genet
make
make modules
make install
make modules_install
depmod





