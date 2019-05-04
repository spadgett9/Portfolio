## LIBRARIES

library(tidyverse)
library(arules)
library(readxl)
library(janitor)
library(arulesViz)
library(dplyr)
library(readr)

## READ DATA
  url_store <- read_csv("superstore.csv") %>%
  
## CLEAN DATA    
  clean_names(c = "lower_camel") %>%
  remove_empty()

head(url_store)

## Converting the data frame into a list of transactions suitable for analysis:
tx_data <- url_store
superstore <- tx_data %>%
  read.transactions(file = "superstore.csv",
                    sep=",",
                    format = 'single',
                    cols = c(2,17),
                    header= TRUE)
itemFrequencyPlot(superstore, topN = 5, xlab = "Popular Items", ylab = "Item Frequency by Support")

## Carrying out the Association Rules Analysis:
  rules <- apriori(
    superstore,
    parameter = list(supp = 0.0006, conf = 0.55)
  )

summary(rules)

options(digits = 2)
inspect(rules[1:4])

