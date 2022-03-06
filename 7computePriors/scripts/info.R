##Load libraries
library("dplyr")
library("lubridate")

##Read data
metadata <- read.delim(file = paste0("input/", list.files(path = "input/", pattern="^[^~].*tsv$")), sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")

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
overall <- data.frame("Mindanao", 
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
          file = "output/info.csv",
          row.names = FALSE)


