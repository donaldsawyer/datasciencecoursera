#setwd("C:/ds/Learning/DataScience_Specialization/R/week1/specdata")
#expected.count <- 772087L
# directory <- "C:/ds/Learning/DataScience_Specialization/R/week1/specdata"
# pollutant <- c("sulfate")
# id <- 1:332

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  rowcount <- 0
  
  #load all files with the ids in the directory
  for(i in id) {
    file <- paste(directory,"/",sprintf("%03d",i),".csv",sep="")
      
    if(!exists("agg.data")) {
      agg.data = read.csv(file, header=TRUE) 
    } else {
      newdata <- read.csv(file, header=TRUE)
      agg.data <- rbind(agg.data, newdata)
    }
  }
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  return(mean(agg.data[,pollutant], na.rm=TRUE))
}

