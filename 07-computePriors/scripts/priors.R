## Load libraries
library(ggtree)
library(treeio)
library(ggplot2)
library(patchwork)
library(scales)
library(dplyr)
library(lubridate)

## Read input
est.start <- as.Date("2020-03-15", format="%Y-%m-%d")
doh1 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch0.csv") , sep = ',', header = TRUE)
doh2 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch1.csv") , sep = ',', header = TRUE)
doh3 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch2.csv") , sep = ',', header = TRUE)
doh4 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch3.csv") , sep = ',', header = TRUE)
doh <- rbind(doh1, doh2, doh3, doh4)
doh$DateRepConf <- as.Date(doh$DateRepConf, format="%Y-%m-%d")
info <- read.delim(file = "output/info.csv" , sep = ',', header = TRUE)
info$Oldest.Sample <- as.Date(info$Oldest.Sample, format="%Y-%m-%d")
info$Youngest.Samples <- as.Date(info$Youngest.Samples, format="%Y-%m-%d")

##Define function to calculate number of cases as of the latest sample
cases_as_of <- function(region.doh.name, date) {
  region.doh <- subset(doh, RegionRes == region.doh.name)
  region.doh <- data.frame(table(region.doh$DateRepConf))
  region.doh[, 2] <- cumsum(region.doh[, 2])
  return(region.doh$Freq[region.doh$Var1 == date])
}

##Add column for cumulative cases
info['cases'] <- c(cases_as_of("BARMM", as.character(info$Youngest.Samples[info$Region == "Bangsamoro Autonomous Region In Muslim Mindanao"])),
                   cases_as_of("CARAGA", as.character(info$Youngest.Samples[info$Region == "Caraga"])),
                   cases_as_of("Region XI: Davao Region", as.character(info$Youngest.Samples[info$Region == "Davao Region"])),
                   cases_as_of("Region X: Northern Mindanao", as.character(info$Youngest.Samples[info$Region == "Northern Mindanao"])),
                   cases_as_of("Region XII: SOCCSKSARGEN", as.character(info$Youngest.Samples[info$Region == "Soccsksargen"])),
                   cases_as_of("Region IX: Zamboanga Peninsula", as.character(info$Youngest.Samples[info$Region == "Zamboanga Peninsula"])),
                   0)
info$cases[info$Region == "Mindanao"] = sum(info$cases)

##Add column for sampling proportion prior
info <- transform(info,
                  samp.proportion = Clean.Samples/cases)

##Add column for origin prior
info <- transform(info,
                  median.origin = difftime(info$Youngest.Samples, est.start, units = c("days"))/365.25)

##Save 
write.csv(x = info,
          file="output/priors.csv",
          row.names = FALSE)
