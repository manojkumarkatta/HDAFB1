best<-function(state,outcome){
  data<-read.csv("outcome-of-care-measures.csv",colClasses = "character")
  df<-data.frame(data[,2],data[,7],data[,11],data[,17],data[,23])
  health<-c("Hospital","State","Heart Attack","Heart Failure","Pneumonia")
  
  if(!state == df[,7]){
    stop("Invalid")
  }
  if (!outcome == c("Heart Attack","Heart Failure","Pneumonia")) {
    stop ("invalid outcome")
  }
  
  else {
    a <- which(df[, 7] == state)
    b <- df[a, ]   
    c <- as.numeric(b[, eval(outcome)])
    min_val <- min(c, na.rm = TRUE)
    result  <- b[, "hospital"][which(c == min_val)]
    output  <- result[order(result)]
  }
  return(output)
  }
  

