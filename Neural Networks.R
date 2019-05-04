##### LIBRARIES
library(dplyr)
library(readr)
library(neuralnet)
library(ggplot2)
library(Metrics) 

##### DATA

man_dat <- read.csv("manheim.csv")

##### REGRESSION
attach(man_dat)
price_lm <- lm(price ~ sale + miles + model)
summary(price_lm)
predict_lm <- round(predict.lm(price_lm))
mse_lm <- rmse(price, predict_lm)

##### RECODING
man_dat$saleCode <- case_when(
  man_dat$sale == 'Auction' ~1,
  man_dat$sale == 'Online' ~2
)
man_dat$modelCode <- case_when(
  man_dat$model == 'X' ~1,
  man_dat$model == 'Y' ~2,
  man_dat$model == 'Z' ~3
)
man_dat$sale <- NULL
man_dat$model <- NULL

##### NORMALIZATION

# Normalize data
maxs <- apply(man_dat, 2, max)
mins <- apply(man_dat, 2, min)
n <- as.data.frame(scale(man_dat, center = mins, scale = maxs - mins))

# Build neural net
set.seed(2)
net <- neuralnet(price ~ miles +
                   saleCode + modelCode, data = n, hidden
                 = 3, linear.output = T)
plot(net)

# Prediction
pr.net <- compute(net, n[,2:4])

# rescale
predict.net <- pr.net$net.result*(max(man_dat$price)-min(man_dat$price))+min(man_dat$price)
MSE.net <- rmse(man_dat$price, predict.net)

# Compare the two models' mean square error

paste('MSEs for linear regression and neural net ',round(mse_lm,0),round(MSE.net,0))
paste('Percent difference ', round(((MSE.net - mse_lm)/mse_lm*100),2))

# Graph Findings

man_dat <- man_dat %>% mutate(diff = predict_lm - predict.net)
ggplot(man_dat, aes(x=price)) +
  geom_point(aes(y=diff, color='Prediction difference')) +
  geom_point(aes(y=predict_lm, color='Linear model')) +
  geom_point(aes(y=predict.net,color='Neural net')) +
  geom_abline(intercept = 0, slope = 1) +
  xlab('Actual price') +
  ylab('Predicted price')


# the neural network appears to have performed better due to the lower mean squared error and 
# from the fact that the neural network followed closer to the mean in the plot of the two.



