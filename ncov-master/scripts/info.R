##Read argument
args = commandArgs(trailingOnly = TRUE)

##Load libraries
library("dplyr")

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

##Date Range
sampdate <- transform(sampdate, range = youngest - oldest)

##Make data frame
info <- data.frame(count[1], count[2], sampdate[2], sampdate[3], sampdate[4])
colnames(info) <- c("Region","Clean Samples","Oldest Sample", "Youngest Samples", "Date Range")

#Add Overall
overall <- data.frame("BDMM", 
                      sum(info$`Clean Samples`), 
                      min(info$`Oldest Sample`), 
                      max(info$`Youngest Samples`), 
                      max(info$`Youngest Samples`)-min(info$`Oldest Sample`))
colnames(overall) <- c("Region","Clean Samples","Oldest Sample", "Youngest Samples", "Date Range")
info.final <- rbind(info, overall)

##Save 
write.csv(x = info.final,
          file = paste0(od, paste0(filename, ".info.csv")),
          row.names = FALSE)


