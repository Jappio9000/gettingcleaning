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

 ## Read in the data fot the test database
  test <- read.table("./data/test/X_test.txt")
  test_labels <- read.table("./data/test/Y_test.txt")
  test_subject <- read.table("./data/test/subject_test.txt")
  
 ## Read in the data for the train database
  train <- read.table("./data/train/X_train.txt")
  train_labels <- read.table("./data/train/Y_train.txt")
  train_subject <- read.table("./data/train/subject_train.txt")
  
  ## Combine the measurement data with subject and labels
    ## Dataset setup: column 1 = subject, column 2 = type of test, 
    ## column 3+ = measurement data
    test_data <- cbind(test_subject, test_labels, test)
    train_data <- cbind(train_subject, train_labels, train)
  
    ## Clean up data
    rm(list=c("test", "train", "test_labels", "train_labels", 
              "test_subject", "train_subject"))
  
 ## Combine the data into one set and remove originals from workspace
  data <- rbind(test_data,train_data)
  rm(list=c("test_data", "train_data"))
  
  
## ========= PART 4: LABEL THE DATASET VARIABLES DESCRIPTIVELY ========
  ## This script first adds descriptive variable names to the dataset
    ## as this will simplify the next data transformation steps and makes
    ## it more obvious what data manipulations and transformations are performed
  
  ## read in the column names for measurements
  cnames <- read.table("./data/features.txt")
    ## clean up the names by removing "()"
    cnames <- sub("\\()","",cnames[,2])
    ## replace "," with "_"
    cnames <- gsub(",","_", cnames)
  
    ## example for cleaning up variable names: 
    ## https://github.com/StephanNelson225/gettingCleaning/blob/master/run_analysis.R
    
  ## Add the 'subject' and 'activity' column names for column 1 and 2
  cnames <- c("subject", "activity", cnames)
  
  ## assign column names to columns of the complete dataset
  names(data) <- cnames
  
  ## clean up the unused dataset with column names
  rm(list=c("cnames"))
  
 
## ========= PART 2: EXTRACT MEAN AND STANDARD DEVIATION ==============
  ## mean and standard deviation data can be selected by column name 
  ## that includes 'mean' or 'std'

  ## create a column list that includes mean OR std in the colnames
  cols <- grep(".*mean.*|.*std.*", names(data))
    ## add columns 1 and 2 (subject and activity)
    cols <- c(1, 2, cols)
  
  ## save these columns of the 'data' set into a new dataset
  data_extract <- data[,cols]

  
## ========= PART 3: USE DESCRIPTIVE ACTIVITY NAMES ===================
  ## Next step is to assign the activity names to the number-coded activities
    ## from the original dataset
  
  ## Read activity labels and assign to column 'activity'
    labels <- read.table("./data/activity_labels.txt")
    ## make labels all lowercase
    labels[,2] <- tolower(labels[,2])
    ## replace the numeric activity labels with descriptive names
    for(i in 1:6){
      data_extract[,2][data_extract[,2]==i] <- labels[i,2]
    }
  
  ## write the file for archiving purposes as data_extract.txt
    write.table(data_extract,"data_extract.txt",col.names=TRUE, row.names=FALSE)
    
  
## ========= PART 5: CREATE A DATASET WITH AVERAGES ===================
  ## Assignment: From the data set in step 4, create a second, independent tidy 
    ## data set with the average of each variable for each activity and each subject.
  
    ## Group the data by subject and activity
    data_group <- group_by(data_extract, subject, activity)
    
    ## Summarise the data by applying the 'mean' function
    data_summary <- summarise_each(data_group, funs(mean))
    
    ## Finally, write the data into a file:
    write.table(data_summary, file="tidy_data.txt", row.names=F)
    
}