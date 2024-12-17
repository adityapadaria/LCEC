#! /bin/bash

echo "\n------------------------------------------------------------------------------------------------------" # Update Repository
echo "[Step:2] Update APT Repository:"
echo "------------------------------------------------------------------------------------------------------\n"

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
