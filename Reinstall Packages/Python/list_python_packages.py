#!/usr/bin/python
# -*- coding: utf8 -*-

##List Python Packages:
#This script is completely free of rights
#Author : Yoann PAGEAUD - yoann.pageaud@gmail.com
#DKFZ - Heidelberg, Germany.
#Runs under Python Version 3.5

##IMPORT PACKAGE
import pkg_resources
import sys
##OUTPUT FILE CREATION
outputfilename='List_Installed_Python_Packages.txt'
path=input('Paste the path to the folder where you want your List of Installed Package file to be saved :')
output=open('{:s}{:s}{:s}'.format(path,"/",outputfilename),'w')


##LISTING ALL PACKAGES
installed_packages = pkg_resources.working_set
inst_pkg_ls = ["{:<40s}{:^20s}\n".format(i.key,i.version) for i in installed_packages]

##PRINTER
f = open(outputfilename, 'a')
for i in range(len(inst_pkg_ls)):
    f.write(inst_pkg_ls[i])

##REFERENCE
f.write(" \n")
f.write("*"*80 + "\n") 
f.write(" \n")
f.write("How to cite : Yoann Pageaud. 'List Python Packages'.\nDKFZ - Heidelberg, Germany. 2019.\n")
f.write(" \n")
f.write("*"*80 + "\n")
f.close()
