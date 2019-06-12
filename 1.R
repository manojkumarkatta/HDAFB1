library("xlsx")
ret<-read_excel("Employee_Attrition_Dataset_Problem.xlsx", sheet = "Dataset")
View(ret)
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

glm_model<-glm(Attrition ~.,data=ret,family = "binomial");
glm_prob<- predict(glm_model,type = "response")
res<- predict(glm_model,ret,type = "response")
#create cut_off range
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
write.xlsx(result,file = "emp.xlsx", sheet = "1", append = TRUE)
  
