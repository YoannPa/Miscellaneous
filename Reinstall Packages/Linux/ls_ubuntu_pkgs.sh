#!/bin/bash

#List Ubuntu packages installed
#This script is completely free of rights
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Ubuntu 16.04 and above.

echo Creating \file containing installed packages...
dpkg --get-selections | grep -v deinstall > ~/list_installed_packages.txt
printf ' \n'
echo Done\! Check the \file\: ~/list_installed_packages.txt
printf ' \n'
printf '*%.0s' {1..80} 
printf '\nHow to cite: Yoann Pageaud. List Ubuntu packages installed\.\nUniversité Paris Diderot-Paris 7. 2016.\n'
printf '*%.0s' {1..80}
printf '\n'
