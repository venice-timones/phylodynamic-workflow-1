plotReSitrep <- function(parameters) {
  
  # Parse inputs
  lf <- do.call(rbind.data.frame, parameters[1])
  region.title <- unlist(parameters[2])
  info <- do.call(rbind.data.frame, parameters[3])
  minimum <- unlist(parameters[4])
  maximum <- unlist(parameters[5])
  region.sitrep <- do.call(rbind.data.frame, parameters[6])
  
  # Calculate Re
  source("scripts/calcRe.R")
  data <- calcRe(lf, region.title, info)
  
  # Plot Re vs. Reported Cases
  plot <- ggplot() +
    geom_line(region.sitrep, mapping = aes(x=as.Date(Date,"%d-%b-%y"), y=Median.R., colour="Statistical Re"), size = 1) +
    geom_ribbon(region.sitrep, mapping = aes(x=as.Date(Date, "%d-%b-%y"), ymin=Quantile.0.025.R., ymax=Quantile.0.975.R.), fill="dark red", alpha=0.2) +
    geom_line(data, mapping = aes(x=as.Date(date,"%Y-%m-%d"), y=median, colour="BDSKY Re"), size = 1) +
    geom_ribbon(data, mapping = aes(x=as.Date(date, "%Y-%m-%d"), ymin=lower, ymax=upper), fill="dark blue", alpha=0.2) +
    scale_x_date(labels = date_format("%b-%Y"), 
                 limits = as.Date(c(minimum, maximum), format="%Y-%m-%d"),
                 date_breaks = '1 month') +
    ylim(0, 5) +
    theme_bw() +
    theme(axis.title.y.left = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.y.right = element_text(margin = margin(t = 0, r = 0, b = 0, l = 10)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
    labs(x = "Month and Year",
         y = "Reproductive Number",
         title = paste0("Effective Reproduction Number vs. Statistical Re (", region.title, " - 2021)")) +
    scale_colour_manual("", 
                      breaks = c("BDSKY Re", "Statistical Re"),
                      values = c("dark blue", "dark red")) +
    theme(legend.position = "top")
  
  # Return plot
  return(plot)
}