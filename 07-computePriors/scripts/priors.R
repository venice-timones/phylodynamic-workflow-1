### Load libraries
library(ggtree)
library(treeio)
library(ggplot2)
library(patchwork)
library(scales)
library(dplyr)
library(lubridate)

### Read input
doh1 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch0.csv") , sep = ',', header = TRUE)
doh2 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch1.csv") , sep = ',', header = TRUE)
doh3 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch2.csv") , sep = ',', header = TRUE)
doh4 <- read.delim((file = "scripts/doh-data-drop/220303.DOH.batch3.csv") , sep = ',', header = TRUE)
doh <- rbind(doh1, doh2, doh3, doh4)
doh$DateRepConf <- as.Date(doh$DateRepConf, format="%Y-%m-%d")

info <- read.delim(file = "output/info.csv" , sep = ',', header = TRUE)
info$oldestSample <- as.Date(info$oldestSample, format="%Y-%m-%d")
info$youngestSample <- as.Date(info$youngestSample, format="%Y-%m-%d")


### Declare EST_START
EST_START <- as.Date("2020-03-15", format="%Y-%m-%d")


### Define function to calculate number of cases as of the latest sample
cases_as_of <- function(subset, date) {
  subset <- data.frame(table(subset$DateRepConf))
  subset[, 2] <- cumsum(subset[, 2])
  return(subset$Freq[subset$Var1 == date])
}


### Subset DOH datafile to Mindanao only
mindanao <- c("BARMM", "CARAGA", "Region XI: Davao Region", "Region X: Northern Mindanao", "Region XII: SOCCSKSARGEN", "Region IX: Zamboanga Peninsula")
dohMindanao <- subset(doh, RegionRes %in% mindanao)


### Add column for cumulative cases
info$cases <- 0
for(i in 1:length(mindanao)) {
  subset <- subset(dohMindanao, RegionRes == mindanao[i]) 
  date <- as.character(info$youngestSample[i])
  info$cases[i] <- cases_as_of(subset, date)
}


### Sum the cases column and set is as the cases for the mindanao row
info$cases[info$region == "Mindanao"] = sum(info$cases)
info$cases[info$region == "BDMM"] = info$cases[info$region == "Mindanao"]


### Add column for sampling proportion prior
info <- transform(info,
                  sampProp = cleanSamples/cases)


### Add column for origin prior
info <- transform(info, 
                  medianOriginDays = round(as.numeric(difftime(info$youngestSample, EST_START, units = c("days"))/365.25),2))


### Save 
write.csv(x = info,
          file="output/info.csv",
          row.names = FALSE)