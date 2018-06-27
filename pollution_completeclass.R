complete <- function(directory, pollutant, id = 1:332) {
  allfiles <- list.files(directory, full.names = TRUE)
  all_data <- do.call(rbind,lapply(allfiles,read.csv))
  #result<-(all_data[complete.cases(all_data),is.na(all_data),by=ID])
return(all_data[complete.cases(all_data),.(nobs= .N),by=id)
}

