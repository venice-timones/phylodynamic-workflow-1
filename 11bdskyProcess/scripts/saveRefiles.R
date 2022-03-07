#### Save datafiles
saveRefiles <- function(lf, region.title, info, minimum, maximum, region.doh) {
  
  # Calculate Re and interpolate
  source("scripts/calcRe.R")
  data <- calcRe(lf, region.title, info)
  data$date <- as.Date(data$date, format="%Y-%m-%d")
  data <- data[as.Date(data[["date"]]) <= as.Date(maximum), ]
  data <- data[as.Date(data[["date"]]) >= as.Date(minimum), ]
  data <- data %>%
    complete(date = seq.Date(as.Date(minimum), as.Date(maximum), by = "day"))
  data <- na_interpolation(data, option = "linear")
                   
  # Compute Reported cases and interpolate
  region.doh <- data.frame(table(region.doh$DateRepConf))
  colnames(region.doh) <- c("date", "reported")
  region.doh$date <- as.Date(region.doh$date, format="%Y-%m-%d")
  region.doh <- region.doh[as.Date(region.doh[["date"]]) <= as.Date(maximum), ]
  region.doh <- region.doh[as.Date(region.doh[["date"]]) >= as.Date(minimum), ]
  region.doh <- region.doh %>%
    complete(date = seq.Date(as.Date(minimum), as.Date(maximum), by = "day"))
  region.doh <- na_interpolation(region.doh, option = "linear")
  
  # Merge two columns
  reDatafile <- merge(data, region.doh, by="date")
  
  # Save datfile
  write.csv(reDatafile, file = paste0("output/", region.title, "ReDatafile.csv"), row.names = FALSE)
}