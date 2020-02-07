##Updated Word Tester
##Ctrl F for “SF_2017_InitialTest” and replace with “Bay_Year” new file name
##Ctrl F for “SF 2012 Proofed Overlays” and replace with “Bay Year Overlays” new folder name


#Load the package
install.packages("magick")
library("magick", lib.loc="~/R/win-library/3.3")
#Set up the Overlays for this session
#these are the overlay files or watermarks
#make sure to change the path if not on Katy's computer

overlay1 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/1.png') 
overlay2 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/2.png')
overlay3 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/3.png')
overlay4 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/4.png')
overlay5 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/5.png')
overlay6 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/6.png')
overlay7 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/7.png')
overlay8 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/8.png')
overlay9 <- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/9.png')
overlay10<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/10.png')
overlay11<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/11.png')
overlay12<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/12.png')
overlay13<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/13.png')
overlay14<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/14.png')
overlay15<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/15.png')
overlay16<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/16.png')
overlay17<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/17.png')
overlay18<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/18.png')
overlay19<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/19.png')
overlay20<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/20.png')
overlay21<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/21.png')
overlay22<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/22.png')
overlay23<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/23.png')
overlay24<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/24.png')
overlay25<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/25.png')
overlay26<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/26.png')
overlay27<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/27.png')
overlay28<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/28.png')
overlay29<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/29.png')
overlay30<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/30.png')
overlay31<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/31.png')
overlay32<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/32.png')
overlay33<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/33.png')
overlay34<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/34.png')
overlay35<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/35.png')
overlay36<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/36.png')
overlay37<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/37.png')
overlay38<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/38.png')
overlay39<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/39.png')
overlay40<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/40.png')
overlay41<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/41.png')
overlay42<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/42.png')
overlay43<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/43.png')
overlay44<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/44.png')
overlay45<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/45.png')
overlay46<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/46.png')
overlay47<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/47.png')
overlay48<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/48.png')
overlay49<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/49.png')
overlay50<- image_read('C:/Users/newcomerk/Desktop/Photo Grid Test/Single Overlays/50.png')


##Create a loop that loads a .jpg file in a known folder as BG 
##make a list of the photo files by doing the following to the relevant folder

Photofiles<- list.files("C:/Users/newcomerk/Desktop/Photo Grid Test/SF 2014 Proofed/")


##then start the loop for every photo in the new list “Photofiles”
for(i in 1:length(Photofiles)){
  BG <- image_read(file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test','SF 2014 Proofed', paste(Photofiles[i]), sep=''))
  #and the background image gets flatted with each of these 50 overlays 
  ##to make 50 separate images with the same background file
  img1 <- c(BG, overlay1)
  z1 <- image_flatten(img1)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z1_', Photofiles[i], sep=''))
  image_write(z1, path = mypath, format = "jpg")
  
  img2 <- c(BG, overlay2)
  z2 <- image_flatten(img2)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z2_', Photofiles[i], sep=''))
  image_write(z2, path = mypath, format = "jpg")
  
  img3 <- c(BG, overlay3)
  z3 <- image_flatten(img3)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test','SF 2014 40 RSZ', paste('z3_', Photofiles[i], sep=''))
  image_write(z3, path = mypath, format = "jpg")
  
  img4 <- c(BG, overlay4)
  z4 <- image_flatten(img4)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test','SF 2014 40 RSZ', paste('z4_', Photofiles[i], sep=''))
  image_write(z4, path = mypath, format = "jpg")
  
  img5 <- c(BG, overlay5)
  z5 <- image_flatten(img5)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z5_', Photofiles[i], sep=''))
  image_write(z5, path = mypath, format = "jpg")
  
  img6 <- c(BG, overlay6)
  z6 <- image_flatten(img6)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z6_', Photofiles[i], sep=''))
  image_write(z6, path = mypath, format = "jpg")
  
  img7 <- c(BG, overlay7)
  z7 <- image_flatten(img7)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z7_', Photofiles[i], sep=''))
  image_write(z7, path = mypath, format = "jpg")
  
  img8 <- c(BG, overlay8)
  z8 <- image_flatten(img8)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z8_', Photofiles[i], sep=''))
  image_write(z8, path = mypath, format = "jpg")
  
  img9 <- c(BG, overlay9)
  z9 <- image_flatten(img9)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z9_', Photofiles[i], sep=''))
  image_write(z9, path = mypath, format = "jpg")
  
  img10 <- c(BG, overlay10)
  z10 <- image_flatten(img10)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z10_', Photofiles[i], sep=''))
  image_write(z10, path = mypath, format = "jpg")
  
  img11 <- c(BG, overlay11)
  z11 <- image_flatten(img11)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test', 'SF 2014 40 RSZ', paste('z11_', Photofiles[i], sep=''))
  image_write(z11, path = mypath, format = "jpg")
  
  img12 <- c(BG, overlay12)
  z12 <- image_flatten(img12)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z12_', Photofiles[i], sep=''))
  image_write(z12, path = mypath, format = "jpg")
  
  img13 <- c(BG, overlay13)
  z13 <- image_flatten(img13)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z13_', Photofiles[i], sep=''))
  image_write(z13, path = mypath, format = "jpg")
  
  img14 <- c(BG, overlay14)
  z14 <- image_flatten(img14)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z14_', Photofiles[i], sep=''))
  image_write(z14, path = mypath, format = "jpg")
  
  img15 <- c(BG, overlay15)
  z15 <- image_flatten(img15)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z15_', Photofiles[i], sep=''))
  image_write(z15, path = mypath, format = "jpg")
  
  img16 <- c(BG, overlay16)
  z16 <- image_flatten(img16)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z16_', Photofiles[i], sep=''))
  image_write(z16, path = mypath, format = "jpg")
  
  img17 <- c(BG, overlay17)
  z17 <- image_flatten(img17)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z17_', Photofiles[i], sep=''))
  image_write(z17, path = mypath, format = "jpg")
  
  img18 <- c(BG, overlay18)
  z18 <- image_flatten(img18)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z18_', Photofiles[i], sep=''))
  image_write(z18, path = mypath, format = "jpg")
  
  img19 <- c(BG, overlay19)
  z19 <- image_flatten(img19)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z19_', Photofiles[i], sep=''))
  image_write(z19, path = mypath, format = "jpg")
  
  img20 <- c(BG, overlay20)
  z20 <- image_flatten(img20)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z20_', Photofiles[i], sep=''))
  image_write(z20, path = mypath, format = "jpg")
  
  img21 <- c(BG, overlay21)
  z21 <- image_flatten(img21)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z21_', Photofiles[i], sep=''))
  image_write(z21, path = mypath, format = "jpg")
  
  img22 <- c(BG, overlay22)
  z22 <- image_flatten(img22)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z22_', Photofiles[i], sep=''))
  image_write(z22, path = mypath, format = "jpg")
  
  img23 <- c(BG, overlay23)
  z23 <- image_flatten(img23)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z23_', Photofiles[i], sep=''))
  image_write(z23, path = mypath, format = "jpg")
  
  img24 <- c(BG, overlay24)
  z24 <- image_flatten(img24)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z24_', Photofiles[i], sep=''))
  image_write(z24, path = mypath, format = "jpg")
  
  img25 <- c(BG, overlay25)
  z25 <- image_flatten(img25)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z25_', Photofiles[i], sep=''))
  image_write(z25, path = mypath, format = "jpg")
  
  img26 <- c(BG, overlay26)
  z26 <- image_flatten(img26)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z26_', Photofiles[i], sep=''))
  image_write(z26, path = mypath, format = "jpg")
  
  img27 <- c(BG, overlay27)
  z27 <- image_flatten(img27)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z27_', Photofiles[i], sep=''))
  image_write(z27, path = mypath, format = "jpg")
  
  img28 <- c(BG, overlay28)
  z28 <- image_flatten(img28)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z28_', Photofiles[i], sep=''))
  image_write(z28, path = mypath, format = "jpg")
  
  img29 <- c(BG, overlay29)
  z29 <- image_flatten(img29)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z29_', Photofiles[i], sep=''))
  image_write(z29, path = mypath, format = "jpg")
  
  img30 <- c(BG, overlay30)
  z30 <- image_flatten(img30)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z30_', Photofiles[i], sep=''))
  image_write(z30, path = mypath, format = "jpg")
  
  img31 <- c(BG, overlay31)
  z31 <- image_flatten(img31)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z31_', Photofiles[i], sep=''))
  image_write(z31, path = mypath, format = "jpg")
  
  img32 <- c(BG, overlay32)
  z32 <- image_flatten(img32)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z32_', Photofiles[i], sep=''))
  image_write(z32, path = mypath, format = "jpg")
  
  img33 <- c(BG, overlay33)
  z33 <- image_flatten(img33)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z33_', Photofiles[i], sep=''))
  image_write(z33, path = mypath, format = "jpg")
  
  img34 <- c(BG, overlay34)
  z34 <- image_flatten(img34)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z34_', Photofiles[i], sep=''))
  image_write(z34, path = mypath, format = "jpg")
  
  img35 <- c(BG, overlay35)
  z35 <- image_flatten(img35)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z35_', Photofiles[i], sep=''))
  image_write(z35, path = mypath, format = "jpg")
  
  img36 <- c(BG, overlay36)
  z36 <- image_flatten(img36)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z36_', Photofiles[i], sep=''))
  image_write(z36, path = mypath, format = "jpg")
  
  img37 <- c(BG, overlay37)
  z37 <- image_flatten(img37)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z37_', Photofiles[i], sep=''))
  image_write(z37, path = mypath, format = "jpg")
  
  img38 <- c(BG, overlay38)
  z38 <- image_flatten(img38)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z38_', Photofiles[i], sep=''))
  image_write(z38, path = mypath, format = "jpg")
  
  img39 <- c(BG, overlay39)
  z39 <- image_flatten(img39)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z39_', Photofiles[i], sep=''))
  image_write(z39, path = mypath, format = "jpg")
  
  img40 <- c(BG, overlay40)
  z40 <- image_flatten(img40)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z40_', Photofiles[i], sep=''))
  image_write(z40, path = mypath, format = "jpg")
  
  img41 <- c(BG, overlay41)
  z41 <- image_flatten(img41)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z41_', Photofiles[i], sep=''))
  image_write(z41, path = mypath, format = "jpg")
  
  img42 <- c(BG, overlay42)
  z42 <- image_flatten(img42)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z42_', Photofiles[i], sep=''))
  image_write(z42, path = mypath, format = "jpg")
  
  img43 <- c(BG, overlay43)
  z43 <- image_flatten(img43)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z43_', Photofiles[i], sep=''))
  image_write(z43, path = mypath, format = "jpg")
  
  img44 <- c(BG, overlay44)
  z44 <- image_flatten(img44)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z44_', Photofiles[i], sep=''))
  image_write(z44, path = mypath, format = "jpg")
  
  img45 <- c(BG, overlay45)
  z45 <- image_flatten(img45)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z45_', Photofiles[i], sep=''))
  image_write(z45, path = mypath, format = "jpg")
  
  img46 <- c(BG, overlay46)
  z46 <- image_flatten(img46)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z46_', Photofiles[i], sep=''))
  image_write(z46, path = mypath, format = "jpg")
  
  img47 <- c(BG, overlay47)
  z47 <- image_flatten(img47)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z47_', Photofiles[i], sep=''))
  image_write(z47, path = mypath, format = "jpg")
  
  img48 <- c(BG, overlay48)
  z48 <- image_flatten(img48)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z48_', Photofiles[i], sep=''))
  image_write(z48, path = mypath, format = "jpg")
  
  img49 <- c(BG, overlay49)
  z49 <- image_flatten(img49)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z49_', Photofiles[i], sep=''))
  image_write(z49, path = mypath, format = "jpg")
  
  img50 <- c(BG, overlay50)
  z50 <- image_flatten(img50)
  mypath = file.path('C:', 'Users', 'newcomerk', 'Desktop', 'Photo Grid Test',   'SF 2014 40 RSZ', paste('z50_', Photofiles[i], sep=''))
  image_write(z50, path = mypath, format = "jpg")
  
  ##then opens the next .jpg file in the folder and repeats this whole process
}
