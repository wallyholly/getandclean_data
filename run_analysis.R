#run_analysis.R takes in the raw data collected from subjects' Samsung Galaxy S
#smartphone accelerometers and ouputs a second, independent "tidy" dataset with
#the average of each variable for each activity and each subject
#get package dplyr

library("dplyr")
library("stringr")


#####################################################################################
# 0. set working directory and read in training and test files;                     #
# we ignore the inertial folder;                                                    #
# The subject IDs are in the variable "subjID"; The activity labels are in variable #
# "actLabels"                                                                       #
#####################################################################################

#################
#training files #
#################
setwd("c:/r_dat/getdata_projectfiles_UCI HAR Dataset/UCI Har Dataset/train")
subject_train = read.table("subject_train.txt", col.names=c("subjID"))
X_train = read.table("X_train.txt")              
y_train = read.table("y_train.txt", col.names=c("actLabels"))

#################
#test files     #
#################
setwd("..")
setwd("./test")
subject_test = read.table("subject_test.txt",col.names=(c("subjID")))
X_test = read.table("X_test.txt")
y_test = read.table("y_test.txt",col.names=c("actLabels"))



################################################################################
#1. merge the training and test sets to create one data set: we first combine  #
#the subject, activity and X_train sets: our 1st column is subject ("subjID"), #
#2nd column is activity ("actLabels")                                          #
################################################################################

subject.y.train = cbind(subject_train,y_train)
training_data = cbind(subject.y.train, X_train)

subject.y.test = cbind(subject_test,y_test)
test_data = cbind(subject.y.test, X_test)

total_data = rbind(training_data, test_data)

################################################################################
#2. Appropriately labels the data set with descriptive variable names; here we #
#follow the convention set in Week 4 Lecture editing text variables. Therefore,#
#all variable names are lower case when possible, descriptive and have no under#
#scores, dots, or white spaces.                                                #
#Here we use the variable names presented in the features.txt file and add the #
#subject ID and activity labels at the very beginning of the vector. The names #
#in features.txt are somehow messed up by parantheses, commas and -, so we'll  #
#have to clean them up using str_replace from the stringr package.             #
#Due to the length of variable names I have used                               #
#camel case to make them more readable.                                        #
################################################################################

features <- read.table("C:/R_dat/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
features$V2<-str_replace(features$V2,"\\(","")  # remove "("
features$V2<-str_replace(features$V2,"\\)","")  # remove "("
features$V2<-str_replace(features$V2,",","")    # remove ","
features$V2<-str_replace(features$V2,"-","")    # remove "-"

features<-make.names(c("subjID","actLabels", features$V2),unique=TRUE,allow_=FALSE)
names(total_data) = features

################################################################################
#3. Extracts only the measurements on the mean and standard deviation for each #
#measurement. After using the features.txt file for naming the variables, we   #
#keep only these variables with the expression "[Mm]ean" or "[Ss]td"           #
################################################################################

mean_std_data<-select(total_data, 1:2, contains("Mean"), contains("Std"))

################################################################################
#4. Uses descriptive activity names to name the activities in the data set     #
#and write file to disk                                                        #
################################################################################

mean_std_data_act<-mutate(mean_std_data,activities = ifelse(actLabels == 1, "WALKING", 
                        ifelse(actLabels == 2, "WALKING_UPSTAIRS", 
                        ifelse(actLabels == 3, "WALKING_DOWNSTAIRS", 
                        ifelse(actLabels == 4, "SITTING",
                        ifelse(actLabels == 5, "STANDING","LAYING"))))))

write.table(mean_std_data_act, "c://r_dat/tidy_mean_and_std_data.txt",row.names=FALSE)

###################################################################################
#5. Create a second, independent tidy dataset with the average of each variable   #
#for each activity and each subject:                                              #
#Result:                                                                          #
#Data Set "mean_act_group", with 180 rows (i.e.30 subjects x 6 activities)        #
###################################################################################

mean_act_group = mean_std_data_act %>% group_by(subjID,activities) %>% summarise_each(funs(mean))
write.table(mean_act_group, "c://r_dat/tidy_mean_act_group.txt",row.names=FALSE)