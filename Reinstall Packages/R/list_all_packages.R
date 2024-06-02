#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_List_All_Packages_###########################################################
Version = '1.0'
Date = '2024-05-02'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Description = 'Save packages installed in a former lib.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

# ENTER YOUR OLD LIBRARY PATH HERE
lib_path <- "~/R/x86_64-pc-linux-gnu-library/4.3/"

# THEN RUN THIS
lib_v <- gsub(
  pattern = "^.+\\/(\\d\\.\\d)\\/*$", replacement = "\\1", x = lib_path)
f_name <- paste("R", lib_v, "packages.txt", sep = "_")
write.table(
  x = installed.packages(lib.loc = lib_path)[, c("Package", "Version")],
  file = f_name, row.names = FALSE,
  col.names = FALSE, quote = FALSE)
if(file.exists(f_name)){
  cat("packages list successfully saved in:", file.path(getwd(), f_name)) }
