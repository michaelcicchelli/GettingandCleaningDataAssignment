GettingandCleaningDataAssignment

The data source can be downloaded and viewed manually at the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The features_info.txt file has a a detailed description of the measurements taken which comprise the dataset. 

The run_analysis.R script performs the following functions:
  1. Downloads dataset to active working directory and then sets working directory within downloaded folder
  2. Combines the data found within the following files:
    a. X_test.txt
    b. y_test.txt
    c. X_train.txt
    d. y_train.txt
    e. activity_labels.txt
    f. features.txt
    g. subject_test.txt
    h. subject_train.txt
  3. Calculates Mean and Standard Deviation for each subject, each activity, and each measurement type
  4. Creates competedata_merged.txt (all relevant measurements) and final_tidy_dataset.txt (Mean and Standard from completedata_merged.txt)

Note: the plyr and data.table R packages must be installed in order to run the run_analysis.R script successfully.
These packages can be installed using the insall.packages("plyr") and install.packages("data.table") commands.
