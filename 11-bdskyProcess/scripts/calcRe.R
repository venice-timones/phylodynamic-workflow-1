### Output: Dataframe containing the parsed Re from BDSKY log files

calcRe <- function(lf, region.title, info) {
  
  # Extract the HPDs of Re
  Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
  Re_hpd    <- getMatrixHPD(Re_sky)
  
  # Smoothen
  timegrid <- seq(0,median(lf$origin),length.out=101)
  Re_gridded <- gridSkyline(Re_sky,lf$origin, timegrid)
  Re_gridded_hpd <- getMatrixHPD(Re_gridded)
  times <- info$Youngest.Samples..Decimal.[info$Region==region.title]-timegrid
  
  # Convert to dataframe
  data <- t(Re_gridded_hpd)
  rownames(data) <- NULL
  data <- data.table::as.data.table(data)
  data$date <- date_decimal(times)
  colnames(data) <- c("lower", "median", "upper", "date")
  
  # Return dataframe
  return(data)
}