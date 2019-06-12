library("readxl")
ret<-read_excel("Employee_Attrition_Dataset_Problem.xlsx", sheet = "Dataset")
View(ret)
summary(ret)
library(caret)
ret$Over18<-NULL
ret$EmployeeCount<-NULL
ret$EmployeeNumber<-NULL
ret$StandardHours<-NULL
ret$BusinessTravel<-as.numeric(as.factor(ret$BusinessTravel))
ret$Department<-as.numeric(as.factor(ret$Department))
ret$EducationField<-as.numeric(as.factor(ret$EducationField))
ret$Gender<-as.numeric(as.factor(ret$Gender))
ret$JobRole<-as.numeric(as.factor(ret$JobRole))
ret$MaritalStatus<-as.numeric(as.factor(ret$MaritalStatus))
ret$OverTime<-as.numeric(as.factor(ret$OverTime))
ret$Attrition<-ifelse(ret$Attrition == "Yes" , 1,0)
ret$Attrition<-as.factor(ret$Attrition)
set.seed(2)
library(caTools)
#trained-downsampled data
'%ni%'<-Negate('%in%')
down_train<-downSample(x=ret[,colnames(ret)%ni%"Attrition"],y=ret$Attrition)

logitmod<-glm(Class ~.,data=down_train,family = "binomial");

summary(logitmod)

res<- predict(logitmod,ret,type = "response")


cut_off <- seq(1:10)*.1

accuracy <- numeric()
false_pos <- numeric()
false_neg <- numeric()
Yes <- numeric()
No<- numeric()
for(i in cut_off) {
  t<-table(ActualValue=ret$Attrition,PredictValue=res>i)
  
  if(NCOL(t)>1){
    accuracy<-c(accuracy,(t[1,1]+t[2,2])/(t[1,1]+t[1,2]+t[2,1]+t[2,2]))
    false_pos<-c(false_pos,(t[2,1])/(t[1,1]+t[1,2]+t[2,1]+t[2,2]))
    false_neg<-c(false_neg,(t[1,2])/(t[1,1]+t[1,2]+t[2,1]+t[2,2]))
    Yes <- c(Yes,(t[2,2])/(t[2,1]+t[2,2]))
    No <- c(No,(t[1,1])/(t[1,1]+t[1,2]))
    
  }
  if(NCOL(t)==1){
    accuracy<-c(accuracy,(t[1,1])/(t[1,1]+t[2,1]))
    false_pos<-c(false_pos,(t[2,1])/(t[1,1]+t[2,1]))
    false_neg<-c(false_neg,0)
    Yes <- c(Yes,0)
    No <- c(No,(t[1,1])/(t[1,1]))
  }
}
result <- data.frame(cut_off,accuracy,false_pos,false_neg,Yes,No)
print(result)
write.xlsx(result,file = "emp.xlsx", sheet = "3", append = TRUE)

