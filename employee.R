library("xlsx")
ret<-read_excel("Employee_Attrition_Dataset_Problem.xlsx", sheet = "Dataset")
ret
str(ret)
summary(ret)
library(caret)
ret$Over18<-NULL
ret$EmployeeCount<-NULL
ret$EmployeeNumber<-NULL
ret$StandardHours<-NULL
ret$BusinessTravel <- as.factor(ret$BusinessTravel)
ret$Department <- as.factor(ret$Department)
ret$EducationField <- as.factor(ret$EducationField)
ret$Gender <- as.factor(ret$Gender)
ret$JobRole <- as.factor(ret$JobRole)
ret$MaritalStatus <- as.factor(ret$MaritalStatus)
ret$OverTime <- as.factor(ret$OverTime)
library(caTools)
split = sample.split(ret$Attrition, SplitRatio = 0.7)
train = subset(ret, split == TRUE)
test = subset(ret, split == FALSE)
library(rpart)
model<-rpart(Attrition ~ ., data=train,method = "class")
prediction <- predict(model, newdata=test,type = "class")
table(test$Attrition)
table(test$Attrition, prediction)


a<-ifelse(e2>0.5,1,0)
library(xlsx)
write.xlsx(a, "./ead.xlsx", sheet="Test")

require(caret)
table(ActualValue=train_sample$Attrition,PredictiveValue=e1>0.5)
table(ActualValue=test_sample$Attrition,PredictiveValue=e2>0.5)


