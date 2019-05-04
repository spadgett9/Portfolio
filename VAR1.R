library(readxl)
library(tseries)
library(vars)
library(forecast)
library(astsa)


#loading data

data1 = read_excel("INDPRO.xls")
ip = ts(data=data1$INDPRO, frequency=12, start=c(1919,1), end=c(2018,12))
data2 = read_excel(skip = 10, "UNRATE.xls")
unrate = ts(data=data2$UNRATE, frequency = 12, start=c(1948,1), end=c(2018,12))

# Calculating rate of growth (% change) 
lnip = log(ip)
dlnip = diff(lnip)
dunrate = diff(unrate)   # this is the growth rate

# creating sample 
start1 = start = c(1970,1); end1 = end = c(2018,12)
regvars = ts.union(lnip,unrate)
regvars1 = window(regvars, start = start1, end = end1)

# checking trend as is
plot(regvars1)

# Run VARselect to specify model, then run VAR() to estimate
# 'both' includes constant and trend in each equation
# AIC - measuring cot of too many and too few lags, we thing you should have 7 lags
# HQ - 
#SC - 
#FPE - 

VARselect(regvars1, type="both")

# 6 lags, 48 steps for impulse response
plag = 8; ksteps = 48  


# runs the VAR model for Y1 (first row)
VAR1 = VAR(regvars1, p = plag, type = c("both")) 

# Big messy table gives coefficient estimates for all vars and lags
summary(VAR1);

# tests for serial correlation. There is serial correlation even we used many lags
# null  = no seral correlation
serial.test(VAR1);

# seems the residuals are, for the most part, WN. Just some spikes
acf(residuals(VAR1))
plot.ts(residuals(VAR1))

# Granger-causality tests: these are joint tests to test signifigance of joint variables
# this is a test that the lagged industrial prod has no effect on unemployment [H0 = C21 = 0 for all lags of C21]
# H0 industrial prod does not granger cause unemployment
# we reject null that lnip does not cause unemp (with super small p-val)
causality(VAR1, cause = "lnip")

# H0 = C12 = 0 accross all lags of C12 ( the uneployment has no effect of industrial production)
causality(VAR1, cause = "unrate")

# Impulse response functions and forecast error variance decomposition
  irf1 = irf(VAR1, n.ahead = ksteps)
  print(irf1); plot(irf1)
  forecast(VAR1)
  fcvar1 = forecast(VAR1)
  plot(fcvar1)
  fevd1 = fevd(VAR1, n.ahead = ksteps)
  plot(fevd1)

# switch ordering -- doesn't affect forecasts, only IRFs
regvars_switch = ts.union(unrate,lnip)
regvars2 = window(regvars_switch, start = start1, end = end1)

# estimate model for Y2 (2nd row)
VAR2 = VAR(regvars2, p = plag, type = c("both"))
summary(VAR2)
irf2 = irf(VAR2, n.ahead = ksteps)
plot(irf2); print(irf2)

# Estimate the model in first differences to ensure stationarity
# Doing so is a mis-specification if the variables are 'cointegrated'
dregvars = ts.union(dlnip,dunrate)
dregvars1 = window(dregvars, start = start1, end = end1)
VARselect(dregvars1, type="both") # 'both' includes constant and trend in each equation
VAR3 = VAR(dregvars1, p = plag, type = c("const")) 
summary(VAR3); serial.test(VAR3); acf(residuals(VAR3))
plot.ts(residuals(VAR3))
irf3 = irf(VAR3, n.ahead = ksteps)
plot(irf3)


