#For this section we'll use the ggplot2 library for visualizing data.
library(ggplot2)
library(readr)
setwd('/home/relethford/Desktop/ML/Rclass/Assignments/')
#Load a dataset in R with:
data(iris)

#Use ggplot to generate a scatterplot of petal width vs. petal length, with the color of the data indicating the iris species.
ggplot(data = iris, aes(x=Petal.Width,y=Petal.Length, col=Species))+geom_point()

#Update by changing the size, transparency, shape of the data points.
ggplot(data = iris, aes(x=Petal.Width,y=Petal.Length, col=Species))+geom_point(size=3, alpha=.8, shape=8)

#Faceted Plots
ggplot(data = iris, aes(x=Petal.Width,y=Petal.Length, col=Species))+geom_point(size=3, alpha=.8, shape=8) + facet_wrap(~Species)

#Okay, now let's get a tidy dataset: https://raw.githubusercontent.com/mharb75/MATE-T580/master/Datasets/iris_alt.csv and separate by Part.
url <- 'https://raw.githubusercontent.com/mharb75/MATE-T580/master/Datasets/iris_alt.csv'
GET(url, write_disk("tidy_iris.csv"))
tidy_iris <- read_csv('tidy_iris.csv')

ggplot(data=tidy_iris, aes(x=Length,y=Width, col=Species)) + geom_point(size=1, alpha=0.8) + facet_wrap(~Part)

#Looking good. Now let's do one more plot to match what the professor has on the website.
url2 <- 'https://raw.githubusercontent.com/mharb75/MATE-T580/master/Datasets/titanic_train.csv'
GET(url2,write_disk('titanic.csv'))
titanic <- read_csv('titanic.csv')
ggplot(data=titanic, aes(x=Pclass, fill=factor(Survived))) + 
       geom_bar(position='fill') + 
       facet_wrap(~Sex)

#Now, make any plot that shows the relationship between survival, age, and gender.

ggplot(data=titanic, aes(x=Age, fill=factor(Survived))) + 
  geom_histogram(bins=10) + 
  facet_wrap(~Sex)

#Another practice - Work with the Nobel prizes dataset. Rank countries by total number of prizes,a nd shows breakdown of prizes by prize category.
url3 <- 'https://raw.githubusercontent.com/maherharb/MATE-T580/master/Datasets/Nobel_data_full.csv'
GET(url3,write_disk('nobel.csv'))
df_nobel <- read_csv('nobel.csv')
head(df_nobel)
#I need to clean this data so that I only have variables I care about: Org Country, Category, Year, total.
df_nobel %>% 

df_nobel %>% ggplot(aes(x=reorder(Organization Country), fill=Category)) +
      geom_bar(position='stack') +
      theme(axis.text.x = element_text(angle=70, hjust=1))

