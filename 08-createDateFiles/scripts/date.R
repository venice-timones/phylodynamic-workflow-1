## Load libraries
require(pacman)
p_load(EpiCurve,dplyr,tidyr,pacman, ggplot2,ggthemes,broom,stringr,ggpubr,scales,lubridate)

# Read metadata files
metadataFiles <- list.files(path = "input/", pattern="^[^~].*tsv$")

for (metadataName in metadataFiles) {
  # Read metadata file
  metadata <- read.delim(file = paste0("input/", metadataName), sep = '\t', header = TRUE)
  metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")
  
  # Subset to strain and date columns only
  metadata <- data.frame(metadata$strain, metadata$date)
  colnames(metadata) <- c("strain", "date")
  
  #Save dataframe
  write.table(metadata, 
              file = paste0("output/", gsub('.{4}$', '', metadataName), "Date.txt"),
              quote=FALSE, 
              sep='\t',
              row.names = FALSE)
}






