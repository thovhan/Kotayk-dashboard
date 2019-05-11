#We should install the packages that we need

#install.packages("ggplot2")
library(ggplot2)
library(lubridate)
#install.packages("ggthemes")
library(ggthemes)

#Integrate the date

data<-read.csv("data.csv")
str(data)

#Lets make it date

data$Date<-mdy(data$Date)
str(data)

#Have a look on data

str(data)

#Have a look on data structure we have 33 observations and 9 variables

#Let start some visualisation stuff
str(data)
#First Trial

theme_set(theme_bw())
# PLOT_1
ggplot(data=data, aes(Number_of_Transactions,Purchase_and_Sale))+ 
  geom_point(aes(colour=Region))+labs(subtitle="Scatterplot", 
                                                 y="Purchase and Sale", 
                                                 x="Number of overall transactions", 
                                                 title="Changes in purchase and sale related to number of transactions")+scale_color_brewer(palette = "Set1")

                                              
#Second trial

g <- ggplot(data, aes(Avarage_Price_Per_Transaction,Real_estate_acquired_by_foreign_citizens))
# PLOT_2
g + geom_boxplot(aes(fill=factor(Region))) + 
  theme(axis.text.x = element_text(angle=120, vjust=0.9)) + 
  labs(title="What is the relation between real estate purchase and avarage price with respect of each region", 
       subtitle="Boxplot",
       caption="Source: data",
       x="Avarage price per transaction",
       y="Real estate acquired by foreign citizens")+theme_set(theme_classic())

#Third trial

# Allow Default X Axis Labels

plot<-ggplot(data, aes(x=Date)) + 
  geom_line(aes(y=Alienation),colour="yellow") + 
  labs(title="Date variation related to Alimentation", 
       subtitle="Time Series Chart", 
       caption="Source: data", 
       x="Date",
       y="Alienation") +
scale_x_date(date_breaks = "12 days",
             date_labels = "%b-%y")+theme_dark()
# PLOT_3
plot+ theme(
  plot.background = element_rect(fill = "white"),
  panel.background = element_rect(fill = "black"),
  axis.line.x = element_line(color = "white")
)
