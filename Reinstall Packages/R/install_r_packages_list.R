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

# LOAD THIS FUNCTION
ls_pkgs <- function(txt.file = NULL, lib.dir = NULL){
  if(is.null(txt.file)){
    if(is.null(lib.dir)){
      stop("You need to provide either a txt file or a lib directory.")
    } else {
      ls.R.pkgs <- installed.packages(
        lib.loc = lib.dir)[, c("Package", "Version")]
    }
  } else {
    ls.R.pkgs <- read.table(txt.file)
    colnames(ls.R.pkgs) <- c("Package", "Version")
  }
  return(ls.R.pkgs)
}

# RUN THIS with either a .txt file or an old lib dir.
ls.R.pkgs <- ls_pkgs(txt.file = "R_4.3_packages.txt")
ls.R.pkgs <- ls_pkgs(lib.dir = "~/R/x86_64-pc-linux-gnu-library/4.3/")

# OPTIONAL (recommended) install BiocManager
if(!"BiocManager" %in% installed.packages()){
  bioc_mng_v <- unlist(ls.R.pkgs[ls.R.pkgs[, "Package"] == "BiocManager",])[2]
  install.packages("BiocManager", version = bioc_mng_v)
}

# INSTALL PACKAGES
pkg_ver <- paste(ls.R.pkgs[,"Package"], ls.R.pkgs[, "Version"], sep = "|")
pkg_inst <- paste(
  installed.packages()[, "Package"], installed.packages()[, "Version"],
  sep = "|")
ls.R.pkgs <- ls.R.pkgs[!pkg_ver %in% pkg_inst, ]
if(nrow(ls.R.pkgs) > 0){
  CRAN_pkg <- ls.R.pkgs[ls.R.pkgs[, "Package"] %in% available.packages(),]
  other_pkg <- ls.R.pkgs[!ls.R.pkgs[, "Package"] %in% available.packages(),]
  if(nrow(CRAN_pkg)>0){
    install.packages(CRAN_pkg[, "Package"], version = CRAN_pkg[, "Version"])
  }
  if(nrow(other_pkg)>0 & "BiocManager" %in% installed.packages()[, "Package"]){
    BiocManager::install(pkgs = other_pkg[, "Package"])
  }
} else { cat("All packages are already installed.") }
