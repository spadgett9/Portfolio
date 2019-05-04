####### LIBRARIES

library(tidyverse)
library(DBI)
library(RMySQL)
library(tibble)

####### SQL CALL QUERY

conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="student", password="student")


products <- dbGetQuery(conn, "SELECT (SELECT productName FROM Products WHERE Products.productCode = OD1.productCode) AS `Product 1`, 
            (SELECT productName FROM Products WHERE Products.productCode = OD2.productCode) AS `Product 2`, 
            count(*) as Frequency
            FROM OrderDetails AS OD1 JOIN OrderDetails AS OD2 ON OD1.orderNumber = OD2.orderNumber 
            WHERE OD1.productCode > OD2.productCode
            GROUP BY `Product 1`, `Product 2` HAVING Frequency > 10
            ORDER BY Frequency DESC, `Product 1`, `Product 2`;")



prodArrange <- arrange(products,desc(Frequency))
top15 <- head(prodArrange, n=15)

top15$Prod1 <- top15$`Product 1`
top15$Prod2 <- top15$`Product 2`


ggplot(data=top15, mapping = aes(Prod2, Prod1, angle = -90, fill = Frequency)) +
  geom_tile() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
