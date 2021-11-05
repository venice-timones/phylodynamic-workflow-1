##Read Argument
args = commandArgs(trailingOnly = TRUE)

##Load directories
setwd("/Users/ijborda/GitHub/gisaid-preprocessing/ncov-master")
wd = getwd()
id = paste0(wd,"/align/")   
od = paste0(wd,"/align/")

##Load libraries
require(pacman)
p_load(EpiCurve,dplyr,tidyr,pacman, ggplot2,ggthemes,broom,stringr,ggpubr,scales,lubridate)

##Required input
filename <-  args[1] #filename <- "211102.bdmm"  

#Read data
metadata <- read.delim(file = (paste0(id,filename,".metadata.sanitized.clean.aligned.tsv")) , sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")

#Make dataframe
metadata <- data.frame(metadata[1], metadata[3])

#Save dataframe
write.table(metadata, 
            file = paste0(od, paste0(filename, ".date.txt")),
            quote=FALSE, 
            sep='\t',
            row.names = FALSE)

