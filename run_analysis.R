#################
# Coursera Getting and Cleaning Data
# Course Project
#################

# The data used in this script was collected from the accelerometers from the Samsung Galaxy S smartphone
# Source:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(dplyr)

## 1. Merge the training and the test sets to create one data set.

# Read the data
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Add subject who performed the activity and labels
x_test <- cbind(x_test,y_test,subjects_test)
x_train <- cbind(x_train,y_train,subjects_train)

# Put testing and training sets together
x_all <- rbind(x_test,x_train)


## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Name columns so mean and std can be extracted
features <- read.table("UCI HAR Dataset/features.txt")
colnames(x_all) <- c(as.character(features$V2),"y","subjects")
colnames(x_all)

# Get all columns containing mean and standard deviation
mean_vals <- grep("mean",colnames(x_all))
std_vals <- grep("std",colnames(x_all))

# Create new dataframe from those
x_all_reduced <- data.frame(subjects = x_all$subjects, y = x_all$y, y_descriptive = NA)
x_all_reduced <- cbind(x_all_reduced,x_all[,c(mean_vals,std_vals)])
colnames(x_all_reduced)


## 3. Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
x_all_reduced$y_descriptive <- activity_labels[x_all_reduced$y,2]


## 4. Appropriately labels the data set with descriptive variable names. 

# The columns already have the descriptive measure names from the step 
# "Extract only the measurements on the mean and standard deviation for each measurement." 
# However, I will format them to comply with the style suggestions.

# Use underscore instead of minus
colnames(x_all_reduced) <- gsub("-", "_", colnames(x_all_reduced))

# Get rid of unnecessary brackets
colnames(x_all_reduced) <- gsub("()", "", colnames(x_all_reduced),fixed=TRUE)
colnames(x_all_reduced)


## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

x_all_reduced_tbl <- tbl_df(x_all_reduced)
x_all_reduced_tbl$y <- as.factor(x_all_reduced_tbl$y)
x_all_tidy <- group_by(x_all_reduced_tbl, subjects, y_descriptive) %>% summarise_each(c("mean"))

write.table(x_all_tidy, "submission_tidy_data.txt", row.name=FALSE)
