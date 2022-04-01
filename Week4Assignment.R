#imports
library(dplyr)
library(data.table)
library(stringr)

#file paths
xtrain_path <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/train/X_train.txt"
ytrain_path <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/train/Y_train.txt"
subject_train <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/train/subject_train.txt"

xtest_path <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/test/X_test.txt"
ytest_path <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/test/Y_test.txt"
subject_test <- "C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/test/subject_test.txt"

features <- fread("C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/features.txt")
activityLabels <- fread("C:/Users/Wayne Mogel/Downloads/UCI HAR Dataset/activity_labels.txt")

features
activityLabels

xtrain_data <- fread(xtrain_path)
ytrain_data <- fread(ytrain_path)
subject_train_data <- fread(subject_train)

head(xtrain_data)
head(ytrain_data, 10)
head(subject_train_data)

xtest_data <- fread(xtest_path)
ytest_data <- fread(ytest_path)
subject_test_data <- fread(subject_test)

#Change the column names for train data
colnames(xtrain_data) <- features$V2
colnames(ytrain_data) <- "activityID"
colnames(subject_train_data) <- "subjectID"

#Change the column names for test data
colnames(xtest_data) <- features$V2
colnames(ytest_data) <- "activityID"
colnames(subject_test_data) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityLabel")

activityLabels

#merge data together
merge_train <- cbind(ytrain_data, subject_train_data, xtrain_data)
merge_test <- cbind(ytest_data, subject_test_data, xtest_data)

head(merge_train, 10)
head(merge_test, 10)

merge_all <- rbind(merge_train, merge_test)

head(merge_all, 10)

#getting the mean and std
columns <- colnames(merge_all)
mean_std <- (grepl("activityId" , columns) | grepl("subjectId" , columns) | grepl("mean.." , columns) | grepl("std.." , columns))

subMeanStd <- merge_all[, mean_std == TRUE]

head(subMeanStd, 10)
