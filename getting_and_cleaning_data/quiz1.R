setwd("C:\\ds\\git\\datasciencecoursera\\getting_and_cleaning_data")

#install.packages()
library(data.table)
install.packages("xlsx")
library(xlsx)

setwd("C:\\ds\\git\\datasciencecoursera\\getting_and_cleaning_data")
housing.csv <- "quiz1_question1_data.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile=housing.csv)
dateDownloaded = date()

housing.data <- read.table(housing.csv, sep=",", header=TRUE, na.strings = "00")
head(housing.data)
names(housing.data)
dim(housing.data[,housing.data$VAL==24])
length(housing.data[housing.data$VAL>=24,"VAL"])
head(housing.data$VAL)
length(housing.data[housing.data$VAL == 24 & !is.na(housing.data$VAL), "VAL"])
head(housing.data$FES)


natgas.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
natgas.xlsx <- "natural_gas.xlsx"
download.file(natgas.url, destfile=natgas.xlsx, method="curl")
colIndex <- 7:15
rowIndex <- 18:23

natgas.data <- read.xlsx(natgas.xlsx, sheetIndex=1, header=TRUE, rowIndex=rowIndex, colIndex=colIndex)
dat <- natgas.data
sum(dat$Zip*dat$Ext,na.rm=T)
str(natgas.data)

library(XML)
restaurants.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
restaurants.xml <- "restuarants.xml"
download.file(restaurants.url, dest=restaurants.xml)
restaurants.data <- xmlTreeParse(restaurants.xml, useInternal=TRUE)
names(xmlRoot(restaurants.data))
rootNode <- xmlRoot(restaurants.data)
xmlName(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode[[1]])
rootNode[[1]]
zipcodes <- xpathSApply(rootNode[[1]], "//zipcode", xmlValue)
length(zipcodes[zipcodes == "21231"])

housing.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
housing.csv <- "housing.csv"
download.file(housing.url, dest=housing.csv)
DT <- fread(housing.csv)
mean(replicate(100, system.time(DT[,mean(pwgtp15),by=SEX], gcFirst = TRUE)[1]))
system.time({replicate(200, DT[,mean(pwgtp15),by=SEX]);})
system.time(replicate(200, {rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2];}))
system.time({replicate(200, {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15);})})
system.time({replicate(200, tapply(DT$pwgtp15,DT$SEX,mean))})
system.time({replicate(200, mean(DT$pwgtp15,by=DT$SEX))})
system.time({replicate(200, sapply(split(DT$pwgtp15,DT$SEX),mean))})


system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2];}, gcFirst = TRUE)
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15);}, gcFirst = TRUE)
system.time(tapply(DT$pwgtp15,DT$SEX,mean), gcFirst = TRUE)
system.time(mean(DT$pwgtp15,by=DT$SEX), gcFirst = TRUE)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean), gcFirst = TRUE)

DT[,mean(pwgtp15),by=SEX]
{rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2];}
{mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15);}
tapply(DT$pwgtp15,DT$SEX,mean)
mean(DT$pwgtp15,by=DT$SEX)
sapply(split(DT$pwgtp15,DT$SEX),mean)
