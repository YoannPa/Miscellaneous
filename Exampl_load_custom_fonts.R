#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_Example load custom fonts_###################################################
Version = '0.0.1'
Date = '2020-08-06'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 4.0.5 (2021-03-31)',
'RStudio Version 1.2.5019 – © 2009-2019','!!Add dependencies here!!')
Description = 'An example of how to integrate downloaded fonts in R.'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

##IMPORTS
library(showtext)

##MAIN
# Tiepolo Book SC
font_add(family = "Tiepolo Book SC",
         regular = "~/OnlineWebFonts_COM_2914d2f9e80fcca837cb9154ee802e36/ITC Tiepolo W01 Book SC/ITC Tiepolo W01 Book SC.ttf")
showtext_auto()

# Rotonda Bold
font_add(family = "Rotonda Bold", regular = "~/1260-font.ttf")
showtext_auto()

# Rotunda Bold
font_add(family = "Rotunda Bold",
         regular = "~/Rotunda_www.Dfonts.org/Rotunda/Rotunda-Bold.otf")
showtext_auto()
