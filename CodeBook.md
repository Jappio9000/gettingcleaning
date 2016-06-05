# CodeBook

This is the CodeBook for the course assignment of the Getting and Cleaning data course.<br>
Refer to the README.md file for a more general description. <br>

R-script: "run_analysis.R" <br>
Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip <br>

The R-script aims to collect and clean up data from the dataset from the 'Human Activity Recognition Using Smartphones Data Set'. 
For more information about the data collection method, refer to the following website: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones <br>

The R-script performs the following modifications and transformations of the source dataset:<br>
<h4>1.Merge the training and the test sets to create one data set.</h4>
  
<h4>2.Extract only the measurements on the mean and standard deviation for each measurement. </h4>

<h4>3.Use descriptive activity names to name the activities in the data set.</h4>

<h4>4.Appropriately label the data set with descriptive variable names. </h4>

<h4>5.From the data set in step 4, create a second, independent tidy data set with the average of each 
variable for each activity and each subject.</h4>
