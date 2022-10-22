# Experiment Description Data

## subject

Id of the Person under the experiment

## activity

Type of activity in pratice. 

Values:
* Laying
* Sitting
* Standing
* Walking
* Walking Downstairs
* Walking Upstairs

# Experiment Values Data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'frequency' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Time Body accelerometer mean and standard deviation x-y-z

* calculated.time.bodyacc.mean.x
* calculated.time.bodyacc.mean.y
* calculated.time.bodyacc.mean.z
* calculated.time.bodyacc.std.x
* calculated.time.bodyacc.std.y
* calculated.time.bodyacc.std.z

## Frequence Body accelerometer mean and standard deviation x-y-z

* calculated.frequency.bodyacc.mean.x
* calculated.frequency.bodyacc.mean.y
* calculated.frequency.bodyacc.mean.z
* calculated.frequency.bodyacc.std.x
* calculated.frequency.bodyacc.std.y
* calculated.frequency.bodyacc.std.z


## Time Body gravity acceleration signals mean and standard deviation x-y-z

* calculated.time.gravityacc.mean.x
* calculated.time.gravityacc.mean.y
* calculated.time.gravityacc.mean.z
* calculated.time.gravityacc.std.x
* calculated.time.gravityacc.std.y
* calculated.time.gravityacc.std.z

## Time Body accelerometer mean and standard deviation of Jerk Signal x-y-z

* calculated.time.bodyaccjerk.mean.x
* calculated.time.bodyaccjerk.mean.y
* calculated.time.bodyaccjerk.mean.z
* calculated.time.bodyaccjerk.std.x
* calculated.time.bodyaccjerk.std.y
* calculated.time.bodyaccjerk.std.z

## Frequency Body accelerometer mean and standard deviation of Jerk Signal x-y-z

* calculated.frequency.bodyaccjerk.mean.x
* calculated.frequency.bodyaccjerk.mean.y
* calculated.frequency.bodyaccjerk.mean.z
* calculated.frequency.bodyaccjerk.std.x
* calculated.frequency.bodyaccjerk.std.y
* calculated.frequency.bodyaccjerk.std.z

## Time Body gyroscope mean and standard deviation x-y-z

* calculated.time.bodygyro.mean.x
* calculated.time.bodygyro.mean.y
* calculated.time.bodygyro.mean.z
* calculated.time.bodygyro.std.x
* calculated.time.bodygyro.std.y
* calculated.time.bodygyro.std.z

## Frequency Body gyroscope mean and standard deviation x-y-z

* calculated.frequency.bodygyro.mean.x
* calculated.frequency.bodygyro.mean.y
* calculated.frequency.bodygyro.mean.z
* calculated.frequency.bodygyro.std.x
* calculated.frequency.bodygyro.std.y
* calculated.frequency.bodygyro.std.z

## Time Body gyroscope mean and standard deviation of Jeark Signal x-y-z

* calculated.time.bodygyrojerk.mean.x
* calculated.time.bodygyrojerk.mean.y
* calculated.time.bodygyrojerk.mean.z
* calculated.time.bodygyrojerk.std.x
* calculated.time.bodygyrojerk.std.y
* calculated.time.bodygyrojerk.std.z

## Time Body accelerometer magnitude mean and standard deviation

* calculated.time.bodyaccmag.mean
* calculated.time.bodyaccmag.std

## Frequency Body accelerometer magnitude mean and standard deviation

* calculated.frequency.bodyaccmag.mean
* calculated.frequency.bodyaccmag.std


## Time Gravity accelerometer magnitude mean and standard deviation

* calculated.time.gravityaccmag.mean
* calculated.time.gravityaccmag.std

## Time Body acceleromenter jerk magnitude mean and standard deviation

* calculated.time.bodyaccjerkmag.mean
* calculated.time.bodyaccjerkmag.std

## Frequency Body acceleromenter jerk magnitude mean and standard deviation

* calculated.frequency.bodyaccjerkmag.mean
* calculated.frequency.bodyaccjerkmag.std

## Time Body of gyroscope magnitude mean and standard deviation

* calculated.time.bodygyromag.mean
* calculated.time.bodygyromag.std

## Frequency Body of gyroscope magnitude mean and standard deviation

* calculated.frequency.bodygyromag.mean
* calculated.frequency.bodygyromag.std

## Time Body of gyroscope jerk magnitude mean and standard deviation

* calculated.time.bodygyrojerkmag.mean
* calculated.time.bodygyrojerkmag.std

## Frequency Body of gyroscope jerk magnitude mean and standard deviation

* calculated.frequency.bodygyrojerkmag.mean
* calculated.frequency.bodygyrojerkmag.std

The set of variables that were estimated from these signals are: 

```
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.
```
