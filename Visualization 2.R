## necessary libraries
library(janitor)
library(stringr)
library(dplyr)
library(ggplot2)
library(googleVis)

url <- read.csv("http://www.richardtwatson.com/data/InternetCompanies.csv") %>%
  clean_names() %>%
  remove_empty()
url
## changing class type to character where necessary
url$market_cap <- as.character(url$market_cap)
url$cash <- as.character(url$cash)
url$revenue <- as.character(url$revenue)
## removing the $ symbols
url$market_cap <- str_remove_all(url$market_cap, "[$]")
url$cash <- str_remove_all(url$cash, "[$]")
url$revenue <- str_remove_all(url$revenue, "[$]")

## replacing spaces with 0s
url$cash <- str_replace_all(url$cash, "-", "0")
url$revenue <- str_replace_all(url$revenue, "-", "0")
  url
  
## removing any leading or trailing spaces
url$cash <- str_trim(url$cash)
url$revenue <- str_trim(url$revenue)
  ## fixing class types
  url$market_cap <- as.integer(url$market_cap)
  url$cash  <- as.integer(url$cash)
  url$revenue <- as.integer(url$revenue)
url # dataset is now cleaned

## quick data manipulation
viz_data <- url %>%
              select(company, market_cap, cash, revenue) %>%
              arrange(desc(market_cap)) %>%
              slice(1:5)
viz_data

## creating the visualization plot
ggplot(viz_data, aes(market_cap, revenue)) +
      geom_point() +
      geom_text(aes(label = company),size = 2.25, nudge_x = 5, nudge_y = 5)
## using googleVis to create a bubble plot
bubble <- viz_data %>%
                gvisBubbleChart(idvar = "company", xvar = "market_cap", yvar = "revenue", 
                                options=list(hAxis='{minValue:10, maxValue:50}'))
  plot(bubble)

