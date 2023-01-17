#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# loading required packages
library("tidyverse")
library("ggplot2")

# parsing input parameters for convenience
INPUT_FILENAME = args[1]
OUTPUT_FILENAME = args[2]

# Loading data, now we are using tidy own data

table0 <- read_csv(INPUT_FILENAME)

table1 <- table0 %>% group_by(Park.Name) %>% summarize(num_squirrels = n(), most_common_color =names(which.max(table(table0$Primary.Fur.Color)))) 

write.csv(table1, OUTPUT_FILENAME)