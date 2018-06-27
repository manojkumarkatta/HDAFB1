corr <- function(directory, threshold = 0) {
  filesList <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
  
  #ids<-nobs_table$id[nobs_table$nobs > threshold]
  cors <- numeric()
  
  for (i in 1:332) {
    data <- read.csv(filesList[i])
    
    if (sum(complete.cases(data)) > threshold) {
      cors <- c(cors, cor(sulfate,nitrate, use = "complete.obs"))
    }
  }
  return(cors)
}









if (sum(complete.cases(data)) > threshold) {
  cors <- c(cors, cor(data[["sulfate"]], data[["nitrate"]], use = "complete.obs"))