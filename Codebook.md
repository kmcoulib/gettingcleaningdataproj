## Raw data description
The dataset represent axial linear acceleration and axial angular velocity.
The experiments have been carried out with a group of 30 volunteers within an age
bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity 
at a constant rate of 50Hz. The experiments have been video-recorded to label the 
data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% 
the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window). The sensor acceleration signal, which has gravitational 
and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency 
components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time and frequency 
domain.

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated
  body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Files description
The dataset includes the following files:

- 'features.txt': List of all features on 2 columns, column 2 contains the feature's names
  and column 1 the row numbering 1 to 561.

- 'activity_labels.txt': Links the class labels with their activity name, a two column file
   with column 1 being the class label and colmn 2 the activity names. Six activities
   are listed

- 'train/X_train.txt': Training set, a headerless array with 561 columns and 7352 rows.
                       it contains the actual measured feature values
- 'train/y_train.txt': Training activity labels.

- 'test/X_test.txt': Test set, a headerless array with 561 columns and 2947 rows.
                       it contains the actual measured feature values
- 'test/y_test.txt': Test activity labels..
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for
   each window sample. Its range is from 1 to 30.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each
  window sample. Its range is from 1 to 30.


Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

### Variables description
The features selected for this database come from the accelerometer and gyroscope 3-axial raw 
signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were 
captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 
3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, 
the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner 
frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these
three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag,
tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

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

Additional vectors obtained by averaging the signals in a signal window sample. These are 
used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


## Modification and processing performed
The processing steps are outlined below:
- The Training set was read in an R dataframe (X_train.txt)
- The train activity and train subjects were read in two seperate vectors and appended to the
  train set previously read
- The same steps were carried out with the test dataset
- Both resulting dataframes were merged (rbind) to create a full dataset
- the feature names were read from the features.txt file and indices of variables names
  containing the strings "mean" and "std" were extracted
- Indices were used to subset the full dataset columns and create a dataset with standard
  deviation and mean only
- Then the activity code and description were read from the file activity_labels.txt and used to
  update the activity columns in the newly created dataset with activity descrition
- The Features names were deemed descriptive enough but were modified to make them compatible
  with R variable naming convention, by replacing deleting the string"()" and replacing "-" with
  "_" in all features names
- A final tidy dataset was created by averaging all features per activity and per subject



## Final tidy dataset description

The final tidy dataset submitted contains 180 rows and 81 columns. The first two columns are the
activities and the subjects. The remaining columns represents the mean of the variable retained during
the modification phase above.
Each row contains the average for all retained features for a given activity and a given subject.