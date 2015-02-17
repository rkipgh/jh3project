# February 2015
# This script was written for Johns Hopkins University Coursera "Getting and Cleaning Data" course

# This script arranges and organizes a data set for later analysis
# The tasks that the script executes are described below in the comments labeled "INSTRUCTIONS"

# The data are from cell phone accelerometer readings recorded from 30 participants while
# they were performing various activities (e.g., walking, standing, sitting)

# data originally downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# data are described at
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# reads data from local directory "UCI HAR Dataset" extracted from downloaded zip file
testsubject = read.table("./UCI HAR Dataset/test/subject_test.txt")        # subject ID numbers for testing data set
testx = read.table("./UCI HAR Dataset/test/X_test.txt")                    # measured variables for testing data set
testy = read.table("./UCI HAR Dataset/test/y_test.txt")                    # numbers denoting the activities performed by the subjects for the testing data set
trainsubject = read.table("./UCI HAR Dataset/train/subject_train.txt")     # subject ID numbers for training data set
trainx = read.table("./UCI HAR Dataset/train/X_train.txt")                 # measured variables for training data set
trainy = read.table("./UCI HAR Dataset/train/y_train.txt")                 # numbers denoting the activities performed by the subjects for the testing data set

# INSTRUCTIONS:  1. Merges the training and the test sets to create one data set.
# combines subject ID numbers, activity-denoting numbers, and measured variables for each data set
test = cbind(testsubject, testy, testx)
train = cbind(trainsubject, trainy, trainx)
# combines training and testing data sets into one data set
data = rbind(train, test)                         

# SHOULD I RE-ORDER THE DATA BY SUBJECT ID?
# INSTRUCTIONS:  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
varnames = read.table("./UCI HAR Dataset/features.txt")                    # reads names of the measured variables
varnamescol = 2                                                            # the variable names are in the 2nd column
meanlocales = grepl("-mean()", varnames[ , varnamescol], fixed = TRUE)     # identifies where means are in the measured variables
sdlocales = grepl("-std()", varnames[ , varnamescol], fixed = TRUE)        # identifies where standard deviations are in the measured variables
meansdindices = which(meanlocales)                          
meansdindices = append(meansdindices, which(sdlocales))     
meansdindices = sort(meansdindices)                                        # column indices for measured variables that are means or standard deviations
varcolnames = varnames[meansdindices, varnamescol]                         # reads variable names of measured variables that are means or standard deviations (for INSTRUCTION #4 below)
meansdindices = meansdindices + 2                                          # adjusts column indices for the earlier prepending of 2 columns:  subject ID numbers and activity-denoting numbers
meansddata = data[ , c(1, 2, meansdindices)]                               # data with only means and standard deviations (excludes all other measured variables)

# INSTRUCTIONS:  3. Uses descriptive activity names to name the activities in the data set
activitynames = read.table("./UCI HAR Dataset/activity_labels.txt")        # reads names of the activities performed by the subjects
activitiescol = 2                                                          
meansddata[ , activitiescol] = as.factor(meansddata[ , activitiescol])     # changes the activities column (derived from trainy and testy) from numeric to a factor
levels(meansddata[ , activitiescol]) = levels(activitynames[ , 2])         # renames the activities column from numbers to descriptive names originally from "activity_labels.txt"

# INSTRUCTIONS:  4. Appropriately labels the data set with descriptive variable names. 
# renames variable columns with descriptive names originally from "features.txt"
colnames(meansddata) = c("subjectID", "activity", as.vector(varcolnames))  

# INSTRUCTIONS:  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# the "aggregate" function groups all rows/observations for each combination of subject ID number and activity performed by the subject
# in grouping together the rows/observations, the "aggregate" function finds the mean of the measured variable
datameanedby = aggregate(meansddata[ , 3:dim(meansddata)[2]], 
                         by = meansddata[ , 1:2], 
                         FUN = mean)

# writes data to text file
write.table(datameanedby, file = "output.txt", row.names = FALSE)
