# run_analysis.R
# This script reads files from the 'UCI HAR Dataset' provided by Coursera Getting and Cleaning Data,
# then constructs three types of tidy data frame from 'UCI HAR Dataset', and writes a table to a '.txt' file.
# -----------------------------------------------------------------------------------------------------------

# Load the required R packages
require(plyr)
require(dplyr)
require(tidyr)
require(car)
# -----------------------------------------------------------------------------------------------------------

# Read the files into variables.  This may be achieved with a looping function.

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# -----------------------------------------------------------------------------------------------------------

# Construct the initial data frame

# Assign column names
feature.names.vector <- features$V2
colnames(x_test) <- feature.names.vector
colnames(x_train) <- feature.names.vector

# Attach activity data and bind 'train' and 'test' data
activity <- y_test$V1
subject <- subject_test$V1
complete.activity <- cbind(subject, activity, x_test)

activity <- y_train$V1
subject <- subject_train$V1
complete.activity.train <- cbind(subject, activity, x_train)

all.activity <- rbind(complete.activity, complete.activity.train)

# Remove duplicate columns
all.activity.3 <- all.activity[ !duplicated(names(all.activity))]
all.activity.3 <- tbl_df(all.activity.3)
## select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))
## chosen.variables <- select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))

# Recode the integer values to character strings for 'activity'
## activity.number <- chosen.variables$activity
activity.number <- all.activity.3$activity
activity.recoded <- Recode(activity.number, "1 = 'walking'; 
                                             2 = 'walking upstairs'; 
                                             3 = 'walking downstairs'; 
                                             4 = 'sitting'; 
                                             5 = 'standing'; 
                                             6 = 'laying'")
## chosen.variables$activity <- activity.recoded
all.activity.3$activity <- activity.recoded


# Tidy the data frame and create a new file
all.activity.3 %>%
  select(subject, activity, contains("mean()"), contains("std()")) %>%
  group_by(subject, activity) %>%
  arrange(subject, activity) %>%
  summarise_each(funs(mean)) %>%
  write.table(file = "tidy_data_1.txt")

all.activity.3 %>%
  select(subject, activity, contains("mean()"), contains("std()")) %>%
  group_by(activity) %>%
  arrange(subject) %>%
  summarise_each(funs(mean), -subject) %>%
  write.table(file = "tidy_data_2.txt")

all.activity.3 %>%
  select(subject, activity, contains("mean()"), contains("std()")) %>%
  group_by(subject) %>%
  summarise_each(funs(mean), -activity) %>%
  write.table(file = "tidy_data_3.txt")

tdata1 <- read.table("tidy_data_1.txt")
tdata2 <- read.table("tidy_data_2.txt")
tdata3 <- read.table("tidy_data_3.txt")

View(tdata1)
View(tdata2)
View(tdata3)

### FOR A MORE DETAILED EXPLANATION PLEASE SEE THE CODEBOOK AND README FILES ###
