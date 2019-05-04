########## LIBRARIES
library(shiny) 
library(quantmod)
library(shinydashboard)
library(tidyverse)
library(dygraphs)

######### BONES
header <-  dashboardHeader(title = 'Apple stock watch') 
sidebar <- dashboardSidebar(NULL) 
boxPrice <- box(title='Closing share price', width = 12, height = NULL, dygraphOutput("apple")) 
body <-   dashboardBody(fluidRow(boxPrice)) 
ui <- dashboardPage(header, sidebar, body) 
server <- function(input, output) { 
  # quantmod retrieves closing price as a time series 
  output$apple <- renderDygraph({dygraph(Cl(getSymbols('AAPL', auto.assign=FALSE)))}) 
} 
shinyApp(ui, server)




########## NOTES 


# use font awesome and Glyphicons for fonts and icons respectively


