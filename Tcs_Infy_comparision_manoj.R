library(readxl)
t<-read_excel("Stock Comparision Infy & TCS_Problem.xlsx", sheet = "Sheet")
ttest<- t.test(t$INFY,t$TCS,mu=0,alternative = "two.sided",paired = T,conf.level = 0.95)
ttest
