#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# loading required packages
library("tidyverse")
library("ggplot2")

# parsing input parameters for convenience
INPUT_FILENAME = args[1]
OUTPUT_FILENAME = args[2]
PARK = as.character(args[3])

# reading data
dat <- read_csv(INPUT_FILENAME)

# variable names...
# dat <- 
#   dat |> 
#   group_by(most_common_color) |> 
#   summarize(
#     count = n()
#   ) |> 
#   ungroup() |> 
#   rename(
#     color = most_common_color
#   )

print(PARK)
dat <- filter(dat, Park.Name==PARK) 

print(dat)
  
  dat <-dat |>
  group_by(Primary.Fur.Color) |> 
  summarize(count = n() ) 


# make plot
myplot <-
  dat |> 
  ggplot(aes(x = Primary.Fur.Color, y = count)) + 
  geom_col(fill = "black") + 
  theme_minimal()
  

ggsave(OUTPUT_FILENAME, plot = myplot, width = 4, height = 4)

