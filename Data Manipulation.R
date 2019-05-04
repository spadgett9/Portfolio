##### LIBRARIES

library(tidyverse)
library(DBI)
library(RMySQL)
library(tibble)

###### CONNECTING TO DATABASE
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="student", password="student")


###### Query the database and create file t for use with R
tPay <- dbGetQuery(conn,"SELECT customerNumber, amount from Payments;") # on Customers.customerNumber = Payments.customerNumber;"
tCust <- dbGetQuery(conn, "Select customerNumber, customerName from Customers;")
dbListTables(conn)

###### Join the Data Frames
tJoin <- inner_join(tPay,tCust)


##### Select variables, group by cust. name, calculate percentage of cust sales
tFinal <- tJoin %>% 
  select(customerName, amount) %>%
  group_by(customerName) %>%
  summarize(custAmmt = sum(amount)) %>%
  mutate(PercentageAmmt = 100*(custAmmt/sum(custAmmt)))


##### Compute quantiles for ranking
a <- quantile(tFinal$PercentageAmmt, .8)
b <- quantile(tFinal$PercentageAmmt, .5)
c <- quantile(tFinal$PercentageAmmt, 0)

##### Assign Ranking Values
tFinal$Category <- case_when(
  tFinal$PercentageAmmt >= a ~ 'A',
  tFinal$PercentageAmmt < a & tFinal$PercentageAmmt >= b ~ 'B',
  tFinal$PercentageAmmt >= c & tFinal$PercentageAmmt < b ~ 'C')

arrange(tFinal, Category)

##### Display Table
head(tFinal, 20)

##### A plot for checking correct category assignment

ggplot(data = tFinal) +
  geom_bar(mapping = aes(x = tFinal$Category))

 


   
