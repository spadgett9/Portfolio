library(tidyverse)
library(janitor)
###########################

##### LOADING FILE

clean.table <- read_csv('http://richardtwatson.com/data/cleaning.csv')
clean.tibble <- read.csv('http://richardtwatson.com/data/cleaning.csv')

clean <- clean.table
##### CLEANING

summary(clean.table)

unique(clean$City)
unique(clean$State)
unique(clean$Zip)
unique(clean$Income)


df <- data.frame(clean)
df[,-1] <- as.character(gsub("KIRKWOOD", "Kirkwood", as.matrix(df[,-1])))




unique(df$City)
