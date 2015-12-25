#Create appropriate directory, download relevant files, and record downloaded date stamp
	setwd("C:/Users/ecicmic/Documents")
	dir.create("UCI HAR Dataset")
	
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileURL, destfile = "./UCI HAR Dataset.zip")
	downloaddatestamp <- date()
	print(downloaddatestamp)
	
#Unzip all files and folders, set new working directory, and confirm contents
	unzip("UCI HAR Dataset.zip", exdir = "UCI HAR Dataset")
	setwd("C:/USers/ecicmic/Documents/UCI HAR Dataset/UCI HAR Dataset")
	dir()
	library(plyr)
	library(data.table)
	
#Read the relevant datasets into R (original files) and confirm new variable list
	activities <- read.table("activity_labels.txt")
	features <- read.table("features.txt")
	testsubjects <- read.table("test/subject_test.txt")
	trainsubjects <- read.table("train/subject_train.txt")
	xtestgroup <- read.table("test/X_test.txt")
	ytestgroup <- read.table("test/y_test.txt")
	xtraingroup <- read.table("train/X_train.txt")
	ytraingroup <- read.table("train/y_train.txt")
	

#Combine test and train datasets and extract datapoints of mean and standard deviation
	xgroupraw <- rbind(xtestgroup, xtraingroup)
	ygroupraw <- rbind(ytestgroup, ytraingroup)
	subjectids <- rbind(testsubjects, trainsubjects)
	colnames(subjectids) <- "SubjectID"
	featurecalc <- grep("-mean\\(\\)| -std\\(\\)", features[,2])
	activitydatay <- join(ygroupraw,activities)
	activitydatay <- activitydatay[,2]
	activitydatay <- data.frame(activitydatay)
	colnames(activitydatay) <- "ActivityLabels"
	activitydatax <- xgroupraw[,featurecalc]
	names(activitydatax) <- gsub("\\(|\\)", "", features$V2[featurecalc])
	completedata <- cbind(subjectids, activitydatax, activitydatay)
	write.table(completedata, "completedata_merged.txt")

#Produce final tidy dataset with relevant standard deviations and means
	tidydataset <- data.table(completedata)
	datapoints <- tidydataset[, lapply(.SD, mean), by = c("SubjectID", "ActivityLabels")]
	write.table(datapoints, "final_tidy_dataset.txt", row.name = FALSE)
