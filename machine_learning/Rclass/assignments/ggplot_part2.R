#For this section we'll use the ggplot2 library for visualizing data.
library(ggplot2)
library(readr)
setwd('/home/relethford/Desktop/ML/Rclass/Assignments/')
#Load a dataset in R with:

#Another practice - Work with the Nobel prizes dataset. Rank countries by total number of prizes,a nd shows breakdown of prizes by prize category.
url <- 'https://raw.githubusercontent.com/maherharb/MATE-T580/master/Datasets/Nobel_data_full.csv'
GET(url,write_disk('nobel.csv',overwrite=TRUE))
df_nobel <- read_csv('nobel.csv')
head(df_nobel)

#I need to clean this data so that I only have variables I care about: Org Country, Category, Year, total.
df_nobel <- df_nobel %>% na.omit() %>% select(Category,`Organization Country`) %>% 
            group_by(`Organization Country`) %>% mutate(Total = n()) %>% ungroup() %>% filter(Total>1)

head(df_nobel)

df_nobel %>% ggplot(aes(x=reorder(`Organization Country`, -Total), fill=Category)) +
  geom_bar(position='stack') +
  theme(axis.text.x = element_text(angle=70, hjust=1))

