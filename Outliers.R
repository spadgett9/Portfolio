######## LOADING LIBRARIES

Library(tidyverse)


######## LOADING FILE

cricket <- read.csv('http://richardtwatson.com/data/cricket.csv')

######## DETECTION

head(cricket)

sd(cricket$Average)
mean(cricket$Average)

x <- pnorm(99.94, mean = 52.1745, sd = 7.33111)

probability <- 1-x

probability

######### GRAPHICALLY

ggplot(cricket,aes(factor(0),Average)) +
  geom_boxplot(outlier.colour='red') + xlab("") + ylab("Average")

cricket$log <- log(cricket$Average)


ggplot(data = cricket) +
  geom_histogram( mapping = aes(x=log), fill='Light Blue')

ggplot(data = cricket) +
  geom_histogram( mapping = aes(x=Average), fill='Light Blue')


########## CONCLUSION

# As shown both graphically and logically Bradman is an outlier. In the boxplot test, he is shown as an outlier in red, and
# in the histograms, of both the Average column and the Log of the Average column, he is shown to be an outlier.
# accordiing to the pnorm test, he is shown to have a 3.623535e-11 percent probability of doing what he did.



