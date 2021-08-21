#!/bin/bash

cd ~
sudo echo

sudo apt update
sudo apt install wget openssl build-essential bash-completion -y

wget https://www.softether-download.com/files/softether/v4.38-9760-rtm-2021.08.17-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
tar xzvf softether-vpnserver*
cd vpnserver
make
cd ..
sudo cp -r vpnserver /usr/local
cd /usr/local/vpnserver
sudo chmod 700 vpncmd vpnserver
sudo chmod +x vpncmd vpnserver

echo '[Unit]' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'Description=SoftEther VPN Serve' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'After=network.target network-online.target' | sudo tee -a /etc/systemd/system/vpnserver.service
echo '[Service]' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'ExecStart=/usr/local/vpnserver/vpnserver start' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'ExecStop=/usr/local/vpnserver/vpnserver stop' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'Type=forking' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'RestartSec=3s' | sudo tee -a /etc/systemd/system/vpnserver.service
echo '[Install]' | sudo tee -a /etc/systemd/system/vpnserver.service
echo 'WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/vpnserver.service


sudo systemctl enable vpnserver
sudo systemctl start vpnserver

echo "done"
