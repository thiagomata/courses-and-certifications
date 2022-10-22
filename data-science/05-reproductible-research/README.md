# Reproducible Research: Peer Assessment 1

## Introduction

This assignment makes use of data from a personal activity monitoring
device. This device collects data at 5 minute intervals through out the
day. The data consists of two months of data from an anonymous
individual collected during the months of October and November, 2012
and include the number of steps taken in 5 minute intervals each day.

## Data

The data for this assignment can be downloaded from the course web
site:

* Dataset: [Activity monitoring data]("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip") [52K]

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing
    values are coded as `NA`)

* **date**: The date on which the measurement was taken in YYYY-MM-DD
    format

* **interval**: Identifier for the 5-minute interval in which
    measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a 
total of 17,568 observations in this dataset.

## Assignment

This assignment is described in multiple parts that need to be writed into a report 
that answers the questions detailed into [README.md](README.md)


```r
rm(list=ls())
activityDataFile = "activity.csv"
activityDataUrl  = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
```


```r
## include libraries
library('ggplot2')
library('data.table')

## Set default lang and number
# Sys.setenv(LANG = "en")
# Sys.setlocale("LC_TIME", "en_US")
options(scipen=999)
```

## Loading and preprocessing the data

Download the [activity data url](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) and extract it into the file activity.csv. 
Then load the CSV data into a data.table.

### Loading Data

```r
###
# Loading Data
###

## if the data file not exists
if( ! file.exists( activityDataFile ) ) {
  
  ## download the zip file into a temp file
  temp <- tempfile()
  download.file( activityDataUrl, temp )
  
  ## unzip the content from the zip file
  unzip( temp, files = activityDataFile )
  
  ## remove the zip file
  unlink(temp)
}
```

### Preprocessing Data


```r
###
# Preprocessing Data
###

activityData <- fread( activityDataFile)
activityData$date <- as.Date(activityData$date,"%Y-%m-%d")
```

## What is mean total number of steps taken per day?

1. Calculate the total number of steps taken per day


```r
## aggregate by the sum of steps
activityStepsPerDay <- aggregate(steps ~ date, data = activityData, sum ,na.rm = TRUE)
```

2. Make a histogram of the total number of steps taken each day

```r
## plot the histogram
qplot(
  activityStepsPerDay$steps,
  xlab='Total Steps',
  ylab='Count',
  bins=40,
  geom="histogram",
  col=I("white"),
  fill=I("blue")
)
```

![](PA1_files/figure-html/stepsPerDayTotalHistogram-1.png)<!-- -->

3. Calculate and report the mean and median of the total number of steps taken per day

```r
## calculate the mean and median
meanTotalStepsPerDay <- mean(activityStepsPerDay$steps)
medianTotalStepsPerDay <- median(activityStepsPerDay$steps)
```

    The mean of total number of steps taken per day is 10766.19 
    and the median is  10765.

## What is the average daily activity pattern?

1. Make a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
activityAvgDailyActivity <- aggregate(steps ~ interval, data = activityData, mean ,na.rm = TRUE)
qplot(
  x=activityAvgDailyActivity$interval,
  xlab='Interval',
  y=activityAvgDailyActivity$steps,
  ylab='Steps',
  geom=c("line")
)
```

![](PA1_files/figure-html/averageDailyActivity-1.png)<!-- -->

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
maxSteps = max( activityAvgDailyActivity$steps )
maxStepsInterval = activityAvgDailyActivity[
  activityAvgDailyActivity$steps == maxSteps,
]$interval
```

    The 5-minutes interval that, on average across all the days in the dataset, 
    contains the maximum number of steps is the 835, with 206.1698113 steps.

## Imputing missing values

Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
missingData <- !complete.cases(activityData)
totalMissingData <- length( missingData[ missingData == TRUE ] )
```

    The total of missing data is 2304.

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

3. Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
activityMissingData <- activityData[ missingData == TRUE, ]
activityFilledData <- activityData

## Set the steps of missing data based on the median of the interval
missingDataIntervals <- unique( activityMissingData$interval )
for( loopInterval in missingDataIntervals ) {
  ## select the lines with empty step and into the current interval and set the mean of the current interval
  activityFilledData[      is.na( steps ) & interval == loopInterval, ]$steps <- 
    median( activityData[ !is.na( steps ) & interval == loopInterval, ]$steps  )
}
```
4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. 

## plot the histogram

```r
activityFilledStepsPerDay <- aggregate(steps ~ date, data = activityFilledData, sum ,na.rm = TRUE)


## plot the histogram
qplot(
  activityFilledStepsPerDay$steps,
  xlab='Total Steps',
  ylab='Count',
  bins=40,
  geom="histogram",
  col=I("white"),
  fill=I("blue")
)
```

![](PA1_files/figure-html/stepsPerDayFilledHistogram-1.png)<!-- -->

```r
meanFilledTotalStepsPerDay <- mean(activityFilledStepsPerDay$steps)
medianFilledTotalStepsPerDay <- median(activityFilledStepsPerDay$steps)

diffMeanSteps <- 100 - round(
  (
    100 * 
    min( meanFilledTotalStepsPerDay, meanTotalStepsPerDay )/
    max( meanFilledTotalStepsPerDay, meanTotalStepsPerDay )
  ),
  2
)

diffMedianSteps <- 100 - round(
  (
    100 *
    min( medianFilledTotalStepsPerDay, meanTotalStepsPerDay   )/
    max( medianFilledTotalStepsPerDay, medianTotalStepsPerDay )
  ),
  2
)
```

Do these values differ from the estimates from the first part of the assignment? 

    The mean with the filled data is 9503.87. 
    The mean of the original data is 10766.19.
    
    The median with the filled data is 10395. 
    The median of the original data is 10765.
    
What is the impact of imputing missing data on the estimates of the total daily number of steps?

    The difference between the means is 11.72 %.
    The difference between the median is 3.44 %.

## Are there differences in activity patterns between weekdays and weekends?


```r
activityFilledData$weekDay <- as.POSIXlt( activityFilledData$date )$wday
activityFilledData$weekDayType <- ifelse( activityFilledData$weekDay %in% c(0,6), "weekend", "weekday" )

activityByWeekDayType <- aggregate(
  activityFilledData$steps, 
  by=list(
    activityFilledData$interval,
    activityFilledData$weekDayType
  ),
  mean
)

names(activityByWeekDayType) <- c( "interval", "weekdays", "steps" )

qplot(
  interval,
  steps,
  data = activityByWeekDayType,
  facets = ~ weekdays,
  xlab='Interval',
  ylab='Total of Steps',
  geom=c("line")
)
```

![](PA1_files/figure-html/fillweekday-1.png)<!-- -->
