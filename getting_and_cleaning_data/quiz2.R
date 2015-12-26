setwd("C:\\ds\\git\\datasciencecoursera\\getting_and_cleaning_data")

#install.packages("httr")
#install.packages("httpuv")
#install.packages("rjson")
library(httpuv)
library(httr)
library(rjson)


## Question 1 ##
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "3a3dad5b21a6bb78aa59",
                   secret = "6fd7a1d6fe0dac88ac195ac888939049c4588a1f")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=TRUE)

token <- config(token = github_token) 
req <- GET("https://api.github.com/users/jtleek/repos", token) 
stop_for_status(req) 
content(req) 
content(req)[[1]]

json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[json2$name == 'datasharing', "created_at"]


## Question 2 & 3 ##
install.packages("sqldf")
library(sqldf)
q2.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
q2.csv <- "q2.csv"
download.file(q2.url, destfile = q2.csv)
acs <- read.csv(q2.csv, header=TRUE)
## sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")
unique(acs$AGEP) == sqldf("select distinct AGEP from acs")

## Question 4 ##
q4.url="http://biostat.jhsph.edu/~jleek/contact.html"
q4.con <- url(q4.url)
q4.html <- readLines(q4.con)
close(q4.con)
q4.html
q4.html[1]
nchar(q4.html[10])
nchar(q4.html[20])
nchar(q4.html[30])
nchar(q4.html[100])

## Question 5 ##
q5.url = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
install.packages("foreign")
library(foreign)
download.file(q5.url, destfile = "q2_q5.for")
q5.data <- read.fwf("q2_q5.for", header=FALSE, skip=4, widths = c(15,4,1,3,5,4,1,3,5,4,1,3,5,4,1,3))
sum(q5.data$V6)
