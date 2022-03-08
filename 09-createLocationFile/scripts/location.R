### Load libraries
require(pacman)
p_load(EpiCurve,dplyr,tidyr,pacman, ggplot2,ggthemes,broom,stringr,ggpubr,scales,lubridate)

### Read metadata file
metadataName <- list.files(path = "input/", pattern="^[^~].*tsv$")
metadata <- read.delim(file = paste0("input/", metadataName), sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")

### Subset to strain and date columns only
metadata <- data.frame(metadata$strain, metadata$division)

### Save dataframe
write.table(metadata, 
            file = paste0("output/", gsub('.{4}$', '', metadataName), "Location.txt"),
            quote=FALSE, 
            sep='\t',
            row.names = FALSE,
            col.names = FALSE)