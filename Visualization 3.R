## library collection
library(dplyr)
library(ggplot2)
library(readxl)
library(googleVis)

## uploading the data 
url_battery <- read.csv("http://www.richardtwatson.com/data/LiOnBattery.csv")
  url_battery  

# cleaning up the name
colnames(url_battery)[colnames(url_battery) == "Projected.cost.of.Li.On.Battery.Storage....kW."] <- 'projectedBatteryKWH'

## checking types
glimpse(url_battery)
  url_battery$Year <- as.factor(url_battery$Year)
# part a  
## point graph creation
ggplot(data = url_battery, mapping = aes(x = Year , y = projectedBatteryKWH)) +
        geom_point()+
        theme_dark()+
        ggtitle("Projected Costs of Lithium Ion Batteries")


## part b 
chevybattery <- url_battery %>%
                            mutate(cost = projectedBatteryKWH*60)
ggplot(data = chevybattery, aes(x = Year, y = cost)) +
        geom_line(col = "blue") +
        theme_dark()+
        ggtitle("Projected Costs of Batteries|Chevy Bolt")
       
## part c
chevycar <- chevybattery %>%
            mutate(car_cost = cost+19500)
chevycar

  ggplot(data = chevycar, aes(x = Year, y = car_cost)) +
        geom_bar(stat = "identity", mapping = aes(y = car_cost), fill = "green") +
        theme_dark()+
        ggtitle("Projected Costs of Chevy Bolt")

## googleviz alternatives
  
## part a
url_battery$Year <- as.numeric(url_battery$Year)
url_battery$projectedBatteryKWH <- as.numeric(url_battery$projectedBatteryKWH)
  plot(gvisScatterChart(data = url_battery, options = list(title = "Projected Cost of LiOn Batteries",
                                                           vAxis ="{title:'Cost USD'}",
                                                           hAxis ="{title:'Year'}"
                                                           )))
  
## part b
plot(gvisLineChart(data = chevybattery, xvar = "Year", yvar = "cost", options = list(title = "Projected Cost of Batteries for Chevy Bolt",
                                                                                     vAxis ="{title:'Cost USD'}",
                                                                                     hAxis ="{title:'Year'}"
)))
chevybattery
## part c
plot(gvisBarChart(data = chevycar, xvar="Year", yvar="car_cost", options = list(title = "Projeted Costs for Chevy Bolts",
                                                                                 vAxis ="{title:'Cost USD'}",
                                                                                 hAxis ="{title:'Year'}")))

