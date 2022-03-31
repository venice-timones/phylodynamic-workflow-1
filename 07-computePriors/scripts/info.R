### Load libraries
library("dplyr")
library("lubridate")
library("stringr")


### Read data
mindanao <- read.delim(file = paste0("input/mindanao.tsv"), sep = '\t', header = TRUE)
mindanao$date <- as.Date(mindanao$date, format="%Y-%m-%d")

bdmm <- read.delim(file = paste0("input/bdmm.tsv"), sep = '\t', header = TRUE)
bdmm$date <- as.Date(bdmm$date, format="%Y-%m-%d")


### Define Regions
locations <- c(str_sort(unique(mindanao$division)), "Mindanao", "BDMM")
info <- data.frame()


### Write info
for (location in locations) {
  if (location == "Mindanao") {
    subset <- mindanao
  } else if (location == "BDMM") {
    subset <- bdmm
  } else {
    subset <- mindanao[mindanao$division == location, ]
  }
  subsetInfo <- data.frame(location, 
                      count(subset),
                      min(subset$date), 
                      max(subset$date), 
                      max(subset$date)-min(subset$date),
                      min(decimal_date(subset$date)),
                      max(decimal_date(subset$date)))
  info <- rbind(info, subsetInfo)
}
colnames(info) <- c("region","cleanSamples","oldestSample", "youngestSample", "dateRange", "oldestSampleDecimal", "youngestSampleDecimal")


### Save files 
write.csv(x = info,
          file = "output/info.csv",
          row.names = FALSE)