#Variants Density along DNA Sequence
#Author: Yoann PAGEAUD
#Date: September 27th, 2016

library(VariantAnnotation)
library(plyr)


setwd("/home/user/your_folder/")


vcf <- readVcf("Example.vcf","S.cerevisiae")


Data_Frame_ranges<-as.data.frame(ranges(vcf))
sequence<-Data_Frame_ranges[grep("^chr-E",Data_Frame_ranges$names),]


Matrix_Position_Sequence<-as.matrix(sequence[1])


start_position = head(sequence[[2]],n=1L)
end_position = tail(sequence[[2]],n=1L)


histogram_breakpoints = 347
window_size = round((end_position - start_position)/histogram_breakpoints)


hist(Matrix_Position_Sequence,
     xlim=c(start_position,end_position),
     breaks = histogram_breakpoints,
     col='blue',
     xaxt="n",
     border='blue',
     ylim=c(0,10),
     main='Density of Variants along a DNA Sequence',
     xlab='Positions on Sequence (bp)',
     ylab=paste("Variants Density (Sliding Window of ~",window_size,"bp)",sep=" "))


step_accuracy=10**4


axis(1, at = seq(from = round_any(start_position,
                                  step_accuracy,
                                  f=floor),
                 to = round_any(end_position,
                                step_accuracy,
                                f=ceiling),
                 by = round_any(end_position,
                                step_accuracy,
                                f=ceiling)/
                   ((1/step_accuracy)*
                      round_any(end_position,
                                step_accuracy,
                                f=ceiling))))

