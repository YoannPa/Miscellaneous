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
      ls.R.pkgs <- list.dirs(
        path = lib.dir, recursive = FALSE, full.names = FALSE)
    }
  } else {
    ls.R.pkgs <- as.character(unlist(read.table(txt.file)))
  }
  return(ls.R.pkgs)
}

# RUN THIS with either a .txt file or an old lib dir.
ls.R.pkgs <- ls_pkgs(txt.file = "R_4.3_packages.txt")
ls.R.pkgs <- ls_pkgs(lib.dir = "~/R/x86_64-pc-linux-gnu-library/4.2/")

# OPTIONAL (recommended) install BiocManager
if(!"BiocManager" %in% installed.packages()){ install.packages("BiocManager") }

# INSTALL PACKAGES
ls.R.pkgs <- ls.R.pkgs[!ls.R.pkgs %in% installed.packages()[, 1]]
if(length(ls.R.pkgs) > 0){
  CRAN_pkg <- ls.R.pkgs[ls.R.pkgs %in% available.packages()]
  other_pkg <- ls.R.pkgs[!ls.R.pkgs %in% available.packages()]
  if(length(CRAN_pkg) > 0){ install.packages(CRAN_pkg) }
  if(length(other_pkg) > 0 & "BiocManager" %in% installed.packages()){
    BiocManager::install(pkgs = other_pkg)
  }
} else { cat("All packages are already installed.") }
