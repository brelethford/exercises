#6.2
library(ggplot2)
library(readr)
setwd('/home/relethford/Desktop/ML/Rclass/Assignments/')

#Load a dataset in R with:

url <- 'https://raw.githubusercontent.com/maherharb/MATE-T580/master/Datasets/ISLR_Credit.csv'
GET(url,write_disk('credit.csv',overwrite=TRUE))
df_credit <- read_csv('credit.csv')
head(df_credit)


#Use Caret in order to train a linear model.
set.seed(1234)
trControl <- trainControl(method = "cv", number = 5)
grid <- expand.grid(alpha = 1, lambda = seq(0, 10, length = 101))
mod <- train(Rating ~ .-Limit, df_credit, method = "glmnet", tuneGrid = grid, 
             trControl = trControl, metric = "RMSE", preProcess = c("center", 
                                                                    "scale"))
par(mar = c(4, 4, 0, 0))
plot(mod)
mod

#Look at the coefficients for the most useful lambda.
Beta <- coef(mod$finalModel,6)
Beta
R2 <- mod$results$Rsquared[which(grid$lambda == 0.9)]
1 - (1 - R2) * (nrow(df_credit) - 1)/(nrow(df_credit) - sum(Beta != 0) - 1)


