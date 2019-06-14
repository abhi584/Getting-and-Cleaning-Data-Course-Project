# getting-cleaning-data-peer-graded
Coursera Data Science Specialization - Course 3, Week 4, Peer-Graded Assignment

*This repo contrains (4) files:  This README.md, run_analysis.R, and the script output, in both csv and txt formats.*

How the script works:
1) Downloads specified zip file and extracts to working directory if zip and extracted folders don't already exist and loads all needed R packages (reshape2)
2) Reads all applicable txt files as tables and assigns to variables
3) Removes unneccesary columns, combines variables appropriately, and labels columns and activities
4) Melts and Casts, using reshape2, data to take means for each person (1-30) performing each activity and writes data to txt (and csv)
5) removes downloaded file, extracted file(s), and variables from work environment for resource management

Variables Created & Used
1) DLas <- name of downloaded file
2) DLfrom <- URL of file to be downloaded
3) ExtractedDirectory <- Name of extracted folder
4) subject_test <- Read Table from raw data
5) subject_train <- Read Table from raw data
6) X_test <- Read Table from raw data
7) y_test <- Read Table from raw data
8) X_train <- Read Table from raw data
9) y_train <- Read Table from raw data
10) activity_labels <- Read Table from raw data
11) features <- Read Table from raw data
12) Combined_X <- combined data from X_test and X_train
13) MEANandSTD <- Vector identifying the column numbers that contain "std()" and "mean()"
14) ColumnHeaders <- Cleaned columnheader names (removal of parentheses)
15) subject <- rbound data from subject_test and subject_train
16) activity <- rbound data from activity_test and activity_train
17) DirtyDataSet <- cbound subject, activity, Combined_X
18) ActivityLabels <- a factor for comparing an activity number to a label
19) SkinnyData <- Melted data (reshape2)
20) FinalDataSet <- Casted data (reshape2)
