#!/usr/bin/env Rscript
library("optparse")

opt_parser = OptionParser(description = "
##_Methrix Tutorial_############################################################
Version = '0.0.1'
Date = '2020-03-05'
Author = 'Yoann PAGEAUD'
Maintainer = 'Yoann PAGEAUD (yoann.pageaud@gmail.com)'
Dependencies = c('R version 3.6.2 (2019-12-12)',
'RStudio Version 1.2.5019 – © 2009-2019','!!Add dependencies here!!')
Description = 'script description here'
################################################################################
");
if (is.null(parse_args(opt_parser)$file) != TRUE){print_help(opt_parser);quit()}

#Load library
library(methrix)
library(BSgenome.Hsapiens.UCSC.hg19) 

#Example bedgraph files 2 cancer samples and 2 normal samples
bdg_files <- list.files(
  path = system.file('extdata', package = 'methrix'),
  pattern = "*bedGraph\\.gz$",
  full.names = TRUE
)

#Generate some sample annotation table
sample_anno <- data.frame(
  row.names = gsub(
    pattern = "\\.bedGraph\\.gz$",
    replacement = "",
    x = basename(bdg_files)
  ),
  Condition = c("cancer", 'cancer', "normal", "normal"),
  Pair = c("pair1", "pair2", "pair1", "pair2"),
  stringsAsFactors = FALSE
)

#First extract genome wide CpGs from the desired reference genome
hg19_cpgs <- methrix::extract_CPGs(ref_genome = "BSgenome.Hsapiens.UCSC.hg19")

#Read the files 
meth <- methrix::read_bedgraphs(
  files = bdg_files,
  ref_cpgs = hg19_cpgs,
  chr_idx = 1,
  start_idx = 2,
  M_idx = 3,
  U_idx = 4,
  stranded = FALSE,
  zero_based = FALSE, 
  collapse_strands = FALSE, 
  coldata = sample_anno
)

#Generate report
methrix::methrix_report(meth = meth, output_dir = "/home/yoann/methrix_tuto/")

#Remove uncovered locis
meth = methrix::remove_uncovered(m = meth)

if(!require(MafDb.1Kgenomes.phase3.hs37d5)) {
  BiocManager::install("MafDb.1Kgenomes.phase3.hs37d5")} 
if(!require(GenomicScores)) {
  BiocManager::install("GenomicScores")}

library(MafDb.1Kgenomes.phase3.hs37d5)
library(GenomicScores)

#Remove SNPs
meth_snps_filtered <- methrix::remove_snps(m = meth)

#Example data bundled, same as the previously generated meth 
data("methrix_data")

#Coverage matrix
coverage_mat <- methrix::get_matrix(m = methrix_data, type = "C")
head(coverage_mat)

#Methylation matrix
meth_mat <- methrix::get_matrix(m = methrix_data, type = "M")
head(meth_mat)

#If you prefer you can attach loci info to the matrix and output in GRanges format
meth_mat_with_loci <- methrix::get_matrix(m = methrix_data, type = "M",
                                          add_loci = TRUE, in_granges = TRUE)
meth_mat_with_loci

#e.g; Retain all loci which are covered at-least in two sample by 3 or more reads
methrix::coverage_filter(m = methrix_data, cov_thr = 3, min_samples = 2)

#Retain sites only from chromosme chr21
methrix::subset_methrix(m = methrix_data, contigs = "chr21")

#e.g; Retain sites only in TP53 loci 
target_loci <- GenomicRanges::GRanges("chr21:27867971-27868103")
methrix::subset_methrix(m = methrix_data, regions = target_loci)

#Subset by sample
methrix::subset_methrix(m = methrix_data, samples = "C1")

#Get basic statistics
meth_stats <- get_stats(m = methrix_data)

#Draw mean coverage per sample
plot_stats(plot_dat = meth_stats, what = "C", stat = "mean")

#Draw mean methylation per sample
plot_stats(plot_dat = meth_stats, what = "M", stat = "mean")

#Do PCA
mpca <- methrix_pca(m = methrix_data, do_plot = FALSE)
#Plot PCA results
plot_pca(pca_res = mpca, show_labels = TRUE)

#Color code by an annotation
plot_pca(pca_res = mpca, m = methrix_data, col_anno = "Condition")

#Violin plots
methrix::plot_violin(m = methrix_data)

#Coverage
methrix::plot_coverage(m = methrix_data, type = "dens")

#Convert Methrix object into Bsseq object
if(!require(bsseq)) {
  BiocManager::install("bsseq")}
library(bsseq)
bs_seq <- methrix::methrix2bsseq(m = methrix_data)

bs_seq



