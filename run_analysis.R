## run_analysis.R
run_analysis <- function(x) {

## Course Assignment for Getting and Cleaning data
## Comments and explanations in this file minimized. 
## Please review the README.md and CodeBook.md file enclosed in the repository for
## more information.

## ========= PART 1: READ THE DATA AND MERGE INTO ONE DATASET ==========

 ## Read in the data for the test database
  test <- read.table("./data/test/X_test.txt")
  test_labels <- read.table("./data/test/Y_test.txt")
  test_subject <- read.table("./data/test/subject_test.txt")
  
 ## Read in the data for the train database
  train <- read.table("./data/train/X_train.txt")
  train_labels <- read.table("./data/train/Y_train.txt")
  train_subject <- read.table("./data/train/subject_train.txt")
  
  ## Combine the measurement data
  alldata <- rbind(test,train)
  act <- rbind(test_labels, train_labels)
  subj <- rbind(test_subject, train_subject)
  
  ## Assign column names for activity and subject data
  colnames(act)="activity"
  colnames(subj)="subject"
  
  ## Combine the data into one set and remove originals from workspace
  data <- cbind(subj, act, alldata)
  rm(list=c("test", "train", "test_labels", "train_labels", 
            "test_subject", "train_subject", "alldata", "act", "subj"))
  
  
## ========= PART 2: EXTRACT MEAN AND STANDARD DEVIATION ==============
  ## mean and standard deviation data can be selected by column name 
  ## that includes 'mean' or 'std'
  features <- read.table("./data/features.txt", colClasses="character")
  
  ## create a column list that includes "mean" OR "std" in the colnames
  fcols <- grep(".*mean.*|.*std.*", features[,2])
  ## Since we've added the "subject" and "activity" columns as col 1 and 2
  ## of the data set, we need to add 2 to all column numbers and then add
  ## column 1 and 2 to the column list
  cols = fcols + 2 
  cols <- c(1, 2, cols)
  
  ## save these columns of the 'data' set into a new dataset
  data_sub <- data[,cols]
  
  ## remove the unfiltered dataset
  rm("data", "cols")
  
## ========= PART 3: USE DESCRIPTIVE ACTIVITY NAMES ===================
  ## Next step is to assign the activity names to the number-coded activities
    ## from the original dataset
  
  ## Read activity labels and assign to column 'activity'
    labels <- read.table("./data/activity_labels.txt")
    ## make labels all lowercase
    labels[,2] <- tolower(labels[,2])
    ## replace the numeric activity labels with descriptive names
    for(i in 1:6){
      data_sub[,2][data_sub[,2]==i] <- labels[i,2]
    }
    
    ## remove the labels and counter list
    rm("labels", "i")
    
## ========= PART 4: LABEL THE DATASET VARIABLES DESCRIPTIVELY ========
## Feature (column) names have been read in step 2 into the "features" variable
## The feature names have some properties that make them less human-friendly:
    # Names contain brackets "()"
    # Names contain comma as value separator "," 
    # Words are not separated visually
    # Names have capitals and lowercase

## select only the features that are extracted to the dataset
flist <- features[fcols,2]
        
## clean up the names by removing "(" and ")"
fnames <- gsub("\\(", "", flist)
fnames <- gsub("\\)", "", fnames)
## replace "," with "_"
fnames <- gsub(",","_", fnames)
## create visual word separation with "."
fnames <- gsub("^f", "f.", fnames)
fnames <- gsub("^t", "t.", fnames)
fnames <- gsub("^angle", "angle.", fnames)

fnames <- gsub("Acc", ".acc", fnames)
fnames <- gsub("Gyro", ".gyro", fnames)
fnames <- gsub("Jerk", ".jerk", fnames)
fnames <- gsub("Mag", ".mag", fnames)
## change to all lowercase
fnames <- tolower(fnames)

## Add the 'subject' and 'activity' column names for column 1 and 2
cnames <- c("subject", "activity", fnames)

## assign column names to columns of the complete dataset
names(data_sub) <- cnames

## clean up the unused datasets
rm(list=c("cnames", "fnames", "features", "fcols", "flist"))


  
## ========= PART 5: CREATE A DATASET WITH AVERAGES ===================
  ## Assignment: From the data set in step 4, create a second, independent tidy 
  ## data set with the average of each variable for each activity and each subject.
  
  ## requires dplyr package
  require(dplyr)

    ## Group the data by subject and activity
    data_group <- group_by(data_sub, subject, activity)
    
    ## Summarise the data by applying the 'mean' function
    data_summary <- summarise_each(data_group, funs(mean))
    
    ## Finally, write the data into a file:
    write.table(data_summary, file="tidy_data.txt", row.names=F)
    
}