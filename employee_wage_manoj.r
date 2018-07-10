library(readxl)
 for(i in 1:3){
    Sheet<- paste("Sheet",i,sep="")
    print(paste("-------------Prob",i,"------------"),sep="")
    first <-read_excel("Employee Wage Comparision_Manoj.xlsx", sheet = Sheet)
    first$Gender<- as.factor(first$Gender)
    first$Company<-as.factor(first$Company)
    model1<- lm(Salary ~ Company*Gender,data=first)
    print(anova(model1))
    myanova <- anova(model1)
    print(cbind(myanova, 'CriticalValue' = qf(0.95,1,16)))
}
  
