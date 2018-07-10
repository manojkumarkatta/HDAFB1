library("xlsx")
ret<-read_excel("Employee_Attrition_Dataset_Problem.xlsx", sheet = "Dataset")
#train without downsampling
ret
test<-read_excel("Employee_Attrition_Dataset_Problem.xlsx", sheet = "Evaluation")
str(ret)
summary(ret)
library(caret)
ret$Over18<-NULL
ret$EmployeeCount<-NULL
ret$EmployeeNumber<-NULL
ret$StandardHours<-NULL
ret$Attrition<-as.factor(ret$Attrition)
ret$BusinessTravel <- as.factor(ret$BusinessTravel)
ret$Department <- as.factor(ret$Department)
ret$EducationField <- as.factor(ret$EducationField)
ret$Gender <- as.factor(ret$Gender)
ret$JobRole <- as.factor(ret$JobRole)
ret$MaritalStatus <- as.factor(ret$MaritalStatus)
ret$OverTime <- as.factor(ret$OverTime)
set.seed(2)
#trained-downsampled data
'%ni%'<-Negate('%in%')
down_train<-downSample(x=ret[,colnames(ret)%ni%"Attrition"],y=ret$Attrition)

model <-glm(Class ~.,data=down_train, family = "binomial")
summary(model)
#id<-sample(2,nrow(down_train),prob = c(0.7,0.3),replace = T)
train_sample <- down_train[id == 1,]
test_sample <- down_train[id==2,]
library(rpart)
samp<-rpart(Attrition ~ .,data=train_sample)
summary(samp)

p<-predict(samp,newdata = down_train, type= "class")

p3<-predict(model,newdata = ret, type = "class")
p1<-predict(samp,newdata = train_sample, type = "class")
p2<-predict(samp,newdata = test_sample, type = "class")
p2

#pred<-ifelse(p> 0.5,1,0)
table(down_train$Class,p)
table(down_train$Class)
table(test_sample$Class,e2)
library("xlsx")
write.xlsx(ret, "./emp_ret-data.xlsx", sheet="1",append=TRUE)
write.xlsx(down_train, "./emp_ret-data.xlsx", sheet="2",append=TRUE)
write.xlsx(p1, "./emp_ret-data.xlsx", sheet="3",append=TRUE)
cut_off <- seq(1:10)*.1
cut_off
accuracy <- numeric()
for(i in cut_off){
  predicted <- ifelse(test_sample <= i, 0,1)
  
  accuracy <- c(accuracy, mean(predicted == testData$Attrition1))
}
result <- data.frame(cut_off,accuracy)

print(result)

y_pred_num <- ifelse(res2 > 0.5, 0, 1)
y_pred <- factor(y_pred_num, levels=c(0, 1))
y_act <- testData$Attrition1

print(mean(y_pred == y_act)) 
