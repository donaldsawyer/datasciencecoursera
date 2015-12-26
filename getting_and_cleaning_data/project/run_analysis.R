#install.packages("dplyr")
library(dplyr)

# Assume the working directory is set properly #
#setwd("C:\\ds\\git\\datasciencecoursera\\getting_and_cleaning_data\\project")

test.dir <- paste0(".", .Platform$file.sep, "uci_har_dataset", .Platform$file.sep, "test", .Platform$file.sep)
train.dir <- paste0(".", .Platform$file.sep, "uci_har_dataset", .Platform$file.sep, "train", .Platform$file.sep)



# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.

#### OBJECTIVE 1: merge test and training sets into a single data set ####
## MERGE THE SUBJECT DATA FROM TEST AND TRAINING SETS ##
test.subject = read.table(paste0(test.dir,"subject_test.txt"))
train.subject <- read.table(paste0(train.dir,"subject_train.txt"))
subject.data <- rbind(test.subject, train.subject)
rm(train.subject, test.subject) ## remove unused data ##
names(subject.data) <- "subject"

## MERGE THE ACTVITIES DATA (Y DATA) FROM TEST AND TRAINING SETS ##
test.y <- read.table(paste0(test.dir, "y_test.txt"))
train.y <- read.table(paste0(train.dir, "y_train.txt"))
activity.data <- rbind(test.y, train.y)
rm(test.y, train.y)
names(activity.data) <- "activity.id"

## MERGE THE MEASUREMENTS DATA (X DATA) FROM TEST AND TRAINING SETS ##
test.x = read.table(paste0(test.dir,"x_test.txt"))
train.x <- read.table(paste0(train.dir, "x_train.txt"))
measurement.data <- rbind(test.x, train.x)
rm(test.x, train.x)

#### OBJECTIVE 4: Appropriately labels the data set with descriptive variable names ####
## read variable names from features.txt file ##
features.txt <- read.table(paste0(".", .Platform$file.sep, "uci_har_dataset", .Platform$file.sep,"features.txt"))
## set the measurement data columns based on variable names (in 2nd column) ##
names(measurement.data) <- features.txt[,2]

#### OBJECTIVE 2: Extracts only the measurements on the mean and standard deviation for each measurement. ####
measurement.data <- measurement.data[, grepl("mean()", names(measurement.data)) | grepl("std()", names(measurement.data))]

#### OBJECTIVE 3: Uses descriptive activity names to name the activities in the data set ####
activity.labels <- read.table(paste0(".", .Platform$file.sep, "uci_har_dataset", .Platform$file.sep, "activity_labels.txt"))
names(activity.labels) <- c("activity.id", "activity.name")
activity.data <- left_join(activity.data, activity.labels, by="activity.id")

#### FINISH MERGING DATA FOR OBJECTIVE 1 ####
all.data <- cbind(subject.data, activity.data, measurement.data)

#### OBJECTIVE 5: From the data set in step 4, creates a second, independent tidy data set 
    ## with the average of each variable for each activity and each subject. ####
averaged.data <- all.data %>% group_by(subject, activity.id, activity.name) %>% summarise_each(funs(mean), -(1:3))
names(averaged.data)[-(1:3)] <- sapply(names(averaged.data)[-(1:3)], FUN=function(x) { paste0("Mean of ",x)})

