plotReCases <- function(parameters) {
  
  # Parse inputs
  lf <- do.call(rbind.data.frame, parameters[1])
  region.title <- unlist(parameters[2])
  info <- do.call(rbind.data.frame, parameters[3])
  minimum <- unlist(parameters[4])
  maximum <- unlist(parameters[5])
  region.doh <- do.call(rbind.data.frame, parameters[6])
  
  # Calculate Re
  source("scripts/calcRe.R")
  data <- calcRe(lf, region.title, info)
  
  # Plot Re vs. Reported Cases
  region.doh <- data.frame(table(region.doh$DateRepConf))
  region.mult <- max(region.doh$Freq)/max(data$upper, na.rm = TRUE)
  plot <- ggplot() +
    geom_col(region.doh, mapping = aes(x=as.Date(Var1, format="%Y-%m-%d") , y=Freq), width = 1, alpha = 0.7) +
    geom_line(data, mapping = aes(x=as.Date(date,"%Y-%m-%d"), y=median*region.mult), color = "dark blue", size = 1) +
    geom_ribbon(data, mapping = aes(x=as.Date(date, "%Y-%m-%d"), ymin=lower*region.mult, ymax=upper*region.mult), fill="dark blue", alpha=0.2) +
    scale_x_date(labels = date_format("%b-%Y"), 
                 limits = as.Date(c(minimum, maximum), format="%Y-%m-%d"),
                 date_breaks = '1 month') +
    theme_bw() +
    theme(axis.title.y.left = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.y.right = element_text(margin = margin(t = 0, r = 0, b = 0, l = 10)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
    labs(x = "Month and Year",
         y = "Reported Cases",
         title = paste0("Effective Reproduction Number vs. Reported Cases (", region.title, " - 2021)")) +
    scale_y_continuous(sec.axis=sec_axis(~.*1/region.mult,name="Re"))
  
  # Return plot
  return(plot)
}