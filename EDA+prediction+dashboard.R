# 1) import libraries ------
library(DataExplorer)
library(data.table)
library(tidyverse)
library(DT)
library(dplyr)
library(plotly)
library(ggplot2)
library(corrplot)
library(prophet)
library(zoo)
library(nnfor)
library(timeSeries)
library(RColorBrewer)

# 2) import data -----
train <- read.csv("D:/R files/R_file/EDA+prediction+dashboard/train.csv", stringsAsFactors=TRUE)
test <- read.csv("D:/R files/R_file/EDA+prediction+dashboard/test.csv", stringsAsFactors=TRUE)

# 3) extract year and month from date -----
train$year = year(train$date) #returns the year from date 
train$month = as.yearmon(train$date) #returns the month from date 

# 4) data introduction -----
train %>% introduce()
train %>% plot_intro()

# 5) continuous feature distribution -----
train %>% plot_density()
train %>% plot_histogram()

# 6) correlation plot -----
train %>% plot_correlation()

#7) histogram for sales -------
ggplot(train , aes(x=sales))+
  geom_density(fill="#6f42f5")+
  labs(x=NULL , y=NULL , title = "histogram of sales price")+theme_minimal()

#8) growth by date ----
msp <- aggregate(sales~ date ,train , mean)

growth1 <- ggplot(msp , aes(x=as.factor(date) , y=sales))+
  geom_line(color="#6c92b8",aes(group=1), size=1.5)+
  geom_point(color="#5d256b" , size=3)+
  labs(title = "the growth of sales price by date" ,x= NULL , y="sales price")+
  theme_minimal()
growth1

msp$rate <- c(0 , 100*diff(msp$sales)/msp[-nrow(msp),]$sales)

growth2 <- ggplot(msp , aes(x=as.factor(date) , y=rate))+
  geom_line(color="#6c92b8",aes(group=1), size=1.5)+
  geom_point(color="#5d256b" , size=3)+
  geom_hline(yintercept = 0)+
  labs(title = "change of rate of sales price",x =NULL , y="sales price")+theme_minimal()
growth2

#9) growth by month of different year ----
msp2<-aggregate(sales~month ,train,mean)

monthgro <- ggplot(msp2 , aes(x=as.factor(month) , y=sales))+
  geom_line(color="#376b56" , size=1.5, aes(group=1))+
  geom_point(color="#f4fc05" , size=3)+
  labs(title = "The Growth of Sale Prices by Month of Year" , x=NULL,y="sales price")+
  theme_minimal()+theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))
monthgro  


msp2$rate <- c(0, 100*diff(msp2$sales)/msp2[-nrow(msp2),]$sales)

monthgro2 <-ggplot(msp2 , aes(x=as.factor(month) , y=rate))+
  geom_line(color="#e64747" , size=1.5 ,aes(group=1))+
  labs(title = "change of rate of sales price" , x=NULL , y="sales price")+
  geom_hline(yintercept = 0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
monthgro2

# 10) growth by year ----
msp3 <- aggregate(sales~year , train , mean)

yeargro <- ggplot(msp3 , aes(x=as.factor(year) , y=sales))+
  geom_line(color="#e64747" , aes(group=1) , size=1.5)+
  geom_point(color="#5d256b" , size=3)+
  labs(title = "The Growth of Sale Prices by Year" , x=NULL , y="sales price")+
  theme_minimal()
yeargro

msp3$rate <- c(0 , 100*diff(msp3$sales)/msp3[-nrow(msp3),]$sales)

yeargro2 <- ggplot(msp3 , aes(x=as.factor(year) , y=rate))+
  geom_line(color="#181ec9" , aes(group=1) , size=1.5)+
  geom_point(color="#e64747" , size=3)+
  labs(title = "Change rate of Sale Price", x="Year", y="rate of change")+
  geom_hline(yintercept = 0)+theme_minimal()
yeargro2

#11) growth by store ----
unique(train$store)

year_state <- aggregate(sales~store+year , train , mean)

storegro <- ggplot(year_state , aes(group=store))+
  geom_line(aes(x=year , y=sales , color=store) , show.legend =F)+
  labs(title = "The Growth of Sales Price by Store from 2013 - 2017" , x=NULL)+
  theme_minimal()
storegro
#store 3 has highest growth and 7 has lowest growth

#12) growth by item ----

unique(train$item)
year_state2 <- aggregate(sales~item+year , train , mean)

itemgro <- ggplot(year_state2 , aes(group=item))+
  geom_line(aes(x=year , y=sales , color=item ) , show.legend = F)+
  labs(title = "The Growth of Sales Price by Store from 2013 - 2017" , x= NULL)+
  theme_minimal()
itemgro

#Prophet model for time series ----

prop_data <- subset(train , train$store==1 & train$item==1)

pro_data <- data.frame(y=log1p(prop_data$sales) , ds=prop_data$date)
pro_data <- aggregate(pro_data$y , by=list(pro_data$ds) , FUN=sum)

head(pro_data)
colnames(pro_data) <- c("ds" , "y") 
head(pro_data)

model = prophet(pro_data)
summary(model)

#create future data for prediction ----
future = make_future_dataframe(model , periods = 100)
forecast = predict(model , future)
plot(model , forecast)
prophet_plot_components(model , forecast)




