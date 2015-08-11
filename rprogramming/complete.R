complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  for(i in id) {
    file <- paste(directory,"/",sprintf("%03d",i),".csv",sep="")
    d <- read.csv(file, header=TRUE)
    obs <- d[!is.na(d$sulfate) & !is.na(d$nitrate),]

    if(!exists("nn")) {
      nn <- data.frame(id=i, nobs=length(obs$ID))
    } else {
      nn <- rbind(nn, data.frame(id=i, nobs=length(obs$ID)))
    }
  }
  nn
}