---
title: "Tidy Data"
author: "James Theobald"
date: "July 25, 2015"
output: html_document
---

README
======

Getting and Cleaning Data Course Project
----------------------------------------

The purpose of this project is to build a tidy data set from files listed in the UCI HAR Dataset folder provided by the course instructors.  Descriptions of variables and experimental procedure can be found in `features_info.txt` and `README.txt` in the UCI HAR Dataset folder.  This information will not be described in the project work.

##The following sections are included in the codebook
* `GCD script` -- this file is a detailed explanation of the code used to tidy data
* `Duplicated Column Names` -- this is an illustration and resolution of duplicates
* `Dataframe structure` -- this is the structure of the data frames output by `run_analysis.R`
* `Session info` -- resutls of running session information functions

##The following files are output by `run_analysis.R`
* `tidy_data_1.txt`
* `tidy_data_2.txt`
* `tidy_data_3.txt`

##Cleaning the Data
To begin building the clean dataset be sure the UCI HAR Dataset is in the working directory, then source the script `run_analysis.R`.
The analysis will begin with reading all the data except inertial data.  For simplicity, inertial data is excluded.  Columns are bound and column names added from the appropriate data files. Duplicate column names are removed, and columns selected.  The final tidy data is selected, grouped, arranged, and summarized.  Summaries report the mean of means of the `mean()` and `std()` for each feature (varialble).  Finally, a new file is written to save the tidy data.

```{r eval = FALSE}
source("run_analysis.R")
```

R version 3.2.1 (2015-06-18)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] devtools_1.8.0 car_2.0-25     tidyr_0.2.0    dplyr_0.4.2    plyr_1.8.3    

loaded via a namespace (and not attached):
 [1] Rcpp_0.11.6      rstudioapi_0.3.1 xml2_0.1.1       magrittr_1.5     splines_3.2.1    MASS_7.3-40      lattice_0.20-31 
 [8] R6_2.1.0         minqa_1.2.4      tools_3.2.1      nnet_7.3-9       parallel_3.2.1   pbkrtest_0.4-2   grid_3.2.1      
[15] nlme_3.1-120     mgcv_1.8-6       quantreg_5.11    DBI_0.3.1        git2r_0.10.1     rversions_1.0.2  digest_0.6.8    
[22] lme4_1.1-8       lazyeval_0.1.10  assertthat_0.1   Matrix_1.2-1     nloptr_1.0.4     curl_0.9.1       memoise_0.2.1   
[29] SparseM_1.6     

Session info -----------------------------------------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.2.1 (2015-06-18)
 system   x86_64, mingw32             
 ui       RStudio (0.99.465)          
 language (EN)                        
 collate  English_United States.1252  
 tz       America/New_York            

Packages ---------------------------------------------------------------------------------------------------------------------------------
 package    * version date       source        
 assertthat   0.1     2013-12-06 CRAN (R 3.2.1)
 car        * 2.0-25  2015-03-03 CRAN (R 3.2.1)
 curl         0.9.1   2015-07-04 CRAN (R 3.2.1)
 DBI          0.3.1   2014-09-24 CRAN (R 3.2.1)
 devtools   * 1.8.0   2015-05-09 CRAN (R 3.2.1)
 digest       0.6.8   2014-12-31 CRAN (R 3.2.0)
 dplyr      * 0.4.2   2015-06-16 CRAN (R 3.2.1)
 git2r        0.10.1  2015-05-07 CRAN (R 3.2.1)
 lattice      0.20-31 2015-03-30 CRAN (R 3.2.1)
 lazyeval     0.1.10  2015-01-02 CRAN (R 3.2.1)
 lme4         1.1-8   2015-06-22 CRAN (R 3.2.1)
 magrittr     1.5     2014-11-22 CRAN (R 3.2.0)
 MASS         7.3-40  2015-03-21 CRAN (R 3.2.1)
 Matrix       1.2-1   2015-06-01 CRAN (R 3.2.1)
 memoise      0.2.1   2014-04-22 CRAN (R 3.2.1)
 mgcv         1.8-6   2015-03-31 CRAN (R 3.2.1)
 minqa        1.2.4   2014-10-09 CRAN (R 3.2.1)
 nlme         3.1-120 2015-02-20 CRAN (R 3.2.1)
 nloptr       1.0.4   2014-08-04 CRAN (R 3.2.1)
 nnet         7.3-9   2015-02-11 CRAN (R 3.2.1)
 pbkrtest     0.4-2   2014-11-13 CRAN (R 3.2.1)
 plyr       * 1.8.3   2015-06-12 CRAN (R 3.2.1)
 quantreg     5.11    2015-01-11 CRAN (R 3.2.1)
 R6           2.1.0   2015-07-04 CRAN (R 3.2.1)
 Rcpp         0.11.6  2015-05-01 CRAN (R 3.2.1)
 rstudioapi   0.3.1   2015-04-07 CRAN (R 3.2.1)
 rversions    1.0.2   2015-07-13 CRAN (R 3.2.1)
 SparseM      1.6     2015-01-05 CRAN (R 3.2.1)
 tidyr      * 0.2.0   2014-12-05 CRAN (R 3.2.1)
 xml2         0.1.1   2015-06-02 CRAN (R 3.2.1)
 
### GCD Script
 
Read Files  
 Use `read.table()` to read files by full filenames.  A loop may be
 written to read each file in the directory and assign a predetermined
 name as defined in a names vector.

```{r eval = FALSE}
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
```

###Build Dataframe  

 Features is a dataframe of column names for the 'x_' dataframes.
 Extract the column information for feature names and store it into
 a variable as a vector -- for this case 'feature.names.vector'.
 Use `colnames()` on 'x_'.
 As follows

```{r eval = FALSE}
feature.names.vector <- features$V2
colnames(x_test) <- feature.names.vector
colnames(x_train) <- feature.names.vector
```

 Two more vectors must be created and named for subjects and activity
 and added to the 'x_' dataframe.  Use `cbind()` complete the dataframe
 and save it to a new variable -- 'complete.activity'.
 As follows

```{r eval = FALSE}
activity <- y_test$V1
subject <- subject_test$V1
complete.activity <- cbind(subject, activity, x_test)
```

 Here view the first 5 rows and first 3 columns:  

```{r eval = FALSE}  
  complete.activity[1:5, 1:3] 

 subject activity tBodyAcc-mean()-X  
 1       2        5         0.2571778  
 2       2        5         0.2860267  
 3       2        5         0.2754848  
 4       2        5         0.2702982  
 5       2        5         0.2748330  
```

 Once a working dataframe is constructed, the test and train datasets
 may be combined using 'cbind()' first as described above followed by 
 `rbind()` to add additional rows.


```{r eval = FALSE}
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
```
 Take note of the dimensions and class of the completed dataframe.
```{r eval = FALSE}
# > dim(all.activity)
# [1] 10299   563
# > class(all.activity)
# [1] "data.frame"
```

###Tidy the Dataframe

 The initial dataframe is composed using the base package.  To simplify cleaning the data load
 'tidyr' and 'dplyr'.  First the dataframe is loaded using `tbl_df()`.

```{r eval = FALSE}
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
```

 Careful examination of the remaining variables not printed shows that only colnames containing "mean()" or "std()" are
 selected.

```{r eval = FALSE)

chosen.variables <- select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))
```
```{r eval = FALSE}
require(car)
```
 Use the 'recode()' function in the package 'car' to assign the activity descriptors to the numbers in the 'activity' column
 Create a vector assigning 'activity' in 'chosen.variables' to 'activity.number'.
 <http://www.inside-r.org/packages/cran/car/docs/recode>

```{r eval = FALSE}
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
```

 Save the new recoded variables to the 'activity' column in 'chosen.variables'.

```{r eval = FALSE}
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
```

###Write Tidy dataframe to a Table
 Create a '.txt' file using `write.table()`

```{r eval = FALSE)
write.table(chosen.variables, file = "activity_data.txt")
```

 The following code outputs a dataframe that shows the mean for each feature grouped by subject and activity,
 then arranged by subject and activity.

```{r eval = FALSE}
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
```

 The next code outputs a dataframe that shows the mean for each feature grouped by activity and subject,
 then arranged by activity and subject.

```{r eval = FALSE}
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
```

 The next code outputs a dataframe that shows the means of each feature grouped by activity,
 then arranged by subject.  Notice that the subject numbers are also averaged, but can be removed as shown
 in the next set of code.  Also note that averages are calculated across each activity.

```{r eval = FALSE}
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
```

 Grouping by subject only introduces 'NA' into the activity column upon calculating the means.
 The following dataframe shows the mean for each feature grouped by subject with activity removed.
 A mean for each feature is assigned to each of the 30 subjects.

```{r eval = FALSE}
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
```

###Duplicated Column Names Illustration and Resolution

An initial attempt to `select()` specific columns from the tbl_df results in an 'duplicated column name' error.
Note the first 10 rows of the tbl_df 'all.activity.2' consisting of 10,299 rows and 563 columns.  The 'select()' 
code results in the error.

```{r eval = FALSE}
  > require(dplyr)
  > require(tidyr)
  > all.activity.2 <- tbl_df(all.activity)
  > all.activity.2
  Source: local data frame [10,299 x 563]

     subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
  1        2        5         0.2571778       -0.02328523       -0.01465376       -0.9384040
  2        2        5         0.2860267       -0.01316336       -0.11908252       -0.9754147
  3        2        5         0.2754848       -0.02605042       -0.11815167       -0.9938190
  4        2        5         0.2702982       -0.03261387       -0.11752018       -0.9947428
  5        2        5         0.2748330       -0.02784779       -0.12952716       -0.9938525
  6        2        5         0.2792199       -0.01862040       -0.11390197       -0.9944552
  7        2        5         0.2797459       -0.01827103       -0.10399988       -0.9958192
  8        2        5         0.2746005       -0.02503513       -0.11683085       -0.9955944
  9        2        5         0.2725287       -0.02095401       -0.11447249       -0.9967841
  10       2        5         0.2757457       -0.01037199       -0.09977589       -0.9983731
  ..     ...      ...               ...               ...               ...              ...

  > select(all.activity.2, subject, activity, contains("mean()"), contains("std()"))
  Error: found duplicated column name
```

Thanks to a post on stack overflow (SO): <http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name>
One post indicates the following code to
    1 -- remove all of the non-duplicated names into a new dataframe
    2 -- pass the new dataframe into tbl_df
    3 -- select the necessary columns
  
Note that the new dataframe has 68 columns which disagrees with the code posted to SO.  The difference is due
to the matching term used to find column names, i.e. "mean()" and "std()" vs. "mean" and "std".

```{r eval = FALSE}
  > all.activity.3 <- all.activity[ !duplicated(names(all.activity))]
  > all.activity.3 <- tbl_df(all.activity.3)
  > View(all.activity.3)
  > select(all.activity.3, subject, activity, contains("mean()"), contains("std()"))
  Source: local data frame [10,299 x 68]
  
     subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
  1        2        5         0.2571778       -0.02328523       -0.01465376            0.9364893           -0.2827192
  2        2        5         0.2860267       -0.01316336       -0.11908252            0.9274036           -0.2892151
  3        2        5         0.2754848       -0.02605042       -0.11815167            0.9299150           -0.2875128
  4        2        5         0.2702982       -0.03261387       -0.11752018            0.9288814           -0.2933958
  5        2        5         0.2748330       -0.02784779       -0.12952716            0.9265997           -0.3029609
  6        2        5         0.2792199       -0.01862040       -0.11390197            0.9256632           -0.3089397
  7        2        5         0.2797459       -0.01827103       -0.10399988            0.9261366           -0.3095639
  8        2        5         0.2746005       -0.02503513       -0.11683085            0.9265862           -0.3107735
  9        2        5         0.2725287       -0.02095401       -0.11447249            0.9255553           -0.3157374
  10       2        5         0.2757457       -0.01037199       -0.09977589            0.9241734           -0.3175966
  ..     ...      ...               ...               ...               ...                  ...                  ...
  
  > select(all.activity.3, subject, activity, contains("mean"), contains("std"))
  Source: local data frame [10,299 x 88]
  
     subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
  1        2        5         0.2571778       -0.02328523       -0.01465376            0.9364893           -0.2827192
  2        2        5         0.2860267       -0.01316336       -0.11908252            0.9274036           -0.2892151
  3        2        5         0.2754848       -0.02605042       -0.11815167            0.9299150           -0.2875128
  4        2        5         0.2702982       -0.03261387       -0.11752018            0.9288814           -0.2933958
  5        2        5         0.2748330       -0.02784779       -0.12952716            0.9265997           -0.3029609
  6        2        5         0.2792199       -0.01862040       -0.11390197            0.9256632           -0.3089397
  7        2        5         0.2797459       -0.01827103       -0.10399988            0.9261366           -0.3095639
  8        2        5         0.2746005       -0.02503513       -0.11683085            0.9265862           -0.3107735
  9        2        5         0.2725287       -0.02095401       -0.11447249            0.9255553           -0.3157374
  10       2        5         0.2757457       -0.01037199       -0.09977589            0.9241734           -0.3175966
  ..     ...      ...               ...               ...               ...                  ...                  ...
```  

Further investigation reveals that there are 84 duplicated coloumn names in features.txt.  There are also other column names that contain "mean" or "std" which are not technically the mean of a particular feature.  For example, the angle() variable lists several mean values as other columns named such as meanFreq.  For the sake of simplicity in completing the assingment only columns fitting the following pattern were isolated: 'feature-fun()-axis' where feature is the name of the feature as described in features_info.txt, fun() is either mean() or std(), and axis is X, Y, or Z.

The following is the code used to investigate column names.
 
```{r eval = FALSE} 
  > meanStdColumns <- grep("mean|std", features$V2, value = FALSE)
  > meanStdColumnsNames <- grep("mean|std", features$V2, value = TRUE)
  > duplicated(meanStdColumnsNames)
  > duplicated(c(features$V2))
  > sum(duplicated(c(features$V2)))
  > length(meanStdColumnsNames)
  > length(meanStdColumns)
```

##Notes
All work for this project was completed using Rstudio.
Scripts contain lines of code that were placed for testing and were not deleted.  Those lines are indicated by '##' two hash marks where '#' indicate comments.
The analysis script reads the output files and passes them to `View()` for easy viewing of the dataframe. Use comment symbols to prevent viewing.

##Resources 

<http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name>

<http://www.inside-r.org/packages/cran/car/docs/recode>

<http://daringfireball.net/projects/markdown/dingus>
