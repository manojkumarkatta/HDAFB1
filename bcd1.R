train <- read_excel("./Breast_Cancer_Dataset.xlsx", sheet = "Train")
model<-glm(type~.,data = train,family = "binomial")
summary(model)
res<-predict(model,data = train,type = "resonse")
(table(Actualvalue=data$train,type="response")
  