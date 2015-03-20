## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each

library(data.table)
library(plyr)
## Get the data file adn unzip

if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read the files into variables
path <- file.path("./data" , "UCI HAR Dataset")
activityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
subjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
featuresTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)


##1. Merges the training and the test sets to create one data set
## Concatenate the data tables by rows
subject <- rbind(subjectTrain, subjectTest)
activity<- rbind(activityTrain, activityTest)
features<- rbind(featuresTrain, featuresTest)

##set names to variables
names(subject)<-c("subject")
names(activity)<- c("activity")
featureHeadings <- read.table(file.path(path, "features.txt"),head=FALSE)
names(features)<- featureHeadings$V2  ## just take the column with the headings

##Merge columns to get the data frame Data for all data
df <- cbind(features,subject, activity)


##2. Extracts only the measurements on the mean and standard deviation for each measurement
##Subset Name of Features by measurements on the mean and standard deviation
measurementsDF<-featureHeadings$V2[grep("mean\\(\\)|std\\(\\)", featureHeadings$V2)]

##Pull the columns of activity and subject data
subsetHeadings<-c(as.character(measurementsDF), "subject", "activity" )
df<-subset(df,select=subsetHeadings)

##Uses descriptive activity names to name the activities in the data set
currentActivityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

##Features will labelled using descriptive variable names.

names(df)<-gsub("^t", "time", names(df))
names(df)<-gsub("^f", "frequency", names(df))
names(df)<-gsub("Acc", "Accelerometer", names(df))
names(df)<-gsub("Gyro", "Gyroscope", names(df))
names(df)<-gsub("Mag", "Magnitude", names(df))
names(df)<-gsub("BodyBody", "Body", names(df))

## Creates a second,independent tidy data set and ouput it
tidy_dt <- data.table(df)
tidy_dt <- tidy_dt[, lapply(.SD, mean), by = 'subject,activity']
write.table(tidy_dt, file = "tidy_data.txt", row.names = FALSE)
