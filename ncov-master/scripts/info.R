##Read argument
args = commandArgs(trailingOnly = TRUE)

##Load libraries
library("dplyr")
library("lubridate")

##Load directories
setwd("/Users/ijborda/GitHub/gisaid-preprocessing/ncov-master")
wd = getwd()
id= paste0(wd,"/output/")
od = paste0(wd,"/output/")

##Required input
filename <- args[1] #"211102.bdmm" 

##Read data
metadata<- read.delim(file = (paste0(id,filename,".metadata.sanitized.clean.tsv")) , sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")

##Clean region names
metadata$division <- ifelse(grepl("Davao Region", metadata$division),'Davao', metadata$division)
metadata$division <- ifelse(grepl("Bangsamoro Autonomous Region in Muslim Mindanao", metadata$division),'BARMM', metadata$division)
metadata$division <- ifelse(grepl("Region IX", metadata$division),'Zamboanga', metadata$division)
metadata$division <- ifelse(grepl("National Capital Region", metadata$division),'NCR', metadata$division)

##Number of samples 
count <- data.frame(table(metadata$division))

##Sampling date
sampdate.transform <- metadata %>% select(division, date)
sampdate <- sampdate.transform %>%
  group_by(division) %>%
  summarise(
    oldest = min(date, na.rm = T),
    youngest = max(date, na.rm = T)
  ) %>%
  arrange(division)

##Date range and decimals
sampdate <- transform(sampdate, 
                      range = youngest - oldest,
                      oldest.decimal = decimal_date(oldest),
                      youngest.decimal = decimal_date(youngest))

##Make data frame
info <- data.frame(count[1], count[2], sampdate[2], sampdate[3], sampdate[4], sampdate[5], sampdate[6])
colnames(info) <- c("Region","Clean Samples","Oldest Sample", "Youngest Samples", "Date Range", "Oldest Sample (Decimal)", "Youngest Samples (Decimal)")

#Add Overall
overall <- data.frame("BDMM", 
                      sum(info$`Clean Samples`), 
                      min(info$`Oldest Sample`), 
                      max(info$`Youngest Samples`), 
                      max(info$`Youngest Samples`)-min(info$`Oldest Sample`),
                      min(info$`Oldest Sample (Decimal)`),
                      max(info$`Youngest Samples (Decimal)`))
colnames(overall) <- c("Region","Clean Samples", "Oldest Sample", "Youngest Samples", "Date Range", "Oldest Sample (Decimal)", "Youngest Samples (Decimal)")
info.final <- rbind(info, overall)

##Save 
write.csv(x = info.final,
          file = paste0(od, paste0(filename, ".info.csv")),
          row.names = FALSE)


