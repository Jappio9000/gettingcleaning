## run_analysis.R
run_analysis <- function(x) {

## Course Assignment for Getting and Cleaning data

## Acquiring data instructions
  ## 1. download the zip-file from this url:
    ## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  ## 2. Extract the data into your working directory in such a way that the 'test' and 'train' 
    ## folders are placed in a "data" folder within  the working directory 
      ## Example folder structure for working directory "D:/Rwd":
      ## D:/Rwd/data/test

## Please review the README.md and CodeBook.md file enclosed in the repository for
  ## more information.
 
## Script assumes the raw data in is present in a "data" folder in the current working directory.

## ========= PART 1: READ THE DATA AND MERGE INTO ONE DATASET ==========

  ## Read in the data 

  test <- read.table("./data/test/X_test.txt")
  test_labels <- read.table("./data/test/Y_test.txt")
  test_subject <- read.table("./data/test/subject_test.txt")
  
  train <- read.table("./data/train/X_train.txt")
  train_labels <- read.table("./data/train/Y_train.txt")
  train_subject <- read.table("./data/train/subject_train.txt")
  
## assign names to data column of labels and subject data file
  names(test_labels) <- "activity"
  names(train_labels) <- "activity"
  names(test_subject) <- "subject"
  names(train_subject) <- "subject"

## read in the column names for measurements
  cnames <- read.table("./data/features.txt")
    ## clean up the names by removing "()"
    cnames <- sub("\\()","",cnames[,2])
    ## replace "," with "_"
    cnames <- gsub(",","_", cnames)
    
## assign column names to columns in test and train datasets
    names(train) <- cnames
    names(test) <- cnames
      
## combine the data for training and test data in two sets
  test_bind <- cbind(test_subject, test_labels, test)
  train_bind <- cbind(train_subject,train_labels, train)

## clean up the unused datasets
  rm(list=c("test", "train", "test_labels", "train_labels", 
            "test_subject", "train_subject", "cnames"))
  
## combine the data into one dataset
  data <- rbind(test_bind, train_bind)
  
## read activity labels and assign to column 'activity'
  labels <- read.table("./data/activity_labels.txt")
  ## make labels all lowercase
  labels[,2] <- tolower(labels[,2])
  ## replace the numeric activity labels with descriptive names
  for(i in 1:6){
    data[,2][data[,2]==i] <- labels[i,2]
  }
  
## clean up the unused datasets
  rm(list=c("test_bind", "train_bind"))

## ========= PART 2: EXTRACT MEAN AND STANDARD DEVIATION ==============
  ## mean and standard deviation data can be selected by column name 
  ## that includes 'mean' or 'std'
  
  ## create a column list that includes mean OR std in the colnames
  cols <- grep(".*mean.*|.*std.*", names(data))
  ## save this data AND the activity and subject columns [1:2]
  
  
## ========= PART 3: USE DESCRIPTIVE ACTIVITY NAMES ===================
  ## re-use the 'labels' data previously read into memory
  
  
## ========= PART 4: LABEL THE DATASET VARIABLES DESCRIPTIVELY ========
  
## ========= PART 5: CREATE A DATASET WITH AVERAGES ===================
  ## Assignment: From the data set in step 4, creates a second, independent tidy 
    ## data set with the average of each variable for each activity and each subject.
  

}