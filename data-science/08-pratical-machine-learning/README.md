# Coursera - Practical Machine Learning - Course Project

## Introduction

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. 

In this [project](https://www.coursera.org/learn/practical-machine-learning/supplement/PvInj/course-project-instructions-read-first), the goal is creating a model to predict the manner in which they did the exercise. To do so, we are going to use the data from the study about [Qualitative Activity Recognition of Weight Lifting Exercises](http://groupware.les.inf.puc-rio.br/public/papers/2013.Velloso.QAR-WLE.pdf) [1] that register the accelerometers on the belt, forearm, arm, and dumbell of 6 participants. In this study, the participants were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information about this data is available on  and more details about it can be access by this website [http://groupware.les.inf.puc-rio.br/har](http://groupware.les.inf.puc-rio.br/har), in the section on the Weight Lifting Exercise Dataset. The result of this project is available on this [github project](https://github.com/thiagomata/CourseraPracticalMachineLearningCourseProject) that can be better visualized on the [github page](https://thiagomata.github.io/CourseraPracticalMachineLearningCourseProject/).

## Assignment

As said previously, the goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. To do so, it is allowed to use any of the other variables to predict with. This paper must report how built the created model, how were used the cross validation, what is the expected out of sample error, and the cause of the choices maded. After that, it must present the prediction result of the model over 20 different test cases.

## Code and Analysis

The R code and details about how this project works can be found on the [Project.Rmd](Project.Rmd). The code with the execution result of that can be found on the [Project.html](https://thiagomata.github.io/CourseraPracticalMachineLearningCourseProject/Project.html) and [Project.pdf](Project.pdf).

## Method

First, was removed all the columns with more than 97% of the rows with null values. After that, was replace the remaing null values to the most common value. Then, was removed all the identifier columns. Using the clean data, were created the following models:

### Fit Bag - FT

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 551   | 7     | 1     | 1     | 1     |
| B   | 2     | 367   | 3     | 0     | 6     |
| C   | 0     | 2     | 334   | 11    | 6     |
| D   | 4     | 1     | 4     | 307   | 3     |
| E   | 1     | 2     | 0     | 2     | 344   |


### K Nearst Neighbor - KNN

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 550   | 8     | 0     | 1     | 1     |
| B   | 2     | 363   | 1     | 0     | 1     |
| C   | 2     | 7     | 338   | 11    | 5     |
| D   | 3     | 0     | 3     | 307   | 2     |
| E   | 1     | 1     | 0     | 2     | 351   |

### Recursive Partition - RPart

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 507   | 221   | 318   | 154   | 147   |
| B   | 0     | 0     | 0     | 0     | 0     |
| C   | 0     | 0     | 0     | 0     | 0     |
| D   | 40    | 76    | 17    | 123   | 56    |
| E   | 11    | 82    | 7     | 44    | 157   |

![Pariticion Description](./img/RPartFancy.png "Partition Description")

### Gradient Boosting Machine - GBM

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 504   | 35    | 19    | 11    | 6     |
| B   | 11    | 295   | 24    | 3     | 29    |
| C   | 20    | 29    | 282   | 35    | 25    |
| D   | 18    | 6     | 9     | 267   | 17    |
| E   | 5     | 14    | 8     | 5     | 283   |

### Random Forest - RF

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 557   | 7     | 0     | 0     | 0     |
| B   | 0     | 370   | 1     | 0     | 1     |
| C   | 0     | 2     | 340   | 11    | 2     |
| D   | 1     | 0     | 1     | 309   | 1     |
| E   | 0     | 0     | 0     | 1     | 356   |

![OOB Error Rate by Number of Trees](./img/RandomForestOOB.png "OOB Error Rate by Number of Trees")

### Voting with Weight
Those models were combined into a voting with weigth mechanism that uses all the generated models with accuracy bigger or equal of 80%.

#### Confusion Matrix

|     |   A   |   B   |   C   |   D   |   E   |
|-----|-------|-------|-------|-------|-------|
| A   | 557   | 8     | 0     | 0     | 0     |
| B   | 0     | 369   | 2     | 0     | 1     |
| C   | 0     | 1     | 339   | 11    | 3     |
| D   | 1     | 0     | 1     | 309   | 2     |
| E   | 0     | 1     | 0     | 1     | 354   |

### Overall Statistics

Accuracy:	0.9832

95% CI:	( 0.9764, 0.9884 )

No Information Rate:	0

Kappa:	0.9787

Mcnemar’s Test P-Value:	NaN

### Result

The result comparing with the validation data is:

## Preditictions on the Test Dataset

The result of the prediction on the test dataset is

```
  B A A A A E D B A A B C B A E E A B B B
```

## Biografy

[1] Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human ’13) . Stuttgart, Germany: ACM SIGCHI, 2013.
