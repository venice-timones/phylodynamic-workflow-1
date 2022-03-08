### Output: Re figures

plotRe <- function(parameters) {
  
  # Parse inputs
  lf <- do.call(rbind.data.frame, parameters[1])
  region.title <- unlist(parameters[2])
  info <- do.call(rbind.data.frame, parameters[3])
  minimum <- unlist(parameters[4])
  maximum <- unlist(parameters[5])
  
  # Calculate Re
  source("scripts/calcRe.R")
  data <- calcRe(lf, region.title, info)
  
  # Plot Re
  plot <- ggplot(data = data) +
    geom_line(aes(x=as.Date(date), y=median), color = "dark blue", size = 1) +
    theme_bw() +
    labs(x="Date", 
         y="Re",
         title = paste0("Effective Reproduction Number (", region.title," - 2021)")) +
    scale_x_date(date_breaks = "1 month", 
                 limits = as.Date(c(minimum, maximum), format="%Y-%m-%d"),
                 labels=date_format("%b-%Y")) +
    geom_ribbon(data = data, aes(x=as.Date(date), ymin=lower, ymax=upper), fill="dark blue", alpha=0.2) +
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))
  
  # Return plot
  return (plot)
}