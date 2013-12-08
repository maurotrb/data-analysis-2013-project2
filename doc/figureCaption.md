Figure 1. Activity Recognition Using Smartphones Data Set. Classification Tree.
-------------------------------------------------------------------------------

Classification tree relating subjects' activities with features variables
calculated on data collected from smartphones sensors.

The dataset was composed of 1485 observations and 561 variables, and the tree
was computed on all the variables.
The resulting tree uses 9 features, with 11 terminal nodes and a misclassification
error rate of 2.42%.

The features used were:

*  __tBodyAcc.std.X__: Body Acceleration Standard deviation
*  __tGravityAcc.mean.X__: Gravity Acceleration Mean value
*  __tGravityAcc.energy.Z__: Gravity Acceleration Energy measure. Sum of the squares divided by the number of values.
*  __tGravityAcc.mean.Y__: Gravity Acceleration Mean value
*  __tGravityAcc.min.Y__: Gravity Acceleration Smallest value in array
*  __fBodyAccJerk.bandsEnergy.17.32.Z__:Body Acceleration Jerk Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  __fBodyAccMag.mad__: Body Acceleration Magnitude Median absolute deviation 
*  __tBodyAcc.correlation.X.Y__: Body Acceleration Correlation coefficient between two signals
*  __tBodyGyro.correlation.Y.Z__: Body Angular Speed Correlation coefficient between two signals

Activity Recognition (AR) aims to recognize the actions and goals of one or more agents
from a series of observations on the agents' actions and the environmental conditions
[[1](#activity-recognition)].

Recognition can be of different types. We used a sensor based approach employing
smartphones as sensing tools. Smartphones are an effective solution for AR, because
they come with embedded built-in sensors such as microphones, dual cameras, accelerometers,
gyroscopes, etc.

Using a public domain dataset [[2](#uci-har)], we built a function that predicts what
activity a subject is performing based on the quantitative measurements from the phone.

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


#### Features
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window at 50 Hz).
From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.
