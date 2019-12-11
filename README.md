# Miscellaneous
Miscellaneous scripts...

## Reinstall Packages
This folder contains scripts I use when I want to reinstall packages (Linux, R or Python3) I used in a former configuration.  

## Variant_Density_along_DNA_Sequence_1.0
R script to plot the density of variants contained in a VCF file along the DNA sequence you have annotated (Chromosome, Scaffold, Contig, Whole Genome, ...).  

## Others
* `funRDS.R` - A script containing functions related to RDS file manipulations.  
* `fun_stringeval.R` - A script containing functions related to string evaluations.  
* `Install_Conf_SSH_Vino.sh` - A script that install packages to use the Reminna video service for distant desktop access. It is also used for setting vino properly. No idea if this still works...  
* `manage_na.R` - A script containing a function doing imputation of missing values on matrix or data.frame based on known groups of samples. It is useful when you have missing values for a sample and that you know this sample is supposed to have relatively similar values to samples in the same group. The median of the group replace the missing value. If only 1 value is available, this value replace the missing one. If 2 values are available, the mean is computed instead. 
* `My_RStudio_snippets.txt` - That file contains the snippets I used in RStudio.  
* `parallel_histogram.R` - This function was an attempt to make the computation of histograms in R faster for large amount of data. It is unfortunately slower than the hist() and geom_histogram() functions.  
* `Projects_Kalendar_Generator.R` - Something I am thinking about currently, to organize in a smart way the time I want to dedicate to each project I am currently working on. Possibly an interesting tool to develop here...  
* `reboot_sound.sh` - A script that allow a user to reboot the sound system on its computer when it is not working properly (Linux OS). It can be the case especially for laptop users with dual boot configurations... many other causes can explain sound malfunctions.  

