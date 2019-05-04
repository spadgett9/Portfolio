library(stargazer)
library(sandwich)
library(AER)

setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/Random")

# WRITE SCRIPT OUTPUT TO A SEPARATE FILE

sink(file="card.ols.out",append=FALSE,split=TRUE)   

# IMPORT DATASET 

card <- read.csv("card.csv")






######## PROBLEM 3 ########



# variables: educ, exper, exper2, black, smsa, south, nearc4

#reduced form regression of exuc on other explanatory variables

RF_Reg <- lm(educ ~ nearc4 + exper + expersq + black + smsa + south, card)
summary(RF_Reg)

#regression of IQ on nearc4 to determine exogeniality

IQnearc4_Reg <- lm(iq ~ nearc4, card)
summary(IQnearc4_Reg)

#regression of IQ on nearc4 with region dummies included

IQnearc4Region_Reg <- lm(iq ~ nearc4 + smsa66 + reg662 + reg663 + reg664 + reg665 + reg666 + reg667 + reg668 + reg669, card)
summary(IQnearc4Region_Reg)



########## ANSWERS ###########

# 1: Nearness to college should be uncorrelated with other variables in the error term as nearness to college, although 
# related to education as shown by the reduced form regression of education on other explanatory variables, has no intuitive
# correlation with other variables not consitered.

# 2: With a p-value signifigant at the 1% level, we see, initially, that nearc4 may be highly related to IQ, and would 
# therefore may be exogenous in our structural equation. However, we may bee seeing that nearc4 is simply swalling the 
#varience created by those who live in afluent regions which should then be included as explanatory variables in the 
#structural equation.

#3: Although statistically signifigant, smsa66 is needed to control for those students near urban hubs. Since colleges are more
#likely to be centrally located near a city center, this avoids nearc4 to be correlated with this factor in the error 
#term. This is shown by the further loss of signifigance from this regression including smsa66 than without.







######## PROBLEM 5 #########




# stage 1 reduced form regression

stage1 <- lm(educ ~ nearc4 + exper + expersq + black + south + smsa +
        reg662 + reg662 + reg663 + reg664 + reg665 + reg666 + reg667 + reg668  + reg669 + smsa66
      , data=card)



# stage 2 reduced form regression

stage2 <- ivreg(lwage ~ educ + exper + expersq + black + south + smsa + reg662 + reg662 + reg663 + reg664 + 
reg665 + reg666 + reg667 + reg668  + reg669 + smsa66 + resid(stage1), data=card)
summary(stage2)

# stage 1 with nearc2

stage1_2c <- lm(educ ~ nearc4 + nearc2 + exper + expersq + black + south + smsa +
                      reg662 + reg662 + reg663 + reg664 + reg665 + reg666 + reg667 + reg668  + reg669 + smsa66
                    , data=card)



# Stage 2 with nearc2

stage2_2c <- ivreg(lwage ~ exper + expersq + black + south + smsa + reg662 + reg662 + reg663 + reg664 + 
                          reg665 + reg666 + reg667 + reg668  + reg669 + smsa66 + resid(stage1_2c), data=card)
summary(LM_educOnNear4)


# testing overidentifying

overID <- lm(resid(stage2_2c) ~ nearc4 + nearc2 + exper + expersq + black + south + smsa +
               reg662 + reg662 + reg663 + reg664 + reg665 + reg666 + reg667 + reg668  + reg669 + smsa66, data = card)
stargazer(overID, type="text", out="card.2sls1.txt")
variables <- c("nearc4", "nearc2")




####### ANSWERS #######

# 1)
#The coeficient on V2 is about -0.0570621  with a p-stat of 0.279973. Therefore the diferences to educ
# is large but is not signifigant

#2) 
# The estimate to education grew to .157. 

#3)
# with a P value in the linearHypothesisis test of .478, we do not reject the null.
                 
                 
                 
                 
setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/1) Econometrics")
rmarkdown::render("Problem set 9 HW.R", "pdf_document")


