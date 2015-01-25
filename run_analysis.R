# UCI HAR Dataset is set as the Working Directory

# Load the required packages - Install them in case they don't exist using install.packages("<package_name>")
library(plyr)
library(reshape)

# Reading the files
feature_test <- read.table('./test/X_test.txt')
activity_test <- read.table('./test/y_test.txt')
subject_test <- read.table('./test/subject_test.txt')
feature_train <- read.table('./train/X_train.txt')
activity_train <- read.table('./train/y_train.txt')
subject_train <- read.table('./train/subject_train.txt')
activity_labels <- read.table('activity_labels.txt')
features <- read.table('features.txt')

# Subsetting the features which contain mean and std in their names
mean_features <- features[grep("mean", features$V2),]$V1
std_features <- features[grep("std", features$V2),]$V1
subset_features <- c(mean_features, std_features)

#For the activity_test and activity_train data, fetch the corresponding labels
activity_test_labels <- join(activity_test,activity_labels,by="V1")
activity_train_labels <- join(activity_train,activity_labels,by="V1")

#Rename the subject_test and subject_train columns
names(subject_test) <- "Subject"
names(subject_train) <- "Subject"

#Create subsetted training and test data sets
test_subset <- cbind(feature_test[,subset_features],activity_test_labels$V2,subject_test)
train_subset <- cbind(feature_train[,subset_features],activity_train_labels$V2,subject_train)

#Rename the activity label columns to merge easily
test_subset <- rename(test_subset, replace= c("activity_test_labels$V2" = "Activity"))
train_subset <- rename(train_subset, replace= c("activity_train_labels$V2" = "Activity"))

#Create the initial tidy data set
initial_tidy_dataset <- rbind(test_subset,train_subset)

#Rename all the columns appropriately
names(initial_tidy_dataset) <- c("X Component of Mean Body Acceleration - Time Signal", "Y Component of Mean Body Acceleration - Time Signal", "Z Component of Mean Body Acceleration - Time Signal", "X Component of Mean Gravitational Acceleration - Time Signal",
                                 "Y Component of Mean Gravitational Acceleration - Time Signal", "Z Component of Mean Gravitational Acceleration - Time Signal", "X Component of Mean Body Jerk Acceleration - Time Signal",
                                 "Y Component of Mean Body Jerk Acceleration - Time Signal","Z Component of Mean Body Jerk Acceleration - Time Signal", 
                                 "X Component of Mean Body Angular Velocity - Time Signal","Y Component of Mean Body Angular Velocity - Time Signal", "Z Component of Mean Body Angular Velocity - Time Signal",
                                 "X Component of Mean Body Jerk Angular Velocity - Time Signal", "Y Component of Mean Body Jerk Angular Velocity - Time Signal", "Z Component of Mean Body Jerk Angular Velocity - Time Signal",
                                 "Mean Body Acceleration Magnitude - Time Signal","Mean Gravity Acceleration Magnitude - Time Signal", "Mean Body Jerk Acceleration - Time Signal",
                                 "Mean Body Angular Velocity - Time Signal", "Mean Body Jerk Angular Velocity - Time Signal", 
                                 "X Component of Mean Body Acceleration - Frequency Signal", "Y Component of Mean Body Acceleration - Frequency Signal", "Z Component of Mean Body Acceleration - Frequency Signal",
                                 "X Component of Mean Frequency of Body Acceleration - Frequency Signal", "Y Component of Mean Frequency of Body Acceleration - Frequency Signal", "Z Component of Mean Frequency of Body Acceleration - Frequency Signal",
                                 "X Component of Mean Body Jerk Acceleration - Frequency Signal", "Y Component of Mean Body Jerk Acceleration - Frequency Signal", "Z Component of Mean Body Jerk Acceleration - Frequency Signal",
                                 "X Component of Mean Frequency of Mean Body Jerk Acceleration - Frequency Signal", "Y Component of Mean Frequency of Mean Body Jerk Acceleration - Frequency Signal", "Z Component of Mean Frequency of Mean Body Jerk Acceleration - Frequency Signal",
                                 "X Component of Mean Body Angular Velocity - Frequency Signal", "Y Component of Mean Body Angular Velocity - Frequency Signal", "Z Component of Mean Body Angular Velocity - Frequency Signal",
                                 "X Component of Mean Frequency of Mean Body Angular Velocity - Frequency Signal", "Y Component of Mean Frequency of Mean Body Angular Velocity - Frequency Signal", "Z Component of Mean Frequency of Mean Body Angular Velocity - Frequency Signal",
                                 "Mean Body Acceleration Magnitude - Frequency Signal", "Mean Frequency of Body Acceleration Magnitude - Frequency Signal","Mean Body Jerk Acceleration Magnitude - Frequency Signal","Mean Frequency of Mean Body Jerk Acceleration Magnitude - Frequency Signal",
                                 "Mean Body Angular Velocity Magnitude - Frequency Signal", "Mean Frequency of Body Angular Velocity Magnitude - Frequency Signal","Mean Body Jerk Angular Velocity Magnitude - Frequency Signal","Mean Frequency of Mean Body Jerk Angular Velocity Magnitude - Frequency Signal",
                                 "X Component of Standard Deviation of Body Acceleration - Time Signal", "Y Component of Standard Deviation of Body Acceleration - Time Signal", "Z Component of Standard Deviation of Body Acceleration - Time Signal","X Component of Standard Deviation of Gravitational Acceleration - Time Signal",
                                 "Y Component of Standard Deviation of Gravitational Acceleration - Time Signal", "Z Component of Standard Deviation of Gravitational Acceleration - Time Signal", "X Component of Standard Deviation of Body Jerk Acceleration - Time Signal",
                                 "Y Component of Standard Deviation of Body Jerk Acceleration - Time Signal","Z Component of Standard Deviation of Body Jerk Acceleration - Time Signal", 
                                 "X Component of Standard Deviation of Body Angular Velocity - Time Signal","Y Component of Standard Deviation of Body Angular Velocity - Time Signal", "Z Component of Standard Deviation of Body Angular Velocity - Time Signal",
                                 "X Component of Standard Deviation of Body Jerk Angular Velocity - Time Signal", "Y Component of Standard Deviation of Body Jerk Angular Velocity - Time Signal", "Z Component of Standard Deviation of Body Jerk Angular Velocity - Time Signal",                                  
                                 
                                 "Standard Deviation of Body Acceleration Magnitude - Time Signal","Standard Deviation of Gravity Acceleration Magnitude - Time Signal", "Standard Deviation of Body Jerk Acceleration - Time Signal",
                                 "Standard Deviation of Body Angular Velocity - Time Signal", "Standard Deviation of Body Jerk Angular Velocity - Time Signal", 
                                 "X Component of Standard Deviation of Body Acceleration - Frequency Signal", "Y Component of Standard Deviation of Body Acceleration - Frequency Signal", "Z Component of Standard Deviation of Body Acceleration - Frequency Signal",
                                 "X Component of Standard Deviation of Body Jerk Acceleration - Frequency Signal", "Y Component of Standard Deviation of Body Jerk Acceleration - Frequency Signal", "Z Component of Standard Deviation of Body Jerk Acceleration - Frequency Signal",
                                 
                                 "X Component of Standard Deviation of Body Angular Velocity - Frequency Signal", "Y Component of Standard Deviation of Body Angular Velocity - Frequency Signal","Z Component of Standard Deviation of Body Angular Velocity - Frequency Signal",
                                 "Standard Deviation of Body Acceleration Magnitude - Frequency Signal","Standard Deviation of Body Jerk Acceleration Magnitude - Frequency Signal", "Standard Deviation of Body Angular Velocity - Frequency Signal",
                                 "Standard Deviation of Body Angular Jerk Velocity - Frequency Signal","Activity", "Subject")

#Writing the Initial Tidy DataSet into a text file
write.table(x = initial_tidy_dataset, file = "./Initial_Tidy_Data_Set.txt", row.names = FALSE)

#Modify the data set to calculate mean values
Final_tidy_dataset <- cast(melt(initial_tidy_dataset, id= c("Activity","Subject")), Subject + Activity ~ variable, mean)

#Writing the Final Tidy Dataset into a text file
write.table(x = Final_tidy_dataset, file = "./Final_Tidy_Data_Set.txt", row.names = FALSE)
