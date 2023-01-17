#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# loading required packages
library("tidyverse")
library("ggplot2")

# parsing input parameters for convenience
INPUT_FILENAME = args[1]
OUTPUT_FILENAME = args[2]

# reading data
dat <- read_csv(INPUT_FILENAME)

# variable names...

# make plot
myplot <-
  dat |> 
  gggplot(aes(x = color, y = count)) + 
  geom_col(fill = "black") + 
  theme_minimal()
  

ggsave(OUTPUT_FILENAME, plot = myplot, width = 4, height = 4)

