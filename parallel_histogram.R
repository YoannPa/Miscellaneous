
##IMPORTS
Imports = c("quantmod","ggplot2","ggrepel","parallel")
lapply(Imports, library, character.only = T)

##FUNCTIONS

# par.hist ###########################################################

#' @description compute in parallel and plot an histogram using ggplot2 from a
#'              given vector of values.
#'
#' @param x          A \code{numeric} vector to be used for plotting the
#'                   histogram.
#' @param xmax       A \code{numeric} specifying the maximum limit on the x axis
#'                   to display values. All values above this limit will be
#'                   agregated on the last histogram bin.
#' @param nbreaks    An \code{integer} specifying the number of delimitations to
#'                   be use for histogram bins (Default: nbreaks = 10).
#' @param ngrad      An \code{integer} specifying the number of graduations to
#'                   display on the X-axis of the plot (Default: ngrad = 10).
#' @param round.grad An \code{integer} specifying the number significant digits
#'                   to be considered when calculating graduations
#'                   (Default: round.grad = 1).
#' @param ncores     An \code{integer} to specifying the number of cores to use
#'                   when parallel-running the function (Default: ncores = 1).
#' @param xlab       A \code{character} to be used as X-axis label
#'                   (Default: xlab = 'values').
#' @param ylab       A \code{character} to be used as Y-axis label
#'                   (Default: ylab = 'Frequency').
#' @param bin.col    A \code{character} matching a R color code to be use to
#'                   fill the histogram bins. 
#' @value a \code{gg} plot of an histogram.
#' @author Yoann Pageaud.

par.hist<-function(
  x, xmax, nbreaks=10, ngrad=10, round.grad=1, ncores=1,
  xlab="values", ylab="Frequency", bin.col="#0570b0"){
  #Set Maximum
  x[x > xmax] <- xmax
  #Set breaks
  xbreaks <- seq(0, xmax, length.out = nbreaks)
  #Set graduations
  xgrads <- round(x = seq(0, xmax, length.out = ngrad), digits = round.grad) 
  #Set X axis labels
  xlabs<-as.character(xgrads)
  xlabs[length(xlabs)]<-paste(xlabs[length(xlabs)],"\nor more")
  #Split x in ncores sub vectors
  cat("Split values\n")
  # subx<-split(x, ceiling(1:length(x)/(length(x)/ncores)))
  subx<-splitIndices(length(x), ceiling(length(x)/(length(x)/ncores)))
  subx<-lapply(subx, function(i){x[i]})
  #Parallel compute for each vector the number of values falling in each range 
  cat("Parallel computing\n")
  subhist<-mclapply(subx, mc.cores = ncores, function(i){
    subs<-lapply(seq(length(xbreaks)-1), function(j){
      if(j == length(xbreaks)-1){ #If last bin take values equal to maximum too
        qs<-length(i[i >= xbreaks[j] & i <= xbreaks[j+1]])
      } else { qs<-length(i[i >= xbreaks[j] & i < xbreaks[j+1]]) }
    })
    subs<-unlist(subs)
    return(subs)
  })
  histdata <- Reduce(f = `+`, x = subhist) #Get the sum for each bin 
  #Get recommended cut-off value and median
  cat("Compute Median and Cutoff\n")
  cutoff.val <- findValleys(histdata)[1]
  cutoff.pos <-cutoff.val*(length(histdata)/xmax) + 0.5
  median.val<-median(x,na.rm = TRUE)
  median.pos<-median.val*(length(histdata)/xmax) + 0.5
  histbreaks<-xgrads*(length(histdata)/xmax) + 0.5   #Scale graduations
  dframe<-data.frame(x= seq(histdata), y=histdata) #Create dataframe
  #Plot
  cat("Plotting\n")
  gghist<-ggplot(data = dframe, aes(x=x, y=y)) +
    geom_bar(stat = "identity", width=1, fill = bin.col, alpha = 0.7) +
    scale_x_continuous(breaks = histbreaks, labels = xlabs,
                       limits = c(histbreaks[1],histbreaks[length(histbreaks)]),
                       expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    geom_vline(xintercept = median.pos, color = "#313695", size = 0.7) +
    geom_label_repel(
      data = data.frame(), aes(x = median.pos, y = Inf, fontface = 2,
                               label = paste0("median = ", round(x = median.val,
                                                                 digits = 2))),
      vjust = 1.1, color = "#313695") +
    labs(x = xlab, y = ylab) +
    theme(plot.margin = unit(c(0.1,1,0,0),"cm"),
          axis.title = element_text(size = 13),
          axis.text = element_text(size = 11),
          panel.grid.major = element_line(colour = "grey"),
          panel.grid.minor = element_line(colour = "grey"),
          panel.background = element_rect(fill = "white"))
  #If recommended cut-off inferior or equal to median, plot cut-off
  if(cutoff.val <= median.val){
    gghist<-gghist +
      geom_vline(xintercept=cutoff.pos, color="#d7191c", size=0.7) +
      geom_label_repel(
        data = data.frame(),
        aes(x = cutoff.pos, y = Inf, fontface = 2,
            label = paste0("cut-off = ", round(x = cutoff.val, digits = 2))),
        vjust = 2.4,color = "#d7191c")
  }
  gghist
}
