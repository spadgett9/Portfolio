######### LIBRARIES

library(tidyverse)
library(tidyverse)
library(stringr)
library(ggmap)
library(mapproj)
library(googleVis)


######### READ IN FILE
internetCo <- read.csv("http://richardtwatson.com/data/InternetCompanies.csv")


######## CLEANING FILE

#remove $; MarketCap, Cash, Rev

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


####### GRAPHICAL REPRESENTATION

coArrange <- arrange(internetCo,desc(Revenue))
top5 <- head(coArrange, n=5)
top5$Company <- as.character(top5$Company)
ggplot(top5, aes(MarketCap, Revenue)) +
  geom_point() +
  geom_label(aes(label = Company), vjust = "inward", hjust = "inward)"


####### CREATING GOOGLE MAP

chart <- gvisBubbleChart(top5, idvar = "Company", xvar = "MarketCap", yvar = "Revenue", sizevar = "Cash")
plot(chart)
