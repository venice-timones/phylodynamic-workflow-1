##Read Argument
args = commandArgs(trailingOnly = TRUE)

##Load directories
setwd("/Users/ijborda/GitHub/gisaid-preprocessing/ncov-master")
wd = getwd()
id = paste0(wd,"/output/")   
od = paste0(wd,"/align/")

##Load libraries
require(pacman)
p_load(EpiCurve,dplyr,tidyr,pacman, ggplot2,ggthemes,broom,stringr,ggpubr,scales,lubridate)

##Required input
filename <-  args[1] #filename <- "211102.bdmm"  

#Read data
metadata <- read.delim(file = (paste0(id,filename,".metadata.sanitized.clean.tsv")) , sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")

#Clean region names
metadata$division <- ifelse(grepl("Davao Region", metadata$division),'Davao', metadata$division)
metadata$division <- ifelse(grepl("Bangsamoro Autonomous Region in Muslim Mindanao", metadata$division),'BARMM', metadata$division)
metadata$division <- ifelse(grepl("Region IX", metadata$division),'Zamboanga', metadata$division)
metadata$division <- ifelse(grepl("National Capital Region", metadata$division),'NCR', metadata$division)

#Save dataframe
write.table(metadata, 
            file = paste0(od, paste0(filename, ".metadata.sanitized.clean.aligned.tsv")),
            quote=FALSE, 
            sep='\t',
            row.names = FALSE)

