#Lesson 8 - Decision Trees

library(ggplot2)
library(readr)
library(httr)
library(caret)
library(rattle)
library(rpart)
library(e1071)
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

#Build a classification tree to predict survival. Visualize the tree and check the accuracy of the model.

survival_mod <- rpart(factor(Survived) ~ Sex+Pclass+Age+Fare, ttrain)
fancyRpartPlot(survival_mod, sub="")

#Predict how well it fits the test data.
pred_survive <- predict(survival_mod, ttest, type = "class")

#Create a confusion matrix to see how well it fits.
confusionMatrix(pred_survive,factor(ttest$Survived))

#Looks decent. Let's try doing the same thing, but changing some hyperparameters (maxdepth, cp, or minsplit)
survival_mod <- rpart(factor(Survived) ~ Sex+Pclass+Age+Fare, ttrain,control = list(maxdepth=3,minsplit=100))
fancyRpartPlot(survival_mod, sub="")
pred_survive <- predict(survival_mod, ttest, type = "class")
confusionMatrix(pred_survive,factor(ttest$Survived))

#Accuracy is slightly less, but is a bit simpler to look at.
