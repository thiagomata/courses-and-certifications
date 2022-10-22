# Coursera Getting and Cleaning Data Course Project
## Colleting, Working with and Cleaning Data 
## Analyse the Human Activity Recognition Using Smartphones Data Set

This is a R project to get and clean the data from the Coursera Course of Data Cleaning.
The data used in this project is from the Human Activity Recognition Using Smartphones.

# Data Set Information:

The data used in this project is from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones").

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

This project process the data, clean and merge some informations creating the [tidy data file](tidy_data.txt). You can see the description of the variables of this file in the [code book](CodeBook.Rmd)

More info can ben see into the article [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones")

# This script must

* Download the Experiment Data
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Load Libs

```{r libs}
# install the dplyr library if not installed
if (!require('dplyr')) {
  packages.install('dplyr')
}
# include dplyr library
library('dplyr')
```

## Define Constants

```{r const}
# Url to download the dataset zip data
dataset.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Name of directory of the unzip data from url
dataset.directory <-'UCI HAR Dataset'

# Directory where the data should be downloaded
setwd( '~' )
dataset.download.dir <- getwd()
```

## Define Functions

```{r define_functions}

###
# Fix column name 
###
fixName <- function (var) {
  
    # There is double Body in some vars.. fix them
    var <- gsub("(B+o+d+y+)+", "Body", var, ignore.case = TRUE)

    # Remove parentheses and hyphens
    var <- gsub('[\\(|\\)]', '', var)
    var <- gsub('-', '.', var)
    
    # replace 't' to 'time' and 'f' to 'frequency'
    if (substr(var, 1, 1) == 'f') {
      prefix <- 'frequency'    
    } else {
      prefix <- 'time'
    }
    
    # combine all together in the new name
    return(
      paste('calculated', prefix, tolower(substring(var, 2)), sep = '.')
    )
}

###
# Load the dataset into a data.frame and filter them to extract the
# data
###
LoadDataSet <- function (set) {
    path = file.path( dataset.download.dir, dataset.directory, set)
    
    subjectFile <- file.path(
      path, 
      paste0('subject_', set, '.txt')
    )
    
    activitiesFile <- file.path(
      path, 
      paste0('y_', set, '.txt')
    )
    
    metricsFile <- file.path(
      path, 
      paste0('X_', set, '.txt', sep = '')
    )
    
    # Load data from disk
    subjects   <- read.table( subjectFile )
    activities <- read.table( activitiesFile )
    metrics    <- read.table( metricsFile )
    
    # Appropriately labels the data set with descriptive variable names. 
    metric.labels <- sapply(metric.labels, fixName)
    names(metrics) <- metric.labels
    
    ##
    # To make easy to extracts only the measurements on the mean and 
    # standard deviation for each measurement, this functions
    # returns the columns what are mean or std
    ##
    filterColumnNames <- function(colname){
      if ( grepl(colname,  pattern = "\\.std") ) {
        return( TRUE )
      }
      if ( grepl(colname,  pattern = "\\.meanfreq") ) {
        return( FALSE )
      }
      return( grepl(colname,  pattern = "\\.mean") );
    }
    
    # Extracts only the measurements on the mean and standard deviation for each measurement. 
    columnIndexes = sapply(
      metric.labels, 
      filterColumnNames
    )
    metrics <- metrics[, columnIndexes]

    data <- cbind(subjects, activities)
    names(data) <- c('subject', 'activity')
    data <- cbind(data, metrics)
    
    return( data )
}
 
###
# Download experiment data
###
downloadData <- function () {

  data.extract.file <- file.path( dataset.download.dir, "runAnalytics.zip")
  
  # load data zip file
  if( ! file.exists( data.extract.file ) ) {
    print( "data file does not exist, downloading it")
    download.file( dataset.url, data.extract.file )
  }

  if ( ! file.exists( data.extract.file ) ) {
    warning('Error on downloading data')
  }
  
  dataset.extract.dir <- file.path( dataset.download.dir, dataset.directory )

  # extract data zip file
  if ( ! dir.exists( dataset.extract.dir ) ) {
    print("extracting zip file into data dir")
    unzip( dataFile, overwrite = TRUE, exdir = dataset.extract.dir )
  }

  # Check if unzip was ok
  if ( ! dir.exists( dataset.extract.dir ) ) {
     warning('Error on extracting data')
  }
}
```

## Download Experiment Data

```{r download_experiment_data}

# Download the Experiment Data
downloadData()

```

## Merge and Filter Data

```{r merge_data}

# Get the v2 column ( with data ) of the features file
metric.labels   <- read.table(
  file.path( dataset.download.dir, dataset.directory, 'features.txt' )
)$V2

# Get the v2 column ( with data ) of the activity label
activity.labels <- as.character(
  read.table(
    file.path( dataset.download.dir, dataset.directory, 'activity_labels.txt')
)$V2)

# Merge training data and the test data to create one data set.
data <- rbind(LoadDataSet('train'), LoadDataSet('test'))

# Sort by activity to apply labels
orderActivity <- order(data$activity)

# Apply labels
data <- data[orderActivity, ]
data[,"activity"] <- factor(data[,"activity"], labels = activity.labels)

```

## From the Data Set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```{r tidy_data}

# From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.
tidy.data <- group_by(data, subject, activity) %>% summarise_each(funs(mean))

tidy.file <- file.path( dataset.download.dir, 'tidy_data.txt')

# Output data to disk in fulfillment of: upload your data set as a txt file created with write.table() using row.name=FALSE
write.table(tidy.data, row.name=FALSE, file= tidy.file)

head( tidy.data )
```

The result of the running of this code is the creation of the [tidy data file](tidy_data.txt). You can see the description of the variables of this file in the [code book](CodeBook.Rmd)

