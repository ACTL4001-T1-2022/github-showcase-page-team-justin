setwd("C:\\Users\\Hari\\Desktop\\ACTL4001\\ass")

library(caTools)

nganion<-read.csv('nganion.csv')
sobianitedrucy<-read.csv('sobianitedrucy.csv')
rarita<-read.csv('rarita.csv')
rarita2<-read.csv('rarita2.csv')

set.seed(125)

data_split <- sample.split(nganion$GDP, SplitRatio = 0.75)
train <- as.data.frame(subset(nganion$GDP, data_split == TRUE))
test <-subset(nganion$GDP, data_split == FALSE)

model <- lm(nganion$GDP ~ nganion$Revenue + nganion$Expense, data = train)
summary(model)

data_split2 <- sample.split(sobianitedrucy$GDP, SplitRatio = 0.75)
train2 <- as.data.frame(subset(sobianitedrucy$GDP, data_split2 == TRUE))
test2 <-subset(sobianitedrucy$GDP, data_split2 == FALSE)

model2 <- lm(sobianitedrucy$GDP ~ sobianitedrucy$Revenue + sobianitedrucy$Expense, data = train2)
summary(model2)

data_split3 <- sample.split(rarita$GDP, SplitRatio = 0.75)
train3 <- as.data.frame(subset(rarita$GDP, data_split3 == TRUE))
test3 <-subset(rarita$GDP, data_split3 == FALSE)

model3 <- lm(rarita$GDP ~ rarita$Revenue + rarita$Expense, data = train3)
summary(model3)

data_split4 <- sample.split(rarita2$GDP, SplitRatio = 0.75)
train4 <- as.data.frame(subset(rarita2$GDP, data_split4 == TRUE))
test4 <-subset(rarita2$GDP, data_split4 == FALSE)

model4 <- lm(rarita2$GDP ~ rarita2$Interest_Rate + rarita2$Inflation + rarita2$Net_Export, data = train4)
summary(model4)

test_predict<- predict(model, data=test)
mean((nganion$GDP-test_predict)^2)
test_predict2<- predict(model2, data=test2)
mean((sobianitedrucy$GDP-test_predict2)^2)
test_predict3<- predict(model3, data=test3)
mean((rarita$GDP-test_predict3)^2)
test_predict4<- predict(model4, data=test4)
mean((rarita2$GDP-test_predict4)^2)

test_predict5<- predict(model, data=test3)
mean((rarita$GDP-test_predict5)^2)
test_predict6<- predict(model2, data=test3)
mean((rarita$GDP-test_predict6)^2)

data_split7 <- sample.split(rarita$GDP, SplitRatio = 0.75)
train7 <- as.data.frame(subset(rarita$GDP, data_split7 == TRUE))
test7 <-subset(rarita$GDP, data_split7 == FALSE)

model7 <- lm(rarita$GDP ~ rarita$Revenue + rarita$Expense +rarita$Net_Export, data = train7)
summary(model7)
test_predict7<- predict(model7, data=test7)
mean((rarita$GDP-test_predict7)^2)

data_split8 <- sample.split(rarita$GDP, SplitRatio = 0.75)
train8 <- as.data.frame(subset(rarita$GDP, data_split8 == TRUE))
test8 <-subset(rarita$GDP, data_split8 == FALSE)

model8 <- lm(rarita$GDP ~ rarita$Revenue + rarita$Expense +rarita$Interest_Rate, data = train8)
summary(model8)
test_predict8<- predict(model8, data=test8)
mean((rarita$GDP-test_predict8)^2)

#Multicollinearity Test

X<-rarita[,2:7]
install.packages('GGally')
library(GGally)
ggpairs(X)

install.packages('corpcor')
library(corpcor)
cor2pcor(cov(X))

install.packages('ppcor')
library(ppcor)
pcor(X, method = "pearson")

library(readxl)
library(car)
vif(model8)
