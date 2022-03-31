### Load libraries
library("dplyr")
library("lubridate")

### Read data
metadata <- read.delim(file = paste0("input/mindanao.tsv"), sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")
bdmm <- read.delim(file = paste0("input/bdmm.tsv"), sep = '\t', header = TRUE)
bdmm$date <- as.Date(bdmm$date, format="%Y-%m-%d")

### Count number of samples per region
count <- data.frame(table(metadata$division)) 

### Obtain date of youngest and oldest sampes per region
sampdate <- metadata %>% 
  select(division, date) %>%
  group_by(division) %>%
  summarise(
    oldest = min(date, na.rm = T),
    youngest = max(date, na.rm = T)
  ) %>%
  arrange(division)

### Calculate date range and convert dates to decimals
sampdate <- transform(sampdate, 
                      range = youngest - oldest,
                      oldestDecimal = decimal_date(oldest),
                      youngestDecimal = decimal_date(youngest))

### Aggregate all info into one data frame
info <- data.frame(count[1], count[2], sampdate[2], sampdate[3], sampdate[4], sampdate[5], sampdate[6])
colnames(info) <- c("region","cleanSamples","oldestSample", "youngestSample", "dateRange", "oldestSampleDecimal", "youngestSampleDecimal")

### Add info for Mindanao (overall)
overall <- data.frame("Mindanao", 
                      sum(info$cleanSamples), 
                      min(info$oldestSample), 
                      max(info$youngestSample), 
                      max(info$youngestSample)-min(info$oldestSample),
                      min(info$oldestSampleDecimal),
                      max(info$youngestSampleDecimal))
colnames(overall) <- colnames(info)

### Add info for bdmm (mindanao, but subsampled)
bdmm1 <- data.frame("BDMM", 
                    count(bdmm),
                    min(bdmm$date), 
                    max(bdmm$date), 
                    max(bdmm$date)-min(bdmm$date),
                    min(decimal_date(bdmm$date)),
                    max(decimal_date(bdmm$date)))
colnames(bdmm1) <- colnames(info)

info.final <- rbind(info, overall, bdmm1)

### Save files 
write.csv(x = info.final,
          file = "output/info.csv",
          row.names = FALSE)


