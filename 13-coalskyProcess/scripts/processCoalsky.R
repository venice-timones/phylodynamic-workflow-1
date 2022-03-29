#### Libraries
library(ggtree)
library(treeio)
library(ggplot2)
library(patchwork)
library(scales)
library(tidyr)
library(imputeTS)

#### Read Input
# TSV files
barmm.tsv <- read.delim(file = "input/barmm.tsv" , sep = '\t', header = TRUE)
caraga.tsv <- read.delim(file = "input/caraga.tsv" , sep = '\t', header = TRUE)
davao.tsv <- read.delim(file = "input/davao.tsv" , sep = '\t', header = TRUE)
northmindanao.tsv <- read.delim(file = "input/northmindanao.tsv" , sep = '\t', header = TRUE)
soccsksargen.tsv <- read.delim(file = "input/soccsksargen.tsv" , sep = '\t', header = TRUE)
zamboanga.tsv <- read.delim(file = "input/zamboanga.tsv" , sep = '\t', header = TRUE)

# DOH data drop
doh1 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch0.csv", sep = ',', header = TRUE)
doh2 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch1.csv", sep = ',', header = TRUE)
doh3 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch2.csv", sep = ',', header = TRUE)
doh4 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch3.csv", sep = ',', header = TRUE)
doh <- rbind(doh1, doh2, doh3, doh4)
doh$DateRepConf <- as.Date(doh$DateRepConf, format="%Y-%m-%d")

# Metadata file for sampling times
metadata <- read.delim(file = "input/mindanao.tsv" , sep = '\t', header = TRUE)
metadata$data <- as.Date(metadata$date, format="%Y-%m-%d")

# Info file for latest sampling dates of each region
info <- read.delim(file = "input/info.csv", sep = ',', header = TRUE)


#### Plot limits
minimum = "2021-01-01"
maximum = max(info$Youngest.Samples)


#### Load functions
source("scripts/plotNe.R")
source("scripts/plotNeCases.R")
source("scripts/plotNeSampling.R")
source("scripts/saveNefiles.R")


#### Define inputs for plottings
barmmParams <- list(barmm.tsv, "BARMM", minimum, maximum)
caragaParams <- list(caraga.tsv, "Caraga", minimum, maximum)
davaoParams <- list(davao.tsv, "Davao", minimum, maximum) 
northmindanaoParams <- list(northmindanao.tsv, "Northern Mindanao", minimum, maximum)
soccsksargenParams <- list(soccsksargen.tsv, "Soccsksargen", minimum, maximum)
zamboangaParams <- list(zamboanga.tsv, "Zamboanga", minimum, maximum)


#### Plot Re for each region and save
final.ne <- plotNe(barmmParams) + 
            plotNe(caragaParams) + 
            plotNe(davaoParams) + 
            plotNe(northmindanaoParams) + 
            plotNe(soccsksargenParams) + 
            plotNe(zamboangaParams) + 
            plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.ne,
       filename = "output/ne.png",
       width = 15, height = 10, units = "in", dpi = 300)


#### Plot Re vs reported cases for each region and save
final.ne.cases <- plotNeCases(append(barmmParams, list(subset(doh, RegionRes == "BARMM")))) + 
                  plotNeCases(append(caragaParams, list(subset(doh, RegionRes == "CARAGA")))) +
                  plotNeCases(append(davaoParams, list(subset(doh, RegionRes == "Region XI: Davao Region")))) +
                  plotNeCases(append(northmindanaoParams, list(subset(doh, RegionRes == "Region X: Northern Mindanao")))) +
                  plotNeCases(append(soccsksargenParams, list(subset(doh, RegionRes == "Region XII: SOCCSKSARGEN")))) +
                  plotNeCases(append(zamboangaParams, list(subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")))) + 
                  plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.ne.cases,
       filename = "output/ne.cases.png",
       width = 15, height = 10, units = "in", dpi = 300)


#### Plot Ne vs. Sampling Dates for each region and save
final.ne.sampling <- plotNeSampling(append(barmmParams, list(subset(metadata, division == "Bangsamoro Autonomous Region In Muslim Mindanao")))) + 
                     plotNeSampling(append(caragaParams, list(subset(metadata, division == "Caraga")))) +
                     plotNeSampling(append(davaoParams, list(subset(metadata, division == "Davao Region")))) +
                     plotNeSampling(append(northmindanaoParams, list(subset(metadata, division == "Northern Mindanao")))) +
                     plotNeSampling(append(soccsksargenParams, list(subset(metadata, division == "Soccsksargen")))) +
                     plotNeSampling(append(zamboangaParams, list(subset(metadata, division == "Zamboanga Peninsula")))) + 
                     plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.ne.sampling,
       filename = "output/ne.sampling.png",
       width = 15, height = 10, units = "in", dpi = 300)


#### Compute Ne datafiles
barmmNeDatafile         <- saveNefiles(append(barmmParams, list(subset(doh, RegionRes == "BARMM")))) 
caragaNeDatafile        <- saveNefiles(append(caragaParams, list(subset(doh, RegionRes == "CARAGA"))))
davaoNeDatafile         <- saveNefiles(append(davaoParams, list(subset(doh, RegionRes == "Region XI: Davao Region"))))
northmindanaoNeDatafile <- saveNefiles(append(northmindanaoParams, list(subset(doh, RegionRes == "Region X: Northern Mindanao"))))
soccsksargenNeDatafile  <- saveNefiles(append(soccsksargenParams, list(subset(doh, RegionRes == "Region XII: SOCCSKSARGEN"))))
zamboangaNeDatafile     <- saveNefiles(append(zamboangaParams, list(subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")))) 
barmmNeDatafile["Region"]               <- "BARMM"
caragaNeDatafile["Region"]              <- "CARAGA"
davaoNeDatafile["Region"]               <- "DAVAO"
northmindanaoNeDatafile["Region"]       <- "NORTHMINDANAO"
soccsksargenNeDatafile["Region"]        <- "SOCCSKSARGEN"
zamboangaNeDatafile["Region"]           <- "ZAMBOANGA"

#### Save Ne datafiles
neDatafile <- rbind(barmmNeDatafile, caragaNeDatafile, davaoNeDatafile, northmindanaoNeDatafile, soccsksargenNeDatafile, zamboangaNeDatafile)
write.csv(neDatafile, file = "output/ReDatafile.csv", row.names = FALSE)
