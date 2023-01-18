##################

# Group 4: Figure 2

## Reproducible Data Science 
## January 2023

##################


# Package Installation ####

list.of.packages <- c("dplyr", "ggplot2", "ggmap", "readr")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages)>0) install.packages(new.packages)

library(dplyr)
library(ggplot2)
library(ggmap)
library(readr)

# Description
  # Try to pinpoint where the squirrel's were on the map 
    # latitude/longitude plotting 

# Data Import ##### 

#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# parsing input parameters for convenience
INPUT_FILENAME = args[1]
OUTPUT_FILENAME = args[2]



## Generating Plot ##### 

squirrels_preproc <- read.csv(INPUT_FILENAME) %>% 
       filter(!is.na(Primary.Fur.Color) & Primary.Fur.Color!="")

min_long <- min(squirrels_preproc$Squirrel.Longitude...DD.DDDDDD., na.rm=T); max_long <- max(squirrels_preproc$Squirrel.Longitude...DD.DDDDDD., na.rm=T)
min_lat <- min(squirrels_preproc$Squirrel.Latitude..DD.DDDDDD., na.rm=T); max_lat <- max(squirrels_preproc$Squirrel.Latitude..DD.DDDDDD., na.rm=T)

coords <- c(left = min_long, right=min_long+0.1
            , bottom = min_lat, top = max_lat)

nyc_base <- ggmap::get_stamenmap(bbox = coords
                                 , zoom=13
                                 # , maptype = "terrain" # pretty but hard to see data 
                                 , maptype = "toner-lite"
                                 ) 

# currently plotting individual squirrels 
ggmap(nyc_base) + 
  geom_point(data=squirrels_preproc, aes(x=Squirrel.Longitude...DD.DDDDDD.
                                         , y =Squirrel.Latitude..DD.DDDDDD.
                                         , color = Primary.Fur.Color)
             , size=3, alpha=0.5) +
  ylab("Latitude") + xlab("Longitude") + 
  theme_minimal() +
  scale_color_manual(values=c("black", "red4", "lightblue"))

  
##### Saving output ### 

ggsave(OUTPUT_FILENAME, plot = myplot, width = 4, height = 4)
