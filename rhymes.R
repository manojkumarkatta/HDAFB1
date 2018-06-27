rhymes <- c("Ten", "Nine", "Eight", "Seven", "Six", "Five",
             "Four", "Three", "Two", "One")
for (i in rhymes) {
  if(i == "Ten"){
    cat("Here we go!")
    cat("\n")
  }
  else
  {
    cat(stringr::str_c(i,"!"))
    cat("\n")
  }

   cat(stringr::str_c("There were ", i, " in the bed\n"))
  cat("and the little one said,\n")
  if (i == "One") {
    cat("I'm lonely...[sigh].")
    cat("\n")
  } 
  else {
    cat("Roll over, roll over.\n")
    
  cat("So they all rolled over and one fell out.\n")
  }
  cat("\n")
}
