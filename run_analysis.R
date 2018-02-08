setwd("C:\\Users\\Ivy\\Google Drive\\DATA SCIENCE!!\\MODULE 3\\Week4")
getwd()


#download the required data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

#unzip the file to preferred place
path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files

setwd("C:\\Users\\Ivy\\Google Drive\\DATA SCIENCE!!\\MODULE 3\\Week4\\data\\UCI HAR Dataset")
getwd()




# STEP 1 - Merge the training and the test sets to create one data set

# Reading training tables
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")


#Reading test tables
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")


#Reading feature vector
features <- read.table("features.txt")


#Reading activity labels
activity_label <- read.table("activity_labels.txt")


#Assigning column names
colnames(X_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(X_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_label) <- c('activityId','activityType')



#Merging all data in one set
TRAIN <- cbind(y_train, subject_train, X_train)
TEST <- cbind(y_test, subject_test, X_test)
TESTandTRAIN <- rbind(mrg_train, mrg_test)




## STEP 2 - Extract only the measurements on the mean and standard deviation for each measurement

#Reading column names
colNames <- colnames(TESTandTRAIN)


#Vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
)


#Making nessesary subset from TESTandTRAIN
MeanAndStd <- TESTandTRAIN[ , mean_and_std == TRUE]


### STEP 3 - Use descriptive activity names to name the activities in the data set

ActivityNames <- merge(MeanAndStd, activity_label,
                              by='activityId',
                              all.x=TRUE)


#### STEP 4 - Appropriately label the data set with descriptive variable names

tidyDATA <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
tidyDATA <- tidyDATA[order(tidyDATA$subjectId, tidyDATA$activityId),]


##### STEP 5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

write.table(TidySet, "tidyDATA.txt", row.name=FALSE)