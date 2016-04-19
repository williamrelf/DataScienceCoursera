##Code Book | Samsung Galaxy S Accelerometer Data

###Summary

This code book describes the contents of the clean data file "Samsung Galaxy S Accelerometer Data.csv" and the transformative steps that have been applied by "run_analysis.R" on the original data files contained in the folder "UCI HAR Dataset" in order to acheive said clean data.

###Variables | Samsung Galaxy S Accelerometer Data.csv

- SubjectId: The identifier of an individual for whome data is available, a person who has taken part in the trial.
- ActivityName: The name of the activity the individual was performing at the point the data was collected.
- The following variables are the average mean values captured from the three points of the accelerometer, X, Y and Z by Subject and Activity.
    - tBodyAcc mean Y
    - tBodyAcc mean Z
    - tGravityAcc mean X
    - tBodyAcc mean X
    - tGravityAcc mean Y
    - tGravityAcc mean Z
    - tBodyAccJerk mean X
    - tBodyAccJerk mean Y
    - tBodyAccJerk mean Z
    - tBodyGyro mean X
    - tBodyGyro mean Y
    - tBodyGyro mean Z
    - tBodyGyroJerk mean X
    - tBodyGyroJerk mean Y
    - tBodyGyroJerk mean Z
    - tBodyAccMag mean
    - tGravityAccMag mean
    - tBodyAccJerkMag mean
    - tBodyGyroMag mean
    - tBodyGyroJerkMag mean
    - fBodyAcc mean X
    - fBodyAcc mean Y
    - fBodyAcc mean Z
    - fBodyAccJerk mean X
    - fBodyAccJerk mean Y
    - fBodyAccJerk mean Z
    - fBodyGyro mean X
    - fBodyGyro mean Y
    - fBodyGyro mean Z
    - fBodyAccMag mean
    - fBodyBodyAccJerkMag mean
    - fBodyBodyGyroMag mean
    - fBodyBodyGyroJerkMag mean
- The following variables are the average mean values captured from the three points of the accelerometer, X, Y and Z by Subject and Activity.
    - tBodyAcc std X
    - tBodyAcc std Y
    - tBodyAcc std Z
    - tGravityAcc std X
    - tGravityAcc std Y
    - tGravityAcc std Z
    - tBodyAccJerk std X
    - tBodyAccJerk std Y
    - tBodyAccJerk std Z
    - tBodyGyro std X
    - tBodyGyro std Y
    - tBodyGyro std Z
    - tBodyGyroJerk std X
    - tBodyGyroJerk std Y
    - tBodyGyroJerk std Z
    - tBodyAccMag std
    - tGravityAccMag std
    - tBodyAccJerkMag std
    - tBodyGyroMag std
    - tBodyGyroJerkMag std
    - fBodyAcc std X
    - fBodyAcc std Y
    - fBodyAcc std Z
    - fBodyAccJerk std X
    - fBodyAccJerk std Y
    - fBodyAccJerk std Z
    - fBodyGyro std X
    - fBodyGyro std Y
    - fBodyGyro std Z
    - fBodyAccMag std
    - fBodyBodyAccJerkMag std
    - fBodyBodyGyroMag std
    - fBodyBodyGyroJerkMag std

##The Data | Samsung Galaxy S Accelerometer Data.csv

The body of the data set contains clean summarised data for an individual. The file consolidates the data contained in the test and train data contained the "UCI HAR Dataset" folder. The individual files within test have been joined together, as have the indivudual files within train, the resulting joined data has then been merged, appended, to build a complete data set for all subjects and activities.

##Transformation Steps | run_analysis.R

The following steps have been performed to build the clean data set. In order. The original data has been included, so the "run_analysis.R" script can be rerun for repeatable results.

1. Read all data files contained in the test and train folders, using the provided feature list (\UCI HAR Dataset\features.txt) as variable/column names when loading the following data files.
    - \UCI HAR Dataset\test\X_test.txt
    - \UCI HAR Dataset\train\X_train.txt
2. Combine the following **test** data files, based on possition, using cbind()
    - \UCI HAR Dataset\test\subject_test.txt
    - \UCI HAR Dataset\test\y_test.txt
    - \UCI HAR Dataset\test\X_test.txt
3. Combine the following **train** data files, based on possition, using cbind()
    - \UCI HAR Dataset\train\subject_train.txt
    - \UCI HAR Dataset\train\y_train.txt
    - \UCI HAR Dataset\train\X_train.txt
4. Append the test and train data into a single data set, using rbind()
5. Join the complete data set to the file below in order to translate activity Label IDs to Label Names, using plyr::join.
    - \UCI HAR Dataset\activity_labels.txt
6. Shorten the result set by selecting variables for mean and standard deviation only, using a combination of grep() to identify the column indexes and dplyr::select() to retrive those columns.
7. Summarise the data by subject id and activity name, using group_by(), and aggregating the value attributes using the mean() aggregate function on all columns. 
8. Clean up the variable names, making them more human readable, removing dots in column names and trailing whitespace, using gsub().
9. Write the resultant clean summarised data to file if it does not exist. 