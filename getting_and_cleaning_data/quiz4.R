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
length(grep("^United", q4q2.data$X.3[1:190]))

#QUESTION 4#
q3.gdp.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
q3.gdp.csv <- "q3q3_gdp.csv"
download.file(q3.gdp.url, destfile = q3.gdp.csv)
head(read.csv(q3.gdp.csv))
q3.gdp.data <- read.csv(q3.gdp.csv, skip=5, header = FALSE, stringsAsFactors = FALSE) %>% select(1:5)
#str(q3.gdp.data$V2)
names(q3.gdp.data) <- c("economy", "ranking", "blank1", "name", "us.dollars")
levels(q3.gdp.data$economy)
q3.gdp.data <- q3.gdp.data[q3.gdp.data$economy != "" & q3.gdp.data$ranking != "", ]
q3.gdp.data$ranking <- as.numeric(q3.gdp.data$ranking)

q3.edu.url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
q3.edu.csv <- "q3q3_edu.csv"
download.file(q3.edu.url, destfile = q3.edu.csv)
#head(read.csv(q3.edu.csv))
q3.edu.data <- read.csv(q3.edu.csv)
q3.edu.data <- q3.edu.data[q3.edu.data$CountryCode != "", ]
q3.joined <- inner_join(q3.gdp.data, q3.edu.data, by=c("economy"="CountryCode"))
head(q3.joined)
fiscal.years <- grep("Fiscal year end: June", ignore.case = TRUE, q3.joined$Special.Notes)
length(fiscal.years)

#QUESTION 5#
install.packages("quantmod")
library(quantmod)
install.packages("lubridate")
library(lubridate)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes <- index(amzn)
sampleTimes.2012 <- sampleTimes[year(sampleTimes) == 2012]
length(sampleTimes.2012)
wday(sampleTimes.2012)
wday(as.Date("1/1/2016"))
length(sampleTimes.2012[wday(sampleTimes.2012) == 2])
