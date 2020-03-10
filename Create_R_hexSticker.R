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
Description = 'Creates a hexSticker for a R package.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

##IMPORTS
setwd("/home/yoann/DTrsiv/")
library(hexSticker)
library(magick)
imgurl<-system.file("img/DTrsiv_icon.png", package="DTrsiv")
sticker(imgurl, package="DTrsiv", asp = 12, dpi = 600,
        s_x = 0.95, s_y = 1,
        p_x = 1, p_y = 0.75, p_color = "black", p_size = 27,
        h_color = "yellow",
        spotlight = TRUE, l_x = 0.98, l_y = 1, l_width = 6, l_height = 6,
        l_alpha = 0.3,
        filename="img/my_hexsticker.png")