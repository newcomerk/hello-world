# CDFW 2017 Report
# Species accumulation curve example

# revised Fri 20170317 0853 hrs


# Load libraries
library(vegan)
library(ggplot2)
library(scales)
library(reshape2)
library(plyr)



# Set working directory
setwd("")


# Load and assemble data

## Splitting and reshaping data is probably most easily done in R, but for the purposes of this example, I assume one dataframe for each status for each bay/year

## Data should be in format Year, Bay, Site, SampleID, sp1, sp2, sp3, etc -- with one dataframe containing only the species for each status. 5 dataframes in all -- total (all statuses together), unr (unresolved), inv (introduced), nat (native), crypto (cryptogenic)


haizeasdata.total <- read.csv("sftotal.csv")
haizeasdata.unr <- read.csv("sfunr.csv")
haizeasdata.crypto <- read.csv("sfcrypto.csv")
haizeasdata.nat <- read.csv("sfnat.csv")
haizeasdata.inv <- read.csv("sfinv.csv")


source('Fouling_theme.R', chdir = TRUE)


all.sp <- specaccum(haizeasdata.total[5:length(names(haizeasdata.total))], method = "rarefaction")

unr.sp <- specaccum(haizeasdata.unr[5:length(names(haizeasdata.unr))], method = "rarefaction")

inv.sp <- specaccum(haizeasdata.inv[5:length(names(haizeasdata.inv))], method = "rarefaction")

nat.sp <- specaccum(haizeasdata.nat[5:length(names(haizeasdata.nat))], method = "rarefaction")

crypto.sp <- specaccum(haizeasdata.crypto[5:length(names(haizeasdata.crypto))], method = "rarefaction")



all <- data.frame(with(all.sp, data.frame(sites, richness, sd)), with(haizeasdata.total, data.frame(Year, Bay)))

unr <- data.frame(with(unr.sp, data.frame(sites, richness, sd)), with(haizeasdata.unr, data.frame(Year, Bay)))

inv <- data.frame(with(inv.sp, data.frame(sites, richness, sd)), with(haizeasdata.inv, data.frame(Year, Bay)))

nat <- data.frame(with(nat.sp, data.frame(sites, richness, sd)), with(haizeasdata.nat, data.frame(Year, Bay)))

crypto <- data.frame(with(crypto.sp, data.frame(sites, richness, sd)), with(haizeasdata.crypto, data.frame(Year, Bay)))



## Create dataframe of all taxa from marine sites - by status
### Add a status column 
all$Status <- as.factor(c("Total"))
unr$Status <- as.factor(c("Unresolved"))
inv$Status <- as.factor(c("NIS"))
nat$Status <- as.factor(c("Native"))
crypto$Status <- as.factor(c("Cryptogenic"))

### Combine into one dataframe
sp.acc <- rbind(all, crypto, inv, nat, unr)


# Re-order factor levels -- this should put them in the order: Total, Unresolved, Cryptogenic, Native, NIS
sp.acc$Status <- factor(sp.acc$Status, levels(sp.acc$Status)[c(1, 5, 2, 4, 3)])

# Make plot

ggplot(sp.acc, aes(x = sites,y = richness)) +
	geom_ribbon(aes(ymin = richness - sd, ymax = richness + sd, fill = Status), alpha = 0.3) +
	geom_line(aes(colour = Status), size = 1) +
	scale_colour_manual(values = accum_colors_total, name = "") +
	xlab("Samples") +
	ylab("Richness") +
	scale_fill_manual(values = accum_colors_total, guide = "none") +
	scale_x_continuous() +
#	facet_grid(Year ~ .) + # for San Francisco, facet by year; for other bays, just facet by bay
	Fouling_theme_small_labels
#	Fouling_facet_theme_small_labels # use this theme if using facets

ggsave("SpeciesAccumulationExample.jpeg", width = 5, height = 5, dpi = 150)