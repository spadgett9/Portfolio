

library(dplyr)
library(lubridate)

# import Data

mydata <- read.csv("http://richardtwatson.com/data/electricityprices.csv")


newdata <- sample_n(mydata, 10)




# Create Date Column in correct format.

newdata$datetime <- ymd_hms(newdata$timestamp)

# Year

newdata$year <- year(newdata$datetime)

# Month

newdata$Month <- months(newdata$datetime)

# Day of Month

newdata$Day <- day(newdata$datetime)

# Weekday (name)

newdata$weekDay <- weekdays(newdata$datetime)

# weekday (Number)

newdata$weekDayNum <- wday(newdata$datetime)

# Hour

newdata$Hour <- hour(newdata$datetime)

# Leap Year?

newdata$Leap <- leap_year(newdata$datetime)


select(newdata, timestamp, year, Month, Day, weekDay, weekDayNum, Hour, Leap)

    