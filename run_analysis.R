#Obtaining Data and Loading package(s)

DLas <- "peer-graded-getting-cleaning-data.zip"                                                   #Sets Variable for what to name file.
DLfrom <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #sets variable for download URL
ExtractedDirectory <- "UCI HAR Dataset"                                                           #sets variable for extracted directory for verification
if(!file.exists(DLas)){                                                                           #If file does not exist
  download.file(DLfrom, DLas, mode = "wb")}                                                       #download file to the working directory ##From ?download.file documentation: The choice of binary transfer (mode = "wb" or "ab") is important on Windows, since unlike Unix-alikes it does distinguish between text and binary files and for text transfers changes \n line endings to \r\n (aka 'CRLF'). 
if(!file.exists(ExtractedDirectory)){                                                             #if ExtractedDirectory directory does not exist
  unzip(DLas, files = NULL, exdir=".")}                                                           #unzip downloaded file to Working Directory
if (!"reshape2" %in% installed.packages()) {                                                      #If 'reshape2' is not installed
  install.packages("reshape2")}                                                                   #install 'reshape2'
library("reshape2")                                                                               #loads 'reshape2'

#Reading each text file as a table (read.table) and establishing variables equivelant to its corresponding text file name.  Comments are explanations of individual tables and were pulled from README.txt in zip

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")                               #Each row identifies the subject who performed the activity for each window sample (1-30)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")                            #Each row identifies the subject who performed the activity for each window sample (1-30)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")                                           #Test Set
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")                                           #Test Labels
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")                                        #Training Set
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")                                        #Training Labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")                              #Links the class labels with their activity name
features <- read.table("UCI HAR Dataset/features.txt")                                            #list of all features

#Merging and Labeling Data

Combined_X <- rbind(X_train,X_test)                                                               #Merges the training and the test sets to create one data set using rbind 
MEANandSTD <- grep("mean()|std()", features[, 2])                                                 #Sets Variable MEADandSTD to a vector from the list of geatures of all column headers that contain either "mean()" or "std()"
Combined_X <- Combined_X[,MEANandSTD]                                                             #using the MEANandSTD Vector variable, removes all columns that do not contain either "mean()" or "std()"
ColumnHeaders <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})                          #takes the names of features and removes the parentheses and assigns to variable ColumnHeaders
names(Combined_X) <- ColumnHeaders[MEANandSTD]                                                    #Using the MEANandSTD vector, applies the specific, newly-formatted column headers to the column names of our data set.
subject <- rbind(subject_train, subject_test)                                                     #combines training and test data into single dataset for use in single column
names(subject) <- 'subject'                                                                       #names the single column in dataset appropriately based on source data
activity <- rbind(y_train, y_test)                                                                #combines training and test data into single dataset for use in single column
names(activity) <- 'activity'                                                                     #names the single column in dataset appropriately based on source data
DirtyDataSet <- cbind(subject,activity, Combined_X)                                               #combines our labeled "mean" and "std" results with subject and activity information
ActivityLabels <- factor(DirtyDataSet$activity)                                                   #creates a variable representing the factors of the activity column of our final data set
levels(ActivityLabels) <- activity_labels[,2]                                                     #sets the names of the individual Activities
DirtyDataSet$activity <- ActivityLabels                                                           #applies the appropriate label for each activity in lieu of a number

#Tidy the data

SkinnyData <- melt(DirtyDataSet,(id.vars=c("subject","activity")))                                #makes data skinny on the vector of id variables 'subject' and 'activity', leaving the remainder of variables on individual records
FinalDataSet <- dcast(SkinnyData, subject + activity ~ variable, mean)                            #takes skinny data and casts it with the subject, activity, and means of the other variables
write.table(FinalDataSet, "tidy_data.txt",row.name=FALSE, sep = ",")                              #writes required tidy_data.txt
write.csv(FinalDataSet,"tidy_data.csv")                                                           #writes a CSV (personal preference)

#System resources cleanup
file.remove(DLas)                                                                                 #removes downloaded source file
unlink(ExtractedDirectory, recursive=TRUE)                                                        #removes source data
rm(list=ls())                                                                                     #clears data set
