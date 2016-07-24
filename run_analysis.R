## load needed packages ##
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

## download data package ##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "Dataset.zip")
download.file(url, f, method = "curl", mode = wb)
dateDownloaded<-date()

## file needs to be unzipped
unzip(f)

# read individual files into R
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

#run check on each data table to test it loaded properly
dim(X_test)
dim(X_train)
dim(y_test)
dim(y_train)
dim(subject_test)
dim(subject_train)
dim(features)
dim(activity)

#bind the datasets together
Rawdata <- rbind(X_test,X_train)
ActivityID <- rbind(y_test,y_train)
subjectID <- rbind(subject_test,subject_train)

##extract columns with mean or std as header
Features_inc <- grep("-(mean|std)\\(\\)", features[, 2])
dim(Rawdata)
dim(ActivityID)
dim(subjectID)

#assign header name to the subjectID column
colnames(subjectID)<-"SubID"

#merging Activity labels with Y
library(plyr)
Activity <- join(ActivityID,activity)
Activity2 <- Activity[,2]
Activity2 <- data.frame(Activity2)
colnames(Activity2) <- "Activity_Label"

#label the "Rawdata" data
Raw <- Rawdata[,Features_inc]
names(Raw) <- gsub("\\(|\\)","",features$V2[Features_inc])

#complete data set made
Alldata <- cbind(subjectID,Raw,Activity2)
write.table(Alldata,"merged_Alldata.txt")

#calculate the mean and sd
library(data.table)
TidyData <- data.table(Alldata)
MeanSD <- TidyData[,lapply(.SD,mean), by=c("SubID","Activity_Label")]
write.table(MeanSD,"Getting_Cleaning_Data_Tidy_Data.txt", row.name=FALSE)