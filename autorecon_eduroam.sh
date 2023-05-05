#!/bin/bash

#recon_eduroam
#Description: For some laptops, the eduroam wifi network keeps randomly stopping. This script reconnects your computer to eduroam network when pinging to google.com fails.
#To automatically launch this script after booting you can add it into your crontab.
#For example:
# @reboot sleep 30 && bash /home/user/Miscellaneous/autorecon_eduroam.sh
#In your crontab, the previous line will start autorecon_eduroam.sh 30 seconds after your laptop will have boot.
#This scripts depends on nmcli. Please install the package "network-manager" following these steps:
# sudo apt install network-manager;
# systemctl start NetworkManager.service;
# systemctl enable NetworkManager.service;
#Author: PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux - Ubuntu 22.04
#This script is free of rights.

while true;
do
	networkname=$(nmcli -t -f NAME c show --active);
	sleep 1;
	if [[ $networkname == "eduroam" ]]; then
		# echo "$networkname";
		if ! pingout=$(ping -c 1 google.com > /dev/null); then
			# echo "Reconnecting...";
			nmcli con up eduroam;
		fi
	fi
done
