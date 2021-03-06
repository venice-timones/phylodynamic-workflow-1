### Output: Ne vs. reported cases figures

plotNeCases <- function(parameters) {
  
  # Parse inputs
  region.file <- do.call(rbind.data.frame, parameters[1])
  title <- unlist(parameters[2])
  minimum <- unlist(parameters[3])
  maximum <- unlist(parameters[4])
  region.doh <- do.call(rbind.data.frame, parameters[5])
  
  # Plot Ne vs. Reported Cases
  region.doh <- data.frame(table(region.doh$DateRepConf))
  region.mult <- max(region.doh$Freq)/max(region.file$upper, na.rm = TRUE)
  plot <- ggplot() +
    geom_col(region.doh, mapping = aes(x=as.Date(Var1, format="%Y-%m-%d") , y=Freq), width = 1, alpha = 0.7) +
    geom_line(region.file, mapping = aes(x=as.Date(date,"%Y-%m-%d"), y=median*region.mult), color = "dark blue", size = 1) +
    geom_ribbon(region.file, mapping = aes(x=as.Date(date, "%Y-%m-%d"), ymin=lower*region.mult, ymax=upper*region.mult), fill="dark blue", alpha=0.2) +
    scale_x_date(labels = date_format("%b-%Y"), 
                 limits = as.Date(c(minimum, maximum), format="%Y-%m-%d"),
                 date_breaks = '1 month') +
    theme_bw() +
    theme(axis.title.y.left = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.y.right = element_text(margin = margin(t = 0, r = 0, b = 0, l = 10)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
    labs(x = "Month and Year",
         y = "Reported Cases",
         title = paste0("Effective Population size vs. Reported Cases (", title, " - 2021)")) +
    scale_y_continuous(sec.axis=sec_axis(~.*1/region.mult,name="Effective Population Size"))
  
  # Return plot
  return(plot)
}