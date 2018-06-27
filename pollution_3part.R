corelation <- function(directory, threshold = 0) {
  filelist <- list.files(directory, full.names = TRUE)
  nobs_table <- complete("specdata",1:332)
  ids<-nobs_table$id[nobs_table$nobs > threshold]
  cr <- numeric()
  
  for (i in ids) {
    data <- read.csv(filelist[i])
    
      cr <- c(cr, cor(data$sulfate,data$nitrate, use="complete.obs"))
    }
  return(cr)
}