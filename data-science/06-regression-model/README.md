# Coursera - Regression Model - Course Project

## Introduction

In this [project](https://www.coursera.org/learn/regression-models/peer/nxntd/regression-models-course-project), the goal is to make a study to the Motor Trend magazine
that want know more about the relationship between a set of variables and miles per gallon (MPG) (outcome). The dataset used in this study is the [Motor Trend Car Road Tests Data](https://www.rdocumentation.org/packages/datasets/versions/3.5.2/topics/mtcars). They are particularly interested in the following two questions:

* Is an automatic or manual transmission better for MPG
* Quantify the MPG difference between automatic and manual transmissions

The result of the Anaylsis should be delivery as a PDF where the document without the appendices should have two pages or less. This document should present at the first paragraph an executive summary. Comparisons are expected between the different models and also an analysis of the coefficients, and residuals. The conclusions should include the confidence interval and the p-value.

## Summary

After making a exploratory data analyses, this study will propose some models to define the relationship among the fields and the MPG. 
After that, this paper will describe what strategy was used to the model selection. 
Then, it will present the residual plot and diagnostics based on the model.

The result of this project is available on this [github project](https://github.com/thiagomata/CourseraRegressionModelProject) that can be better visualized on the [github page](https://thiagomata.github.io/CourseraRegressionModelProject/).

## Analysis

The R code and details of this project can be found on the [Project.Rmd](Project.Rmd). The code with the execution result of that can be found on the [Project.html](https://thiagomata.github.io/CourseraRegressionModelProject/Project.html) and into the [Project.pdf](https://thiagomata.github.io/CourseraRegressionModelProject/Project.pdf).

## Conclusion

If we don’t have any other information about a car, beyond the Type of Transmission, then we can say that a car with Manual Transmission should have the MPG around 7.2449393 (from 3.64151 to 10.84837 in the 95% confidence interval) bigger than the Automatic. If we know everything about a car, and just changing the transmission type from Automatic to Manual shoud increase the MPG around 1.9520082 (from -1.673548 to 5.577564 in the 95% confidence interval).

So, automatic cars in general consume more than manual ones. But, not necessarly because the Type of Engine increase the consume. But, in general, automatic cars presents others features, that also affects the consume. Considering the Transmission Type isolated, the real effect of changing the Transmission Type is 0.5417548 MPG (from -1.179838 to 2.263348 in the 95% confidence interval).

Considering our 95% confidence interval, there is a reasonable chance that the effect of the different types of Transmission Types is zero. In that sense, ***it is inconclusive if some Transmission Type is better for MPG***. But, we still can say that, if the Transmission Type affects the MPG, the impact is pretty low (from -1.179838 to 2.263348)
