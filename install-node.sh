#!/bin/bash
read -p "Isert User home directory for idena = " idenahome
read -p "Isert node key idena (skip this if you dont have key) = " idenakeystore
mkdir -p /home/$idenahome
idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)

#------------ download idena node latest version--------------#

wget $idena_download -q --show-progress -O /usr/bin/idena
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -q --show-progress -O /usr/bin/idena-update
chmod +x /usr/bin/idena
chmod +x /usr/bin/idena-update
#--------------- create idena service-------------------------#

cat <<EOF > /lib/systemd/system/idena.service
[Unit]
Description=idena service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/$idenahome
User=root
ExecStart=-/usr/bin/idena

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena
service idena start

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/datadir/keystore/nodekey
service idena stop
service idena start
echo " Copy this API key to your idena client "
cat /home/$idenahome/datadir/api.key && echo ''