# TidyDataWeek4Project
My final project for the Getting and Cleaning Data course

The run_analysis.R script is applied to data contained in the Human Activity Recognition Using Smartphones Data Set found at. http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script will read in the following files, which should be located relative to the working directory as follows:
  UCI HAR Dataset/test/X_test.txt
  
  UCI HAR Dataset/test/y_test.txt
  
  UCI HAR Dataset/test/subject_test.txt
  
  UCI HAR Dataset/train/X_train.txt
  
  UCI HAR Dataset/train/y_train.txt
  
  UCI HAR Dataset/train/subject_train.txt
  
  UCI HAR Dataset/features.txt
  
  UCI HAR Dataset/activity_labels.txt

The script will work through the five steps of the assignment automatically as follows:

Step 1 - Merging of the test and train datasets
After reading in the test and train datasets, along with their associated activity type and subject labels, the data is converted to dplyr tbls.  The aforementioned labels are added to each tbl.  Finally, the test and train tbls are merged into a single tbl which the script calls 'mergedtbl'.

Step 2 - Extracting columns with mean or standard deviation data.
Step 4 - Label the columns with appropriate label names.
In otder to assist with the subsetting of the tbl by column, column labels are first assigned to the merged tbl using rbind.  A grep search is then performed to select all columns which contain 'mean', 'Mean', or 'std'.  At the end of this portion, data exists in 'step2tbl'.

Step 3 - Attaches descriptive activity names to each row.
Exercise types (or activities) are read in with their associated indeces.  Then a merge is performed by the indeces to attach a column of desriptive names to a new column in 'merged_step3'.

Step 4 - Note that this was combined with step 2 (see above.)

Step 5 - Create a tidy data set of the averages of each column.
After putting the subject index and activity type in the first two columns, the tbl is grouped by subject and activity type.  A summarise_all on the grouped tbl is then performed using the mean function.  Finally, the resulting 'summary_table' is sorted by subject and activity index and written to an output .txt file.

Please see the Codebook for definitions of all data.
