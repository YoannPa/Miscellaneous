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
Description = 'All my R packages hexStickers.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

#WARNING: If you try to reproduce these HexStickers you might not succeed.
# HexStickers creation include use of Adobe Photoshop, Adobe Illustrator or Photopea.
# Moreover, files used for HexStickers design are not necessary available.
# The purpose of this script is to provide some HexSticker creation examples.

##IMPORTS
library(hexSticker)

## methview.qc
setwd("~/methview.qc/")
sticker(subplot = "img/methview_logo_refined_final.png", package = "",
        dpi = 1080, s_x = 1, s_y = 1.08, s_width = 0.85,
        h_color = "#4682B4", h_fill = "white",
        filename = "img/my_hexsticker.png")

## NCBI.BLAST2DT
setwd("~/NCBI.BLAST2DT/")
sticker(subplot = "img/New Project.png", package = "NCBI.BLAST2DT",
        dpi = 300, s_x = 1, s_y = 0.95, s_width = 1, p_y = 1.35, p_size = 18,
        p_family = "Tiepolo Book SC", p_color = "#154a89", h_color = "#154a89",
        h_fill = "#26bdb0", asp = 0.85, filename = "img/my_hexsticker.png")

## DTrsiv
setwd("~/DTrsiv/")
sticker(subplot = "img/DTrsiv_icon.png", package = "DTrsiv", asp = 12,
        dpi = 600, s_x = 0.95, s_y = 1, p_x = 1, p_y = 0.75, p_color = "black",
        p_size = 27, h_color = "yellow", spotlight = TRUE, l_x = 0.98, l_y = 1,
        l_width = 6, l_height = 6, l_alpha = 0.3,
        filename="img/my_hexsticker.png")
