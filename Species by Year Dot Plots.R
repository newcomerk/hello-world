# Tue 20171031 1724 hrs This script needs to be updated to use new data from Stacey and Brian

# This script produces exploratory plots of species x year present (across all of SF Bay)

# Requires running lines 1-153 of "SF Bay Temporal Comparison Data Processing.R"

setwd("~/Dropbox (Smithsonian)/SERC Two The Return/CDFW/Meetings/20171003 CDFW Meeting - Fairfield")


Data_sub <- DataAll.marine[DataAll.marine$YearDeployed %in% 2012:2016, ]

p <- ggplot(data = Data_sub, aes(y = Species, x = YearDeployed))
p + geom_point()

ggsave("Marine Species by Year 2012-2016.pdf", height = 20, width = 5)


Data_sub_int <- DataAll.marine[DataAll.marine$YearDeployed %in% 2012:2016 & DataAll.marine$int == 1, ]

p <- ggplot(data = Data_sub_int, aes(y = Species, x = YearDeployed))
p + geom_point()

ggsave("Marine NIS by Year 2012-2016.pdf", height = 20, width = 5)