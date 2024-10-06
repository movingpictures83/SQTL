## ----setup_knitr, include=FALSE, cache=FALSE-------------------------------
library(knitr)
library(DRIMSeq)
opts_chunk$set(cache = FALSE, warning = FALSE, out.width = "7cm", fig.width = 7, out.height = "7cm", fig.height = 7)
library(PasillaTranscriptExpr)

input <- function(inputfile) {
   myprefix <<- inputfile
}

run <- function() {

}

output <- function(outputfile) {
geuv_counts <- readRDS(paste(myprefix, "counts", "rds", sep="."))
geuv_genotypes <- readRDS(paste(myprefix, "genotypes", "rds", sep="."))
geuv_gene_ranges <- readRDS(paste(myprefix, "gene", "rds", sep="."))
geuv_snp_ranges <- readRDS(paste(myprefix, "snp", "rds", sep="."))

## ----SQTLdmSQTLdata_create, message=FALSE----------------------------------
colnames(geuv_counts)[c(1,2)] <- c("feature_id", "gene_id")
colnames(geuv_genotypes)[4] <- "snp_id"
geuv_samples <- data.frame(sample_id = colnames(geuv_counts)[-c(1,2)])

d <- dmSQTLdata(counts = geuv_counts, gene_ranges = geuv_gene_ranges,
  genotypes = geuv_genotypes, snp_ranges = geuv_snp_ranges, 
  samples = geuv_samples, window = 5e3)
saveRDS(d, outputfile)
}
