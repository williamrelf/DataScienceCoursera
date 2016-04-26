##  This script will load the required files, merge the test and training data sets,
##  and extract the mean and standard deviation for each measurement.
##  The variable names are formatted to make them more readable.
##  See the accompanying codebook for more details.

##  Install required libraries if required.
print("Install required libraries if required.")

if (!"dplyr" %in% rownames(installed.packages())) {
    install.packages("dplyr")
}

if (!"plyr" %in% rownames(installed.packages())) {
    install.packages("plyr")
}

if (!"stringr" %in% rownames(installed.packages())) {
    install.packages("stringr")
}

##  Load required libraries
print("Load required libraries")

library(plyr)
library(dplyr)
library(stringr)

## Read in high level files
print("Read in high level files")

Features <- read.table(file = ".\\UCI HAR Dataset\\features.txt", header = FALSE, stringsAsFactors = FALSE)[,2]
Labels <- read.delim(".\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = " ", col.names = c("LabelId", "ActivityName"))

##  Read in test files
print("Read in test files")

TestSubject <- read.delim(file = ".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, sep = " ", col.names = c("SubjectId"))
TestLabels <- read.delim(file = ".\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, sep = " ", col.names = c("LabelId"))
TestData <- read.fwf(".\\UCI HAR Dataset\\test\\X_test.txt", widths = rep.int(16, 561), header = FALSE, col.names = Features)

##  Combine test files
print("Combine test files")

CombinedTestData <- cbind(TestSubject, TestLabels, TestData)

## Remove redundant objects to free memory
print("Remove redundant objects to free memory")

rm(TestSubject)
rm(TestLabels)
rm(TestData)

##  Read in train files
print("Read in train files")

TrainSubject <- read.delim(file = ".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE, sep = " ", col.names = c("SubjectId"))
TrainLabels <- read.delim(file = ".\\UCI HAR Dataset\\train\\y_train.txt", header = FALSE, sep = " ", col.names = c("LabelId"))
TrainData <- read.fwf(".\\UCI HAR Dataset\\train\\X_train.txt", widths = rep.int(16, 561), header = FALSE, col.names = Features)

## Combine train data
print("Combine train data")

CombinedTrainData <- cbind(TrainSubject, TrainLabels, TrainData)

## Remove redundant objects to free memory
print("Remove redundant objects to free memory")

rm(TrainSubject)
rm(TrainLabels)
rm(TrainData)

## Combine final data sets
print("Combine final data sets")

CombinedData <- rbind(CombinedTestData, CombinedTrainData)

## Add activity labels
print("Add activity labels")

CombinedData <- join(CombinedData, Labels)

## Remove redundant objects to free memory
print("Remove redundant objects to free memory")

rm(CombinedTestData)
rm(CombinedTrainData)
rm(Features)
rm(Labels)

## Get column list of mean and standard deviation columns
print("Get column list of mean and standard deviation columns")

ColList <- c(grep("[.]mean[.].", names(CombinedData)), grep("[.]std[.].", names(CombinedData)))

CombinedData <- tbl_df(select(CombinedData, SubjectId, ActivityName, ColList))

## Summarise the data
print("Summarise the data")

SummarisedData <- group_by(CombinedData, SubjectId, ActivityName) %>% summarise_each(funs(mean))

## Cleanup the variable names
print("Cleanup the variable names")

CleanNames <- gsub("\\.", " ", names(SummarisedData))
CleanNames <- trimws(gsub("   ", " ", CleanNames))
names(SummarisedData) <- CleanNames

## Write clean file
print("Write clean file")

if (file.exists("Samsung Galaxy S Accelerometer Data.csv")) {
    file.remove("Samsung Galaxy S Accelerometer Data.csv")
}
write.table(SummarisedData, file = "Samsung Galaxy S Accelerometer Data.csv", sep = ",", row.names = FALSE)