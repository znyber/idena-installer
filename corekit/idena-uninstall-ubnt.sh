#!/bin/bash
rm -rf /home/.env
rm -rf /home/datadir
rm -rf /home/idenafast
rm -rf /home/idenachain.db.zip
rm -rf /home/index.js
rm -rf /home/package.json
rm -rf /home/tulung.txt
rm -rf /home/portIpf.txt
rm -rf /home/portRpc.txt
rm -rf /home/config.json
rm -rf /home/niteni
rm -rf /home/idena*
rm -rf /home/*.txt
rm -rf /home/*.js
systemctl disable idena.service
rm -rf /usr/lib/systemd/system/idena*
rm -rf /etc/systemd/system/
rm -rf /etc/systemd/system/idena.target*
rm -rf /usr/bin/idena*
rm -rf /usr/bin/wBatch
rm -rf /usr/bin/clear-ipfs
rm -rf /usr/bin/ceklek-htm
rm -rf /usr/bin/list-ic
rm -rf /usr/bin/miningallon
iptables -F
pm2 delete idena-node-proxy
pm2 delete telegraf-bot
pm2 unstartup
apt autoremove -y nodejs unzip git pwgen