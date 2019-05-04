
########## LIBRARIES

library(tidyverse)
library(purrr)
library(readxl)
library(dplyr)
library(janitor)

########## LOADING FILE

setwd("C:/Users/Scott Padgett/OneDrive - University of Georgia/MSBA/1) Advanced Data Analytics")
sales <- "C:/Users/Scott Padgett/OneDrive - University of Georgia/MSBA/1) Advanced Data Analytics/mrtssales92-present.xls"

########## RUN EXCEL CONCAT FUNCTION

Sales_Concat <- sales %>%
  excel_sheets() %>%
  set_names() %>%
  map_df(~ read_excel(path = sales, sheet = .x, range = "B72:O110"), .id = "sheet")

########## NORMALIZE

colnames(Sales_Concat) <- c('Year', 'Type', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', "July", 'Aug', 'Sep', 'Oct', 'Nov','Dec', 'End')

Sales_Norm <- gather(Sales_Concat, key =  "Month", value = "Sales", "Jan":"End")

########## FACTOR MONTH

Sales_Norm$Month <- parse_factor(Sales_Norm$Month, Levels = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', "July", 'Aug', 'Sep', 'Oct', 'Nov','Dec', 'End'), ordered = TRUE)

Sales_Norm <- na.omit(Sales_Norm)

########## CALCULATING MONTH AVERAGES

yearCol <- as.data.frame(unique(Sales_Norm$Year))
yearCount <- count(yearCol)
yearNum <- as.numeric(yearCount[["n"]][1])

Sales_Final <- Sales_Norm %>%
  select(Year, Type, Month, Sales) %>%
  filter(Type == "Retail and food services sales, total") %>%
  group_by(Month) %>%
  summarise(Avg = sum(Sales)/yearNum)

Sales_Final

