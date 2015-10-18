# Getting and Cleaning Data Course Project  
# ========================================

To run the script run_analysis.R do:

1. read codebook.md for details
2. create folder "c:\r_dat"
3. download and extract data in "c:\r_dat"
4. run "run_analysis"

The script does:

* sets working directory and read in training and test files.
* merge the training and test sets to create one data set
* labels the data set according to **features.txt*´
* extracts only the measurements on the mean and standard deviation for each measurement; writes output file "tidy_mean_and_std_data.txt"
* uses descriptive activity names to name the activities in the data set 
* creates a second, independent tidy dataset with the average of each varable for each activity and each subject; writes output file "tidy_mean_act_group.txt"