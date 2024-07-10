#!/bin/bash

#Temporary reset network interface MAC address to bypass Teamviewer free limitation.
#The mac address is set to its initial value after reboot.
#This script is free of rights.
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux - Ubuntu 22.04
#This script is free of rights.

if [ "$1" != "" ] && [ "$1" != "-h" ]; then
	netint=$(ip a s "$1");
	if [ "$netint" == "" ]; then
		echo "Error: Network interface not found."
	else
		sudo systemctl stop teamviewerd.service;
		sudo rm /opt/teamviewer/config/global.conf;
		ip -o link | grep "$1" | awk '{ print "The old Mac address is: " $17 }';
		#newmac=$(echo $FQDN|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/00:\1:\2:\3:\4:\5/'); #This method allows to reproduce the MAC address based on the FQDN of the machine.
		newmac=$(tr -dc a-f0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/00:/'); #This method randomly generates a new MAC address.
		sudo ip link set dev "$1" down;
		sudo ip link set dev "$1" address "$newmac";
		sudo ip link set dev "$1" up;
		echo "The new Mac address is:" $newmac;
		sudo systemctl start teamviewerd.service;
	fi
elif [ "$1" == "-h" ]; then
	echo Usage: ./temp_reset_mac_address_teamviewer.sh netint_name
	echo	
	echo Command line examples:
	echo "./temp_reset_mac_address_teamviewer.sh enp39s0"
	echo	
	echo Report a bug: create a Github issue on the repository or mail me at yoann.pageaud@gmail.com
fi
