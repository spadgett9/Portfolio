install.packages("tidyverse")
library(tidyverse)
library(data.table)
library(feather)

# 1) Reading Temp Data ------------------------------------------------------------------------

tempdata <- fread('http://people.terry.uga.edu/rwatson/data/centralparktemps.txt')

head(tempdata, 10)

# 2) ????????
# Database access ---------------------------------------------------------------------------

library(DBI)
library(RMySQL)
library(tibble)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="student", password="student")
# Query the database and create file t for use with R
t <- dbGetQuery(conn,"SELECT * from record;")
dbListTables(conn)

#3) feather file -----------------------------------------------------------------------------

setwd("C:/Users/Scott Padgett/Documents")
feather <- read_feather('C:/Users/Scott Padgett/Documents/radiation.feather')
head(feather, 10)

#4) InternetCompanies -------------------------------------------------------------------------

library(readxl)
url <- "http://richardtwatson.com/data/InternetCompanies.xlsx"
destfile <- "InternetCompanies.xlsx"
curl::curl_download(url, destfile)
InternetCompanies <- read_excel(destfile)
View(InternetCompanies)
head(InternetCompanies, 10)

