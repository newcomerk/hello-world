# File Rename for Zipped archive
# could also just rename in the zip step below, but whatever

setwd("W:/Library/EF (Element File)/Ecology EF/Marine eelgrass meadow/ARCHIVE/2025")

listfiles<-list.files()

for(i in 1:length(listfiles)){
# Specify the current name of the zip file
old_zip_name <- listfiles[i]
  
short<- gsub("_0.zip", "", listfiles[i])

# Specify the new desired name for the zip file
new_zip_name <-  paste0("MarineEelgrassMeadow_" , short, "_superseded.zip")


# Rename the zip file
file.rename(from = old_zip_name, to = new_zip_name)
}

##################################################
#creating a zip archive

#make a list of just the unique numbers

setwd("C:/Users/kxlawson/OneDrive - New York State Office of Information Technology Services/Documents/KLawson/Project Files/Habitats and Communities/Marine Eelgrass Meadow/ARCHV Biotics Source Features")

ListNames<-list.files()
ListNames<- sub("\\..*$", "", ListNames)
ListNames<- unique(ListNames)

  for(i in 1:length(ListNames)){

filtered_files <- list.files(pattern = ListNames[i], # Matches files
                             full.names = FALSE) # Returns full paths

zip(zipfile = paste0(ListNames[i], ".zip"), files = filtered_files)

}


#
#https://medium.com/@mark.reuter/zip-files-directly-with-r-d425ee101b7f

library(zip)
library(rstudioapi)

#get the current working directory, where the script is saved
wd <- getSourceEditorContext()$path
dir <- dirname(wd)
print(dir)

#get test folder
child.dirs <- list.dirs(dir)
print(child.dirs)
test.dir <- child.dirs[2]
print(test.dir)

#list files in test dir
files.for.compression <- list.files(test.dir,
                                    full.names = FALSE)
print(files.for.compression)

#iterate through the files to get an idea of the number and size
for (i in 1:length(files.for.compression)){
  f.info <- file.info(
    paste0(
      test.dir,
      "/",
      files.for.compression[i])
  )
  print(files.for.compression[i])
  print(paste0(
    f.info$size/1000000,
    " mb"
  )
  )
}

#create zip archive
setwd(test.dir)
print(getwd())
#compression_level 1 to 9 (9 is slowest and most compressed)
#create a file name
f.name <- paste0(test.dir,"/archive_",Sys.Date(),".zip")
print(f.name)
start.zip <- Sys.time()
zip(f.name,
    files.for.compression,
    compression_level = 1)
end.zip <- Sys.time()
print(
  paste0("compression complete in ",
         end.zip - start.zip,
         " seconds")
)

#list archive
zipped.files <- list.files(test.dir,
                           pattern = ".zip")
print(zipped.files)

##use the native utils zip function
f.name2 <- paste0(test.dir,"/utils_archive_",Sys.Date(),".zip")
print(f.name2)
utils::zip(f.name2,
           files.for.compression)

### unzip
unzip.dir <- child.dirs[3]
print(unzip.dir)
##unzip using zip library
unzip(zipfile = zipped.files[1],
      exdir = unzip.dir)
##unzip using base utilities
utils::unzip(zipfile = zipped.files[1],
             exdir = unzip.dir)


