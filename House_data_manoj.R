library("readxl")
l<-read_excel("C:/Users/manoj kumar/Desktop/training/Regression/Housing Data_Problem.xlsx", sheet = "Train")
summary(l)
library(caret)
l$Sno<-NULL
l$INDUS<-NULL
l$CHAS<-NULL
l$AGE<-NULL
library(caTools)
model <- lm( MEDV~.,data=l)
mvdb<-read_excel("C:/Users/manoj kumar/Desktop/training/Regression/Housing Data_Problem.xlsx", sheet = "Evaluation")
mvdb$Sno<-NULL
mvdb$INDUS<-NULL
mvdb$CHAS<-NULL
mvdb$AGE<-NULL
MEDV<- predict(model,mvdb,type = "response")
mvdb$MEDV<-NULL
md<-cbind(mvdb,MEDV)
View(md)
write.csv(md,file = "Housing.csv")  
