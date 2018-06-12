#Setup

setwd('/home/relethford/Desktop/ML/Rclass/Assignments/')
library(httr)
library(XML)
library(stringr)
#Now let's look at the site we'll pull information from: Donald Trump's Twitter.

url <- 'https://twitter.com/realDonaldTrump?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor'
xmlpage <- htmlParse(rawToChar(GET(url)$content))
length(capture.output(xmlpage))
capture.output(xmlpage)[1:4]

#Now let's try to get just the tweets.

searchfor <- '//p[@class="TweetTextSize TweetTextSize--normal js-tweet-text tweet-text"]'
tweet <- xpathSApply(xmlpage, searchfor, xmlValue)
length(tweet)

#good. Now we'll get the ones with Donald Trump as the author so that we don't get retweets. How do we get the author?
#They all have the following author identifier in the strong class... let's get the authors?

searchfor2 <- '//strong[@class="fullname show-popup-with-id u-textTruncate "]'
author <- xpathSApply(xmlpage, searchfor2, xmlValue)

#All right, now combine these two in a dataframe.
df_tweets <- data.frame(Tweet=1:length(tweet),Text=tweet,Author=author)

#Now let's clean it. First, remove the definite article 'the' from the tweets with gsub.
df2 <- gsub("[ ]{2,}", " ", gsub("\\bthe\\b","",df_tweets$Text, ignore.case = TRUE))

#Grep doesn't substitute - it just returns indices where it occurs. use grep, grepl to find where Trump mentions himself.

df3 <- grep("\\bTrump\\b",df_tweets$Text, value = TRUE)
length(df3)

#Note that this includes tweets where he is not the author - could be retweets.
#Now, use regex to find tweets with ! at end of tweet.

df4 <- grep("!$",df_tweets$Text, value=TRUE)

#Now find tweets that contain Acronyms (USA, NRA, E.U, etc.)

df5 <- grep("([A-Z][.]?){2,}",df_tweets$Text, value=TRUE)
unlist(str_extract_all(df_tweets$Text, "([A-Z][.]?){2,}" %>% head(20)))

#Use unlist to extract phrases with title caps (more than a couple words in a row with capitalized first letter.)

unlist(str_extract_all(df_tweets$Text, "( [A-Z][a-z]+){3,}"))

