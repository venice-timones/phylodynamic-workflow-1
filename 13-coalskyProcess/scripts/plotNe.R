### Output: Ne figures

plotNe <- function(parameters) {
  
  # Parse inputs
  region.data <- do.call(rbind.data.frame, parameters[1])
  title <- unlist(parameters[2])
  minimum <- unlist(parameters[3])
  maximum <- unlist(parameters[4])
  
  # Plot Ne
  plot <- ggplot(data = region.data) +
    geom_line(aes(x=as.Date(date,"%Y-%m-%d"), y=median), color = "dark blue", size = 1) +
    theme_bw() +
    labs(x="Date", 
         y="Effective Population Size",
         title = paste0("Effective Population Size (", title," - 2021)")) +
    scale_x_date(date_breaks = "1 month", 
                 limits = as.Date(c(minimum, maximum), format="%Y-%m-%d"),
                 labels=date_format("%b-%Y")) +
    geom_ribbon(data = region.data, aes(x=as.Date(date, "%Y-%m-%d"), ymin=lower, ymax=upper), fill="dark blue", alpha=0.2) +
    #scale_y_log10(limits=c(0.01,100)) +
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))
  
  # Return plot
  return(plot)
}