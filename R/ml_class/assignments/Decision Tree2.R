#Lesson 8 - Decision Trees

library(ggplot2)
library(readr)
library(httr)
library(caret)
library(rattle)
library(rpart)
library(e1071)
library(ranger)
setwd('/home/relethford/Desktop/ML/Rclass/Assignments/')

#Load a dataset in R with:

url1 <- 'https://raw.githubusercontent.com/maherharb/MATE-T580/master/Datasets/titanic_train.csv'
url2 <- 'https://raw.githubusercontent.com/maherharb/MATE-T580/master/Datasets/titanic_test.csv'
GET(url1,write_disk('titanic_train.csv',overwrite=TRUE))
ttrain <- read_csv('titanic_train.csv')
GET(url2,write_disk('titanic_test.csv',overwrite=TRUE))
ttest <- read_csv('titanic_test.csv')
head(ttrain)
head(ttest)

#This time use the ranger package to build the titanic survival model. First impute the missing values.
med_Age <- mean(ttrain$Age[!is.na(ttrain$Age)])
ttrain$Age[is.na(ttrain$Age)] <- med_Age

#Exclude cabin and embarked data - they're discrete variables that we can't median.

mod <- ranger(Survived~.-Cabin-Embarked,ttrain,classification = TRUE)
mod
