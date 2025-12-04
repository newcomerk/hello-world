####===============================================================================
# Examples of my favorite maps
# KLawson 2025
# Other useful mapping references
# https://ggplot2-book.org/maps.html
# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html
# https://www.andrewheiss.com/blog/2023/07/28/gradient-map-fills-r-sf/

####===============================================================================
#load packages
library(raster)
library(sf)
library("ggplot2")
theme_set(theme_bw())
library("rnaturalearth")
library("rnaturalearthdata")
library("ggspatial")
library(dplyr)
library(tidyr)
library(viridis)
library(red)
library(units)
library(redlistr)
library(stars)


mycols<- c("#C969A1FF", "#CE4441FF", "#EE8577FF", "#EB7926FF", "#FFBB44FF", "#859B6CFF", "#62929AFF", "#004F63FF", "#122451FF")

####===============================================================================


#Using the direct path
#NY Waters, State boundaries
NYOAP <- read_sf('C:/Users/kxlawson/XXX.shp') #these are locally stored shape files of relevant boundaries
otherstates<-read_sf('C:/Users/kxlawson/XXX.shp')
NYstate<-read_sf('C:/Users/kxlawson/XXX.shp')
Mid_Depth<- read_sf('C:/Users/kxlawson/XXX.shp')
stat_area<- read_sf('C:/Users/kxlawson/XXX.shp')
sub_stat_area<- read_sf('C:/Users/kxlawson/XXX.shp')
#ensure mapped the same
NYOAP <- st_transform(NYOAP, crs = 4326) # convert to WGS84
otherstates <- st_transform(otherstates, crs = 4326) # convert to WGS84
NYstate <- st_transform(NYstate, crs = 4326) # convert to WGS84
Mid_Depth <- st_transform(Mid_Depth, crs = 4326) # convert to WGS84
sub_stat_area <- st_transform(sub_stat_area, crs = 4326) # convert to WGS84
st_crs(otherstates)==st_crs(NYOAP) #check


####===============================================================================


# transform lat / long into geometries for R to read
merged_data <- merged_csv %>% st_as_sf(coords = c("long", "lat"), crs = 4269) # convert to NAD83
merged_data<-st_transform(merged_data, "+proj=utm +zone=18 +ellps= GRS80 +datum=NAD83")
occurences_merge <- merged_data

##================================================================================
#making the plot
# this is an example plot that plots points overlaid on state boundaries, and a NY waters boundary called NYOAP

p<- ggplot() +
  geom_sf(data=otherstates)+  # boundary of states
  geom_sf(data=NYstate, fill = "antiquewhite") + # boundary of NY with an accent color
  geom_sf(data=NYOAP, fill = "white") + # boundary of NY waters with an accent color
  annotation_scale(location = "bl", width_hint = 0.5) + # bottom left scale
  annotation_north_arrow(location = "bl", which_north = "true",  # bottom left north arrow
                         pad_x = unit(0.4, "in"), pad_y = unit(0.5, "in"), 
                         style = north_arrow_fancy_orienteering) +
  geom_sf(data = occurences_merge, aes(color=Source)) +  # the points, with colors matching a "occurences_merge$Source" column
  xlab("") + ylab("") + # remove labels on x and y
  annotate(geom = "text", x = -70.5, y = 38.45, label = ifelse(end.status == TRUE, "CONFIDENTIAL DATA", ""), color = "darkgray", size = 2) # if I marked this spp as confidential, adds a tag to the bottom of the map

# plot the above within a boundary
p + coord_sf(xlim = c(-74.4, -70), ylim = c(38.4, 41.78)) # this plots the map in boundaries I set

# save the plot
ggsave("../XX.jpg") #, width = 6, height = 6, dpi = "screen") # saves the plot and can specify image quality


##================================================================================
#making the plot WLIS only

p.WLIS<- ggplot() +
  geom_sf(data=otherstates)+
  geom_sf(data=NYstate, fill = "antiquewhite") +
  geom_sf(data=NYOAP, fill = "white") + 
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.4, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering) +
  geom_sf(data = occurences_merge %>% filter(Source == "DEC Western Long Island Seine"), aes(color="Source")) +  # note how you can filter a data set by any column, here by "Source"
  # geom_sf(data = inat_data_clip, alpha = 0.7) +
  xlab("") + ylab("") +
  annotate(geom = "text", x = -70.5, y = 38.45, label = ifelse(end.status == TRUE, "CONFIDENTIAL DATA", ""), color = "darkgray", size = 2) 

# plot the above within a boundary
p.WLIS + coord_sf(xlim = c(-74.4, -73.2), ylim = c(40.4, 41.2)) # this is the zoomed in window for WLS



####===============================================================================
#making the plot
# this is an example plot that plots fish presence overlaid on state boundaries, and a NY waters boundary called NYOAP

s1 <- ggplot() +
  geom_sf(data=otherstates)+  # boundary of states
  geom_sf(data=NYstate, fill = "gray46") + # boundary of NY with an accent color
  geom_sf(data=NYOAP, fill = "white") + # boundary of NY waters with an accent color
  geom_sf(data=stat_area, fill="white")+ # boundary of fishery management areas
  geom_sf_text(data=stat_area, label = stat_area$Id, size = 1) + # this adds labels for the fishery management stat area, with stat_area$Id and font size of 1
  annotation_scale(location = "bl", width_hint = 0.5) + # bottom left scale
  annotation_north_arrow(location = "br", which_north = "true", # bottom left north arrow
                         pad_x = unit(0.4, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering) +
  geom_sf(data = allhauls, aes(fill= "black"), shape = 3) + # this layers on all fishing trips GPS location with a black cross (shape 3, look up shape numbers online)
  geom_sf(data = allhauls %>% filter(`STURGEON, ATLANTIC` > 0), aes(color = "pink", size = `STURGEON, ATLANTIC`)) + # this layers on a pink circle where sturgeon were caught, 
                                                                                                                  #and makes the circle size reflect the column of sturgeon count allhauls$`STURGEON, ATLANTIC`
  guides(linewidth = FALSE, size = FALSE) + # this supresses the legends because got too busy
  labs(title = "CatchAll Hauls and Sturgeon") # title of the plot


s1 +  coord_sf(xlim = c(-75.65, -66), ylim = c(34.6, 45.01))  +theme(legend.position ="none") + # this plots the map in my boundaries and sets a nice design
  annotate("text", x = Inf, y = -Inf, label = "Confidential Fishery Data", # this a text box I manually add to say its confidential and shouldnt be shared
           hjust=1.1, vjust=-1.1, col="gray41", cex=2,
           fontface = "bold", alpha = 0.8) 
ggsave("AllHauls_SturgeonOverlay_CatchAll.jpg") # this saves it


#save legend separately if too big
my_legend_s1 <- get_legend(s1)
as_ggplot(my_legend_s1)
ggsave("AllHauls_CatchAll_Legend.jpg")


