# Getting Cleaning Data - Week 3 - Peer assessment
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## READ given files # --> ######################################################

# read "feature.txt"
feature <- read.csv("./features.txt",header=FALSE,sep=" ",col.names=c("Feature_ID", "Feature_Name"))

# read "activity_labels.txt"
act_labels <- read.csv("./activity_labels.txt",header=FALSE,sep=" ",col.names=c("Activity_ID", "Activity_Name"))

# read "./test/subject_test.txt"
test_subject <- read.csv("./test/subject_test.txt",header=FALSE,sep=" ",col.names=c("Subject_ID"))

# read "./test/Y_test.txt"
test_y <- read.csv("./test/y_test.txt",header=FALSE,sep=" ",col.names=c("Activity_ID"))

#read "./train/subject_train.txt"
train_subject <- read.csv("./train/subject_train.txt",header=FALSE,sep=" ",col.names=c("Subject_ID"))

#read "./train/Y_train.txt"
train_y <- read.csv("./train/y_train.txt",header=FALSE,sep=" ",col.names=c("Activity_ID"))

# define column_names for measure files 
measure_column_names <- gsub("-", "_", gsub("|\\(|\\)", "", feature$Feature_Name))
# read "./test/X_test.txt"
test_x <- read.table("./test/X_test.txt",header=FALSE,col.names=measure_column_names)
#read "./train/X_train.txt"
train_x <- read.table("./train/X_train.txt",header=FALSE,col.names=measure_column_names)

## <-- # READ given files #######################################################



## Merge files # --> ############################################################

# --- test -------------------------
# add activity_labels to subjects
test_y_labels <- merge(test_y,act_labels, by.x="Activity_ID", by.y="Activity_ID",  all=TRUE)
# add values from x to subjects and activity_labels
test <- cbind(test_subject,test_y_labels, test_x)

# --- train -------------------------
# add activity_labels to subjects
train_y_labels <- merge(train_y,act_labels, by.x="Activity_ID", by.y="Activity_ID",  all=TRUE)
# add values from x to subjects and activity_labels
train <- cbind(train_subject,train_y_labels, train_x)

# --- all together -------------------------
all_data <- rbind(train,test)

## <-- # Merge files ############################################################



## Identify Columns # --> #######################################################

# define subset of columns (only mean + sd + Key's but without meanFreq)
sub_columns <- unique(grep("Freq"
                           , grep("Subject_ID|Activity_Name|mean|std", names(all_data), value=TRUE)
                           , invert=TRUE, value=TRUE, ignore.case=TRUE))

data_mean_std <- all_data[,sub_columns]

## <-- # Identify Columns #######################################################



## calculate average # --> ######################################################

library(reshape2)

# define subset of columns (only mean + sd without Keys)
sub_columns_measures <- unique(grep("mean|std", sub_columns, value=TRUE))

data_avgmelt <- melt(data_mean_std, id.vars=c("Subject_ID","Activity_Name"),measure.vars=sub_columns_measures)
data_avg <- dcast(data_avgmelt, Subject_ID + Activity_Name ~ variable, mean)

## <-- # calculate average ######################################################

# -------------------------------------------------------------------------------

# Sort Values
result <- data_avg[with(data_avg, order(Activity_Name,Subject_ID)), ]
# Write Values
write.table(result, file="./result.txt",sep=";", row.names = FALSE)
