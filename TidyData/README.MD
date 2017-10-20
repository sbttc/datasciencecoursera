# About  

This project utilizes dataset downloaded from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- The dataset contains experiments carried out with a group of 30 volunteers. Each participant is represented by an integer (1-30).

- Each subject performed any of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Signals are captured.

- The obtained dataset has been randomly partitioned into two sets, where 70% of the subjects was selected for generating the training data and 30% the test data.

This is a Coursera course project. It is to prepare workable data from these source files, and then perform the following tasks
- Combine Training dataset and Test dataset and give data elements meaningful names
- Extract measurements with the words 'mean' or 'std' in the measurement (aka feature) name.
- Calculate the 'average' (mean) for each ( subject, activity, measure).
- Save the result into an output file (in this case a csv)


## Process
The R script uses the following libraries:

* httpr
* plyr
* sqldf
* reshape2

R objects are given meaningful names at the time they are created. The final output is named: output.csv and takes the following format:
* Subject ID
* Activity Code
* Activity description
* (Measurement) Variable
* (Measurement) Value


#### 1 : Read and consolidate data files from datasets

The R script reads in the "code" files first. They are:
- features.txt
- activity_labels.txt

Then, it reads in files in the Train dataset, which includes:
- subject_train.txt: contains subject's participation
- y_train.txt: contains subject's activities
- X_train.txt: contains signal measurements

All 3 are combined with activity description added to it. Meaningful column names are given.

The same process is repeated for the Test dataset.
#### 2: Combine Training and Test datasets

#### 3: Extract only signal measurements that have 'mean' or 'std' in the name

#### 4: Use melt & dcast to reshape the dataframe for getting averages and formatting into Long-format 

#### 5: Write final output to a text file named: output.txt
