# Libraries
library("tidyr")
library("dplyr")

# parsing input parameters for convenience
INPUT_FILENAME = args[1]
OUTPUT_FILENAME = args[2]

table <- read.csv(INPUT_FILENAME)

# filter squirrels
table0 <- table %>%
  drop_na(Squirrel.Latitude..DD.DDDDDD., Squirrel.Longitude...DD.DDDDDD.)

write.csv(table0, file = OUTPUT_FILENAME)
