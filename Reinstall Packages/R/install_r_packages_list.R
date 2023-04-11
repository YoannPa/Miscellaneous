#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_Install R Packages List_#####################################################
Version = '1.0'
Date = '2019-06-11'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 3.6.0 (2019-04-26)',
'RStudio Version 1.1.463 – © 2009-2018')
Description = 'Install all packages listed in a text file from Bioconductor.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

##FUNCTIONS
ls_pkgs <- function(txt.file = NULL, lib.dir = NULL){
  if(is.null(txt.file)){
    if(is.null(lib.dir)){
      stop("You need to provide either a txt file or a directory.")
    } else {
      ls.R.pkgs <- list.dirs(
        path = lib.dir, recursive = FALSE, full.names = FALSE)
    }
  } else {
    ls.R.pkgs <- as.character(unlist(read.table(txt.file)))
  }
  return(ls.R.pkgs)
}

##PARAMETERS
#Load List of packages from text file or from a previous library
# ls.R.pkgs <- ls_pkgs(lib.dir = "~/R/x86_64-pc-linux-gnu-library/4.0/")
ls.R.pkgs <- read.table(
  "/media/yoann/6489-5C3B/Backup_Laptop_2023/Ubuntu_Session/List_R_Packages.txt")[, 1]
##MAIN
#Check for Packages already installed and install package if not installed
pkgs.to.install <- ls.R.pkgs[!ls.R.pkgs %in% installed.packages()[, 1]]
#Check if BiocManager is installed; if no, install it
if(!"BiocManager" %in% installed.packages()){ install.packages("BiocManager") }
#Check if list is empty
if(length(pkgs.to.install)>0){ BiocManager::install(as.vector(pkgs.to.install))
} else { cat("All packages are already installed.") }
