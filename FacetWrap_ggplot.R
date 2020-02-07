#This was a big xy plot of many panels
Simkanin<-read.csv(file.choose(),header=T)

scat1 <- ggplot(data=Simkanin, aes(x=Lat, y=ProbabilityScore)) + geom_point()
# Add horizontal line at y = 0.05
scat1 + geom_hline(yintercept=0.05)
scat1 + labs(x = "Latitude")
scat1 + labs(y = "Probability Score")
p + labs(title = '')

##or

scat1 <- ggplot(data=Simkanin, aes(x=Latitude, y='Probability Score'))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(State ~ Taxon)
scat1

scat <- ggplot(data=Simkanin, aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ 
  facet_wrap( ~ Taxon) + 
  theme(strip.text = element_text(size = 8), axis.title = element_text(size = 8), 
        axis.text = element_text(size = 8)) + labs(y = "Probability Score") + panel_border()
scat


##or
background_grid(major = 'y', minor = "none") + # add thin horizontal lines 
  panel_border() # and a border around each panel


scatAmph <- ggplot(data=subset(Simkanin, Order == 'Amphipoda'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()
scatAmph


scatAntho <- ggplot(data=subset(Simkanin, Order == 'Anthozoa'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()
scatAntho

scatAst <- ggplot(data=subset(Simkanin, Order == 'Asteroidea'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()
+ theme(strip.text.x = element_text(size = 8)
scatAst

scatBiv <- ggplot(data=subset(Simkanin, Order == 'Bivalvia'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()
scatBiv

scatChe <- ggplot(data=subset(Simkanin, Order == 'Cheilostomatida'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()
scatChe

scatCirr <- ggplot(data=subset(Simkanin, Order == 'Cirripedia'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatDec <- ggplot(data=subset(Simkanin, Order == 'Decapoda'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatFlor <- ggplot(data=subset(Simkanin, Order == 'Florideophyceae'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatGast <- ggplot(data=subset(Simkanin, Order == 'Gastropoda'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatHyd <- ggplot(data=subset(Simkanin, Order == 'Hydrozoa'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatIso <- ggplot(data=subset(Simkanin, Order == 'Isopoda'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatPhae <- ggplot(data=subset(Simkanin, Order == 'Phaeophyceae'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatPhas <- ggplot(data=subset(Simkanin, Order == 'Phascolosomatidae'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

scatSerp <- ggplot(data=subset(Simkanin, Order == 'Serpulidae'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()

ScatTuni <- ggplot(data=subset(Simkanin, Order == 'Tunicata'), aes(x=Latitude, y=prediction))  + 
  geom_point() +  geom_hline(yintercept=0.05)+ facet_grid(. ~ Taxon)+ labs(y = "Probability Score") + panel_border()



plot_grid(scatAmph, scatAntho, scatAst, scatBiv, scatChe, scatCirr, scatDec, scatFlor, scatGast, 
          scatHyd, scatIso, scatPhae, scatPhas, scatSerp, ScatTuni, labels = c("Amphipoda", "Anthozoa", "Asteroidea", 
          "Bivalvia","Cheilostomatida", "Cirripedia", "Decapoda", "Florideophyceae", "Gastropoda", "Hydrozoa", "Isopoda",
          "Phaeophyceae", "Phascolosomatidae", "Serpulidae", "Tunicata"),  
          align = 'v')

plot_grid(scatAmph, scatAntho, scatAst, labels = c("Amphipoda", "Anthozoa", "Asteroidea"),  
          align = 'v')


+ theme(strip.text.x = element_text(size=8)
