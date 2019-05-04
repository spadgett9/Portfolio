install.packages("twitteR")
library("twitteR")

api_key <- "dyyc4NDuSul0GrCjdjLvSZIwM" 
api_secret <- "cLjrzgimAj7gIYFyQFJrWzI0gnc9zeqA1IJ8tf4dKgQm13mCVq" #in the quotes, put your API secret token 
token <- "1058369753377619969-ZizVGJ4mBvUo2mKStiSlF9NEgeS2aH" #in the quotes, put your token 
token_secret <- "nLb9ESAbJeXU8WyRzF9TsILUxM3wzOOFvBeb87lGpxaTO" #in the quotes, put your token secret


tweets <- searchTwitter("Deep South Rivalry OR #UGA OR #BAMA OR #TheTide", n = 108, lang = "en")

Tidetweets.df <-twListToDF(tweets)

write.csv(Tidetweets.df, 'C:/Users/Scott Padgett/Documents/R Projects/TwitterExp/Tidetweets.csv') #an

#####   MAP CREATION   ####

install.packages("leaflet") 
install.packages("maps") 
library(leaflet) 
library(maps)

read.csv("C:/Users/Scott Padgett/Documents/R Projects/TwitterExp/Tidetweets.csv", stringsAsFactors = FALSE)  #stringAsFactors = FALSE means to keep the information as it is and not convert it into factors.


m <- leaflet() %>% 
  addTiles(Tidetweets.df,
           urlTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")

Tidetweets.df$latitude <- as.numeric(as.character(Tidetweets.df$latitude))
Tidetweets.df$longitude <- as.numeric(as.character(Tidetweets.df$longitude))

m %>% addCircles(data = Tidetweets.df, lng = ~longitude, lat = ~latitude)# , lng = ~longitude, lat = ~latitude, weight = 8, radius = 40, color = "#fb3004", stroke = TRUE, fillOpacity = 0.8)

m