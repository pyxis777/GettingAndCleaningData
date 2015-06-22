# GettingAndCleaningData
Course Project


This project contains one R script called run_analysis.R that merges the test and training datasets from the following dataset into a "tidy" dataset

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R 
   1. Merges the training and the test sets to create one data set.

   2. Extracts only the measurements on the mean and standard deviation for each measurement. 

   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names. 
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script should be sourced from the top level directory of the dataset referenced above (UCI HAR Dataset).

The script will create the following results files in the top level directory of the level directory of the dataset referenced above: 

tidyTestAndTraining.txt - this dataset is the result of steps 1-4 above
Each row of the new data set has a row_name of the format: 
row index_subject id_activity


tidySubjectActivitySummary.txt - this dataset is the result of step 5 above
Each row of the new data set has a row_name of the format: 
subject id_activity

