#!/bin/sh
echo ">>>>>Resource<<<<<<"
CPUNA=$(cat /proc/cpuinfo |grep "model name\|cpu MHz" |head -2 && hostnamectl |grep "Operating System\| Kernel")
echo "$CPUNA"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
df -h | awk '$NF=="/home"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "CPU Load Average: %.2f\n", $(NF-2)}'
top -bn1 | awk -F  "[: ]+" '/Cpu/{print "CPU Usage Total :", $2 "%"}'
echo "Total Download & Upload Internet"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |head -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |head -n 1
echo "Total Download & Upload Local/Tunnel"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |tail -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |tail -n 1
echo "status Server ON"
uptime -p
TotX=$(while read lineX; do netstat -netulp |grep 127.0.0.1:$lineX; done <<<$(cat /home/all-portRpcUse.txt) |wc -l)
TotU=$(cat /home/user.txt |wc -l)
echo "User aktif $TotU "
echo "Node aktif $TotX "