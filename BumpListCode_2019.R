library(dplyr)
setwd("D:/Dropbox (Smithsonian)/R/FoulSurvey_Species_Cull")
#set working directory, save rules file and three levels of species list there

rules <- read.csv("TB.2018.Rules.csv")
#Stacey makes the above csv rules fule, rename as appropriate
names(rules) <- c("MorphoTaxa","IfTaxa","AlsoTaxa","UseThis")
#KN Note: the above list of names should correspond to the 3 or 4 column headers in your Rules csv file
#make sure to update these file names each time
baydata <- read.csv("TB.2018.BayLevel.csv")
blockdata <- read.csv("TB.2018.BlockLevel.csv")
platedata <- read.csv("TB.2018.PlateLevel.csv")

###BAY LEVEL
###this code makes a function to count the number of times there is a "lower" taxa 
###than the one you selected, according to the rules
##then it makes a loop that asks it to mark true(1) or false(0) that each species is the lowest possible ID
#GenusSpecies should be a column header in each of the 3 levels of species list files, if not fix
checkTaxon <- function(rules, data, iftaxon){
  alsotaxa <- rules %>% filter(AlsoTaxa == as.character(iftaxon)) %>% select(IfTaxa)
  data2 <- data %>% filter(GenusSpecies %in% alsotaxa$IfTaxa)
  return(nrow(data2))
}

##Do the above every time, and then choose from the two options below.
#This option only works if theres just 1 bay in the data

for (i in 1:nrow(baydata)){
  
  iftaxon <- baydata$GenusSpecies[i]
  a <- checkTaxon(rules, baydata, iftaxon)
  print(paste0(i,".) ", iftaxon , " - ", a))
  baydata$keep[i] <- ifelse(a==0, 1, 0)
  
}

write.csv(baydata, "TB.2018.BayLevel.PostBumpList.csv")
###Make this file name whatever you want

##bay sorted by year
#Doublecheck that "Yeardeployed" is a column header in the file
#this only works if there's 1 bay but with many years (ie CB 2012, CB 2014)
years <- unique(baydata$Yeardeployed)
yeardat3 <- baydata %>% filter(Yeardeployed == 1)

for (j in 1:length(years)){
  yeardat2 <- baydata %>% filter(Yeardeployed == years[j])
  for (i in 1:nrow(yeardat2)){
    iftaxon <- yeardat2$GenusSpecies[i]
    a <- checkTaxon(rules, yeardat2, iftaxon)
    print(paste0(i,".) ", iftaxon , " - ", a))
    yeardat2$keep[i] <- ifelse(a==0, 1, 0)
  }
  yeardat3 <- bind_rows(yeardat3, yeardat2)
}
write.csv(yeardat3, "WestAndPanama.Havards.YearBayLevel.PostBumpList.csv")

####This is another Bay sorter, only works if ALL bays in the file have unique Bay Codes
##Make sure you change the crazy bay name

bays <- unique(baydata$Havards_UniqueSpp_BayLevelMoreComplete.Bay)
baydat3 <- baydata %>% filter(Havards_UniqueSpp_BayLevelMoreComplete.Bay == 1)

for (j in 1:length(bays)){
  baydat2 <- baydata %>% filter(Havards_UniqueSpp_BayLevelMoreComplete.Bay == bays[j])
  for (i in 1:nrow(baydat2)){
    iftaxon <- baydat2$GenusSpecies[i]
    a <- checkTaxon(rules, baydat2, iftaxon)
    print(paste0(i,".) ", iftaxon , " - ", a))
    baydat2$keep[i] <- ifelse(a==0, 1, 0)
  }
  baydat3 <- bind_rows(baydat3, baydat2)
}
write.csv(baydat3, "WestAndPanama.Havards.BayLevel.PostBumpList.csv")

###Done with Bay Options


###BLOCK LEVEL
###this code does the same as above, but first sorts into each unique blocks. 
###Can do many Bays at a time with this code, as long as all blocks are unique
###Must run above checkTaxon function first for this code to run
#GenusSpecies should be a column header in each of the 3 levels of species list files, if not fix
#Block_ID should be a column header in this species list file, if not fix

blocks <- unique(blockdata$Block_ID)
blockdat3 <- blockdata %>% filter(Block_ID == 1)

for (j in 1:length(blocks)){
  blockdat2 <- blockdata %>% filter(Block_ID == blocks[j])
  for (i in 1:nrow(blockdat2)){
    iftaxon <- blockdat2$GenusSpecies[i]
    a <- checkTaxon(rules, blockdat2, iftaxon)
    print(paste0(i,".) ", iftaxon , " - ", a))
    blockdat2$keep[i] <- ifelse(a==0, 1, 0)
  }
  blockdat3 <- bind_rows(blockdat3, blockdat2)
}
write.csv(blockdat3, "TB.2018.BlockLevel.PostBumpList.csv")
###Make this file name whatever you want

###PLATE LEVEL
###this code does the same as above, but sorts into each unique plates. 
###Can do many Bays at a time with this code, as long as all plates are unique
###Must run above checkTaxon function first for this code to run
#GenusSpecies should be a column header in each of the 3 levels of species list files, if not fix
#Plate_ID should be a column header in this species list file, if not fix
#This one is tempramental and I'm not 100% sure why, don't change the spacing between Plate_ID==1
#Seems to Work with 12345A etc

plates <- unique(platedata$Plate_ID)
platedat3 <- platedata %>% filter(Plate_ID==1)

for (j in 1:length(plates)){
  platedat2 <- platedata %>% filter(Plate_ID == plates[j])
  for (i in 1:nrow(platedat2)){
    iftaxon <- platedat2$GenusSpecies[i]
    a <- checkTaxon(rules, platedat2, iftaxon)
    print(paste0(i,".) ", iftaxon , " - ", a))
    platedat2$keep[i] <- ifelse(a==0, 1, 0)
  }
  platedat3 <- bind_rows(platedat3, platedat2)
}
write.csv(platedat3, "TB.2018.PlateLevel.PostBumpList.csv")
###Make this file name whatever you want
#############################################################################################


###SOMETIMES Andy and Greg want Only Bay-level unique species per plate. 
##IF so, need to delete all instances of 0 keep species from the Bay list.
##easy to do this in excel by sorting. or this

##plate but filtered by bay
#this only works if there's 1 bay but with many plates
#runs the whole file


for (i in 1:nrow(platedata)){
  
  iftaxon <- platedata$GenusSpecies[i]
  a <- checkTaxon(rules, platedata, iftaxon)
  print(paste0(i,".) ", iftaxon , " - ", a))
  platedata$keep[i] <- ifelse(a==0, 1, 0)
  
}

write.csv(platedata, "TB.2018.PlatebyBayLevel.PostBumpList.csv")


#################################################################################




##block but filtered by bay
#this only works if there's 1 bay but with many blocks 

for (i in 1:nrow(blockdata)){
  
  iftaxon <- blockdata$GenusSpecies[i]
  a <- checkTaxon(rules, blockdata, iftaxon)
  print(paste0(i,".) ", iftaxon , " - ", a))
  blockdata$keep[i] <- ifelse(a==0, 1, 0)
  
}

write.csv(blockdata, "TB.2018.BlockbyBayLevel.PostBumpList.csv")

#################################################################
#########################
#################################################################

#Stacey doesn't want to include our preferred Species table headers, so here's a code to write one.
#this was based on Tampa 2018, and has the "worms" category but no mobiles. 
#Check that "FunctionalGroup1" "FunctionalGroup2" and "ModTaxa" are column headers, where Funct1 only really says
#####Polychaeta or is blank, if there are more categories need to check that code is still accurate.
#right now, all instances LEVEL_2 of the table = ModTaxa, keep checking that this makes sense.
#Level 1 could be any of those 3 headers
#change the Dataset name and file name as needed, but shouldn't need to edit
#this will make the pivot table easier, where LEVEL_1 is a Phylum, and LEVEL_2 is our preferred name

HeadersData <- read.csv("TB.2018.PlateLevel.csv")


for (i in 1:nrow(HeadersData)) {
  a <- ifelse(HeadersData$FunctionalGroup1[i]=="" ,TRUE, FALSE)
HeadersData$LEVEL_1[i] <- ifelse(HeadersData$FunctionalGroup2[i]=="worms"& 
                                    a==FALSE,
            as.character(HeadersData$FunctionalGroup1[i]), ifelse(HeadersData$FunctionalGroup2[i] =="worms" & a ==TRUE, 
                                                  as.character(HeadersData$ModTaxa[i]), 
                                                  ifelse(HeadersData$ModTaxa[i] =="Foraminifera",
                                                  as.character(HeadersData$ModTaxa[i]),       
                                                  as.character(HeadersData$FunctionalGroup2[i])   )  )        )
}


for (i in 1:nrow(HeadersData)) {
  a <- ifelse(HeadersData$FunctionalGroup1[i]=="" ,TRUE, FALSE)
  HeadersData$LEVEL_2[i] <- ifelse(HeadersData$FunctionalGroup2[i]=="worms"& 
                                      a==FALSE,
                                    as.character(HeadersData$ModTaxa[i]), 
                                    ifelse(HeadersData$FunctionalGroup2[i] =="worms" & a ==TRUE, 
                                                              as.character(HeadersData$ModTaxa[i]), 
                                                    as.character(HeadersData$ModTaxa[i])   )                        )
}

write.csv(HeadersData, "TB.2018.SpeciesTableData.csv")



#Based on this logic
#IF $FunctionalGroup2 == "worms", and $FunctionalGroup1 is not blank, $LEVEL_1 == $FuntionalGroup1 
#& $LEVEL_2 == $ModTaxa
#
#IF $FunctionalGroup2 == "worms", and $FunctionalGroup1 is blank, $LEVEL_1 == $ModTaxa
#& $LEVEL_2 == $ModTaxa
#
#IF $FunctionalGroup2 does not equal "worms", $LEVEL_1 == $FunctionalGroup2, $LEVEL_2 == $ModTaxa

