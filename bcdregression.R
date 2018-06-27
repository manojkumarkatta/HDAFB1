train_data <- read_excel("./Breast_Cancer_Dataset.xlsx", sheet = "Train")
t<-glm(Classification ~ .,data=train_data,family=binomial)

summary(t)

p<-predict(t,newdata = train_data, type = "response")
q<-predict(t,newdata = test_data, type = "response")
q
require(caret)

table(ActualValue=train_data$Classification,PredictiveValue=p>0.5)
table(ActualValue=test_data$Classification,PredictiveValue=q>0.5)

residue<-predict(t,test_data,type="response")
summary(residue)

library(ROCR)
ROCRPred = prediction(p,train_data$Classification)
ROCRPred<- performance(ROCRPred,"tpr","fpr")
plot(ROCRPred,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))

