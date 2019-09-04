#!/usr/bin/python
# -*- coding: utf8 -*-

##Installed Python Packages Listing:
#This script is completely free of rights
#Author : Yoann PAGEAUD - yoann.pageaud@gmail.com
#Université Paris Diderot-Paris 7
#Runs under Python Version 2.7.12

##IMPORT PACKAGE
import pip

##OUTPUT FILE CREATION
outputfilename='List_Installed_Python_Packages.txt'
path=raw_input('Paste the path to the folder where you want your List of Installed Package file to be saved :')
output=open('{:s}{:s}{:s}'.format(path,"/",outputfilename),'w')


##LISTING ALL PACKAGES
installed_packages = pip.get_installed_distributions()
for i in range(len(installed_packages)):
    
##PRINTER
    print >>output, "{:<40s}{:^20s}".format(installed_packages[i].key, installed_packages[i].version)
    
##REFERENCE
print >> output, " "
print >> output, "*"*80
print >> output, " "
print >> output, "How to cite : Yoann Pageaud. 'Installed Python Packages Listing'.\nUniversité Paris Diderot-Paris 7. 2016."
print >> output, " "
print >> output, "*"*80