data("flights", package = "nycflights13")
no <- vector("list", ncol(flights))
names(no) <-  names(flights)
for (i in names(flights)){
  no[[i]] <-  class(flights[[i]])
}
no
