# Connecting to SQL db via ODBC

library(RODBC)
channel <- odbcConnect("connection name", uid = "login", pwd = "pass", believeNRows = FALSE, rows_at_time = 100)

odbcGetInfo(channel) # check that connection is working, hash out when running markdown!

# Formulate query
data <- sqlQuery(channel, "SELECT ITEM, TYPE, CURRENCY, CTY, SUM(SALES_VALUE) as SUM_SALE_VAL, SUM(SALES_QTY) as SUM_SALE_QTY
                  FROM AB.TABLE_T
                  WHERE DATE BETWEEN '2016-12-31' AND '2017-12-01' AND
                  CTY = 'US'
                  GROUP BY ITEM, TYPE, CTY, CURRENCY;")

odbcClose(channel) # Close channel

head(data) # check data frame

# Create average price per item
data$PRICE <- (data$SUM_SALE_VAL / data$SUM_SALE_QTY)
# Create profit per sold item

# Join tables using plyr
library(plyr)

new_df <-join(ab, data,
            type = "left")
# Left join ab table with data table on ITEM column