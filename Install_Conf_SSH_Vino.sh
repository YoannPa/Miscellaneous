#!/bin/bash

#Install and Configure SSH and Vino
#This script is completely free of rights
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Ubuntu 16.04

sudo apt install openssh-client openssh-server vino remmina
vino-preferences
vino-passwd
echo Done!
