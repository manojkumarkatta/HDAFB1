raw.data <- read.csv("C:/Users/manoj kumar/Desktop/training/Regression/clustering/Online Retail CSV.csv")
data <- subset(raw.data, !is.na(raw.data$CustomerID))
data$InvoiceDate <- as.Date(data$InvoiceDate, "%d/%m/%Y")
data <- subset(data, InvoiceDate >= "2010-12-09")
data <- subset(data, Country == "United Kingdom")

data$item.returned <- grepl("C", data$InvoiceNo, fixed=TRUE)
data$item.considerinvoice <- ifelse(data$item.returned=="TRUE", 0, 1)
customers <- as.data.frame(unique(data$CustomerID))
names(customers) <- "CustomerID"
data$recency <- as.Date("2011-12-11") - as.Date(data$InvoiceDate)
temp <- subset(data, item.considerinvoice == 1)
recency <- aggregate(recency ~ CustomerID, data=temp, FUN=min, na.rm=TRUE)
remove(temp)
customers <- merge(customers, recency, by="CustomerID", all=TRUE, sort=TRUE)
remove(recency)
customers$recency <- as.numeric(customers$recency)
customer.invoices <- subset(data, select = c("CustomerID","InvoiceNo", "item.considerinvoice"))
customer.invoices <- unique(customer.invoices)
annual.invoices <- aggregate(item.considerinvoice ~ CustomerID, data=customer.invoices, FUN=sum,na.rm=TRUE)
names(annual.invoices)[names(annual.invoices)=="item.considerinvoice"] <- "frequency"
customers <- merge(customers, annual.invoices, by="CustomerID", all=TRUE, sort=TRUE)
remove(annual.invoices,customer.invoices)

customers <- subset(customers, frequency > 0)
data$Amount <- data$Quantity * data$UnitPrice
annual.sales <- aggregate(Amount ~ CustomerID, data=data, FUN=sum, na.rm=TRUE)
names(annual.sales)[names(annual.sales)=="Amount"] <- "monetary"
customers <- merge(customers, annual.sales, by="CustomerID", all.x=TRUE, sort=TRUE)
remove(annual.sales)
customers$monetary <- ifelse(customers$monetary < 0, 0, customers$monetary)

library(car)
library(rgl)
scatter3d(x = customers$frequency,
          y = customers$monetary,
          z = customers$recency,
          xlab = "Frequency",
          ylab = "Monetary Value",
          zlab = "Recency",
          point.col="red",
          axis.scales = FALSE,
          surface = FALSE,
          grid = FALSE,
          axis.col = c("black", "black", "black"))
library(ggplot2)
library(scales)
scatter.1 <- ggplot(customers, aes(x = frequency, y = monetary))
scatter.1 <- scatter.1 + geom_point(aes(colour = recency))
scatter.1

#to remove skewness
customers$recency.log<-log(customers$recency)
customers$frequency.log<-log(customers$frequency)
customers$monetary.log<-customers$monetary+0.1
customers$monetary.log<-log(customers$monetary.log)

library(car)
library(rgl)
scatter3d(x = customers$frequency.log,
          y = customers$monetary.log,
          z = customers$recency.log,
          xlab = "Log Frequency",
          ylab = "Log Monetary Value",
          zlab = "Log Recency",
          point.col="red",
          axis.scales = FALSE,
          surface = FALSE,
          grid = FALSE,
          axis.col = c("black", "black", "black"))
library(ggplot2)
library(scales)
scatter.1 <- ggplot(customers, aes(x = frequency.log, y = monetary.log))
scatter.1 <- scatter.1 + geom_point(aes(colour = recency.log))
scatter.1

#knn clustering
preprocessed<-customers[,c("recency.log","frequency.log","monetary.log")]
k<-3
output<-kmeans(preprocessed,centers = k, nstart = 20)
var.name<-paste("cluster_k",k,sep="_")
customers[,(var.name)]<-output$cluster
customers[,(var.name)]<-factor(customers[,(var.name)],levels = c(1:k))
library(plyr)
cluster_centers<-ddply(customers, .(customers[,(var.name)]),summarize,monetary=round(median(monetary),2),frequency=round(median(frequency),2),recency=round(median(recency),0),cl_count=length(recency.log))

#to rename the cluster column
names(cluster_centers)[names(cluster_centers)=="customers[,(var.name)]"]<-"Cluster"
cluster_centers
write.csv(cluster_centers,"RFM_Cluster",sheet=3,append = TRUE)
#3d graph
colors <- c('red','orange','green3','deepskyblue','blue','darkorchid4','violet','pink1','tan3','black') 
library(car)
library(rgl)
scatter3d(x = customers$frequency.log,
          y = customers$monetary.log,
          z = customers$recency.log,
          groups = customers$cluster_k_3,
          xlab = "Frequency (Log-transformed)", ylab = "Monetary Value (log-transformed)", zlab = "Recency (Log-transformed)", surface.col = colors,
          axis.scales = FALSE,
          surface = FALSE,
          ellipsoid = TRUE,
          grid = FALSE,
          axis.col = c("black", "black", "black"))

