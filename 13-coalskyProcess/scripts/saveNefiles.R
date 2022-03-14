#### Output: Written Re datafiles

saveNefiles <- function(parameters) {
  
  # Parse inputs
  data <- do.call(rbind.data.frame, parameters[1])
  region.title <- unlist(parameters[2])
  minimum <- unlist(parameters[3])
  maximum <- unlist(parameters[4])
  region.doh <- do.call(rbind.data.frame, parameters[5])
  
  # Remove some unused columns in date
  data$time <- NULL
  data$datetime <- NULL
  data$milliseconds <- NULL
  data$mean <- NULL
  
  # Calculate Re and interpolate
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
  neDatafile <- merge(data, region.doh, by="date")
  
  # Save datafile
  write.csv(neDatafile, file = gsub(" ", "", paste0("output/", region.title, "NeDatafile.csv")), row.names = FALSE)
}