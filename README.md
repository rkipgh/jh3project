February 2015

This project was implemented for the course project for the Johns Hopkins University / Coursera "Getting and Cleaning Data" course.

This document describes the data organizing process executed by the file "run_analysis.R".  The data are from cell phone accelerometer readings recorded from 30 participants while they were performing various activities (e.g., walking, standing, sitting).

The data were originally downloaded from<br>
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data are described at<br>
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

After extracting the data files from the downloaded zip file, they are stored in the directory "UCI HAR Dataset" within the working directory.  The data set was split into training and testing subsets.  These subsets are found in "UCI HAR Dataset/train" and "UCI HAR Dataset/test" directories, respectively.  The following files are read by the "run_analysis.R" script, and the descriptions of their contents follow:

"UCI HAR Dataset/train/subject_train.txt"	
subject ID numbers for training data set

"UCI HAR Dataset/train/X_train.txt"		    
measured variables for training data set

"UCI HAR Dataset/train/y_train.txt"		    
numbers denoting the activities performed by the subjects for the testing data set

"UCI HAR Dataset/test/subject_test.txt"		
subject ID numbers for testing data set

"UCI HAR Dataset/test/X_test.txt"		      
measured variables for testing data set

"UCI HAR Dataset/test/y_test.txt"		      
numbers denoting the activities performed by the subjects for the testing data set

The data in the directories "UCI HAR Dataset/test/Inertial Signals" and "UCI HAR Dataset/train/Inertial Signals" were not read by the "run_analysis.R" script because a later step in the project instructions calls for retaining only variables that are means and standard deviations of the measured variables.  There are no means or standard deviations in these two "Inertial Signals" directories, so they were excluded.


The subsequent sections of this document are headed by the corresponding "INSTRUCTION" for the project.

**INSTRUCTIONS:  1. Merges the training and the test sets to create one data set.**
<br>
After combining the training set files together, the resulting data table consisted of 563 columns and 7352 rows.  The first column was the subject/participant ID numbers, the second column was the numbers denoting the activities performed by the subjects/participants, and the remaining columns were 561 variables measured from the experiment.  The testing set files were similarly combined so that the columns were arranged identically as they were for the training data set.  The resulting data table for the testing set consisted of 2947 rows.  The training and testing data sets were then combined, resulting in a data table with 563 columns arranged identically as they were in the training and testing data tables and 10299 rows (7352 rows from the training set plus 2947 rows from the testing set).


**INSTRUCTIONS:  2. Extracts only the measurements on the mean and standard deviation for each measurement.**
<br>
At the next step, columns containing measured variables that were not means or standard deviations were removed from the data set.  The resulting table consisted of the subject ID number column, the column of numbers denoting the activities performed by the subjects, and 66 columns of measured variables that did include means or standard deviations.  The abbreviated variable names describing which measured variables were or were not means or standard deviations were located in the file "UCI HAR Dataset/features.txt".  Some columns of variables described as means were removed from the data set.  Only the variables that had standard deviations that corresponded to the means for the same variable were retained.  

For example, the variable "tBodyAcc-mean()-X" (in column 1 of "UCI HAR Dataset/train/X_train.txt" and "UCI HAR Dataset/train/X_test.txt") has a corresponding standard deviation in the variable "tBodyAcc-std()-X" (in column 4 of "UCI HAR Dataset/train/X_train.txt" and "UCI HAR Dataset/train/X_test.txt").  But the variable "angle(Z,gravityMean)" (in column 561 of "UCI HAR Dataset/train/X_train.txt" and "UCI HAR Dataset/train/X_test.txt") had no variable with the corresponding standard deviation, so it was removed from the data set.  Such variables of means without corresponding standard deviations were removed based on the assumption that any planned analyses on a variable would require the standard deviation in addition to the mean.


**INSTRUCTIONS:  3. Uses descriptive activity names to name the activities in the data set**
<br>
The activities performed by the subjects were denoted by integers in the second column of the data set.  These integers were replaced with their corresponding text labels from "UCI HAR Dataset/activity_labels.txt".  There were 6 text labels:  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.


**INSTRUCTIONS:  4. Appropriately labels the data set with descriptive variable names.**
<br>
The measured variables of means and standard deviations in columns 3 - 68 of the data set were labeled with the same labels found in "UCI HAR Dataset/features.txt".


**INSTRUCTIONS:  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**
<br>
There were 30 subjects/participants in the study, and each participant performed all 6 activities.  There should be one row for each combination of subjects and activities, which results in 180 rows (30 subjects multiplied by 6 activities).  There were multiple observations for each subject-activity combination (i.e., there were many more than 180 rows in the data set; there were 10299 rows in the data set).  In accordance with the instructions, all 66 measured variables were averaged to provide 66 means for each subject-activity combination.  The resulting data set had 180 columns and 68 rows (66 measured variables, plus 2 columns for the subject ID and activity labels).

This final data set meets the criteria for a tidy data set.  Each of the 66 measured variables has its own column.  Each subject-activity combination is an observation and has its own row.  All the variables are of the same "kind" in that they are all movement-related variables generated in the same experiment, so they are all in one table.  In addition to those requirements, all variables are all named in column headers.  These names are abbreviated to make them easier to work with during analysis, but the abbreviations are readily understandable after the brief look at the codebook.

The codebook is available in three files in three different file formats:  "codebook.md", "codebookfinal.html", and " codebookfinal.pdf".  The codebook includes each variable's column number, abbreviated name, description, type, and range of values.  The variables do not include units because the measured variables were normalized in the data set as originally downloaded.
