#Read the CSV file into a dataframe

Reviews <- read.csv("Zomato_Reviews.csv")

# TOOLS REQUIRED FOR OUR ANALYSIS

library(tidyverse)      # data manipulation & plotting
library(stringr)        # text cleaning and regular expressions
library(tidytext)       # provides additional text mining functions


#Number of reviews
Num_Reviews <- length(Reviews[[1]])
#Num_Reviews <- 20
Start <- 1

#Converting reviews to array of words
all_reviews_in_words <- tibble()
for(i in Start:Num_Reviews) {
  clean <- tibble(reviewID = i,text = toString(Reviews[[3]][i]))
  clean
  #Break the text into words
  clean <- unnest_tokens(clean, word, text)
 all_reviews_in_words <- rbind(all_reviews_in_words, clean)
}

#Running sentiment analysis using NRC
nrc_Word_list <- right_join(all_reviews_in_words,get_sentiments("nrc"), by = c("word" = "word")) #by : left_table.word = right_table.word
nrc_Word_list <- filter(nrc_Word_list,!is.na(reviewID))
nrc_Word_list
result <- count(nrc_Word_list,sentiment, sort = TRUE)
result

#Overall Rating

neg <- if (length(which(result[][1]=="negative")) == 0) 0 else result[[2]][which(result[][1]=="negative")]
pos <- if (length(which(result[][1]=="positive")) == 0) 0 else result[[2]][which(result[][1]=="positive")]
rating_nrc <- round(pos / (pos+neg)*5,1)
rating_nrc

#Running sentiment analysis using BING
BING_Word_list <- right_join(all_reviews_in_words,get_sentiments("bing"), by = c("word" = "word")) #by : left_table.word = right_table.word
BING_Word_list <- filter(BING_Word_list,!is.na(reviewID))
BING_Word_list
result_bing <- count(BING_Word_list,sentiment, sort = TRUE)
neg_bing <- if (length(which(result_bing[][1]=="negative")) == 0) 0 else result_bing[[2]][which(result_bing[][1]=="negative")]
pos_bing <- if (length(which(result_bing[][1]=="positive")) == 0) 0 else result_bing[[2]][which(result[][1]=="positive")]
rating_bing <- round(pos_bing / (pos_bing +neg_bing)*5,1)
rating_bing


#Running sentiment analysis using AFINN
AFINN_Word_list <- right_join(all_reviews_in_words,get_sentiments("afinn"), by = c("word" = "word")) #by : left_table.word = right_table.word
AFINN_Word_list <- filter(AFINN_Word_list,!is.na(reviewID))
AFINN_Word_list
result_afinn <- summarise(AFINN_Word_list, total_positive=sum(score[score>=0]), total_negative=sum(score[score<=0]), Overall_sentiment = sum(score), overall_Rating_5= Overall_sentiment/total_positive*5)
rating_afinn <- round(result_afinn$overall_Rating_5,1) 
rating_afinn
