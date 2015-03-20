# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
library(plyr)
# set working directory
setwd("C://Users//kanakisg//Documents//R//UCI HAR Dataset//")

# Merges the training and the test sets to create one data set.....:
# For Activity combine “Y_train.txt” and “Y_test.txt”
# For Subject combine “subject_train.txt” and subject_test.txt"
# For Features combine “X_train.txt” and “X_test.txt”
# rbind will be used to to merge 

Activity_train <- read.table("train/X_train.txt",header = FALSE)
Activity_test <- read.table("test/X_test.txt",header = FALSE)
Activity_all <- rbind(Activity_train, Activity_test)

Subject_train <- read.table("train/subject_train.txt",header = FALSE)
Subject_test <- read.table("test/subject_test.txt",header = FALSE)
Subject_all <- rbind(Subject_train, Subject_test)

Features_train <- read.table("train/y_train.txt",header = FALSE)
Features_test <- read.table("test/y_test.txt",header = FALSE)
Features_all <- rbind(Features_train, Features_test)

# Extracts only the measurements on the mean and standard deviation for each measurement.....: 
# features.txt contains all measurements names. We need to locate all the 'std' and 'mean' ones.
# function grep is used to locate them 

Features_names <- read.table("features.txt",header = FALSE)
Features_names_subset <- grep("-mean\\(\\)|-std\\(\\)", Features_names[, 2])
Activity_all <- Activity_all[, Features_names_subset ]
names(Activity_all) <- Features_names[Features_names_subset , 2]
names(Activity_all)<-gsub("^t", "time", names(Activity_all))
names(Activity_all)<-gsub("^f", "frequency", names(Activity_all))
names(Activity_all)<-gsub("Acc", "Accelerometer", names(Activity_all))
names(Activity_all)<-gsub("Gyro", "Gyroscope", names(Activity_all))
names(Activity_all)<-gsub("Mag", "Magnitude", names(Activity_all))
names(Activity_all)<-gsub("BodyBody", "Body", names(Activity_all))


# Uses descriptive activity names to name the activities in the data set....
# After reading activity labels (tmp), Features_all is updated with the descriptive activity names 
# and column is labeled 'Activity'

tmp <- read.table("activity_labels.txt")
tmp[, 2] = as.character(tmp[, 2])
Features_all[,1] = tmp[Features_all[,1], 2]
names(Features_all) <- "Activity"

# Appropriately labels the data set with descriptive activity names.....
# First Name Subject_all and then use function cbind to combine data 

names(Subject_all) <- "Subject"
clean_data <- cbind(Subject_all, Features_all, Activity_all)

# Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.....#library(plyr);
# Use function ddply to aggragate

clean_data_avg = ddply(clean_data, c("Subject","Activity"), numcolwise(mean))
write.table(clean_data_avg, "clean_data_avg.txt", row.name=FALSE)


