#!/bin/bash
if [ ! -d /home/datadir ]
then
	idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)

	#------------ download idena node latest version--------------#

	wget $idena_download -q --show-progress -O /usr/bin/idena
	wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -q --show-progress -O /usr/bin/idena-update
	chmod +x /usr/bin/idena
	chmod +x /usr/bin/idena-update
	#--------------- create idena service-------------------------#

touch /home/config.json
cat <<EOF > /home/config.json
{"IpfsConf":{"Profile": "server" ,"FlipPinThreshold":1},"Sync": {"LoadAllFlips": true}}
EOF

cat <<EOF > /lib/systemd/system/idena-node.service
[Unit]
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/
User=root
ExecStart=-/usr/bin/idena --config=config.json

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena-node
service idena-node start

echo "wait.... build datadir"
sleep 30
echo "kenebaezxcpm" > /home/$idenahome/$idenanumber/datadir/api.key
service idena stop
systemctl daemon-reload
rm -rf /home/datadir/idenachain.db/*
rm -rf /home/$idenahome/$idenanumber/datadir/ipfs/*

service idena-node start
if command -v npm && command -v node && command -v git &> /dev/null
then
    echo "command exists."
else if command -v yum || ! command -v dnf &> /dev/null
	then 
		yum install -y npm wget curl git
	else
	apt update -y
	apt install -y wget npm curl git
	fi

cd /home && git clone https://github.com/idena-network/idena-node-proxy
cd /home/idena-node-proxy
npm i -g pm2 &> /dev/null
cat <<EOF > /home/idena-node-proxy/.env
AVAILABLE_KEYS=["TWYQCz","qjVtfD","xDhnjN","AtjJZK","Qvzasq","sLAxpY","vAYrET","haxBAJ","DXxjwN","yGqKvw","PWXxHs","cnjsEa","JwevTh","Kyjqsk","ZGWnry","AbBZgS","bBXhLH","qNwhyF","jTANLY","RcHSwA","VNMvyT","EeMXhu","cntZwx","fCHrDq","uGVeaQ","cVMqTh","NjVBuk","gpFZkU","dKQtZT","nThUZf","sCUZLx","ebFLmg","LbcCGg","gpyVbU","cYPsTR","tQJRPB","QDpmuj","ewEnBL","VPUtWk","GMNvew","mtpwDG","xtGqXW","GfLEnR","tPhEfH","ZzEvXp","wbQVyr","MCGmRd","ELvkpb","xvbGsg","DXkvYg","TbDQxS","JCarHq","mSPEsQ","KNzxPA","Xtnwzc","jNhgaT","tWvfxw","uxSKdb","YuFAKP","eDhZzY","qmZuEG","vZnWcM","uenyRh","TkHntS","CJjxyA","CHJpqD","esMGxY","rvEeGF","gDHyqC","crUELg","jSFnaJ","dWtmUH","RrdZEP","cbCgdH","BSarDs","zkmBCh","JBwfNd","gRhLwv","tLyZeg","HnhQjG","fxmSRD","EsCLAM","ghBaXP","KMThZk","ZLWFuH","dqARNt","rRQfKA","VUpKbt","EAfdhm","xLGAmK","ymZgEk","gTEUyM","WSMErH","kwFKXQ","USWsQK","wEBYSx","FZrWBT","wbjUYV","WNzmBf","pTPJVU","hZRPDX","EVygmu","NaXjgh","zEcMBQ","qheVzQ","SZMhJL","JUyxam","jPxpGm","EVsBFh","JYvXjV","EhTpVM","ZXhebg","QFUeav","LUfryb","HXcWSE","RNKcCv","CVkbPL","fSQcrC","xdsDwQ","MfKRZT","BaEXeD","jSTYPd","wQgGtF","yDawEK","PLtvwT","bKJFSc","HnDkcy","urKvMN","WTdAzJ","SVBnEz","ngavFe","MCUbgf","EekNcX","ehsgCr","zADdtc","LZqNpu","AjedNv","MRbdTf","eHjETP","vBnYbT","TEnWDJ","XJsjUw","WkQPrp","WwEFbZ","BJmcAK","QhsKzx","XRMcGf","BAVmzF","QtmhkX","nNywLe","zDQtVN","jpZYFq","TZcRNn","ZBdxEH","QvwhpG","jUrFBY","ZMUGBy","XnDxec","NxghuZ","ScXCKn","ayMEFK","jZKwrR","ktpXdn","xUFcRL","FxAbHz","LRvdeC","XRmFaz","CEVNft","QuXBZE","WtKcsr","bmCkUf","gkaYsF","LEqfvk","umeLsb","CKTkbW","JPMaHg","LwChbX","ZXHmxW","NnetgE","zbHVLs","GAbpzJ","vVgcxk","BfvXea","XYqnHb","LnrwEt","aGwSbe","stBPpE","XDGAgM","qVSsre","jJhKZG","FWuRSG","jCuePY","MqjNHb","MnUzCJ","GUtFPn","hWrCkG","nFcAKt","EmNHua","FBPzwQ","aHQkhb"]
IDENA_URL="http://localhost:9009"
IDENA_KEY="kenebaezxcpm"
PORT=80
EOF
cd /home/idena-node-proxy && npm install &> /dev/null
cd /home/idena-node-proxy && npm start &> /dev/null
fi
echo " Copy this API key to your idena client "
cat /home/$idenahome/$idenanumber/datadir/api.key && echo ''
else
    echo "datadir sudah ada , script not executed"
fi