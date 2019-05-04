######## LIBRARIES

library(shiny) 
library(shinydashboard) 
library(quantmod) 
library(tidyverse)
library(DBI)
library(RMySQL)
library(tibble)


######## LOAD DATA

###### CONNECTING TO DATABASE

conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="student", password="student")


###### Query the database and create file t for use with R

tOrders <- dbGetQuery(conn,"SELECT orderNumber, customerNumber from Orders;") 

tRev <- dbGetQuery(conn, "Select amount, customerNumber from Payments;")

dbListTables(conn)

###### Join the Data Frames

tJoin <- inner_join(tOrders,tRev)

tJoin$Revenue <- sum(tJoin$amount)
tJoin$Orders <- NROW(tJoin$orderNumber)


######## DASHBOARD 


header <- dashboardHeader(title = 'Classic Metrics') 
sidebar <- dashboardSidebar() 
boxRevenue <- box(title = 'Revenue: ',tJoin$Revenue, background = 'blue' ) 
boxOrders <-  box(title = 'Orders: ',tJoin$Orders, background = 'red' ) 
row <- fluidRow(boxRevenue,boxOrders) 
body <- dashboardBody(row) 
ui <- dashboardPage(header,sidebar,body) 
server <- function(input, output) {} 
shinyApp(ui, server)
