# Tidying_Human_Act_Recog_Data
## Code Explanation
### The code run_analysis.R creates the tidy data set. The steps followed in it are listed below:
* The packages 'plyr' and 'reshape' are loaded.
* All the required files are read into the respective tables. The basic idea is that we need the feature values (in x_test and x_train files), the corresponding 
  activities (in y_test and y_train files) and the subjects (subject_test and subject_train files) to capture all the information in one file. The activity labels 
  are also fetched using the activity_labels file. This file is needed to replace the activity ID's in the data files with the activity descriptions.
* We only need the feature values relevant to mean and standard deviation. In my case, I have assumed that the mean features have the word 'mean' in their name
  and the standard deviation features have 'std' in theirs. With this idea, the feature names are filtered using grep function. Combining the result of the 
  two filter operations gives the list of all subsetted features.
* The activity labels for the corresponding activity ID's are found by using a join between the activity test and training data with the activity labels consecutively.
* The test & training data are combined with the activity labels to create the initial tidy dataset
* The column names of the initial tidy data set are changed to meaningful names using the names function
* The initial tidy data set created is then written into a file using the write statement
* The initial tidy data is now modified by first melting the data set based on Subject and Activity data to segregate it. Then the data is recasted into the final tidy 
  data set. During the recasting, the means of the variables are calculated for each Subject and Activity.
* The final tidy data set is now written to a text file