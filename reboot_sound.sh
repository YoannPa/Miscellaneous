#!/bin/bash

#reboot_sound
#Description: restarts Ubuntu sound apps when sound does not work.
#Author: PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux - Ubuntu 16.04
#This script is free of rights.

echo "Restarting pulseaudio and ALSA..."
pulseaudio -k && sudo alsa force-reload
echo "Done."
echo "Suspending CPU in 5s... Please press any key right after!"
sleep 5
sudo pm-suspend
echo "Done! Sound has been successfully rebooted!"
