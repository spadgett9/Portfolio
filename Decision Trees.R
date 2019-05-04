## LIBRARIES
library(tidyverse)
library(dplyr)
library(janitor)
library(readxl)
library(rpart)
library(rpart.plot)
library(caTools)

## LOADING DATA
url_manheim <- read.csv("http://www.richardtwatson.com/data/manheim.csv") %>%
  clean_names() %>%
  remove_empty()
glimpse(url_manheim)


## SORTING INDEX
manheim_tree <- url_manheim 
tree_sorting <- sample(1:nrow(manheim_tree))
manheim_tree <- manheim_tree[tree_sorting,]
head(manheim_tree)

## SUBSETTING
sample <- sample.split(manheim_tree, SplitRatio = 0.8)
train <- subset(manheim_tree, sample == TRUE)
test <- subset(manheim_tree, sample == FALSE)
glimpse(train)

glimpse(test)

## Building the continuous decision tree and visualizing it:
  manheim_train <- rpart(price ~ ., data = train,
                         method = "anova")
rpart.plot(manheim_train, type = 4)

## Testing our model on our shuffled test data and plotting our model-based results against the actual test data:
  manheim_predict <- predict(manheim_train, test)
glimpse(manheim_predict)

plot(test$price, manheim_predict, xlab = "Actual Prices", ylab = "Predicted Prices")
abline(a = 0, b= 1)

prune_manheim<- prune(manheim_train, cp= manheim_train$cptable[which.min(manheim_train$cptable[,
                                                                                                 "xerror"]),"CP"])
