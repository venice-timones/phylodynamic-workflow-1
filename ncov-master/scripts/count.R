##Read Argument
args = commandArgs(trailingOnly = TRUE)

##Load directories
setwd("/Users/ijborda/Augur/ncov-master")
wd = getwd()
id.clean= paste0(wd,"/output/")
id.raw= paste0(wd,"/intermediate/")   
od = paste0(wd,"/output/")

##Required input
filename <- args[1] #"211024.mindanao" 

##Read data
metadata.raw <- read.delim(file = (paste0(id.raw,filename,".metadata.sanitized.tsv")) , sep = '\t', header = TRUE)
metadata.raw$date <- as.Date(metadata.raw$date, format="%Y-%m-%d")
metadata.clean <- read.delim(file = (paste0(id.clean,filename,".metadata.sanitized.clean.tsv")) , sep = '\t', header = TRUE)
metadata.clean$date <- as.Date(metadata.clean$date, format="%Y-%m-%d")

##Clean region names
metadata.raw$division <- ifelse(grepl("Davao Region", metadata.raw$division),'Davao', metadata.raw$division)
metadata.raw$division <- ifelse(grepl("Bangsamoro Autonomous Region in Muslim Mindanao", metadata.raw$division),'BARMM', metadata.raw$division)
metadata.raw$division <- ifelse(grepl("Region IX", metadata.raw$division),'Zamboanga', metadata.raw$division)
metadata.clean$division <- ifelse(grepl("Davao Region", metadata.clean$division),'Davao', metadata.clean$division)
metadata.clean$division <- ifelse(grepl("Bangsamoro Autonomous Region in Muslim Mindanao", metadata.clean$division),'BARMM', metadata.clean$division)
metadata.clean$division <- ifelse(grepl("Region IX", metadata.clean$division),'Zamboanga', metadata.clean$division)

##Count date
count.clean <- data.frame(table(metadata.clean$division))
count.raw <- data.frame(table(metadata.raw$division))

##Make data frame
count <- data.frame(count.raw[1], count.raw[2], count.clean[2])
colnames(count) <- c("Region","Raw","Clean")

##Save 
write.csv(x = count,
          file = paste0(od, paste0(filename, ".count.csv")),
          row.names = FALSE)


