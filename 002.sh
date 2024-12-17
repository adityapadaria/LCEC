#! /bin/bash

echo " "
echo "------------------------------------------------------------------------------------------------------" # Update Repository
echo "[Step:2] Update APT Repository:"
echo "------------------------------------------------------------------------------------------------------"
echo " "

if [ -e /etc/apt/sources.list.d/kcjengr.list ]
then
    echo " "
    echo ">> Remove /etc/apt/sources.list.d/kcjengr.list "
    echo " "
    
    sudo rm /etc/apt/sources.list.d/kcjengr.list
fi

if [ -e /etc/apt/trusted.gpg.d/kcjengr.gpg ]
then
    echo " "
    echo ">> Remove /etc/apt/trusted.gpg.d/kcjengr.gpg "
    echo " "
    
    sudo rm /etc/apt/trusted.gpg.d/kcjengr.gpg
fi

echo " "
echo ">> Install curl: "
echo " "
sudo apt install -y curl

# Install updated repository
echo " "
echo ">> Install QtPyVCP Repository "
echo " "

echo 'deb [arch=arm64] https://repository.qtpyvcp.com/apt stable main' | sudo tee /etc/apt/sources.list.d/kcjengr.list
curl -sS https://repository.qtpyvcp.com/repo/kcjengr.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kcjengr.gpg
gpg --keyserver keys.openpgp.org --recv-key 2DEC041F290DF85A

echo " "
echo ">> Verify Repository: "
echo " "

sudo apt update
