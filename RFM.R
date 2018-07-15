raw<-read.csv("C:/Users/manoj kumar/Desktop/training/Regression/clustering/Online Retail CSV.csv")
head(raw)
cus<- raw[complete.cases(raw$CustomerID), ]
cus$InvoiceDate<-as.Date(cus$InvoiceDate,format = "%m/%d/%y")
cus <- cus[cus$InvoiceDate >= "2010/12/09" & cus$InvoiceDate <= "2011/12/09"]
cus<-subset(cus,Country == "United Kingdom")
cus$item.returned <- grepl("C", cus$InvoiceNo, fixed=TRUE)
cus$item.considerinvoice <- ifelse(cus$item.returned=="TRUE", 0, 1)
#recency
customers <- as.data.frame(unique(cus$CustomerID))
names(customers) <- "CustomerID"
cus$recency <- as.Date("11/12/2011") - as.Date(cus$InvoiceDate)
temp <- subset(cus, item.considerinvoice == 1)
recency <- aggregate(recency ~ CustomerID, data=temp, FUN=min, na.rm=TRUE)
remove(temp)customers <- merge(customers, recency, by="CustomerID", all=TRUE, sort=TRUE)
remove(recency)
#frequency
customer.invoices <- subset(cus, select = c("CustomerID","InvoiceNo", "item.considerinvoice"))
customer.invoices <- unique(customer.invoices)
annual.invoices <- aggregate(item.considerinvoice ~ CustomerID, data=customer.invoices, FUN=sum,
                             na.rm=TRUE)
names(annual.invoices)[names(annual.invoices)=="item.considerinvoice"] <- "frequency"
customers <- merge(customers, annual.invoices, by="CustomerID", all=TRUE, sort=TRUE)
remove(annual.invoices,customer.invoices)
customers <- subset(customers, frequency > 0)
#monetary_value
cus$Amount <- cus$Quantity * cus$UnitPrice
annual.sales <- aggregate(Amount ~ CustomerID, data=data, FUN=sum, na.rm=TRUE)
names(annual.sales)[names(annual.sales)=="Amount"] <- "monetary"
customers <- merge(customers, annual.sales, by="CustomerID", all.x=TRUE, sort=TRUE)
remove(annual.sales)

customers$monetary <- ifelse(customers$monetary < 0, 0, customers$monetary)