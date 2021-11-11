##Read Argument
args = commandArgs(trailingOnly = TRUE)

##Load directories
setwd("/Users/ijborda/GitHub/gisaid-preprocessing/ncov-master")
wd = getwd()
id = paste0(wd,"/output/")   
od = paste0(wd,"/output/")
ref = paste0(wd,"/reference/")

##Load libraries
require(pacman)
p_load(EpiCurve,dplyr,tidyr,pacman, ggplot2,ggthemes,broom,stringr,ggpubr,scales,lubridate)

##Required input
filename <-  args[1] #"211102.bdmm"  

#Read data
metadata <- read.delim(file = (paste0(id,filename,".metadata.sanitized.clean.tsv")) , sep = '\t', header = TRUE)
metadata$date <- as.Date(metadata$date, format="%Y-%m-%d")
variants <- read.delim(file = (paste0(ref,"variants.csv")) , sep = ',', header = TRUE)

#Clean region names
metadata$division <- ifelse(grepl("Davao Region", metadata$division),'Davao', metadata$division)
metadata$division <- ifelse(grepl("Bangsamoro Autonomous Region in Muslim Mindanao", metadata$division),'BARMM', metadata$division)
metadata$division <- ifelse(grepl("Region IX", metadata$division),'Zamboanga', metadata$division)
metadata$division <- ifelse(grepl("National Capital Region", metadata$division),'NCR', metadata$division)

#Make column for VOC
metadata$voc = metadata$pangolin_lineage
metadata['voc'] = "Non VOC"
for(i in 1:nrow(variants)){
  metadata$voc <- ifelse(grepl(as.character(paste0("^",variants[i,1],"$")), metadata$pangolin_lineage),as.character(variants[i,2]), metadata$voc)
}

#Plot date
date <- metadata %>% left_join(metadata %>% group_by(division) %>% summarise(N=n()))%>%
  mutate(Label=paste0(division,' (n = ',N,')')) %>%
  ggplot(metadata, mapping = aes(date)) + 
  geom_histogram(binwidth = 1) +
  scale_x_date(labels = date_format("%b-%Y"), 
               date_breaks = '1 month') +
  ylab("Frequency") + xlab("Month and Year") + 
  theme_bw() +
  labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename)))) +
  facet_wrap(~Label, ncol=1) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))
date

#Plot by gender
sex <- metadata %>% left_join(metadata %>% group_by(division) %>% summarise(N=n()))%>%
  mutate(Label=paste0(division,' (n = ',N,')')) %>%
  ggplot(metadata, mapping = aes(date)) + 
  geom_histogram(binwidth = 1, aes(fill=sex)) +
  scale_x_date(labels = date_format("%b-%Y"), 
               date_breaks = '1 month') +
  ylab("Frequency") + xlab("Month and Year") + 
  theme_bw() +
  labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename))," by Gender")) +
  facet_wrap(~Label, ncol=1) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
  guides(fill=guide_legend(title="Gender")) +
  theme(legend.key.size = unit(.5, 'cm'))
sex

#Plot by pangolin lineage
lin <- metadata %>% left_join(metadata %>% group_by(division) %>% summarise(N=n()))%>%
  mutate(Label=paste0(division,' (n = ',N,')')) %>%
  ggplot(metadata, mapping = aes(date)) + 
  geom_histogram(binwidth = 1, aes(fill=pangolin_lineage)) +
  scale_x_date(labels = date_format("%b-%Y"), 
               date_breaks = '1 month') +
  ylab("Frequency") + xlab("Month and Year") + 
  theme_bw() +
  labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename))," by Pangolin Lineage")) +
  facet_wrap(~Label, ncol=1) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
  guides(fill=guide_legend(title="Pangolin Lineage", ncol=1)) + 
  theme(legend.key.size = unit(.5, 'cm'))
lin

#Plot by VOC
voc <- metadata %>% left_join(metadata %>% group_by(division) %>% summarise(N=n()))%>%
  mutate(Label=paste0(division,' (n = ',N,')')) %>%
  ggplot(metadata, mapping = aes(date)) + 
  geom_histogram(binwidth = 1, aes(fill=voc)) +
  scale_x_date(labels = date_format("%b-%Y"), 
               date_breaks = '1 month') +
  ylab("Frequency") + xlab("Month and Year") + 
  theme_bw() +
  labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename))," by Variant of Concern")) +
  facet_wrap(~Label, ncol=1) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
  guides(fill=guide_legend(title="Variant", ncol=1)) + 
  theme(legend.key.size = unit(.5, 'cm')) +
  scale_fill_brewer(palette = "Dark2")
voc

#Save plots
ggsave (plot = date,
        filename = paste0(od, paste0(filename, ".collection.date.png")),
        width = 7, height = 8, units = "in", dpi = 300)
ggsave (plot = sex,
        filename = paste0(od, paste0(filename, ".gender.png")),
        width = 7, height = 8, units = "in", dpi = 300)
ggsave (plot = lin,
        filename = paste0(od, paste0(filename, ".pangolin.lineage.png")),
        width = 7, height = 8, units = "in", dpi = 300)
ggsave (plot = voc,
        filename = paste0(od, paste0(filename, ".voc.png")),
        width = 7, height = 8, units = "in", dpi = 300)

#Plot each VOC
#define plotting function
voc1 <- function(title) {
  metadata.temp = metadata[c("pangolin_lineage","voc","date","division")]
  metadata.temp$voc <- ifelse(grepl(as.character(paste0("^",title,"$")), metadata.temp$voc),title, "Others")
  metadata.temp$voc <- factor(metadata.temp$voc, levels = c(title, "Others"))
  plot <- metadata.temp %>% left_join(metadata.temp %>% group_by(division) %>% summarise(N=n()))%>%
    mutate(Label=paste0(division,' (n = ',N,')')) %>%
    ggplot(metadata.temp, mapping = aes(date)) + 
    geom_histogram(binwidth = 1, aes(fill=voc)) +
    scale_x_date(labels = date_format("%b-%Y"), 
                 date_breaks = '1 month') +
    ylab("Frequency") + xlab("Month and Year") + 
    theme_bw() +
    labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename))," by Variant of Concern (", title, ")")) +
    facet_wrap(~Label, ncol=1) + 
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
    guides(fill=guide_legend(title="Variant", ncol=1)) + 
    theme(legend.key.size = unit(.5, 'cm')) +
    scale_fill_manual(name = "Variant", values=c("grey50"))
  return(plot)
}
voc2 <- function(title) {
  metadata.temp = metadata[c("pangolin_lineage","voc","date","division")]
  metadata.temp$voc <- ifelse(grepl(as.character(paste0("^",title,"$")), metadata.temp$voc),title, "Others")
  metadata.temp$voc <- factor(metadata.temp$voc, levels = c(title, "Others"))
  plot <- metadata.temp %>% left_join(metadata.temp %>% group_by(division) %>% summarise(N=n()))%>%
    mutate(Label=paste0(division,' (n = ',N,')')) %>%
    ggplot(metadata.temp, mapping = aes(date)) + 
    geom_histogram(binwidth = 1, aes(fill=voc)) +
    scale_x_date(labels = date_format("%b-%Y"), 
                 date_breaks = '1 month') +
    ylab("Frequency") + xlab("Month and Year") + 
    theme_bw() +
    labs(title=paste0("Distribution of Collection Date in ", str_to_title(gsub(".*\\.","",filename))," by Variant of Concern (", title, ")")) +
    facet_wrap(~Label, ncol=1) + 
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
          axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0))) +
    guides(fill=guide_legend(title="Variant", ncol=1)) + 
    theme(legend.key.size = unit(.5, 'cm')) +
    scale_fill_manual(name = "Variant", values=c("red","grey50"))
  return(plot)
}
#create and save graphs
for(i in 1:nrow(variants)){
  if (variants[i,2] %in% metadata$voc) {
    plot = voc2(variants[i,2])
  } else {
    plot = voc1(variants[i,2])
  }
  ggsave (plot = plot,
          filename = paste0(od, paste0(filename, ".", variants[i,2], ".variant.png")),
          width = 7, height = 8, units = "in", dpi = 300)
}


