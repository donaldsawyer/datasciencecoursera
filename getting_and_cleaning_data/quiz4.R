library(stringr)
setwd("c:/ds/git/datasciencecoursera/getting_and_cleaning_data")

#QUESTION 1#
#codebook: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf #
q4q1.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q4q1.csv <- "q3q1.csv"
download.file(q4q1.url, q4q1.csv)
q4q1.data <- read.csv(q4q1.csv)
head(q4q1.data)
strsplit(names(q4q1.data), "wgtp")[123]

#QUESTION 2#
q4q2.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
q4q2.csv <- "q4q2.csv"
download.file(q4q2.url, destfile = q4q2.csv)
q4q2.data <- read.csv(q4q2.csv, skip=4)
head(q4q2.data)
?sub
q4q2.data$revenue <- sapply(q4q2.data$X.4, FUN=function(x) { as.numeric(gsub(",", "", x))})
mean(q4q2.data$revenue[1:190])

#QUESTION 3#
grep("^United", q4q2.data$X.3[1:190])
