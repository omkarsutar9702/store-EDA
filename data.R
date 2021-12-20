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

msp <- aggregate(sales~ date ,train , mean)
msp$rate <- c(0 , 100*diff(msp$sales)/msp[-nrow(msp),]$sales)

msp2<-aggregate(sales~month ,train,mean)
msp2$rate <- c(0, 100*diff(msp2$sales)/msp2[-nrow(msp2),]$sales)


msp3 <- aggregate(sales~year , train , mean)
msp3$rate <- c(0 , 100*diff(msp3$sales)/msp3[-nrow(msp3),]$sales)

year_state <- aggregate(sales~store+year , train , mean)
year_state2 <- aggregate(sales~item+year , train , mean)



prop_data <- subset(train , train$store==1 & train$item==1)
pro_data <- data.frame(y=log1p(prop_data$sales) , ds=prop_data$date)
pro_data <- aggregate(pro_data$y , by=list(pro_data$ds) , FUN=sum)

colnames(pro_data) <- c("ds" , "y") 

model = prophet(pro_data)
future = make_future_dataframe(model , periods = 100)
forecast = predict(model , future)



