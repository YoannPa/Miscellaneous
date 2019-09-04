#!/bin/bash

#Installed Ubuntu Packages Listing
#This script is completely free of rights
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux 16.04

echo Creation of the \file containing of the installed packages
dpkg --get-selections | grep -v deinstall > List_Installed_Packages
printf ' \n'
echo Done\! Check the \file\: List_Installed_Packages
printf ' \n'
printf '*%.0s' {1..80} 
printf '\nHow to cite: Yoann Pageaud. Installed Ubuntu Packages Listing\.\nUniversité Paris Diderot-Paris 7. 2016.\n'
printf '*%.0s' {1..80}
printf '\n'
