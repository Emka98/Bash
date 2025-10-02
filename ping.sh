#!/bin/bash

IP=$1

sppeed=(10 100 1000)
interface=$(ip -o -4 route show to default | awk '{print $5}')
numberOfPing=10

for num in "${sppeed[@]}"
do
 echo ""
 sudo ethtool -s "$interface" speed $num duplex full autoneg off
 sleep 10
 ethtool "$interface" | grep Speed
 ping -c "$numberOfPing" "$IP"
done
