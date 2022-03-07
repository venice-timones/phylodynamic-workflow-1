#### Libraries
library(ggtree)
library(treeio)
library(ggplot2)
library(patchwork)
library(scales)
library(tidyr)
library(lubridate) 
library(gridExtra)
library(cowplot)
library(bdskytools)
library(tibble)
library(dplyr)
library(imputeTS)

#### Read Input
# DOH data drop
doh1 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch0.csv", sep = ',', header = TRUE)
doh2 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch1.csv", sep = ',', header = TRUE)
doh3 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch2.csv", sep = ',', header = TRUE)
doh4 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch3.csv", sep = ',', header = TRUE)
doh <- rbind(doh1, doh2, doh3, doh4)
doh$DateRepConf <- as.Date(doh$DateRepConf, format="%Y-%m-%d")
# Metadata file for sampling times
metadata <- read.delim(file = "input/metadata.tsv" , sep = '\t', header = TRUE)
metadata$data <- as.Date(metadata$date, format="%Y-%m-%d")
# Info file for latest sampling dates of each region
info <- read.delim(file = "input/info.csv", sep = ',', header = TRUE)
# Log files
barmm.log <- readLogfile(file = "input/barmm.log", burnin=0.1)
caraga.log <- readLogfile(file = "input/caraga.log", burnin=0.1)
davao.log <- readLogfile(file = "input/davao.log", burnin=0.1)
northmindanao.log <- readLogfile(file = "input/northmindanao.log", burnin=0.1)
soccsksargen.log <- readLogfile(file = "input/soccsksargen.log", burnin=0.1)
zamboanga.log <- readLogfile(file = "input/zamboanga.log", burnin=0.1)
# Plot limits
minimum = "2021-01-01"
maximum = "2021-08-31"


#### Load functions
source("scripts/plotRe.R")
source("scripts/plotReCases.R")
source("scripts/plotReSampling.R")
source("scripts/saveReFiles.R")


#### Plot Re for each region and save
barmm.re <- plotRe(barmm.log, "BARMM", info, minimum, maximum) 
davao.re <- plotRe(davao.log, "Davao", info, minimum, maximum) 
caraga.re <- plotRe(caraga.log,"Caraga", info, minimum, maximum)
northmindanao.re <- plotRe(northmindanao.log,"Northern Mindanao", info, minimum, maximum)
soccsksargen.re <- plotRe(soccsksargen.log,"Soccsksargen", info, minimum, maximum)
zamboanga.re <- plotRe(zamboanga.log,"Zamboanga", info, minimum, maximum)
final.re <- barmm.re + caraga.re + davao.re + northmindanao.re + soccsksargen.re + zamboanga.re + plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re,
       filename = "output/re1.png",
       width = 12, height = 10, units = "in", dpi = 300)


#### Plot Re vs reported cases for each region and save
barmm.re.cases <- plotReCases(barmm.log, "BARMM", info, minimum, maximum, subset(doh, RegionRes == "BARMM")) 
caraga.re.cases <- plotReCases(davao.log, "Caraga", info, minimum, maximum, subset(doh, RegionRes == "CARAGA")) 
davao.re.cases <- plotReCases(caraga.log, "Davao", info, minimum, maximum, subset(doh, RegionRes == "Region XI: Davao Region")) 
northmindanao.re.cases <- plotReCases(northmindanao.log, "Northern Mindanao", info, minimum, maximum, subset(doh, RegionRes == "Region X: Northern Mindanao")) 
soccsksargen.re.cases <- plotReCases(soccsksargen.log, "Soccsksargen", info, minimum, maximum, subset(doh, RegionRes == "Region XII: SOCCSKSARGEN")) 
zamboanga.re.cases <- plotReCases(zamboanga.log, "Zamboanga", info, minimum, maximum, subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")) 
final.re.cases <- barmm.re.cases + caraga.re.cases + davao.re.cases + northmindanao.re.cases + soccsksargen.re.cases + zamboanga.re.cases + plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re.cases,
       filename = paste0(od, paste0(date.arg, ".re.cases.png")),
       width = 16, height = 10, units = "in", dpi = 300)


#### Plot Re vs. Sampling Dates for each region and save
barmm.re.sampling <- plotReSampling(barmm.log, "BARMM", info, minimum, maximum, subset(metadata, division == "Bangsamoro Autonomous Region In Muslim Mindanao"))
caraga.re.sampling <- plotReSampling(davao.log, "Caraga", info, minimum, maximum, subset(doh, RegionRes == "CARAGA")) 
davao.re.sampling <- plotReSampling(caraga.log, "Davao", info, minimum, maximum, subset(doh, RegionRes == "Region XI: Davao Region")) 
northmindanao.re.sampling <- plotReSampling(northmindanao.log, "Northern Mindanao", info, minimum, maximum, subset(doh, RegionRes == "Region X: Northern Mindanao")) 
soccsksargen.re.sampling <- plotReSampling(soccsksargen.log, "Soccsksargen", info, minimum, maximum, subset(doh, RegionRes == "Region XII: SOCCSKSARGEN")) 
zamboanga.re.sampling <- plotReSampling(zamboanga.log, "Zamboanga", info, minimum, maximum, subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")) 
final.re.sampling <- barmm.re.sampling + caraga.re.sampling + davao.re.sampling + northmindanao.re.sampling + soccsksargen.re.sampling + zamboanga.re.sampling + plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re.sampling,
       filename = paste0(od, paste0(date.arg, ".re.sampling.png")),
       width = 16, height = 10, units = "in", dpi = 300)



# Use function
saveRefiles(barmm.log, "BARMM", info, minimum, maximum, subset(doh, RegionRes == "BARMM"))
saveRefiles(davao.log, "Caraga", info, minimum, maximum, subset(doh, RegionRes == "CARAGA")) 
saveRefiles(caraga.log, "Davao", info, minimum, maximum, subset(doh, RegionRes == "Region XI: Davao Region")) 
saveRefiles(northmindanao.log, "Northern Mindanao", info, minimum, maximum, subset(doh, RegionRes == "Region X: Northern Mindanao")) 
saveRefiles(soccsksargen.log, "Soccsksargen", info, minimum, maximum, subset(doh, RegionRes == "Region XII: SOCCSKSARGEN")) 
saveRefiles(zamboanga.log, "Zamboanga", info, minimum, maximum, subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")) 
