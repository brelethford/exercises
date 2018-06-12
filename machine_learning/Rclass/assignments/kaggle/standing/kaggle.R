#Kaggle Competition
library(ggplot2)
library(readr)
library(httr)
library(caret)
library(rattle)
library(rpart)
library(e1071)
library(ranger)
library(tidyr)
library(rpart)
library(xgboost)

#Set up and download:
setwd('/home/relethford/Desktop/ML/Rclass/Assignments/kaggle/standing/')
train <- read_csv('train.csv')
test <- read_csv('test.csv')
sampleSubmission <- read_csv('sampleSubmission.csv')
head(train)
head(test)
unique((train$Activity))
head(sampleSubmission)

############# RF - ranger ################

#Model with Ranger (remove id from set)

rf_mod <- ranger(Activity ~ . -Id,train,classification = TRUE)
rf_mod
rf_mod$confusion.matrix
accuracy <- 1 - rf_mod$prediction.error

#Make predictions:
rf_pred <- predict(rf_mod,test)
rf_mod$prediction.error
rf_mod$confusion.matrix

#Submit:
df_pred_rf <- data.frame(Id=test$Id,Activity=rf_pred$predictions)

submission <- write_csv(df_pred_rf,'brelethford_rf.csv')

############# Decision Tree ##################

#Model with Decision Tree (remove id from set). Use 80% of train for training, 20% or train to test (to gauge accuracy).

train_ind <- sample(seq_len(nrow(train)),floor(0.8*nrow(train)))

sub_train <- train[train_ind,]
sub_test <-train[-train_ind,]

dt_mod <- rpart(factor(Activity) ~ .-Id,sub_train,control=list(maxdepth=5))
fancyRpartPlot(dt_mod, sub="")

#Make predictions:
dt_pred <- predict(dt_mod,sub_test,type='class')
conf_dt <- confusionMatrix(dt_pred,factor(sub_test$Activity))$table
accuracy <- sum(diag(conf_dt)) / sum(conf_dt)
accuracy

###This accuracy is not great, but let's do predictions for the whole set by repeating for the entire dataset.

dt_mod <- rpart(factor(Activity) ~ .-Id,train,control=list(maxdepth=5))
fancyRpartPlot(dt_mod, sub="")

#Make predictions:
dt_pred <- predict(dt_mod,test,type='class')

#Submit:
df_pred_dt <- data.frame(Id=test$Id,Activity=dt_pred)

submission <- write_csv(df_pred_dt,'brelethford_dt.csv')

################## XGB ##################
