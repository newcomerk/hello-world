# This script assembles data for maps

# 20170302 ALC

# Load libraries
library(readxl)
library(ggplot2)
library(scales)
library(RColorBrewer)
library(maptools)
library(ggmap)
library(ggsn)

# do i need these? (below)
#library(mapproj)
#library(mapplots)
#library(shapefiles)

#library(rgeos)
#library(rgdal)

#library(plyr)
#library(raster)
#library(plotrix)
#library(foreign)
#library(sp)
#library(proj4)
#library(dplyr)

#library(SpatialEpi)
#library(GISTools)


# Load site data
## Fouling
f.locations <- read.csv("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/2017 Fouling/2014 to 2016 CDFW Fouling Sites.csv")
f.locations$group <- NA # Add group variable for ggplot

## Soft Sediment
#ss.locations <- read_excel("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/2017 Soft Sediment/Soft-sediment samples and stations.xls", sheet = 1, skip = 3)
ss.locations <- read.csv("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/2017 Soft Sediment/2017 CDFW Soft Sediment Site Coordinates.csv")
ss.locations$group <- NA # Add group variable for ggplot
#ss.locations$Year <- format.Date(ss.locations$Date, "%Y")
ss.locations$Latitude <- as.numeric(ss.locations$Latitude)
ss.locations$Longitude <- as.numeric(ss.locations$Longitude)

# Load map data
calcoast <- readShapePoly("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/Map Data/California_coast/California_coast.shp", proj4string = CRS("+init=epsg:3488")) #6414 is the new epsg code according to http://www.epsg-registry.org/, but this has to be added to my local epsg database (found at  normalizePath(system.file("proj/epsg", package="rgdal"))) before using it. See http://maths-people.anu.edu.au/~johnm/notes/spatial/spatial-notes.pdf

mdrcoast <- readShapeSpatial("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/Map Data/MDR Coastline/CUSPLine.shp", proj4string = CRS("+init=epsg:4269"))
mdrcoast.latlong <- spTransform(mdrcoast, CRS("+proj=longlat +ellps=GRS80"))

calesri <- readShapePoly("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Data/Map Data/CA ESRI Coastline/cazip.shp")

# Prepare the geographic data sets - convert projection to lat long
calcoast.latlong <- spTransform(calcoast, CRS("+proj=longlat +ellps=GRS80"))
#calocean.latlong <- spTransform(calocean, CRS("+proj=longlat +ellps=GRS80"))

### Transform to WGS84 for use with mapplots package
calcoast.latlong.wgs84 <- spTransform(calcoast.latlong, CRS("+proj=longlat +datum=WGS84"))