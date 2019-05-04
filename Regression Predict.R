###### LIBRARIES

library(tidyverse)

###### READ FILE

data_man <- read.csv('http://www.richardtwatson.com/data/manheim.csv')

###### REGRESSION

## FIRST REGRESSION

reg.price <- lm(price ~ model + sale + miles, data = data_man)

plot(reg.price)
summary(reg.price)

## OUTLIER DETECTION

cook <- cooks.distance(reg.price)
print(cook)

data_man_clean <- data_man[-c(649)]

## CLEANED REGRESSION

reg.price.clean <- lm(price ~ model + sale + miles, data = data_man_clean)

summary(reg.price.clean)
