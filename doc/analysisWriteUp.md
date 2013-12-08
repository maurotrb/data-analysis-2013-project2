Activity Recognition Using Smartphones and Classification Tree
==============================================================

Introduction
------------
Activity Recognition (AR) aims to recognize the actions and goals of one or more agents
from a series of observations on the agents' actions and the environmental conditions
[[1](#activity-recognition)].

Recognition can be of different types. We used a sensor based approach employing
smartphones as sensing tools. Smartphones are an effective solution for AR, because
they come with embedded built-in sensors such as microphones, dual cameras, accelerometers,
gyroscopes, etc.

Using a public domain dataset [[2](#uci-har)], we built a function that predicts what
activity a subject is performing based on the quantitative measurements from the phone.

Methods
-------

### Data Collection
Data were obtained from UCI Machine Learning repository. In particular we used
the *Human Activity Recognition Using Smartphones Data Set* [[2](#uci-har)],
that was used by the original collectors to conduct experiments exploiting
Support Vector Machine (SVM) [[3](#har-smart)].

The dataset was built from experiments carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(walking, walking upstairs, walking downstairs, sitting, standing, laying)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity
were captured at a constant rate of 50Hz. The experiments have been video-recorded
to label the data manually [[4](#har-smart2)].

#### Signals
The 3-axial time domain [[5](#time-domain)] signals from accelerometer and gyroscope
were captured at a constant rate of 50 Hz [[6](#hertz)]. Then they were filtered
to remove noise.
Similarly, the acceleration signal was then separated into body and gravity
acceleration signals using another filter.
Subsequently, the body linear acceleration and angular velocity were derived in time
to obtain Jerk signals [[7](#jerk)]. Also the magnitude [[8](#magnitude)] of these
three-dimensional signals were calculated using the Euclidean norm [[9](#euclidean-norm)]. 
Finally a Fast Fourier Transform (FFT) [[10](#fft)] was applied to some of these
time domain signals to obtain frequency domain [[11](#freq-domain)] signals.

The following table relates the 17 signals to the names used as prefix for the
variables names present in the dataset. "-XYZ" denotes three variables, one for each axis.

Name                                  | Time domain       | Frequency domain
------------------------------------- | ----------------- | -----------------
Body Acceleration                     | tBodyAcc-XYZ      | fBodyAcc-XYZ
Gravity Acceleration                  | tGravityAcc-XYZ   |
Body Acceleration Jerk                | tBodyAccJerk-XYZ  | fBodyAccJerk-XYZ
Body Angular Speed                    | tBodyGyro-XYZ     | fBodyGyro-XYZ
Body Angular Acceleration             | tBodyGyroJerk-XYZ |
Body Acceleration Magnitude           | tBodyAccMag       | fBodyAccMag
Gravity Acceleration Magnitude        | tGravityAccMag    |
Body Acceleration Jerk Magnitude      | tBodyAccJerkMag   | fBodyAccJerkMag
Body Angular Speed Magnitude          | tBodyGyroMag      | fBodyGyroMag
Body Angular Acceleration Magnitude   | tBodyGyroJerkMag  | fBodyGyroJerkMag

#### Features
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window at 50 Hz).
From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autorregresion coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded
within [-1,1].

#### Dataset details
The dataset was slightly processed for the Coursera Data Analysis course, and
it is available from the course website: 

<https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda>

The dataset contains 7352 observation with 563 variables divided in:

*  a 561-feature vector with time and frequency domain variables (numeric)
*  an activity label: laying, sitting, standing, walk, walkdown, walkup
*  an identifier of the subject who carried out the experiment:
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

### Statistical Modeling
To relate activity to features we used a prediction tree, and in particular a
classification tree [[12](#class-tree)], computed with the `tree` R package
[[13](#r-tree)].

### Reproducibility

An RStudio [[14](#r-studio)] project is available at GitHub:

<https://github.com/maurotrb/data-analysis-2013-project2>

The repository contains the R markdown files [[15](#r-markdown)] and the data
file necessary to reproduce the analyses.

Analysis
--------

### Data quality
The dataset didn't contain any NAs values.

Some column names contained invalid characters such as parentheses `()`, dash `-` and
comma `,`. Parentheses were deleted, dashes and commas were substituted with dots.

Other column names were repeated three times. Presumably they contains the same feature
value, but they refer to the X, Y, Z axis. The columns were suffixed with axis symbols,
giving to the first occurrence of the repeated column the symbol `.X`, to the second
occurrence the symbol `.Y`, and to the third occurrence the symbol `.Z`.

In Activity Recognition analysis confounding variables are a problem, because the subject
could do different activities at the same time or in a short time frame.
However the dataset employed came from a controlled experiment, where subject did a single
activity in a given time frame and different activities were separated with a pause of a
few seconds. So confounding variables were not considered in this analysis.

### Predictive analysis

We splitted the dataset in:

*  a training set that included data from subject 1, 3, 5, and 6, for a total of
   1485 observations
*  a test set that included data from subjects 27, 28, 29, and 30, for a total of
   1315 observations

We computed a classification tree using the tree {tree} R function, and relating the factor
activity with all the 561 features of the dataset.
The resulting classification tree uses 9 features, with 11 terminal nodes and a 
misclassification error rate of 2.42% (see Figure 1).

The tree was used as a prediction function on the test set, and the error rate was
calculated as resubstitution error.

The following table compares the actual activities from the test set (rows) with the
activities predicted with the tree applied to the test set (columns).

Predicted ->  | __laying__ | __sitting__ | __standing__ | __walk__ | __walkdown__ | __walkup__
--------------|----------- | ----------- | ------------ | -------- | ------------ | ----------
__laying__    |        215 |           0 |            0 |        0 |            1 |          5
__sitting__   |          0 |         174 |           24 |        0 |            0 |          0
__standing__  |          0 |          66 |          161 |        0 |            0 |          0
__walk__      |          0 |           0 |            0 |      193 |            7 |         66
__walkdown__  |          0 |           0 |            0 |        0 |          174 |         19
__walkup__    |          0 |           0 |            0 |       20 |           38 |        152

The accuracy rate of the prediction was 81.29%, with a resubstitution error of 18.71%.

Conclusions
-----------
In this analysis we used data collected from smartphone sensors to build a function
that predicts what activity a subject wearing the phone is performing. The function was
built with a classification tree.

We obtained a high accuracy rate with the prediction, but this is a preliminary study and
further developments could be made in:

*  the rate of accuracy, transforming some of the features of the dataset used
*  the prediction function, for example using a function that could be used directly
   on smartphones with their limitation in memory and processing resources

References
----------

1.  <a name="activity-recognition"/>Activity recognition. URL: <http://en.wikipedia.org/wiki/Activity_recognition>.
    Accessed 12/02/2013
2.  <a name="uci-har"/>Human Activity Recognition Using Smartphones Data Set.
    URL: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. Accessed 12/02/2013
3. <a name="har-smart"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*.
   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
4. <a name="har-smart2"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *A Public Domain Dataset for Human Activity Recognition Using Smartphones*.
   ESANN 2013 proceedings, European Symposium on Artificial Neural Networks, Computational Intelligence and
   Machine Learning. Bruges (Belgium), 24-26 April 2013
5.  <a name="time-domain"/>Time domain. URL: <http://en.wikipedia.org/wiki/Time-domain>.
    Accessed 12/02/2013
6.  <a name="hertz"/>Hertz. URL: <http://en.wikipedia.org/wiki/Hertz>. Accessed 12/02/2013
7.  <a name="jerk"/>Jerk. URL: <http://en.wikipedia.org/wiki/Jerk_(physics)>. Accessed 12/02/2013
8.  <a name="magnitude"/>Magnitude. URL: <http://en.wikipedia.org/wiki/Magnitude_(mathematics)>. Accessed 12/02/2013
9.  <a name="euclidean-norm"/>Euclidean norm. URL: <http://en.wikipedia.org/wiki/Norm_(mathematics)#Euclidean_norm>.
    Accessed 12/02/2013
10.  <a name="fft"/>Fast Fourier transform. URL: <http://en.wikipedia.org/wiki/Fast_Fourier_Transform>.
     Accessed 12/02/2013
11.  <a name="freq-domain"/>Frequency domain. URL: <http://en.wikipedia.org/wiki/Frequency_domain>.
     Accessed 12/02/2013
12.  <a name="class-tree"/>Cosma Shalizi. *Classification and Regression Trees*. Statistics 36-350: Data Mining.
     URL: <http://www.stat.cmu.edu/~cshalizi/350/lectures/22/lecture-22.pdf>. Accessed 12/02/2013
13.  <a name="r-tree"/>tree: Classification and regression trees. URL: <http://cran.r-project.org/web/packages/tree/index.html>.
     Accessed 12/02/2013
14.  <a name="r-studio"/>The R Project for Statistical Computing. URL: <http://www.rstudio.com/ide/>.
15.  <a name="r-markdown"/>R Markdown Page. URL: <http://www.rstudio.com/ide/docs/authoring/using_markdown>.
     Accessed 12/02/2013
