library(xlsx)
r<-read.xlsx("C:/Users/manoj kumar/Desktop/training/Regression/clustering/Zomato_Review.xlsx",sheetName = "Zomato")
head(r)
library(stringr)
library(syuzhet)
r$Review <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)","", r$Review)

# Cleaning people names

r$Review <- gsub("@\\w+","", r$Review)
r$Review <- gsub("[^\x01-\x7F]", "", r$Review)
#Cleaning Punctuations

r$Review <- gsub("[[:punct:]]"," ",r$Review)

#Cleaning Punctuations

r$Review <- gsub("[^[:alnum:]]", " ",r$Review)
r$Review<-gsub('\\p{So}|\\p{Cn}', '', r$Review, perl = TRUE)
r$Review <- tolower(r$Review)

library(tidyverse)
library(tidytext)
library(sqldf)
library(readr)
library(dplyr)
#sentiment <- r %>% unnest_tokens(word,Review) %>% inner_join(get_sentiments("afinn")) 
reviews_sentiment <- r %>%unnest_tokens(word,Review) %>% 
  right_join(get_sentiments("afinn"), by = "word") %>% 
  group_by(ID) %>% 
  summarize(sentiment = mean(score))
reviews_sentiment
mean(as.numeric(reviews_sentiment$sentiment))

#for positive and neagtive
review_words_counted <- r%>%
  count(ID, sentiment, word) %>%
  ungroup()

review_words_counted
