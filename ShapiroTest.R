#Shapirowilktest

Diffdata<-read.csv(file.choose(),header=T)
shapiro.test(Diffdata$diff_TC_T)
ks.test(Diffdata$diff_TC)
shapiro.test(Diffdata$diff_TC_T)
hist(Diffdata$diff_TC)
ggqqplot(Diffdata$diff_PF)
ggqqplot(Diffdata$diff_PF_T)
hist(Diffdata$diff_PF_T)


##bootstrap confidence intervals
library(boot) 
Abundance<-read.csv(file.choose(),header=T)

# function to obtain the mean
Bmean <- function(data, indices) {
  d <- data[indices] # allows boot to select sample 
  return(mean(d))
} 

# bootstrapping with 1000 replications 
resultsBRB <- boot(data=Abundance$diff_BRB, statistic=Bmean, R=1000)

# view results
results 
plot(results)

# get 95% confidence interval 
boot.ci(resultsBRB, type=c("norm", "basic", "perc", "bca"))

# bootstrapping with 1000 replications 
resultsPF <- boot(data=Abundance$diff_PF, statistic=Bmean, R=1000)
resultsPF
plot(resultsPF)
boot.ci(resultsPF, type=c("norm", "basic", "perc", "bca"))

resultsTS <- boot(data=Abundance$diff_TS, statistic=Bmean, R=1000)
resultsTS
plot(resultsTS)
boot.ci(resultsTS, type=c("norm", "basic", "perc", "bca"))

resultsCR <- boot(data=Abundance$diff_CR, statistic=Bmean, R=1000)
resultsCR
plot(resultsCR)
boot.ci(resultsCR, type=c("norm", "basic", "perc", "bca"))

resultsBRC <- boot(data=Abundance$diff_BRC, statistic=Bmean, R=1000)
resultsBRC
plot(resultsBRC)
boot.ci(resultsBRC, type=c("norm", "basic", "perc", "bca"))

resultsBRS <- boot(data=Abundance$diff_BRS, statistic=Bmean, R=1000)
resultsBRS
plot(resultsBRS)
boot.ci(resultsBRS, type=c("norm", "basic", "perc", "bca"))

resultsBV <- boot(data=Abundance$diff_BV, statistic=Bmean, R=1000)
resultsBV
plot(resultsBV)
boot.ci(resultsBV, type=c("norm", "basic", "perc", "bca"))

resultsCN <- boot(data=Abundance$diff_CN, statistic=Bmean, R=1000)
resultsCN
plot(resultsCN)
boot.ci(resultsCN, type=c("norm", "basic", "perc", "bca"))

resultsHY <- boot(data=Abundance$diff_HY, statistic=Bmean, R=1000)
resultsHY
plot(resultsHY)
boot.ci(resultsHY, type=c("norm", "basic", "perc", "bca"))

resultsWM <- boot(data=Abundance$diff_WM, statistic=Bmean, R=1000)
resultsWM
plot(resultsWM)
boot.ci(resultsWM, type=c("norm", "basic", "perc", "bca"))

resultsBRB <- boot(data=Abundance$diff_BRB, statistic=Bmean, R=1000)
resultsBRB
plot(resultsBRB)
boot.ci(resultsBRB, type=c("norm", "basic", "perc", "bca"))

Morphotaxa<-read.csv(file.choose(),header=T)
resultsMR <- boot(data=Morphotaxa$Diff_MR, statistic=Bmean, R=1000)
resultsMR
plot(resultsMR)
boot.ci(resultsMR, type=c("norm", "basic", "perc", "bca"))
######################################################
# bootstrapping with 1000 replications WITHIN Richness
WMR<-read.csv(file.choose(),header=T)
#WMR = Within Morphotaxa Richness
resultsPF <- boot(data=WMR$diff_PF, statistic=Bmean, R=1000)
resultsPF
plot(resultsPF)
boot.ci(resultsPF, type=c("norm", "basic", "perc", "bca"))

resultsTS <- boot(data=WMR$diff_TS, statistic=Bmean, R=1000)
resultsTS
plot(resultsTS)
boot.ci(resultsTS, type=c("norm", "basic", "perc", "bca"))

resultsCR <- boot(data=WMR$diff_CR, statistic=Bmean, R=1000)
resultsCR
plot(resultsCR)
boot.ci(resultsCR, type=c("norm", "basic", "perc", "bca"))

resultsBRC <- boot(data=WMR$diff_BRC, statistic=Bmean, R=1000)
resultsBRC
plot(resultsBRC)
boot.ci(resultsBRC, type=c("norm", "basic", "perc", "bca"))

resultsBRS <- boot(data=WMR$diff_BRS, statistic=Bmean, R=1000)
resultsBRS
plot(resultsBRS)
boot.ci(resultsBRS, type=c("norm", "basic", "perc", "bca"))

resultsBV <- boot(data=WMR$diff_BV, statistic=Bmean, R=1000)
resultsBV
plot(resultsBV)
boot.ci(resultsBV, type=c("norm", "basic", "perc", "bca"))

resultsCN <- boot(data=WMR$diff_CN, statistic=Bmean, R=1000)
resultsCN
plot(resultsCN)
boot.ci(resultsCN, type=c("norm", "basic", "perc", "bca"))

resultsHY <- boot(data=WMR$diff_HY, statistic=Bmean, R=1000)
resultsHY
plot(resultsHY)
boot.ci(resultsHY, type=c("norm", "basic", "perc", "bca"))

resultsWM <- boot(data=WMR$diff_WM, statistic=Bmean, R=1000)
resultsWM
plot(resultsWM)
boot.ci(resultsWM, type=c("norm", "basic", "perc", "bca"))

resultsBRB <- boot(data=WMR$diff_BRB, statistic=Bmean, R=1000)
resultsBRB
plot(resultsBRB)
boot.ci(resultsBRB, type=c("norm", "basic", "perc", "bca"))

resultsTC <- boot(data=WMR$diff_TC, statistic=Bmean, R=1000)
resultsTC
plot(resultsTC)
boot.ci(resultsTC, type=c("norm", "basic", "perc", "bca"))
