
library(stargazer)


setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/MSBA/Econometrics")


sink(file="discrim.out",append=FALSE,split=TRUE)   


discrimData <- read_CSv("discrim.csv")


stargazer(discrimData, type="text")


discrim_reg <- lm(log(psoda) ~ prpblck + lincome + prppov + lhseval, data=discrimData)
summary(discrim_reg)

bhat <- coef(discrim_reg)
x1 <- discrimData[22]
x2 <- discrimData[32]
x3 <- discrimData[23]
x4 <- discrimData[31]
y <-  discrimData[1]

t.test(x2, x3) #2sided default alternative
t.test(x2)
t.test(x3)
t.test(x4,  alternative = "two.sided")
t.test(x4)
      cor(x2,x3,use="complete.obs", method="kendall")

linearHypothesis(discrim_reg,c("lincome + prppov"),test="F")


sink()