# Libraries
library("tidyr")
library("dplyr")

setwd("/Volumes/GoogleDrive/My Drive/Reproducible Data Science/BST270-Winter2023/squirrel-map-nf/testdata")
table <- read.csv("squirrel-data.csv")

# filter squirrels
table0 <- table %>%
  drop_na(Squirrel.Latitude..DD.DDDDDD., Squirrel.Longitude...DD.DDDDDD.)

write.csv(table0, file = './table0.csv')
