#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_Create R hexSticker_#########################################################
Version = '0.0.1'
Date = '2020-03-10'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 3.6.2 (2019-12-12)',
'RStudio Version 1.2.5019 – © 2009-2019','hexSticker')
Description = 'Create a hexSticker for a R package.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}