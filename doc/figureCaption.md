Figure 1. Activity Recognition Using Smartphones Data Set. Classification Tree.
-------------------------------------------------------------------------------

Classification tree relating subjects' activities with features calculated on
measurements collected from smartphone sensor signals (Activity Recognition analysis).
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap. From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.

The tree was computed on a dataset composed of 1485 observations and 561 features.
The final classification used 9 features, with 11 terminal nodes and a misclassification
error rate of 2.42%.

The features used were:

*  __tBodyAcc.std.X__: Standard deviation of Body Acceleration on X axis (time domain)
*  __tGravityAcc.mean.X__: Mean of Gravity Acceleration on X axis (time domain)
*  __tGravityAcc.energy.Z__: Energy measure of Gravity Acceleration on Z axis (time domain)
*  __tGravityAcc.mean.Y__: Mean of Gravity Acceleration on Y axis (time domain)
*  __tGravityAcc.min.Y__: Mininum value of Gravity Acceleration on Y axis (time domain)
*  __fBodyAccJerk.bandsEnergy.17.32.Z__: Energy of frequency interval 17-32 of
   Body Acceleration Jerk on Z axis
*  __fBodyAccMag.mad__: Median absolute deviation of Body Acceleration Magnitude
   (frequency domain)
*  __tBodyAcc.correlation.X.Y__: Correlation between Body Acceleration on X and Y axis
   (time domain)
*  __tBodyGyro.correlation.Y.Z__: Correlation between Body Angular Speed on Y and Z axis
   (time domain)
