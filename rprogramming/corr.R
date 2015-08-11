corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  for(file in list.files(directory)) {

    #file <- paste(directory,"/",sprintf("%03d",i),".csv",sep="")
    d <- read.csv(paste(directory,"/",file, sep=""), header=TRUE)
    obs <- d[!is.na(d$sulfate) & !is.na(d$nitrate) ,]
    
    if(length(obs$sulfate) > threshold) {
      if(!exists("monitor.cors")) {
        monitor.cors <- cor(obs$sulfate, obs$nitrate)
      } else {
        monitor.cors <- append(monitor.cors, cor(obs$sulfate, obs$nitrate))
      }
    }
  }
  if(!exists("monitor.cors")) {
    vector(mode="numeric")
  } else {
    monitor.cors
  }
}