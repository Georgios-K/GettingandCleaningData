# Getting and Cleaning Data Course Project

Data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Task:
You should create one R script called run_analysis.R that does the following:

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set.

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Solution (script is in run_analysis.R & codebook is in CodeBook.md):

Set working directory

Use read.table to read "UCI HAR Dataset" files 

Merge test and train data files using rbind

Use read table to Filter mean and standard deviation measurements from features.txt.

Use descriptive activity names to label data

Use cbind to combine the data in one file

Use ddply to produce averages for each activity and subject

Use write.table to output the new file.

# How to use
Execute in R Studio the following command:

source("run_analysis.R")
