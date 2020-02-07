Diversity

DataDiv<-read.csv("D:/Dropbox (Smithsonian)/Point Count Functional Group Paper/KN Stats Scratch/DivEv_Plates_20June2019.CSV")
DataDiv2<-read.csv("D:/Dropbox (Smithsonian)/Point Count Functional Group Paper/KN Stats Scratch/DivEv_PlatesPrimary_20June2019.CSV")
DataDiv2$diversity<-diversity(DataDiv2[,2:13],index="shannon")
DataDiv$diversity2<-diversity(DataDiv[,2:13],index="shannon")
DataDiv$evenness<-evenness(DataDiv[,2:13])


DataDiv2$evenness <- DataDiv2$diversity/Richness
  
Richness<-log(specnumber(DataDiv2[,2:13]))

write.csv(DataDiv2, file = "MyData2.csv")


DataDiv$diversity<-diversity(DataDiv[,2:15],index="shannon")
DataDiv$diversity<-diversity(DataDiv[,2:13],index="shannon")
DataDiv$evenness<-evenness(DataDiv[,2:13])


DataDiv$evenness <- DataDiv$diversity/Richness

Richness<-log(specnumber(DataDiv[,2:15]))

write.csv(DataDiv, file = "MyData4.csv")
