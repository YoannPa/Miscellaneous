#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_Create R hexSticker_#########################################################
Version = '0.0.1'
Date = '2021-08-05'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 4.0.5 (2021-03-31)',
'RStudio Version 1.2.5019 – © 2009-2019', 'hexSticker')
Description = 'Example of a hexSticker for one of my R package.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

##IMPORTS
setwd("~/methview.qc/")
library(hexSticker)

##MAIN
sticker(subplot = "img/methview_logo_refined_final.png", package = "",
        dpi = 1080, s_x = 1, s_y = 1.08, s_width = 0.85,
        h_color = "#4682B4", h_fill = "white",
        filename = "img/my_hexsticker.png")
