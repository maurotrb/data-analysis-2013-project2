Analysis Write-Up
=================

Introduction
------------
Activity recognition (AL) aims to recognize the actions and goals of one or more agents
from a series of observations on the agents' actions and the environmental conditions
[[1](#activity-recognition)].

Recognition can be of different types. We used a sensor based approach employing
smartphones as sensing tools. Smartphones are an effective solution for AR, because
they come with embedded built-in sensors such as microphones, dual cameras, accelerometers,
gyroscopes, etc.

Using a public domain dataset [[1](#uci-har)], we built a function that predicts what
activity a subject is performing based on the quantitative measurements from the phone.

Methods
-------

### Data Collection
Data were obtained from UCI Machine Learning repository. In particular we used
the *Human Activity Recognition Using Smartphones Data Set* [[1](#uci-har)],
that was used by the original collectors to conduct some experiments exploiting
Support Vector Machine (SVM) [[1](#har-smart)].

The dataset was built from experiments carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity
were captured at a constant rate of 50Hz. The experiments have been video-recorded
to label the data manually [[1](#har-smart2)].

#### Signals
The 3-axial time domain [[1](#time-domain)] signals from accelerometer and gyroscope
were captured at a constant rate of 50 Hz [[1](#hertz)]. Then they were filtered
to remove noise.
Similarly, the acceleration signal was then separated into body and gravity
acceleration signals using another filter.
Subsequently, the body linear acceleration and angular velocity were derived in time
to obtain Jerk signals [[1](#jerk)]. Also the magnitude [[1](#magnitude)] of these
three-dimensional signals were calculated using the Euclidean norm [[1](#euclidean-norm)]. 
Finally a Fast Fourier Transform (FFT) [[1](#fft)] was applied to some of these
time domain signals to obtain frequency domain [[1](#freq-domain)] signals.

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

No unit of measures is reported as all features were __normalized and bounded
within [-1,1]__.

#### Dataset details
The dataset was slightly processed for the Coursera Data Analysis course, and
it is available from the course website: 

<https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda>

The dataset contains 7352 observation with 563 variables divided in:

*  a 561-feature vector with time and frequency domain variables (numeric)
*  an activity label: laying, sitting standing, walk, walkdown, walkup
*  an identifier of the subject who carried out the experiment:
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

### Exploratory Analysis
Exploratory analysis was performed by examining tables and plots of the sample data.

### Statistical Modeling
To relate activity to features we used a prediction tree, and in particular a
classification tree [[1](#class-tree)]. We used the `tree` R package [[1](#r-tree)].

### Reproducibility

An RStudio [[5](#r-studio)] project is available at GitHub:

<https://github.com/maurotrb/data-analysis-2013-project2>

The repository contains the R markdown files [[6](#r-markdown)] and the data
file necessary to reproduce the analyses.

Analysis
--------

### Data quality
The dataset didn't contain any NAs values.

Some column names contained invalid characters such as parentheses `()`, dash `-` and
comma `,`. Parentheses were deleted, dashes and commas were substituted with dots.

Other column names were repeated three times. Presumably they contains the same feature
value, but they refer to X, Y, Z axis. The columns were suffixed with axis symbols,
giving to the first occurrence the symbol `.X`, to the second occurrence the symbol `.Y`,
and to the third occurrence the symbol `.Z`.

### Predictive analysis


Conclusions
-----------


References
----------

The present analysis is based on the example analysis given in the Data Analysis course, from Coursera.

Other references:

1.  <a name="activity-recognition"/>Activity recognition. URL: <http://en.wikipedia.org/wiki/Activity_recognition>.
    Accessed 12/02/2013
1.  <a name="uci-har"/>Human Activity Recognition Using Smartphones Data Set.
    URL: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. Accessed 12/02/2013
1. <a name="har-smart"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*.
   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
1. <a name="har-smart2"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *A Public Domain Dataset for Human Activity Recognition Using Smartphones*.
   ESANN 2013 proceedings, European Symposium on Artificial Neural Networks, Computational Intelligence and
   Machine Learning. Bruges (Belgium), 24-26 April 2013
1.  <a name="time-domain"/>Time domain. URL: <http://en.wikipedia.org/wiki/Time-domain>.
    Accessed 12/02/2013
1.  <a name="hertz"/>Hertz. URL: <http://en.wikipedia.org/wiki/Hertz>. Accessed 12/02/2013
1.  <a name="jerk"/>Jerk. URL: <http://en.wikipedia.org/wiki/Jerk_(physics)>. Accessed 12/02/2013
1.  <a name="magnitude"/>Magnitude. URL: <http://en.wikipedia.org/wiki/Magnitude_(mathematics)>. Accessed 12/02/2013
1.  <a name="euclidean-norm"/>Euclidean norm. URL: <http://en.wikipedia.org/wiki/Norm_(mathematics)#Euclidean_norm>.
    Accessed 12/02/2013
1.  <a name="fft"/>Fast Fourier transform. URL: <http://en.wikipedia.org/wiki/Fast_Fourier_Transform>.
    Accessed 12/02/2013
1.  <a name="freq-domain"/>Frequency domain. URL: <http://en.wikipedia.org/wiki/Frequency_domain>.
    Accessed 12/02/2013
1.  <a name="r-tree"/>tree: Classification and regression trees. URL: <http://cran.r-project.org/web/packages/tree/index.html>.
    Accessed 12/02/2013
1.  <a name="class-tree"/>Cosma Shalizi. Classification and Regression Trees. Statistics 36-350: Data Mining.
    URL: <http://www.stat.cmu.edu/~cshalizi/350/lectures/22/lecture-22.pdf>. Accessed 12/02/2013
