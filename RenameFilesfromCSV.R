#merge first 3 cells into one cell (file name)
#need to change photo location
#need to edit code so it removes the _1,_2 aspect of the file name, but retains it later

setwd("V:/Invasions/Fouling Plate Photos/")
data <- read.csv("PlatePhotoNameFormattedData.29Apr2020.csv")

library(tidyr)
library(dplyr)
library(magick)
library(stringr)
library(data.table)

#make a merged column to pull to add to photo name


#change this to the relevant folder
#This gets all files even in subfolders
Photofiles1<- basename(list.files("V:/Invasions/Fouling Plate Photos/2017 SF Ready/", recursive = TRUE))
Photofiles2<-list.files("V:/Invasions/Fouling Plate Photos/2017 SF Ready/", recursive = TRUE)


#Photofiles1<- basename(list.files("V:/Invasions/Fouling Plate Photos/2017 SF Ready/", recursive = TRUE))
#Photofiles2<-list.files("V:/Users/newcomerk/Desktop/16Mar20/Panel Photos/trial/2017 SF Ready/", recursive = TRUE)
#'V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready'


Photofiles1<-Photofiles1[!str_detect(Photofiles1,pattern="doc")]
Photofiles2<-Photofiles2[!str_detect(Photofiles2,pattern="doc")]
Photofiles3<-lapply(Photofiles1, tolower)
data$panel2<-lapply(data$Plate_ID, tolower)


proof<-as.data.frame(Photofiles1,Photofiles2)
setDT(proof, keep.rownames = "Photofiles2")
proof$panel<- ifelse(grepl("_", Photofiles1),gsub("(.*)_.*","\\1", Photofiles1,ignore.case=TRUE),
                     ifelse(grepl("-", Photofiles1),gsub("(.*)-.*","\\1", Photofiles1,ignore.case=TRUE),
                            gsub(".jpg","", Photofiles1   )))
proof$panel2<-lapply(proof$panel, tolower)
proof$InFile<-proof$panel2 %in% data$panel2
infilelist<- proof %>% filter(InFile==TRUE) %>% select(Photofiles2)
infilelist2<-as.vector(infilelist$Photofiles2)

##then start the loop for every photo in the new list Photofiles
for(i in 1:length(Photofiles1)){
  BG <- image_read(file.path('V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready', paste(Photofiles2[i]), sep=''))
  dummy<-data %>% filter(panel2 == ifelse(grepl("_", Photofiles3[i]),gsub("(.*)_.*","\\1", Photofiles3[i],ignore.case=TRUE),
                                   ifelse(grepl("-", Photofiles3[i]),gsub("(.*)-.*","\\1", Photofiles3[i],ignore.case=TRUE),
                                       gsub(".jpg","", Photofiles3[i]   ))))           %>% pull(bay)
#this removes all text after the last/ so you keep the file path for all files
    PF<-ifelse(grepl("/", Photofiles2[i]), gsub("(.*)/.*","\\1",Photofiles2[i]),"")
  mypath = file.path('V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready', PF , paste(dummy, Photofiles1[i], sep=''))
image_write(BG, path = mypath, format = "jpg")
}




#when that is done
#check that length has doubled
length(Photofiles1)
newfiles<-basename(list.files("V:/Invasions/Fouling Plate Photos/2017 SF Ready/", recursive = TRUE))
length(newfiles)

#This is the delete call
do.call(file.remove, list(file.path('V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready', infilelist2)))


#######
#for removing the file name
#this goes subfolder by subfolder
fixes1<- basename(list.files("V:/Invasions/Fouling Plate Photos/2017 SF Ready/2619/", recursive = TRUE))

fixes2<-as.data.frame(fixes1)
fixes2<- filter(fixes2, grepl("HB",fixes1))
fixes3<-as.character(fixes2$fixes1)

##then start the loop for every photo in the new list Photofiles
for(i in 1:length(fixes3)){
  BG <- image_read(file.path('V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready', '2619', paste(fixes3[i]), sep=''))
  dummy<-  str_remove_all(fixes3[i], "HB_2019_2619_")
  
  mypath = file.path('V:', 'Invasions', 'Fouling Plate Photos','2017 SF Ready', '2619' , paste(dummy, sep=''))
  image_write(BG, path = mypath, format = "jpg")
}

