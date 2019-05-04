##### LOAD LIBRARIES
library(tidyverse)
library(stringr)
library(knitr)

##### READ CSV
setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/Random")
internetCo <- read.csv("InternetCompanies.csv")
head(internetCo)

##### REMOVE $
internetCo$MarketCap <- str_remove_all(internetCo$MarketCap, "\\$")
internetCo$Cash <- str_remove_all(internetCo$Cash, "\\$")
internetCo$Revenue <- str_remove_all(internetCo$Revenue, "\\$")

##### REPLACE '-' WITH NA
internetCo$MarketCap <- str_replace_all(internetCo$MarketCap, "-", "NA")
internetCo$Cash <- str_replace_all(internetCo$Cash, "-", "NA")
internetCo$Revenue <- str_replace_all(internetCo$Revenue, "-", "NA")

##### CONVERT TO INTEGER
internetCo$MarketCap <- as.numeric(internetCo$MarketCap)
internetCo$Cash <- as.numeric(internetCo$Cash)
internetCo$Revenue <- as.numeric(internetCo$Revenue)

##### COMPUTE CASH TO REV RATIO IN DESCEDING

internetCoFinal <- internetCo %>%
  select(Company, Country, MarketCap, Cash, Revenue) %>%
  mutate(CRRatio = Cash/Revenue,  CRRatio = round(CRRatio, 2)) %>%
  arrange(desc(CRRatio))

##### DISPLAY KABLE

kable(internetCoFinal)
  




  

