# 
# Getting and Cleaning Data Course Project
# 
The purpose of this project is to obtain two tidy datasets from data collected
from the Samsung Galaxy S smartphone in the experiment:

"Human Activity Recognition Using Smartphones Data Set".

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using 
Smartphones. 21th European Symposium on Artificial Neural Networks, 
Computational Intelligence and Machine Learning, ESANN 2013. 
Bruges, Belgium 24-26 April 2013.

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Raw data:
The data for the project was downloaded from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
and uncompressed in the folder 'data'.

So the all the data files are in the subfolder "/data/UCI HAR Dataset/"
The file /data/UCI HAR Dataset/README.txt explains the contents

Files used:
- train/X_train.txt
- test/X_test.txt
- features.txt
- train/y_train.txt
- test/y_test.txt
- activity_labels.txt
- train/subject_train.txt
- test/subject_test.txt

Script file:
- run_analysis.R

Instructions for the script:
----------------------------
1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Explanation of what does the script:
------------------------------------
1.1. Loads X_train.txt and X_test.txt files without headers 
   and binds in one data frame 'x'
1.2. Loads features.txt without header in one data frame
1.3. Makes changes to the names of the features: 
1.4. Assigns the feature names to variable names of the data frame 'x'
1.5. Converts 'x' to a tibble 'xt' in order to use the dplyr package functions
   Note that .name_repair="universal" is used in order to ensure unique
   variable names because fbodyacc_bandsenergy* variables are duplicated
   
2. Creates a new tibble 'xts' selecting columns that contain the mean 
   and standard deviation
3.1 Loads y_train.txt and y_test.txt files without headers 
   and merges in one data frame 'y' and assigns the variable name.
   This data frame contains the activity code 
3.2 Creates a new tibble 'yt' from 'y'
3.2 Loads activity_labels.txt and assigns column names and creates a new tibble
3.3 Merges the labels and select only the variable name 'activity_name' which
    holds the descriptive name of the activity 
3.5 Binds the feature vector of means and standard deviations with the activity
   names in a new tibble 'result_step4'
4. Change the variable names of 'result_step_4'
5.1 Loads subject information files: subject_train.txt and subject_test.txt
    without headers and binds in a data frame 'subject' 
5.2 Assigns the column_name 'subject_id'
5.3 Creates a new tibble binding the feature-label tibble xt2 with the subject
5.4 Groups by activity_name and subject_id
5.5 And creates a new tibble 'result_step5'obtaining the mean of each variable
5.6 prefix each variable name (except activity_name and subject_id) with 'average_'