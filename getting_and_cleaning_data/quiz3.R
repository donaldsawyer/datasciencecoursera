library(dplyr)
setwd("c:/ds/git/datasciencecoursera/getting_and_cleaning_data/")
list.files()

# Question 1 #
q1.data <- read.csv("quiz3_1.csv")
names(q1.data)

# > 10 acres (ACR = 3)
# agricultureLogical = sold > $10,000 of agriculture products (AGS = 6)
agriculturalLogical <- q1.data$ACR == 3 & q1.data$AGS == 6
q1.data[which(agriculturalLogical), ]

# QUESTION 2 #
install.packages("jpeg")
library(jpeg)
image.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(image.url, destfile="q3q2.jpg", mode="wb")
jpg.data <- readJPEG("q3q2.jpg", native = TRUE)
quantile(jpg.data, probs=seq(0, 1, by=0.1))

# QUESTION 3 #
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
q3.joined$ranking <- as.numeric(q3.joined$ranking)
q3.joined <- q3.joined %>% arrange(desc(ranking))
q3.joined[13, "name"]

# QUESTION 4 #
mean(q3.joined[q3.joined$Income.Group == "High income: OECD", "ranking"])
mean(q3.joined[q3.joined$Income.Group == "High income: nonOECD", "ranking"])

# QUESTION 5 #
install.packages("reshape")
library("reshape")
quantile(q3.joined$ranking, probs = seq(0,1, by=0.2))
table(q3.joined[q3.joined$ranking < 39, "Income.Group"])

