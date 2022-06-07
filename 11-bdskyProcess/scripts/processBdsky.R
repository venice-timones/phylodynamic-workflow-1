#### Libraries
library(ggtree)
library(treeio)
library(ggplot2)
library(patchwork)
library(scales)
library(tidyr)
library(lubridate) 
library(gridExtra)
library(cowplot)
library(bdskytools)
library(tibble)
library(dplyr)
library(imputeTS)


#### Read Input
# Log files
barmm.log <- readLogfile(file = "input/barmm.log", burnin=0.1)
caraga.log <- readLogfile(file = "input/caraga.log", burnin=0.1)
davao.log <- readLogfile(file = "input/davao.log", burnin=0.1)
northmindanao.log <- readLogfile(file = "input/northmindanao.log", burnin=0.1)
soccsksargen.log <- readLogfile(file = "input/soccsksargen.log", burnin=0.1)
zamboanga.log <- readLogfile(file = "input/zamboanga.log", burnin=0.1)

# DOH data drop
doh1 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch0.csv", sep = ',', header = TRUE)
doh2 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch1.csv", sep = ',', header = TRUE)
doh3 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch2.csv", sep = ',', header = TRUE)
doh4 <- read.delim(file = "scripts/doh-data-drop/220303.DOH.batch3.csv", sep = ',', header = TRUE)
doh <- rbind(doh1, doh2, doh3, doh4)
doh$DateRepConf <- as.Date(doh$DateRepConf, format="%Y-%m-%d")

# Sitrep data
davao.sitrep <- read.delim(file = "scripts/sit-rep/davaoSitrep.csv", sep = ',', header = TRUE)
zamboanga.sitrep <- read.delim(file = "scripts/sit-rep/zamboangaSitrep.csv", sep = ',', header = TRUE)
        
# Metadata file for sampling times
metadata <- read.delim(file = "input/mindanao.tsv" , sep = '\t', header = TRUE)
metadata$data <- as.Date(metadata$date, format="%Y-%m-%d")

# Info file for latest sampling dates of each region
info <- read.delim(file = "input/info.csv", sep = ',', header = TRUE)


#### Plot limits
minimum = "2021-01-01"
maximum = max(info$youngestSample)


#### Load functions
source("scripts/plotRe.R")
source("scripts/plotReCases.R")
source("scripts/plotReSampling.R")
source("scripts/saveReFiles.R")
source("scripts/plotReSitrep.R")


#### Define inputs for plottings
barmmParams <- list(barmm.log, "Bangsamoro Autonomous Region In Muslim Mindanao", info, minimum, maximum)
caragaParams <- list(caraga.log, "Caraga", info, minimum, maximum)
davaoParams <- list(davao.log, "Davao Region", info, minimum, maximum) 
northmindanaoParams <- list(northmindanao.log, "Northern Mindanao", info, minimum, maximum)
soccsksargenParams <- list(soccsksargen.log, "Soccsksargen", info, minimum, maximum)
zamboangaParams <- list(zamboanga.log, "Zamboanga Peninsula", info, minimum, maximum)


#### Plot Re for each region and save
final.re <- plotRe(barmmParams) + 
            plotRe(caragaParams) + 
            plotRe(davaoParams) + 
            plotRe(northmindanaoParams) + 
            plotRe(soccsksargenParams) + 
            plotRe(zamboangaParams) + 
            plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re,
       filename = "output/re.png",
       width = 20, height = 10, units = "in", dpi = 300)


#### Plot Re vs reported cases for each region and save
final.re.cases <- plotReCases(append(barmmParams, list(subset(doh, RegionRes == "BARMM")))) + 
                  plotReCases(append(caragaParams, list(subset(doh, RegionRes == "CARAGA")))) +
                  plotReCases(append(davaoParams, list(subset(doh, RegionRes == "Region XI: Davao Region")))) +
                  plotReCases(append(northmindanaoParams, list(subset(doh, RegionRes == "Region X: Northern Mindanao")))) +
                  plotReCases(append(soccsksargenParams, list(subset(doh, RegionRes == "Region XII: SOCCSKSARGEN")))) +
                  plotReCases(append(zamboangaParams, list(subset(doh, RegionRes == "Region IX: Zamboanga Peninsula")))) + 
                  plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re.cases,
       filename = "output/re.cases.png",
       width = 20, height = 10, units = "in", dpi = 300)


#### Plot Re vs. Sampling Dates for each region and save
final.re.sampling <- plotReSampling(append(barmmParams, list(subset(metadata, division == "Bangsamoro Autonomous Region In Muslim Mindanao")))) + 
                     plotReSampling(append(caragaParams, list(subset(metadata, division == "Caraga")))) +
                     plotReSampling(append(davaoParams, list(subset(metadata, division == "Davao Region")))) +
                     plotReSampling(append(northmindanaoParams, list(subset(metadata, division == "Northern Mindanao")))) +
                     plotReSampling(append(soccsksargenParams, list(subset(metadata, division == "Soccsksargen")))) +
                     plotReSampling(append(zamboangaParams, list(subset(metadata, division == "Zamboanga Peninsula")))) + 
                     plot_layout(ncol = 2, nrow = 3)
ggsave(plot = final.re.sampling,
       filename = "output/re.sampling.png",
       width = 20, height = 10, units = "in", dpi = 300)


#### Plot Re vs. Sitrep data for each region and save
final.re.sitrep <- plotReSitrep(append(davaoParams, list(davao.sitrep))) + 
                   plotReSitrep(append(zamboangaParams, list(zamboanga.sitrep))) + 
                   plot_layout(ncol = 2, nrow = 1)
ggsave(plot = final.re.sitrep,
       filename = "output/re.sitrep.png",
       width = 20, height = 10, units = "in", dpi = 300)


#### Compute Re datafiles
barmmReDatafile         <- saveRefiles(append(barmmParams, list(subset(doh, RegionRes == "BARMM")))) 
caragaReDatafile        <- saveRefiles(append(caragaParams, list(subset(doh, RegionRes == "CARAGA"))))
davaoReDatafile         <- saveRefiles(append(davaoParams, list(subset(doh, RegionRes == "Region XI: Davao Region"))))
northmindanaoReDatafile <- saveRefiles(append(northmindanaoParams, list(subset(doh, RegionRes == "Region X: Northern Mindanao"))))
soccsksargenReDatafile  <- saveRefiles(append(soccsksargenParams, list(subset(doh, RegionRes == "Region XII: SOCCSKSARGEN"))))
zamboangaReDatafile     <- saveRefiles(append(zamboangaParams, list(subset(doh, RegionRes == "Region IX: Zamboanga Peninsula"))))
barmmReDatafile["Region"]               <- "BARMM"
caragaReDatafile["Region"]              <- "CARAGA"
davaoReDatafile["Region"]               <- "DAVAO"
northmindanaoReDatafile["Region"]       <- "NORTHMINDANAO"
soccsksargenReDatafile["Region"]        <- "SOCCSKSARGEN"
zamboangaReDatafile["Region"]           <- "ZAMBOANGA"


#### Save Re datafiles
reDatafile <- rbind(barmmReDatafile, caragaReDatafile, davaoReDatafile, northmindanaoReDatafile, soccsksargenReDatafile, zamboangaReDatafile)
write.csv(reDatafile, file = "output/ReDatafile.csv", row.names = FALSE)


#### Plot epi parameters
epiParam <- c('becomeUninfectiousRate_BDSKY_Serial', 'origin_BDSKY_Serial', 'samplingProportion_BDSKY_Serial')
for (param in epiParam) {
       max_rows <- max(length(barmm.log[[param]]),
                       length(caraga.log[[param]]),
                       length(davao.log[[param]]),
                       length(northmindanao.log[[param]]),
                       length(soccsksargen.log[[param]]),
                       length(zamboanga.log[[param]]))
       param.df <- cbind(barmm         = c(barmm.log[[param]],         rep(NA, max_rows - length(barmm.log[[param]]))),
                         caraga        = c(caraga.log[[param]],        rep(NA, max_rows - length(caraga.log[[param]]))),
                         davao         = c(davao.log[[param]],         rep(NA, max_rows - length(davao.log[[param]]))),
                         northmindanao = c(northmindanao.log[[param]], rep(NA, max_rows - length(northmindanao.log[[param]]))),
                         soccsksargen  = c(soccsksargen.log[[param]],  rep(NA, max_rows - length(soccsksargen.log[[param]]))),
                         zamboanga     = c(zamboanga.log[[param]]),    rep(NA, max_rows - length(zamboanga.log[[param]])))
       param.df <- as.data.frame(param.df)
       param.df <- param.df %>% gather(region, value)
       param.plot <- ggplot(data = param.df,
                            mapping = aes(x = value, y = ..density.., fill = region)) +
                            geom_density(alpha = 0.7) +
                            scale_fill_manual(values = c("#F76D5E", "#FFFFBF", "#72D8FF", "#228B22", "#8F00FF", "#FFA500")) +
                            theme_classic() +
                            labs(x = gsub("\\_.*","", param), y = "Marginal Density") +
                            guides(fill = guide_legend(title = "Region")) + 
                            theme(axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
                                  axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)))
       ggsave(plot = param.plot,
              filename = paste0('output/', gsub("\\_.*","", param), '.png'),
              width = 7, height = 5, units = "in", dpi = 300)
}