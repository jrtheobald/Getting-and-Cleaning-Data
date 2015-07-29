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

##Notes
All work for this project was completed using Rstudio.
Scripts contain lines of code that were placed for testing and were not deleted.  Those lines are indicated by '##' two hash marks where '#' indicate comments.
The analysis script reads the output files and passes them to `View()` for easy viewing of the dataframe. Use comment symbols to prevent viewing.

##Resources 

<http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name>

<http://www.inside-r.org/packages/cran/car/docs/recode>

<http://daringfireball.net/projects/markdown/dingus>
