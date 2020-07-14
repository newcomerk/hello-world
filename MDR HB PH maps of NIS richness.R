#other bay maps with NIS by site
# Load data
setwd("E:/Users/invasions/Dropbox (Smithsonian)/Revised Code/MM-temp/Analysis code")
source("MeanNISRich_BayAnalysis.R")

#data
NIS<-dcast(Bay +BlockName~ (GenusSpecies), fun.aggregate=sum, value.var="i", data = Data)
##problem is has numbers rather than binary
write.csv(NIS, "NIS.csv")
NIS<-read.csv("NIS.csv")

NISrich<-data.frame(NIS[,2:3], specnumber(NIS[, 4:(length(NIS) - 3)]))

names(NISrich)[3] <- c("Richness")
#remove SF
NISrich<-subset(NISrich, Bay!= "SF")

##need lat and long

### ggplot version with scalebar and north arrow courtesy of ggsn (http://oswaldosantos.github.io/ggsn/)

setwd("E:/Users/invasions/Dropbox (Smithsonian)/Revised Code/Output/Figures/")
# Load data
source('E:/Users/invasions/Dropbox (Smithsonian)/Revised Code/Data Processing/Map Data Processing.R', chdir = TRUE)

# Load theme
source('E:/Users/invasions/Dropbox (Smithsonian)/Revised Code/Themes/Fouling_theme.R', chdir = TRUE)

# Plot maps
setwd("E:/Users/invasions/Dropbox (Smithsonian)/Revised Code/Output/")

## Humboldt
hb.bbox <- make_bbox(lon = Longitude, lat = Latitude, data = f.locations[f.locations$Bay == "HB", ])

### Zoom out a little bit
hb.bbox[1] <- hb.bbox[1] * 1.0005
hb.bbox[2] <- hb.bbox[2] - (hb.bbox[2] * 0.0005)
hb.bbox[3] <- hb.bbox[3] - (hb.bbox[3] * 0.0005)
hb.bbox[4] <- hb.bbox[4] * 1.0005

jpeg(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Humboldt Bay Site Map.jpeg", sep = "hrs "), width = 10, height = 10, units = "in", res = 150)

plot(calesri, col = rgb(0.2, 0.2, 0.2, 0.35), border = rgb(0.2, 0.2, 0.2, 0), xlim = c(as.vector(hb.bbox[1]), as.vector(hb.bbox[3])), ylim = c(as.vector(hb.bbox[2]), as.vector(hb.bbox[4])))

points(Latitude  ~ Longitude, data = f.locations[f.locations$Bay == "HB", ], pch = 19, cex = 2, col = rgb(0, 0, 0, 0.7))

dev.off()


## Marina del Rey
mdr.bbox <- make_bbox(lon = Longitude, lat = Latitude, data = f.locations[f.locations$Bay == "MDR", ])

### Zoom out a little bit
mdr.bbox[1] <- mdr.bbox[1] * 1.00005
mdr.bbox[2] <- mdr.bbox[2] - (mdr.bbox[2] * 0.0001)
mdr.bbox[3] <- mdr.bbox[3] - (mdr.bbox[3] * 0.00005)
mdr.bbox[4] <- mdr.bbox[4] * 1.0001

jpeg(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Marina del Rey Site Map.jpeg", sep = "hrs "), width = 10, height = 10, units = "in", res = 150)

plot(calesri, col = rgb(0.2, 0.2, 0.2, 0.35), border = rgb(0.2, 0.2, 0.2, 0), xlim = c(as.vector(mdr.bbox[1]), as.vector(mdr.bbox[3])), ylim = c(as.vector(mdr.bbox[2]), as.vector(mdr.bbox[4])))

points(Latitude  ~ Longitude, data = f.locations[f.locations$Bay == "MDR", ], pch = 19, cex = 2, col = rgb(0, 0, 0, 0.7))

dev.off()



## Port Hueneme - with axes drawn in
ph.bbox <- make_bbox(lon = Longitude, lat = Latitude, data = f.locations[f.locations$Bay == "PH", ])

f.locations.ph <- f.locations[f.locations$Bay == "PH", ]
f.locations.ph$Longitude[!f.locations.ph$Block_ID == 2286] <- f.locations.ph$Longitude[!f.locations.ph$Block_ID == 2286] - 0.0012 # Correct to fit shapefile, except for 2286 which was corrected separately
f.locations.ph$Latitude[!f.locations.ph$Block_ID == 2286] <- f.locations.ph$Latitude[!f.locations.ph$Block_ID == 2286] - 0.0001 # Correct to fit shapefile, except for 2286 which was corrected separately


jpeg(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Port Hueneme Site Map.jpeg", sep = "hrs "), width = 10, height = 10, units = "in", res = 150)

plot(calesri, col = rgb(0.2, 0.2, 0.2, 0.35), border = rgb(0.2, 0.2, 0.2, 0), xlim = c(as.vector(ph.bbox[1]), as.vector(ph.bbox[3])), ylim = c(as.vector(ph.bbox[2]), as.vector(ph.bbox[4])))
points(Latitude  ~ Longitude, data = f.locations[f.locations$Bay == "PH", ], pch = 19, cex = 2, col = rgb(0, 0, 0, 0.7))
box(color = "black")
axis(1, lwd = 1, at = seq(as.vector(ph.bbox[1]), as.vector(ph.bbox[3]), length.out = 4))
axis(2, lwd = 1, at = round(seq(as.vector(ph.bbox[2] - (0.0001 * ph.bbox[2])), 1.0001 * as.vector(ph.bbox[4]), length.out = 4), 3))

dev.off()




# ggplot versions
f.locations$group = NA # Add grouping variable

loc<-merge(f.locations, NISrich, by=c("BlockName"))

## Humboldt
p <- ggplot(data = calesri, aes(x = long, y = lat, group = group)) + 
  geom_polygon(colour = "#BEBEBE", fill = "#BEBEBE") +
  geom_point(data = loc[loc$Bay.x == "HB", ], aes(x = Longitude, y = Latitude, group = group, colour = Richness), shape = 19, size = 5) +
  scale_shape(solid = FALSE) +
  scale_colour_gradient(low = "blue", 
                        high = "red",
                        name = "Number of NIS",
                        limits = c(5, 25)) + 
  coord_fixed(xlim = c(-124.3, -124.1), ylim = c(as.vector(hb.bbox[2]), as.vector(hb.bbox[4]))) +
  scale_y_continuous(labels=function(n){round(n, 2)}) +
  scale_x_continuous(labels=function(n){round(n, 2)}) +
  ylab("Latitude") +
  xlab("Longitude") +
  Fouling_theme_small_labels +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1))

p +
  north(x.min = -124.29, x.max = -124.27, y.min = 40.82, y.max = 40.84, symbol = 1, scale = 1.8) +
  scalebar(x.min = -124.2, x.max = -124.1, y.min = 40.72, y.max = 40.73, dist = 2.5, dd2km = TRUE, model = 'WGS84', st.size = 3, st.bottom = TRUE, st.dist = 0.4, height = 0.2)

ggsave(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Humboldt Site Map ggplot.jpeg", sep = "hrs "), width = 10, height = 10, units = "in")

## Marina del Rey
p <- ggplot(data = calesri, aes(x = long, y = lat, group = group)) + 
  geom_polygon(colour = "#BEBEBE", fill = "#BEBEBE") +
  geom_point(data = loc[loc$Bay.x  == "MDR", ], aes(x = Longitude, y = Latitude, group = group, colour = Richness), shape = 19, size = 5) +
  scale_shape(solid = FALSE) +
  scale_colour_gradient(low = "blue", 
                        high = "red",
                        name = "Number of NIS",
                        limits = c(10, 25)) + 
  coord_fixed(xlim = c(as.vector(mdr.bbox[1]), as.vector(mdr.bbox[3])), ylim = c(as.vector(mdr.bbox[2]), as.vector(mdr.bbox[4]))) +
  scale_y_continuous(labels=function(n){round(n, 2)}) +
  scale_x_continuous(labels=function(n){round(n, 2)}) +
  ylab("Latitude") +
  xlab("Longitude") +
  Fouling_theme_small_labels +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1))

p +
  north(x.min = -118.463, x.max = -118.458, y.min = 33.982, y.max = 33.984, symbol = 1, scale = 1.8) +
  scalebar(x.min = -118.45, x.max = -118.438, y.min = 33.97, y.max = 33.973, dist = 0.25, dd2km = TRUE, model = 'WGS84', st.size = 3, st.bottom = TRUE, st.dist = 0.2, height = 0.2)

ggsave(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Marina del Rey Site Map ggplot.jpeg", sep = "hrs "), width = 10, height = 10, units = "in")


## Port Hueneme v1 (calesri) -- this doesn't work because the ESRI shapefile doesn't have Port Hueneme's coastline. 20170314 - after discussing with Brian Steves, best course of action is to use the other (calcoast) shapefile for Port Hueneme - see v2 below.
p <- ggplot(data = calesri, aes(x = long, y = lat, group = group)) + 
  geom_polygon(colour = "#BEBEBE", fill = "#BEBEBE") +
  geom_point(data = loc[loc$Bay.x == "PH", ], aes(x = Longitude, y = Latitude, group = group, colour = Richness), shape = 19, size = 5) +
  scale_shape(solid = FALSE) +
  scale_colour_gradient(low = "blue", 
                        high = "red",
                        name = "Number of NIS",
                        limits = c(0, 25)) + 
  coord_fixed(xlim = c(as.vector(ph.bbox[1]), as.vector(ph.bbox[3])), ylim = c(as.vector(ph.bbox[2]), as.vector(ph.bbox[4]))) +
  scale_y_continuous(labels=function(n){round(n, 2)}) +
  scale_x_continuous(labels=function(n){round(n, 2)}) +
  ylab("Latitude") +
  xlab("Longitude") +
  Fouling_theme_small_labels +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1))

p +
  north(x.min = ph.bbox[1], x.max = ph.bbox[1] - (ph.bbox[1] * 0.00005), y.min = ph.bbox[4] - (ph.bbox[4] * 0.0001), y.max = ph.bbox[4], symbol = 1, scale = 0.5, location = "topleft") +
  scalebar(x.min = ph.bbox[3] + (ph.bbox[3] * 0.00005), x.max = ph.bbox[3], y.min = ph.bbox[4] - (ph.bbox[4] * 0.0002), y.max = ph.bbox[4] - (ph.bbox[4] * 0.000025), dist = 0.25, dd2km = TRUE, model = 'WGS84', st.size = 3, st.bottom = TRUE, st.dist = 0.1, height = 0.05, location = "topright")

ggsave(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Port Hueneme Site Map ggplot.jpeg", sep = "hrs "), width = 10, height = 10, units = "in")

## Port Hueneme v2 (calcoast) - this one works. 20170314.
f.locations.ph <- f.locations[f.locations$Bay == "PH", ]
f.locations.ph$Longitude[!f.locations.ph$Block_ID == 2286] <- f.locations.ph$Longitude[!f.locations.ph$Block_ID == 2286] - 0.0012 # Correct to fit shapefile, except for 2286 which was corrected separately
f.locations.ph$Latitude[!f.locations.ph$Block_ID == 2286] <- f.locations.ph$Latitude[!f.locations.ph$Block_ID == 2286] - 0.0001 # Correct to fit shapefile, except for 2286 which was corrected separately
loc<-merge(f.locations.ph, NISrich, by=c("BlockName"))

p <- ggplot(data = calcoast.latlong, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white") +
  geom_point(data = loc[loc$Bay.x == "PH", ], aes(x = Longitude, y = Latitude, group = group, colour = Richness), shape = 19, size = 5)+
  scale_shape(solid = FALSE) +
  scale_colour_gradient(low = "blue", 
                        high = "red",
                        name = "Number of NIS",
                        limits = c(5, 20)) + 
  coord_fixed(xlim = c(as.vector(ph.bbox[1]) - 0.005, as.vector(ph.bbox[3])), ylim = c(as.vector(ph.bbox[2] - (0.0001 * ph.bbox[2])), (1.00002 * as.vector(ph.bbox[4])))) +
  scale_y_continuous(labels=function(n){round(n, 2)}) +
  scale_x_continuous(labels=function(n){round(n, 2)}) +
  ylab("Latitude") +
  xlab("Longitude") +
  Fouling_theme_small_labels +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1),
        panel.background = element_rect(fill = "#BEBEBE")) # Set background color to land color here, and plot white (water) polygons on top, because this shapefile is the reverse of the ESRI shapefile.

p +
  north(x.min = ph.bbox[1] - 0.008, x.max = ph.bbox[1] - (ph.bbox[1] * 0.00005), y.min = ph.bbox[4] - (ph.bbox[4] * 0.0001), y.max = ph.bbox[4], symbol = 1, scale = 0.5, location = "topleft") +
  scalebar(x.min = ph.bbox[3] + (ph.bbox[3] * 0.00005), x.max = ph.bbox[3], y.min = ph.bbox[4] - (ph.bbox[4] * 0.0002), y.max = ph.bbox[4] - (ph.bbox[4] * 0.000025), dist = 0.25, dd2km = TRUE, model = 'WGS84', st.size = 3, st.bottom = TRUE, st.dist = 0.1, height = 0.05, location = "topright")

ggsave(file = paste(format(Sys.time(), "%Y%m%d %H%M", tz = "America/Los_Angeles"), "2015 Port Hueneme Site Map ggplot.jpeg", sep = "hrs "), width = 10, height = 10, units = "in")
  