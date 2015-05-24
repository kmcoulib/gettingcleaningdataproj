### Introduction

This code reads the input files provided for the "Getting and Cleaning Data" course
project and carries out the folllowing tasks:
1. Merge the train and test dataset
2. Extract measurements on standard deviation and mean
3. Rename activities and variables in a meaningful and descriptive way
4. Create a tidy dataset from the previous step containing the averages for each 
   variables for each activity and each subject

### Code inputs

The code assumes that the working directory is the one produced by unzipping the 
getdata_projectfiles_UCI HAR Dataset.zip provided for the project. Which should be
the directory "UCI HAR Dataset" which contains two subdirectories: "train" and "test".
The files required for this code to work are:
1. activity_labels.txt and features.txt located in the main "UCI HAR Dataset"
2. subject_test.txt, X_test.txt and y_test.txt located in the  "test" subdirectory
3. subject_train.txt, X_train.txt and y_train.txt located in the "train" subdirectory

### Code description

The code reads the train dataset first then the test dataset second and merges both datasets. 
It extracts the column indices of variable that contain the string "mean" or "std" and uses
these indices to extract measurements on standard deviation and mean. Then activity codes 
in the resulting dataset are replaced by more descriptive words and the variable names are 
modified to be more descriptive.
Last but not least the code create a new independent tidy dataset with the averages for each 
variable for each activity and each subject using the function ddply from the package plyr