(Datasource: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

At the end a data set is written in a output file.


Usage
=========================
- download the datasource
- unzip the datasource
- place the R-script in the created directory "UCI HAR Dataset"
- run the R-script
```
source("run_analyses.R")
```

Implementation
=========================
Reading and Combining files 
------
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

For the files X_test.txt and X_train.txt the values from the features.txt file were used 
after doing some cleaning actions on the names. (function ```gsup```)
- removed ( and )
- replaced - with _

Afterwards the files are combined together (functions ```merge```, ```cbind```, ```rbind```)
- File y_test.txt is merged with activity_labels.txt via Activity_ID . Afterwards the 3-files in the test-directory are combined via cbind
- File y_train.txt is merged with activity_labels.txt via Activity_ID . Afterwards the 3-files in the train-directory are combined via cbind.
- In a final step the resulting test and train files are combined via rbind.

Calculation
-------
The relevant measure (only the measurements on the mean and standard deviation have to be processed) columns can be identified by 
- *mean()
- *std()
in combination with the ```grep``` function

Column names with meanFreq() are excluded.

The calculation of the average of each relevant measure column for each activity and each subject is performed by using the package ```reshape2``` and the function ```melt``` and ```dcast```.

Result
------
The result data set of the calculation (sorted by activity and subject) is written in a textfile (result.txt) with a semicolon as separator.
