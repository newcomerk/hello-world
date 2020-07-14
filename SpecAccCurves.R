June 2017

SpecAc16<-read.csv(file.choose(),header=T)
sp16 <- specaccum(SpecAc16)
spr16 <- specaccum(SpecAc16, "random")
plot(spr16, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
boxplot(spr16, col="yellow", add=TRUE, pch="+")


spF16 <- specaccum(SpecAcF16)
sprF16 <- specaccum(SpecAcF16, "random")
plot(sprF16, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
boxplot(sprF16, col="yellow", add=TRUE, pch="+")

#######points per plate

SpecAcP16<-read.csv(file.choose(),header=T)
spP16 <- specaccum(SpecAcP16)
sprP16 <- specaccum(SpecAcP16, "random")
plot(sprP16, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
boxplot(sprP16, col="yellow", add=TRUE, pch="+")


PL18289<-read.csv(file.choose(),header=T)
spr18289 <- specaccum(PL18289, "random")
plot(spr18289, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
PL17964<-read.csv(file.choose(),header=T)
spr17964 <- specaccum(PL17964, "random")
plot(spr17964, ci.type="poly", col="red", lwd=2, ci.lty=0, ci.col="pink", add=TRUE)

PL18289<-read.csv(file.choose(),header=T)
spr18289 <- specaccum(PL18289, "random")
PL17964<-read.csv(file.choose(),header=T)
spr17964 <- specaccum(PL17964, "random")
PL17787<-read.csv(file.choose(),header=T)
spr17787 <- specaccum(PL17787, "random")
PL17183<-read.csv(file.choose(),header=T)
spr17183 <- specaccum(PL17183, "random")
PL17144<-read.csv(file.choose(),header=T)
spr17144 <- specaccum(PL17144, "random")

PLF17964<-read.csv(file.choose(),header=T)
sprF17964 <- specaccum(PLF17964, "random")
PLF17787<-read.csv(file.choose(),header=T)
sprF17787 <- specaccum(PLF17787, "random")
PLF17183<-read.csv(file.choose(),header=T)
sprF17183 <- specaccum(PLF17183, "random")


##with backgrounds
plot(spr18289, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Points", ylab="Richness")
plot(spr17964, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)
plot(spr17787, ci.type="poly", col="darkgreen", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=1.0, blue=0.2, alpha=0.2), add=TRUE)


legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue", "darkgreen"), 
  legend = c("18289", "17964", "17787")
)



##without backgrounds

plot(spr17964, ci=0, col="red",  xlab="Points", ylab="Richness")
plot(spr18289, ci=0, col="blue", add=TRUE)
plot(spr17787, ci=0, col="darkgreen", add=TRUE)
plot(spr17183, ci=0, col="orange", add=TRUE)
plot(spr17144, ci=0, col="purple", add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue", "darkgreen","orange","purple"), 
  legend = c("17964", "18289", "17787","17183", "17144")
)



  col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2))

###morphotaxa points

M15818<-read.csv(file.choose(),header=T)
M15818sp <- specaccum(M15818, "random")
M15561<-read.csv(file.choose(),header=T)
M15561sp <- specaccum(M15561, "random")
M16235<-read.csv(file.choose(),header=T)
M16235sp <- specaccum(M16235, "random")
M16124<-read.csv(file.choose(),header=T)
M16124sp <- specaccum(M16124, "random")
M17129<-read.csv(file.choose(),header=T)
M17129sp <- specaccum(M17129, "random")

plot(M15818sp, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink", xlab="Points", ylab="Richness", ylim=c(0,6))
plot(M15561sp, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)
plot(M16235sp, ci.type="poly", col="darkgreen", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=1.0, blue=0.2, alpha=0.2), add=TRUE)
plot(M16124sp, ci.type="poly", col="darkorange", lwd=2, 
     ci.lty=0, ci.col=rgb(red=255, green=140, blue=0, 
                          alpha=100, maxColorValue = 255), add=TRUE)
plot(M17129sp, ci.type="poly", col="deeppink4", lwd=2, 
     ci.lty=0, ci.col=rgb(red=139, green=10, blue=80, 
                          alpha=100, maxColorValue = 255), add=TRUE)


col2rgb("deeppink4", alpha = FALSE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue", "darkgreen"), 
  legend = c("18289", "17964", "17787")
)




####yearly comparisons
##2012
field.2012<-read.csv(file.choose(),header=T)
fieldac.2012 <- specaccum(field.2012, "random")
photo.2012<-read.csv(file.choose(),header=T)
photoac.2012 <- specaccum(photo.2012, "random")
plot(fieldac.2012, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Plates", ylab="Richness")
plot(photoac.2012, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue"), 
  legend = c("Field", "Photo")
)
##2013
field.2013<-read.csv(file.choose(),header=T)
fieldac.2013 <- specaccum(field.2013, "random")
photo.2013<-read.csv(file.choose(),header=T)
photoac.2013 <- specaccum(photo.2013, "random")
plot(fieldac.2013, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Plates", ylab="Richness")
plot(photoac.2013, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue"), 
  legend = c("Field", "Photo")
)

##2014
field.2014<-read.csv(file.choose(),header=T)
fieldac.2014 <- specaccum(field.2014, "random")
photo.2014<-read.csv(file.choose(),header=T)
photoac.2014 <- specaccum(photo.2014, "random")
plot(fieldac.2014, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Plates", ylab="Richness")
plot(photoac.2014, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue"), 
  legend = c("Field", "Photo")
)

##2015
field.2015<-read.csv(file.choose(),header=T)
fieldac.2015 <- specaccum(field.2015, "random")
photo.2015<-read.csv(file.choose(),header=T)
photoac.2015 <- specaccum(photo.2015, "random")
plot(fieldac.2015, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Plates", ylab="Richness")
plot(photoac.2015, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue"), 
  legend = c("Field", "Photo")
)

##2016
field.2016<-read.csv(file.choose(),header=T)
fieldac.2016 <- specaccum(field.2016, "random")
photo.2016<-read.csv(file.choose(),header=T)
photoac.2016 <- specaccum(photo.2016, "random")
plot(fieldac.2016, ci.type="poly", col="red", lwd=2, 
     ci.lty=0, ci.col="pink",  xlab="Plates", ylab="Richness")
plot(photoac.2016, ci.type="poly", col="blue", lwd=2, 
     ci.lty=0, ci.col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.2), add=TRUE)

legend(
  "bottomright", 
  lty=c(1,1), 
  col=c("red", "blue"), 
  legend = c("Field", "Photo")
)

###estimate richness specpool()
###use jack2