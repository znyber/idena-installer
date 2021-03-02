#!/bin/sh
echo ">>>>>Resource<<<<<<"
CPUNA=$(cat /proc/cpuinfo |grep "model name\|cpu MHz" |head -2 && hostnamectl |grep "Operating System\| Kernel")
echo "<code>$CPUNA</code>"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "CPU Load Average: %.2f\n", $(NF-2)}'
top -bn1 | awk -F  "[: ]+" '/Cpu/{print "CPU Usage Total :", $2 "%"}'
echo "load CPU Usage on all Cores"
n=1
while read line; do
echo "<code>Core $n : $line </code>"
n=$((n+1))
done <<<$(top -bn1 1 | awk -F  "[: ]+" '/Cpu/{print $2 "%"}')
echo "Total Download & Upload Internet"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |head -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |head -n 1
echo "Total Download & Upload Local/Tunnel"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |tail -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |tail -n 1
echo "status Server ON"
uptime -p
TotX=$(while read lineX; do netstat -netulp |grep $lineX; done <<<$(cat /home/all-portRpcUse.txt) |wc -l)
TotU=$(cat /home/user.txt |wc -l)
echo "User aktif <code> $TotU </code>"
echo "Node aktif <code> $TotX </code>"