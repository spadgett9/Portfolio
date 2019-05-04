######## LIBRARIES

library(tidyverse)
library(HSAUR3)
library(readxl)
library(janitor)
library(forcats)
library(broom)

install.packages("psych")

library(psych)

######## LOADING DATA

setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/MSBA/1) Advanced Data Analytics")

clust_data <- read_excel(skip=3,"b38c350e-169d-11e5-b07f-00144feabdc0.xls")

######## 1) Extract three clusters from the top 20 companies by market value that have complete data for each row.


     
# ENSURING CORRECT DATA TYPE

sapply(clust_data, class)

clust_data$`Turnover $m` <- as.numeric(clust_data$`Turnover $m`)

## BASIC CLEANING

clean_names(clust_data)

clean_data <- na.omit(clust_data)



## FILTERING FOR TOP 20

data <- clean_data %>%
  select(Company,Sector, `Market value $m`, `Turnover $m`, `Net income $m`, `Total assets $m`, Employees, `Price $`, `Dividend yield (%)`, `P/e ratio`) %>%
  as.data.frame(clean_data)


summary(data)



data$Sector <- forcats::fct_lump(data$Sector, n=5)
  
row.names(data) <- data$Company


 ## UNIFYING DIRECTION OF CLUSTER VARIABLE

data$`Market value $m` <- max(data$`Market value $m`) - data$`Market value $m`
data$`Turnover $m` <- max(data$`Turnover $m`) - data$`Turnover $m`
data$`Net income $m` <- max(data$`Net income $m`) - data$`Net income $m`
data$`Total assets $m` <- max(data$`Total assets $m`) - data$`Total assets $m`
data$Employees <- max(data$Employees) - data$Employees
data$`Price $` <- max(data$`Price $`) - data$`Price $`
data$`Dividend yield (%)` <- max(data$`Dividend yield (%)`) - data$`Dividend yield (%)`
data$`P/e ratio` <- max(data$`P/e ratio`) - data$`P/e ratio`


## CLUSTER ANALYSIS

pca <- prcomp(data[c(3:9)],scale=TRUE) 
pca
summary(pca)
sect <- data$Sector
aug <- augment(pca)

biplot(pca, col = palette("default"))
qplot(.fittedPC1, .fittedPC2, data = aug, color = sect) + 
  stat_ellipse(aes(group = sect))


# FINDINGS:

# From looking at both our biplot and qplot, we can see that oil and gas producers trend most strongly towards
# revenue generation metrics (turnover, market value, total assets, and net income), that automobile and 
# parts sectors trend slightly more towards the employee metric than other sectors, and that technology and 
# pharmacuticals trend most strongly toward net income and Dividend yield. 

# here we see that technology 
