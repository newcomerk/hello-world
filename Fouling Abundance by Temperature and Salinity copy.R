# Create T-S-abundance plot for bryos and tunicates at Richmond across the years.

# Requires raw data to be loaded first to produce dataframe SFBay_all_combined
source("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Analyses/SF Bay Temporal Point Count Raw Data Loader.R")

# Requires raw temperature data to be loaded first to produce dataframe temp.SF
source("~/Dropbox (Smithsonian)/SERC Two The Return/SERC Manuscripts/Chang/Heat Wave ms/Heat Wave ms Temperature Data Processor.R")

# Load Delta Outflow to produce outflow dataframe
outflow <- read.csv("~/Dropbox (Smithsonian)/dropbox/Manuscripts/Storms/Data/2000 to 2017 SF Bay Mean Daily Winter Outflow.csv")

# Requires temperature stats
source("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Analyses/Temperature/R Scripts/Temperature Summary Statistics.R")
temp.sum.SF <- TemperatureStats(temp.SF)

  begyr <- 2001
  
  endyr <- 2016

	ex <- c("T13703", "15491")

  # Load libraries
  library(reshape2)
  library(vegan)
  library(ggplot2)
  
  # Load theme
  source('~/Dropbox (Smithsonian)/Misc R Functions/Fouling_theme.R', chdir = TRUE)
  
  # Load functions
  source('~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Analyses/Forecasts/Single Site Temperature Density Plot.R')
  source('/Users/andychang/Dropbox (Smithsonian)/SERC Two The Return/SERC Manuscripts/Chang/Heat Wave ms/TemperatureStatsAug.R')

    # Process data for selected site
#  All_1 <- SFBay_all_combined[SFBay_all_combined$BlockName == n, ] # Added the following two lines to actually incorporate begyr and endyr
  All_1 <- SFBay_all_combined[SFBay_all_combined$BlockName == n & SFBay_all_combined$Yeardeployed %in% begyr:endyr, ]
  All_1$Yeardeployed <- All_1$Yeardeployed[drop = T]
  
  # Remove excluded panels
  if(is.na(ex) == FALSE) {
    All <- All_1[!All_1$Plate_ID %in% ex, ]
  } else {
    All <- All_1
  }
  
  
  # Subset to macroinvertebrates
  All_sub1 <- All[!All$MorphotypeNum %in% taxaomitlist$Omit, ]
  All_sub <- All_sub1[!is.na(All_sub1$NumPoints), ] # Remove NAs
  
  # Cast to wide form for community comparisons
  All_sub_cast <- dcast(Yeardeployed + Plate_ID ~ MorphotypeNum, value.var = "NumPoints", data = All_sub, sum)
  All_sub_cast[is.na(All_sub_cast)] <- 0 # Convert cast NA values to zeroes
  All_sub_cast <- All_sub_cast[rowSums(All_sub_cast[, 3:length(All_sub_cast)]) > 0, ] # Remove rows with zeroes
  
  # Create vector of year types
  Yeartype <- as.character(All_sub_cast$Yeardeployed)
  Yeartype[Yeartype %in% c(2001, 2002, 2007:2009, 2013:2015)] <- "Dry"
  Yeartype[Yeartype %in% c(2002:2005, 2010, 2012, 2016)] <- "Moderate"
  Yeartype[Yeartype %in% c(2006, 2011, 2017)] <- "Wet"
  
  Yeartemp <- as.character(All_sub_cast$Yeardeployed)
  Yeartemp[Yeartemp %in% c(2001:2013, 2016)] <- "Average"
  Yeartemp[Yeartemp %in% c(2014:2015)] <- "Hot"
  
  ####### Calculate similarities
  bc <- vegdist(All_sub_cast[, 3:length(All_sub_cast)])
  bc <- monoMDS(bc)
  
  bc_pts <- data.frame(bc$points, All_sub_cast$Yeardeployed, Yeartype, Yeartemp, All_sub_cast$Plate_ID)
  names(bc_pts) <- c("X", "Y", "Year", "SalnType", "TempType", "Plate_ID")
  bc_pts$Year <- as.factor(bc_pts$Year)
  

  ####### Plot selected species as a function of temperature and salinity # added 20170909
  temp.sum.SF.sub <- temp.sum.SF[temp.sum.SF$Year %in% begyr:endyr & temp.sum.SF$Site == n,]
  names(temp.sum.SF.sub)[1] <- "Yeardeployed"
  outflow.sub <- outflow[outflow$Year %in% begyr:endyr,]
  names(outflow.sub)[1] <- "Yeardeployed"
  All.temp <- merge(All, temp.sum.SF.sub, by = c("Yeardeployed"), all.x = T)
  All.temp.out <- merge(All.temp, outflow.sub, by = c("Yeardeployed"), all.x = T)

p <- ggplot(data = All.temp.out[All.temp.out$MorphotypeNum%in% c("Tunicata 1", "Tunicata 2", "Tunicata 3", "Tunicata 4", "Tunicata 5", "Tunicata 6", "Tunicata 7", "Tunicata 9", "Tunicata 13", "Tunicata 14", "Tunicata 18"), ], aes(x = Mean, y = MeanDailyOutflow, size = NumPoints, color = MorphotypeNum))
  p + geom_jitter(alpha = 0.5, width = 0.5, height = 100) +
  ylab("Mean Daily Outflow (m3/s)") +
  xlab("Mean Temperature (°C)") +
  scale_size(range = c(1, 10), name = "Percent Cover") +
    Fouling_theme +
	theme(axis.text.x = element_text(angle = 90)) +
    ggtitle(paste(paste(paste(n, "Common Tunicate Abundances", sep = " "), begyr, sep = " "), endyr, sep = " to "))
    
    
  p <- ggplot(data = All.temp.out[All.temp.out$MorphotypeNum%in% c("Bryozoa 1", "Bryozoa 2", "Bryozoa 10", "Bryozoa 4", "Bryozoa 6"), ], aes(x = Mean, y = logMeanDailyOutflow, size = NumPoints, color = MorphotypeNum))
  p + geom_jitter(alpha = 0.5, width = 0.5, height = 0.2) +
  ylab("Log Mean Daily Outflow (m3/s)") +
  xlab("Mean Temperature (°C)") +
  scale_size(range = c(1, 10), name = "Percent Cover") +
#  scale_colour_manual() +
    Fouling_theme +
	theme(axis.text.x = element_text(angle = 90)) +
    ggtitle(paste(paste(paste(n, "Common Bryozoan Abundances", sep = " "), begyr, sep = " "), endyr, sep = " to "))


  setwd("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Analyses/Forecasts/")
  ggsave(file = paste(paste(paste(paste(format.Date(Sys.time(), "%Y%m%d %H%M"), begyr, sep = " hrs "), endyr, sep = " to "), n, sep = " "), "Summer Community Common Bryozoan Abundances by Mean Temperature and Mean Daily Winter Outflow - One Panel.png", sep = " "), width = 10, height = 7)   
    
# Common Tunicates at Richmond
All.temp.out$logMeanDailyOutflow <- log(All.temp.out$MeanDailyOutflow)

p <- ggplot(data = All.temp.out[All.temp.out$MorphotypeNum%in% c("Tunicata 1", "Tunicata 2", "Tunicata 4", "Tunicata 5", "Tunicata 6", "Tunicata 7"), ], aes(x = Mean, y = logMeanDailyOutflow, size = NumPoints, color = MorphotypeNum))
  p + geom_jitter(alpha = 0.5, width = 0.5, height = 0.2) +
  ylab("Log Mean Daily Outflow (m3/s)") +
  xlab("Mean Temperature (°C)") +
  scale_size(range = c(1, 10), name = "Percent Cover") +
    Fouling_theme +
#	theme(axis.text.x = element_text(angle = 90)) +
    ggtitle(paste(paste(paste(n, "Common Tunicate Abundances", sep = " "), begyr, sep = " "), endyr, sep = " to "))

  setwd("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Analyses/Forecasts/")
  ggsave(file = paste(paste(paste(paste(format.Date(Sys.time(), "%Y%m%d %H%M"), begyr, sep = " hrs "), endyr, sep = " to "), n, sep = " "), "Summer Community Common Tunicate Abundances by Mean Temperature and Mean Daily Winter Outflow - One Panel.png", sep = " "), width = 10, height = 7)    
