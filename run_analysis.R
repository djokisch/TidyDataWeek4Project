library(dplyr)
library(tidyr)

## Reading in the test data: X_test.txt
testtbl <- read.table("UCI HAR Dataset/test/X_test.txt",stringsAsFactors = FALSE)
testtbl <- tbl_df(testtbl)
## Reading in the test exercise type from y_test.txt
testlabel <- read.table("UCI HAR Dataset/test/y_test.txt",stringsAsFactors = FALSE)
## Reading in the test subjects from train/subject_test.txt
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = FALSE)

## Reading in the training data: X_train.txt
traintbl <- read.table("UCI HAR Dataset/train/X_train.txt",stringsAsFactors = FALSE)
traintbl <- tbl_df(traintbl)
## Reading in the training exercise type from y_train.txt
trainlabel <- read.table("UCI HAR Dataset/train/y_train.txt",stringsAsFactors = FALSE)
## Reading in the test subjects from train/subject_test.txt
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = FALSE)

## Adding the exersize type labels (as integer codes) as a column in each of the two tbls
testtbl <- mutate(testtbl,xrsize=testlabel[,1])
traintbl <- mutate(traintbl,xrsize=trainlabel[,1])
## Adding the subject labels (as integer codes) as a column in each of the two tbls
testtbl <- mutate(testtbl,subject=test_subject[,1])
traintbl <- mutate(traintbl,subject=train_subject[,1])

## Merging the test and train tbls using rbind
mergedtbl <- rbind(testtbl,traintbl)
###################################
## Step 1 of assignment now complete
###################################

## Loading column names to match definitions in features.txt
cnames <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
cnames <- rbind(cnames,c(562,"xrsize"))
cnames <- rbind(cnames,c(563,"subject"))

## Subsetting to end up with only mean and std dev values
ndx <- grep("[Mm]ean|std|xrsize|subject", cnames[,2])
step2tbl <- select(mergedtbl,ndx)
## Applying column names
names(step2tbl) <- cnames[ndx,2]
###################################
## Steps 2 and 4 of assignment now complete
## while this script completes step 4 prior to 3, it is safe
###################################

## Reading in activity types from activity_labels.txt
actvy_lbl <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
## Merging the labels with the tbl.  Index values for exercise type will be replaced
## with descriptive labels as shown in activity_labels.txt
merged_step3 <- merge(step2tbl, actvy_lbl, by.x="xrsize", by.y="V1")
merged_step3 <- rename(merged_step3, exercise=V2)
###################################
## Step 3 of assignment now complete
###################################

## Beginning Step 5...need to create a new tidy data set of the averages of each column
## these will be grouped by activity and subject
## So...the mean of each column for person 1 walking, person 1 sitting, etc.

## putting the subject and exercise columns at the front
step5tbl <- select(step5tbl,subject,exercise,everything())
## grouping by subject and exercise
step5tbl <- group_by(step5tbl,subject,exercise)
## computing the mean of each column by the groups above
summary_table <- step5tbl %>% summarise_all(mean)
## sorting summary_table by subject first, then exercise (descending)
summary_table <- arrange(summary_table,subject,xrsize)

## Writing the final summary data table out as .txt
write.table(summary_table, file="summary.txt", row.name=FALSE)
