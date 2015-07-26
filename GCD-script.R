#-------------------------Read Files-----------------------------------
# Use 'read.table()' to read files by full filenames.  A loop may be
# written to read each file in the directory and assign a predetermined
# name as defined in a names vector.

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

#-------------------------Build Dataframe------------------------------
# Features is a dataframe of column names for the 'x_' dataframes.
# Extract the column information for feature names and store it into
# a variable as a vector -- for this case 'feature.names.vector'.
# Use 'colnames()' on 'x_'.
# As follows

feature.names.vector <- features$V2
colnames(x_test) <- feature.names.vector
colnames(x_train) <- feature.names.vector
#-------------------------Build Dataframe-----------------------------
# Two more vectors must be created and named for subjects and activity
# and added to the 'x_' dataframe.  Use 'cbind()' complete the dataframe
# and save it to a new variable -- 'complete.activity'.
# As follows

activity <- y_test$V1
subject <- subject_test$V1
complete.activity <- cbind(subject, activity, x_test)

# Here view the first 5 rows and first 3 columns:
# > complete.activity[1:5, 1:3]
#   subject activity tBodyAcc-mean()-X
# 1       2        5         0.2571778
# 2       2        5         0.2860267
# 3       2        5         0.2754848
# 4       2        5         0.2702982
# 5       2        5         0.2748330
#-------------------------Build Dataframe-------------------------------

# Once a working dataframe is constructed, the test and train datasets
# may be combined using 'cbind()' first as described above followed by 
# 'rbind()' to add additional rows.


activity <- y_train$V1
subject <- subject_train$V1
complete.activity.train <- cbind(subject, activity, x_train)

all.activity <- rbind(complete.activity, complete.activity.train)

# > all.activity[1:10, 1:6]
#    subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
# 1        2        5         0.2571778       -0.02328523       -0.01465376       -0.9384040
# 2        2        5         0.2860267       -0.01316336       -0.11908252       -0.9754147
# 3        2        5         0.2754848       -0.02605042       -0.11815167       -0.9938190
# 4        2        5         0.2702982       -0.03261387       -0.11752018       -0.9947428
# 5        2        5         0.2748330       -0.02784779       -0.12952716       -0.9938525
# 6        2        5         0.2792199       -0.01862040       -0.11390197       -0.9944552
# 7        2        5         0.2797459       -0.01827103       -0.10399988       -0.9958192
# 8        2        5         0.2746005       -0.02503513       -0.11683085       -0.9955944
# 9        2        5         0.2725287       -0.02095401       -0.11447249       -0.9967841
# 10       2        5         0.2757457       -0.01037199       -0.09977589       -0.9983731
#
# Take note of the dimensions and class of the completed dataframe.
# > dim(all.activity)
# [1] 10299   563
# > class(all.activity)
# [1] "data.frame"
#-------------------------Tidy the Dataframe--------------------------------------------------
# The initial dataframe is composed using the base package.  To simplify cleaning the data load
# 'tidyr' and 'dplyr'.  First the dataframe is loaded using 'tbl_df'.
require(plyr)
require(dplyr)
require(tidyr)

all.activity.3 <- all.activity[ !duplicated(names(all.activity))]
all.activity.3 <- tbl_df(all.activity.3)
select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))

# > select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))
# Source: local data frame [10,299 x 68]

#    subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
# 1        2        5         0.2571778       -0.02328523       -0.01465376            0.9364893           -0.2827192
# 2        2        5         0.2860267       -0.01316336       -0.11908252            0.9274036           -0.2892151
# 3        2        5         0.2754848       -0.02605042       -0.11815167            0.9299150           -0.2875128
# 4        2        5         0.2702982       -0.03261387       -0.11752018            0.9288814           -0.2933958
# 5        2        5         0.2748330       -0.02784779       -0.12952716            0.9265997           -0.3029609
# 6        2        5         0.2792199       -0.01862040       -0.11390197            0.9256632           -0.3089397
# 7        2        5         0.2797459       -0.01827103       -0.10399988            0.9261366           -0.3095639
# 8        2        5         0.2746005       -0.02503513       -0.11683085            0.9265862           -0.3107735
# 9        2        5         0.2725287       -0.02095401       -0.11447249            0.9255553           -0.3157374
# 10       2        5         0.2757457       -0.01037199       -0.09977589            0.9241734           -0.3175966
# ..     ...      ...               ...               ...               ...                  ...                  ...

# Careful examination of the remaining variables not printed shows that only colnames containing "mean()" or "std()" are
# selected.

chosen.variables <- select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))

require(car)

# Use the 'recode()' function in the package 'car' to assign the activity descriptors to the numbers in the 'activity' column
# Create a vector assigning 'activity' in 'chosen.variables' to 'activity.number'.
# http://www.inside-r.org/packages/cran/car/docs/recode
activity.number <- chosen.variables$activity

# > activity.number[1:100]
# [1] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 6 6 6 6 6 6 6 6 6 6
# [66] 6 6 6 6 6 6 6 6 6 6 6 6 6 6 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1

activity.recoded <- Recode(activity.number, "1 = 'walking'; 
                                             2 = 'walking upstairs'; 
                                             3 = 'walking downstairs'; 
                                             4 = 'sitting'; 
                                             5 = 'standing'; 
                                             6 = 'laying'")

# > activity.recoded[1:100]
# [1] "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing"
# [12] "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing"
# [23] "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "standing" "sitting"  "sitting" 
# [34] "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting" 
# [45] "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting"  "sitting" 
# [56] "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"  
# [67] "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"   "laying"  
# [78] "laying"   "laying"   "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking" 
# [89] "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking"  "walking" 
# [100] "walking" 


# Save the new recoded variables to the 'activity' column in 'chosen.variables'.
chosen.variables$activity <- activity.recoded

# > chosen.variables
# Source: local data frame [10,299 x 68]

#    subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
# 1        2 standing         0.2571778       -0.02328523       -0.01465376            0.9364893           -0.2827192
# 2        2 standing         0.2860267       -0.01316336       -0.11908252            0.9274036           -0.2892151
# 3        2 standing         0.2754848       -0.02605042       -0.11815167            0.9299150           -0.2875128
# 4        2 standing         0.2702982       -0.03261387       -0.11752018            0.9288814           -0.2933958
# 5        2 standing         0.2748330       -0.02784779       -0.12952716            0.9265997           -0.3029609
# 6        2 standing         0.2792199       -0.01862040       -0.11390197            0.9256632           -0.3089397
# 7        2 standing         0.2797459       -0.01827103       -0.10399988            0.9261366           -0.3095639
# 8        2 standing         0.2746005       -0.02503513       -0.11683085            0.9265862           -0.3107735
# 9        2 standing         0.2725287       -0.02095401       -0.11447249            0.9255553           -0.3157374
# 10       2 standing         0.2757457       -0.01037199       -0.09977589            0.9241734           -0.3175966
# ..     ...      ...               ...               ...               ...                  ...                  ...

#-------------------------------Write Tidy dataframe to a Table----------------------------
# Create a '.txt' file using 'write.table()'
write.table(chosen.variables, file = "activity_data.txt")

# The following code outputs a dataframe that shows the mean for each feature grouped by subject and activity,
# then arranged by subject and activity.

grouped <- group_by(chosen.variables, subject, activity)
arranged <- arrange(grouped, subject, activity)
summarise_each(arranged, funs(mean))

# Source: local data frame [180 x 68]
# Groups: subject

#    subject           activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X
# 1        1             laying         0.2215982      -0.040513953        -0.1132036           -0.2488818
# 2        1            sitting         0.2612376      -0.001308288        -0.1045442            0.8315099
# 3        1           standing         0.2789176      -0.016137590        -0.1106018            0.9429520
# 4        1            walking         0.2773308      -0.017383819        -0.1111481            0.9352232
# 5        1 walking downstairs         0.2891883      -0.009918505        -0.1075662            0.9318744
# 6        1   walking upstairs         0.2554617      -0.023953149        -0.0973020            0.8933511
# 7        2             laying         0.2813734      -0.018158740        -0.1072456           -0.5097542
# 8        2            sitting         0.2770874      -0.015687994        -0.1092183            0.9404773
# 9        2           standing         0.2779115      -0.018420827        -0.1059085            0.8969286
# 10       2            walking         0.2764266      -0.018594920        -0.1055004            0.9130173
# ..     ...                ...               ...               ...               ...                  ...

# The next code outputs a dataframe that shows the mean for each feature grouped by activity and subject,
# then arranged by activity and subject.

grouped2 <- group_by(chosen.variables, activity, subject)
arranged2 <- arrange(grouped2, activity, subject)
summarise_each(arranged2, funs(mean))

# Source: local data frame [180 x 68]
# Groups: activity

#    activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
# 1    laying       1         0.2215982       -0.04051395        -0.1132036           -0.2488818            0.7055498
# 2    laying       2         0.2813734       -0.01815874        -0.1072456           -0.5097542            0.7525366
# 3    laying       3         0.2755169       -0.01895568        -0.1013005           -0.2417585            0.8370321
# 4    laying       4         0.2635592       -0.01500318        -0.1106882           -0.4206647            0.9151651
# 5    laying       5         0.2783343       -0.01830421        -0.1079376           -0.4834706            0.9548903
# 6    laying       6         0.2486565       -0.01025292        -0.1331196           -0.4767099            0.9565938
# 7    laying       7         0.2501767       -0.02044115        -0.1013610           -0.5028143            0.3934443
# 8    laying       8         0.2612543       -0.02122817        -0.1022454           -0.4059300            0.5899224
# 9    laying       9         0.2591955       -0.02052682        -0.1075497           -0.5802528           -0.1191542
# 10   laying      10         0.2802306       -0.02429448        -0.1171686           -0.4530697           -0.1392977
# ..      ...     ...               ...               ...               ...                  ...                  ...

# The next code outputs a dataframe that shows the means of each feature grouped by activity,
# then arranged by subject.  Notice that the subject numbers are also averaged, but can be removed as shown
# in the next set of code.  Also note that averages are calculated across each activity.


grouped3 <- group_by(chosen.variables, activity)
arranged3 <- arrange(grouped3, subject)
summarise_each(arranged3, funs(mean))

# Source: local data frame [6 x 68]
# 
#             activity  subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X
# 1             laying 16.64352         0.2686486       -0.01831773        -0.1074356           -0.3750213
# 2            sitting 16.68036         0.2730596       -0.01268957        -0.1055170            0.8797312
# 3           standing 16.51312         0.2791535       -0.01615189        -0.1065869            0.9414796
# 4            walking 15.27294         0.2763369       -0.01790683        -0.1088817            0.9349916
# 5 walking downstairs 15.82859         0.2881372       -0.01631193        -0.1057616            0.9264574
# 6   walking upstairs 15.71697         0.2622946       -0.02592329        -0.1205379            0.8750034

summarise_each(grouped3, funs(mean), -subject)

# Source: local data frame [6 x 67]
# 
# activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
# 1             laying         0.2686486       -0.01831773        -0.1074356           -0.3750213            0.6222704
# 2            sitting         0.2730596       -0.01268957        -0.1055170            0.8797312            0.1087135
# 3           standing         0.2791535       -0.01615189        -0.1065869            0.9414796           -0.1842465
# 4            walking         0.2763369       -0.01790683        -0.1088817            0.9349916           -0.1967135
# 5 walking downstairs         0.2881372       -0.01631193        -0.1057616            0.9264574           -0.1685072
# 6   walking upstairs         0.2622946       -0.02592329        -0.1205379            0.8750034           -0.2813772


# Grouping by subject only introduces 'NA' into the activity column upon calculating the means.
# The following dataframe shows the mean for each feature grouped by subject with activity removed.
# A mean for each feature is assigned to each of the 30 subjects.

grouped5 <- group_by(chosen.variables, subject)
summarise_each(grouped5, funs(mean), -activity)

# Source: local data frame [30 x 67]
# 
# subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
# 1        1         0.2656969       -0.01829817        -0.1078457            0.7448674          -0.08255626
# 2        2         0.2731131       -0.01913232        -0.1156500            0.6607829          -0.14721989
# 3        3         0.2734287       -0.01785607        -0.1064926            0.7078144          -0.02605905
# 4        4         0.2741831       -0.01480815        -0.1075214            0.7065930           0.11259120
# 5        5         0.2791780       -0.01548335        -0.1056617            0.6981537           0.11231311
# 6        6         0.2723766       -0.01756970        -0.1159945            0.6887021           0.01620555
# 7        7         0.2702117       -0.01879049        -0.1124924            0.6812891          -0.04202215
# 8        8         0.2707591       -0.01818950        -0.1068096            0.6474982           0.03032111
# 9        9         0.2703138       -0.02094666        -0.1012338            0.6708455          -0.04674470
# 10      10         0.2768485       -0.01783579        -0.1113015            0.6429057          -0.07402485
# ..     ...               ...               ...               ...                  ...                  ...

