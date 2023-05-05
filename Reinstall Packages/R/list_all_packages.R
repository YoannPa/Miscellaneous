#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_List_All_Packages_###########################################################
Version = '1.0'
Date = '2019-06-11'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 3.6.0 (2019-04-26)',
'RStudio Version 1.1.463 – © 2009-2018',)
Description = 'Print installed packages in a text file.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

write.table(
  x = installed.packages(lib.loc = "~/R/x86_64-pc-linux-gnu-library/4.2/")[,1],
  file = "List_R_Packages.txt", row.names = FALSE, col.names = FALSE,
  quote = FALSE)
