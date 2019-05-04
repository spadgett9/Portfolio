# LOAD STARGAZER PACKAGE

library(stargazer)
library(sandwich)
library(car)

# TELL R WHAT YOUR WORKING DIRECTORY IS 
# THIS WILL DEPEND ON YOUR LOCAL ENVIRONMENT

setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/Random")

# WRITE OUTPUT TO A LOG FILE

sink(file="401k.out",append=FALSE,split=TRUE)   

# IMPORT DATASET FROM .CSV FILE

four01k <- read.csv("401k.csv")

# COMPUTE SUMMARY STATISTICS FOR ALL VARIABLES IN DATASET 

stargazer(four01k, type="text")

# ESTIMATE REGRESSION OF PRATE ON MRATE AND DISPLAY RESULTS

prate_reg <- lm(prate ~ mrate, data=four01k)
summary(prate_reg)