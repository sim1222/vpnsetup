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
sudo cp vpnserver /usr/local
cd /usr/local/vpnserver
sudo chmod 700 vpncmd vpnserver
chmod +x vpncmd vpnserver

{
    [Unit]
Description=SoftEther VPN Server
After=network.target network-online.target

[Service]
ExecStart=/usr/local/vpnserver/vpnserver start
ExecStop=/usr/local/vpnserver/vpnserver stop
Type=forking
RestartSec=3s

[Install]
WantedBy=multi-user.target
} > /etc/systemd/system/vpnserver.service
sudo systemctl enable vpnserver
sudo systemctl start vpnserver

echo "done"