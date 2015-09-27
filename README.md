# Coursera Getting and Cleaning Data
## Course Project

The data used in this repo was collected from the accelerometers from the Samsung Galaxy S smartphone

Source:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The repo contains:

- run_analysis.R:

    A script that 
    1. merges the training and the test sets to create one data set.
    2. extracts only the measurements on the mean and standard deviation for each measurement. 
    3. uses descriptive activity names to name the activities in the data set
    4. appropriately labels the data set with descriptive variable names. 
    5. from the data set in step 4, creates a second, independent tidy data set with the average of each variable for                         each activity and each subject.


    A more detailed description on the steps is directly in the script.
    
- submission_tidy_data.txt:

    The data set from step 5 in run_analysis.R

- codebook.pdf:

    The codebook explaining the dataset submission_tidy_data.txt

- readme.md:

    This file