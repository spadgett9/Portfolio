library(tibble)
library(tidyverse)
library(gdata)


#loading table
setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/Random")
table <- read.csv("Tibble Data.csv")


#convert to Tibble
tibble <- as.tibble(table)

colnames(tibble) <- c('Year', 1:12)

g.tibble <- gather(tibble, key = Month, Value = 2:13)

g.tibble

write_csv(g.tibble, "tibble.csv")


