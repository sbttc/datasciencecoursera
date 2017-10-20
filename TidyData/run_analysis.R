#
# This is the "Tidy Data" project. It reads in 2 datasets --> Training and Test.
# For each set, there are 3 files: Subject (test subjects), Activity (subject's recorded activities), and measurements
# There are also 2 "code" files. One contains the description for activities, and the other contains the description for each measurement
#
library(httpr)
library(plyr)
library(sqldf)
library(reshape2)
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileURL, destfile = 'UCIDataset.zip', method='curl') 
unzip("UCIDataset.zip", exdir = "UCIdata")
setwd("UCIdata/UCI HAR Dataset")

# read in "code" files and give columns meaningful names

activityDF <- read.table("activity_labels.txt", header = FALSE)
colnames(activityDF) <- c('activityCode','description')

featuresDF <- read.table("features.txt", header=FALSE)
colnames(featuresDF) <- c('index','measurement')

# read in train subject, subject's activities and give data columns meanful names

trainSubject <- read.table("train/subject_train.txt", header = FALSE)
colnames(trainSubject) <- c('subjectID')
                            
trainActivity <- read.table("train/y_train.txt", header = FALSE)
colnames(trainActivity) <- c('activityCode')

# make a new dataframe that pulls in description (from code file) for each subject's activities

trainActivityDF <- sqldf('SELECT a.activityCode, b.description            
                       FROM trainActivity a
                       LEFT JOIN activityDF b 
                       WHERE a.activityCode = b.activityCode')

# read in train subject's measurements

trainData <- read.table("train/X_train.txt", quote="\"", 
                    col.names=featuresDF$measurement, header = FALSE)

# combine SubjectID, activity (with description), and measurement from the training set

trainSet <- cbind(trainSubject, trainActivityDF, trainData )       

# read in test subject, subject's activities and give data columns meanful names

testSubject <- read.table("test/subject_test.txt", header = FALSE)
colnames(testSubject) <- c('subjectID')

testActivity <- read.table("test/y_test.txt", header = FALSE)
colnames(testActivity) <- c('activityCode')

# make a new dataframe that pulls in description (from code file) for each subject's activities

testActivityDF <- sqldf('SELECT a.activityCode, b.description           
                         FROM testActivity a
                         LEFT JOIN activityDF b 
                         WHERE a.activityCode = b.activityCode')

# read in test subject's measurements

testData <- read.table("test/X_test.txt", quote="\"", 
                    col.names=featuresDF$measurement, header = FALSE)

# combine SubjectID, activity (with description), and measurement from the training set

testSet <- cbind(testSubject, testActivityDF, testData )       

# combine training set and test set

combinedSet <- rbind(trainSet, testSet)

# 
# extract measures that has 'mean' or 'std' in the name. Use grep to establish the list
#
selectedColumns <- grep("mean|std", tolower(names(combinedSet))) # getting their positions
selectedColumns <- c(1,2,3, selectedColumns)  # select only those identified 
selectedSet <- combinedSet[,selectedColumns]  # extract from the combinedset based on the indices 

## Then, create a new dataset that contains the average per subject/activity/measurement
# averages is the result taking the wide format into long format 
# output contains the result of getting the mean for each (subject/activity/measurement)
# then use the melt function to take output from wide format back to long format

averages <- melt(selectedSet, id=c('subjectID','activityCode','description'))
output <- dcast(averages, subjectID + activityCode + description ~ variable, mean)
output <- melt(output, id = c('subjectID','activityCode','description'))

# save output to a csv

write.table(output, file="output.txt", row.names=FALSE)
