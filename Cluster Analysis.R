######## LIBRARIES

library(tidyverse)
library(HSAUR3)
library(readxl)
library(janitor)
library(cluster)


######## LOADING DATA

setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/MSBA/1) Advanced Data Analytics")

clust_data <- read_excel(skip=3,"b38c350e-169d-11e5-b07f-00144feabdc0.xls")

######## 1) Extract three clusters from the top 20 companies by market value that have complete data for each row.



## ENSURING CORRECT DATA TYPE

sapply(clust_data, class)

clust_data$`Turnover $m` <- as.numeric(clust_data$`Turnover $m`)

## BASIC CLEANING

clean_names(clust_data)

clean_data <- na.omit(clust_data)


## FILTERING FOR TOP 20


top_20_unsort <- clean_data %>%
  select(Company, `Market value $m`, `Turnover $m`, `Net income $m`, `Total assets $m`, Employees, `Price $`, `Dividend yield (%)`, `P/e ratio`) %>%
  as.data.frame(clean_data, row.names = Company) %>%
  dplyr::arrange(desc(`Market value $m`))
  
  
  top_20 <- head(top_20_unsort, 20)

  row.names(top_20) <- top_20$Company
  
## CLUSTER ANALYSIS

top20_scale <- scale(top_20[-1])

top20_kmean <- kmeans(top20_scale, 3)

top20_kmean

clusplot(top20_scale, top20_kmean$cluster,  main='2D representation of the Cluster solution',
             color=TRUE, shade=TRUE,
             labels=2, lines=0)
