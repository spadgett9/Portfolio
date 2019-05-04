library(stargazer)
library(sandwich)
library(car)



setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/Random")


sink(file="injury.out",append=FALSE,split=TRUE)  

# Kentucky data

injury_ky <- read.csv("injury_ky.csv")

stargazer(injury_ky, type="text")

injury_ky_lm <- lm(ldurat ~ afchnge + highearn + afchnge*highearn, data = injury_ky)

summary(injury_ky_lm)

injury__ky_lm_explan <- lm(ldurat ~ afchnge + highearn + afchnge*highearn + ky + male + married + indust + injtype + head + neck + upextr + trunk + lowback + lowextr + occdis, data = injury)

summary(injury_lm_explan) 

# Micigain data

injury_mi <- read.csv("injury_mi.csv")

stargazer(injury_mi, type="text")

injury_mi_lm <- lm(ldurat ~ afchnge + highearn + afchnge*highearn, data = injury_mi)
summary(injury_mi_lm)

# test data Mi = 1 on dummy

injury <- read.csv("injury.csv")

injury_lm <- lm(ldurat ~ afchnge + highearn + mi + afchnge*highearn*mi, data = injury)

summary(injury_lm)


#i)
#BEFORE VARIABLES ADDED
#afchnge:highearn  =  0.18382
#P-Value: 0.00271
#AFTER VARIABLES ADDED
#afchnge:highearn  =  0.2197
#p-value: 0.001392

#we see the effect of the coefficient of afchnge:highearn increases slightly and becomes much more signifigant by nearly
#cutting the p-value by one third

#ii)
#this does not particularly mean the equation is useless. It just means we have not extracted enough variables form the 
#unexplained which correlate with our other independent variables, therefore explaning more varience of the Y

#iii)
# The beta coefficient effect is similar however the statistical signifigance is far lower due to a higher p-value. We see that, all else being
#controlled for, the afchange is less effective in Miciagan.
