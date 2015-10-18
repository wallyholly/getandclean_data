# ORIGINAL DATA

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# IMPORTANT: DOWNLOAD AND EXTRACT DATA IN PATH C:\R_DAT ! CREATE PATH IF NECESSARY!

# Program name: run_analysis.R 

# Transformations: in detail the program...
0. sets working directory and read in training and test files. It ignores the inertial folder!
The subject IDs are in the variable "subjID"; The activity labels are in variable "actLabels"                                                                       
1. merge the training and test sets to create one data set: we first combine the subject, activity and X_train sets: our 1st column is subject ("subjID"), 2nd column is activity ("actLabels")                                          #
2. appropriately labels the data set with descriptive variable names; here we use the variable names presented in the features.txt file and add the subject ID and activity labels at the very 
beginning of the vector. The names in features.txt are somehow messed up.  remove special characters as ( ' -, ´
3. extracts only the measurements on the mean and standard deviation for each measurement. After using the features.txt file for naming the variables, we keep only these variables with the expression "[Mm]ean" or "[Ss]td"
4. uses descriptive activity names to name the activities in the data set 
5. creates a second, independent tidy dataset with the average of each varable for each activity and each subject

# Physical data sets created by the program
1. ** tidy_mean_and_std_data.txt ** after transformation-step 3. of the program
2. ** tidy_mean_act_group.txt **    after transformation-step 5. of the program 

# Variables
In short:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample.
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt' in
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
