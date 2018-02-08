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


library(plyr)

# STEP 1 - Merge the training and the test sets to create one data set

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Merge X data
X_data <- rbind(X_train, X_test)

# Merge y data
y_data <- rbind(y_train, y_test)

# merge subject data
subject_data <- rbind(subject_train, subject_test)



## STEP 2 - Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")

# take the columns that has mean() or std() in their names
newfeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# take the subset of the desired column
X_data <- X_data[, newfeatures]

# correct the column names
names(X_data) <- features[newfeatures, 2]



# STEP 3 - Use descriptive activity names to name the activities in the data set

activity_label <- read.table("activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activity_label[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"



#### STEP 4 - Appropriately label the data set with descriptive variable names

# correct column name
names(subject_data) <- "subject"

# merge all data
all_data <- cbind(X_data, y_data, subject_data)


##### STEP 5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


averageDATA <- dlply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averageDATA, "tidyDATA.txt", row.name=FALSE)