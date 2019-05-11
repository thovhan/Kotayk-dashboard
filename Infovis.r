library(ggplot2)
library(radarchart)
library(lubridate)
library(plotly)
library(lubridate)
theme_set(theme_bw())
library(ggplot2)
library(forecast)
theme_set(theme_classic())

data <- read.csv("marta_data.csv")
head(data)


bar=ggplot(data, aes(Region, Number_of_Transactions, fill=hcl(h,c,l)))+geom_bar(stat="identity", fill="skyblue2")+theme_classic()+ylab("Number of Transactions")+ggtitle("Number of transactions in each region")
bar
ggplotly(bar)





theme_set(theme_classic())

Buble <- data$Region

theme_set(theme_test())
g <- ggplot(data, aes(Rent_transaction, Purchase_and_Sale)) + 
  labs(title="The relationship of Rent transactions to Purchase and Sales transactions in each Region", x="Rent Transactions", y="Purchase and Slaes Transactions")

g + geom_jitter(aes(col=Region, size=Number_of_Transactions))
  