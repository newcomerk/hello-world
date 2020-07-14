# This script generates heat maps for 2017 CDFW Final Report

## Calculate number of unique NIS per site in each bay in each year
NIS_richness_bysite_prep <- aggregate(Species ~ Bay + YearDeployed + BlockID + Site, FUN = "unique", data = DataAll[DataAll$Status == c("Introduced"), ])
names(NIS_richness_bysite_prep)[5] <- c("NIS")

NIS_richness_bysite <- data.frame(NIS_richness_bysite_prep[, 1:4], sapply(NIS_richness_bysite_prep$NIS, length))
names(NIS_richness_bysite)[5] <- c("NumNIS")

## Make maps
## Load location data
dat <- read.csv("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/2017 Fouling/2014 to 2016 CDFW Fouling Sites.csv")

## Merge with block table
names(dat)[1] <- c("BlockID")
NISperblock <- merge(dat, NIS_richness_bysite, by = c("BlockID"), all.x = T)
names(NISperblock)[2] <- c("Bay")
NISperblock$NumNIS[is.na(NISperblock$NumNIS)] <- 0 # Replace NA with 0, because if the block ID didn't come up in the NIS richness dataset, that means none were found at that site

## Prep data
# Load bay-year listing
mybays <- read.csv("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/2017 Fouling/2014 to 2016 Bay Year List.csv", colClasses = c("character", "numeric"))

# Loop to make maps for all bays in each year sampled
for (i in 1:nrow(mybays)){
	bay_name <- mybays[i, 1]
	bay_year <- mybays[i, 2]

	dat.sub <- NISperblock[NISperblock$Bay == bay_name & NISperblock$Year == bay_year, ]

  	# Specify area of map
	bb <- make_bbox(`Longitude`,`Latitude`, dat.sub, f=fval)
  	
  
  	# GOOGLE TERRAIN MAP
  	# Get map data from Google Maps
  	google_block_map <- get_map(bb, source="google", maptype="terrain")
  
  	# Make the map
  	g <- ggmap(google_block_map) + 
  		geom_point(data=dat.sub, aes(x = Longitude, y = Latitude, colour = NumNIS), size=5) + 
  		ylab("") +
  		xlab("") +
  	  scale_colour_gradientn(colours = rainbow(10, start = 4/6, end = 0), limits = c(0, 25), "Number of NIS")
  	assign(paste0(substr(bay_name, 1, 3), "", bay_year, "HeatMap"), g)
}