Content
=========================
This folder contains the R-script "run_analysis.R" from peer assessment 1 of the Coursera class "Getting and Cleaning Data" 

The script includes all described steps 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The raw data collected from the accelerometers from the Samsung Galaxy S smartphone.
(Datasource: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

At the end a data set is written in a output file.


Usage
=========================
- download the datasource
- unzip the datasource
- place the R-script in the created directory "UCI HAR Dataset"
- run the R-script
  source("run_analyses.R")

Implementation
=========================
The following files were read into R:
- ./features.txt
- ./activity_labels.txt
- ./test/subject_test.txt
- ./test/X_test.txt
- ./test/y_test.txt
- ./train/subject_train.txt
- ./train/X_train.txt
- ./train/y_train.txt

All columns got descriptive column names during the read step.
For the files X_test.txt and X_train.txt the values from the features.txt file were used after doing some cleaning actions on the names.
- removed ( and )
- replaced - with _

Afterwards the files are binded together
- y_test.txt is merged with activity_labels.txt via Activity_ID 
  Afterwards the 3-files in the test-directory are combined via cbind
- y_train.txt is merged with activity_labels.txt via Activity_ID 
  Afterwards the 3-files in the train-directory are combined via cbind.
- in a final step the test and train are combined via rbind

The relevant measure (only the measurements on the mean and standard deviation have to be processed) columns can be identified by
- *mean()
- *std()
Column names with meanFreq() are excluded.

The calculation of the average of each relevant measure column for each activity and each subject is performed by using the package reshape2 and the function melt and dcast.

The result data set of the calculation (sorted by activity and subject) is written in a textfile (result.txt).
