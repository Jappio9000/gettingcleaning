# CodeBook

This is the CodeBook for the course assignment of the Getting and Cleaning data course.<br>
Refer to the README.md file for a more general description. <br>

R-script: "run_analysis.R" <br>
Required R-packages: dplyr <br>
Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip <br>
The R-script aims to collect and clean up data from the dataset from the 'Human Activity Recognition Using Smartphones Data Set'. 
For more information about the data collection method, refer to the following website: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones <br>

<h5> Acquiring data instructions </h5>
1. download the zip-file from this url:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the data into your working directory in such a way that the 'test' and 'train' 
  folders are placed in a "data" folder within  the working directory 
  Example folder structure for working directory "D:/Rwd": D:/Rwd/data/test
  
The R-script performs the following modifications and transformations of the source dataset:<br>
<br> Note that every step contains a workspace cleanup for all variables in memory that are no longer needed for the analysis to run.<br>
<h4>1.Merge the training and the test sets to create one data set.</h4>
The script reads in the following data for the test and train datasets: <br>
<li>Measurement data</li>
<li>Activity labels (numeric data 1-6)</li>
<li>Test subject numbers</li>
This data is combined (rbind) into three separate sets. <br>
Column names are assigned to the combine acivity and subject datasets: "acvitity" and "subject". <br>
The data measurement, activity and subject data is then combined (cbind) into one complete dataset. <br>

<h4>2.Extract only the measurements on the mean and standard deviation for each measurement. </h4>
We assume that all measurement data that contains the words 'mean' or 'std' within the description are of interest. First, the script reads in the features (e.g. measurement data descpription) list from the features.txt file.<br>
Then, a list of columns is created that contain the words 'mean' or 'std'. Using this column list, the dataset from step 1 is subsetted to create a dataset that only contains the mean and standard deviation for each measurement.<br>
To maintain the "subject" and "activity" columns in the dataset, the column list is added by 2 and column numbers 1 and 2 are added before subsetting the dataset from step 1.

<h4>3.Use descriptive activity names to name the activities in the data set.</h4>
The activity colum contains integers 1-6 that substitute activities. The activity_labels.txt files contains the text labels for the activities.<br>
The script reads in the activity_labels.txt file and then makes them a bit more human-friendly by making them all lowercase.<br>
A for-loop is used to substitute the numers in the "activity" column by the descriptive activity names.<br>

<h4>4.Appropriately label the data set with descriptive variable names. </h4>
The column names have been read in step 2 into the 'features' variable. This part of the script takes these features descriptions and makes them more human readable before applying the to the column names of the dataset.<br>
The following improvements to the feature names are applied: <br>
<li>Remove all brackets '(' and ')'</li>
<li>Replace ',' with '_'</li>
<li>Create visual separation between words by adding "."</li>
<li>Make the entire feature names list lowercase</li>

Before applying the feature list to the column names of the dataset, labels for column 1 "subject" and column 2 "activity" are applied. <br>


<h4>5.From the data set in step 4, create a second, independent tidy data set with the average of each 
variable for each activity and each subject.</h4>
This step requires the dplyr R-package and checks for availability on the user's computer.<br>
The data is first grouped by subject and activity and then summarised by the 'mean' function.<br>
The tidy_data.txt file is created in the current workdirectory.

END
