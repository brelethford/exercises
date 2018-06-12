#Practice basic linear modelling in R on the mtcars dataset.
data(mtcars)
glimpse(mtcars)
car_mod <- lm(mpg ~ wt, data=mtcars)
summary(car_mod)

ggplot(data=mtcars, aes(x=wt,y=mpg)) +
    geom_point() +
    geom_smooth(method='lm')

#Improve the model by adding additional variables.
car_mod2 <- lm(mpg~factor(cyl)+wt, data=mtcars)
summary(car_mod2)
