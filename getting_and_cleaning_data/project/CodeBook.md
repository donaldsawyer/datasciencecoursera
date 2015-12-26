# Code Book Introduction #
This code book describes the R code and variables used to analyze the Samsung Galaxy S activity study.

# Study Design #
The data was retrieved from the [University of California, Irving Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "University of California, Irving Machine Learning Repository").

An R script (run_analysis.R) was written to take the data downloaded from the UCI repository and create tidy datasets that could be used for further analysis.

## Study Data Gathering Methods ##
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

*Additional study information can be found in the Readme.txt file of the downloaded data.*

## Analysis Objectives ##
1. Combines all of the training and test data for the experiment
2. Extracts only mean and standard deviation measurements for the experiment's subjects & activities
3. Appropriately labels the activities
4. Appropriately names all the variables of the data set
5. Computes the mean for each measurement by subject/activity combinations

# Acquiring the Study Data #
The data can be downloaded from [http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)

Once downloaded, unpack the data into the "Root Project Directory" where the folder containing the data is called "uci\_har\_dataset" (see Prerequisites section below for project directory structure).

# Running the Analysis on the Study Data #
Place the run_analysis.R in the same directory as the uci\_har\_dataset folder.

## Prerequisites ##
To run run\_analysis.R, the script must be located in a directory with the full experiment data in a folder in the same directory.  Once the dataset is unpacked, run\_analysis.R must be placed in the same directory as the dataset directory.

The name of the dataset directory must be called **uci\_har\_dataset**.

The format of the required files and directories should appear as below:

  + Root Project Directory
	  + **run_analysis.R**
	  + **uci\_har\_dataset**
		  + test
			  + x_test.txt
			  + y_test.txt
			  + subject_test.txt
		  + train
			  + x_train.txt
			  + y_train.txt
			  + subject_train.txt  
		  + activity_labels.txt
		  + features.txt

## Descriptions of the Required Study Data Files ##
x\_test: Measurement data for each observation in the test data.

y\_test: Activity Id for each observation in the test data.

subject\_test: Subject Id for each observation in the test data.

x\_train: Measurement data for each observation in the training data.

y\_train: Activity Id for each observation in the training data.

subject\_train: Subject Id for each observation in the training data.

activity\_labels.txt: the labels for each of the Activity Ids.

features.txt: the names of variables in the study.

## Running the R Script ##
From a command line: `Rscript run_analysis.R`.

From RStudio:

1. Open the run_analysis.R file
2. Set the working directory to the "Root Project Directory" name.
3. Run the script

## Outputs ##
**Two analyses are performed:**

1. Generate a full tidy dataset (*all.data*)
2. Generate a tidy dataset of the means for all measurements grouped by subject/activity (*averaged.data*)

*At the end of the script, the console will show the structure and first 6 rows of the two new datasets.*

**Two files are written in the "Root Project Directory" representing the new datasets in space-delimited tabular format:**

1. all_data.txt
2. averaged_data.txt

## Summarization Design Choices ##
In summarizing the data in run\_analysis.R, the means were calculated by grouping the observations by the subject and activity id pairs.  Each mean in the *averaged.data* dataframe contains the mean for each subject/activity pair.

# Flow of Execution for run\_analysis.R#
The flow of execution for run\_analysis.R is as follows:

1. Read & merge the subject data from test & train into the *subject.data* dataframe
2. Read & merge the activity data from test & train into the *activity.data* dataframe
3. Read & merge the measurements data from test & train into the *measurement.data* dataframe
4. Set the variable names of *measurement.data* by reading the names from features.txt
5. Reduce *measurement.data* down to only variables of mean or standard deviation
6. Add the activity names to the *activity.data* dataframe
7. Merge *subject.data*, *activity.data*, and *measurement.data* into a tidy dataset called *all.data*
8. Compute the mean for each variable in *all.data* grouped by the subject/activity combinations and store into the *averaged.data* dataframe
9. Rename the variables of *averaged.data* to prepend "Mean of " in front of the variable names.
10. Write *all.data* to all_data.txt
11. Write *averaged.data* to averaged_data.txt

# Code Book #

The data in *all.data* as the following variable descriptions:

subject: the categorical subject id [1, 30] for the measurements

activity.id: the categorical id of the activity observed for the subject

activity.name: the categorical name for the activity observed for the subject

variables 4 and beyond: feature variables: continuous measurements for the subject (described in detail below)
 
## Detailed Feature Variable Information ##
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ 
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.xc

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

## Full List of Feature Variable Names in *all.data* ##
1. tBodyAcc-mean()-X
2. tBodyAcc-mean()-Y
3. tBodyAcc-mean()-Z
4. tBodyAcc-std()-X
5. tBodyAcc-std()-Y
6. tBodyAcc-std()-Z
7. tGravityAcc-mean()-X
8. tGravityAcc-mean()-Y
9. tGravityAcc-mean()-Z
10. tGravityAcc-std()-X
11. tGravityAcc-std()-Y
12. tGravityAcc-std()-Z
13. tBodyAccJerk-mean()-X
14. tBodyAccJerk-mean()-Y
15. tBodyAccJerk-mean()-Z
16. tBodyAccJerk-std()-X
17. tBodyAccJerk-std()-Y
18. tBodyAccJerk-std()-Z
19. tBodyGyro-mean()-X
20. tBodyGyro-mean()-Y
21. tBodyGyro-mean()-Z
22. tBodyGyro-std()-X
23. tBodyGyro-std()-Y
24. tBodyGyro-std()-Z
25. tBodyGyroJerk-mean()-X
26. tBodyGyroJerk-mean()-Y
27. tBodyGyroJerk-mean()-Z
28. tBodyGyroJerk-std()-X
29. tBodyGyroJerk-std()-Y
30. tBodyGyroJerk-std()-Z
31. tBodyAccMag-mean()
32. tBodyAccMag-std()
33. tGravityAccMag-mean()
34. tGravityAccMag-std()
35. tBodyAccJerkMag-mean()
36. tBodyAccJerkMag-std()
37. tBodyGyroMag-mean()
38. tBodyGyroMag-std()
39. tBodyGyroJerkMag-mean()
40. tBodyGyroJerkMag-std()
41. fBodyAcc-mean()-X
42. fBodyAcc-mean()-Y
43. fBodyAcc-mean()-Z
44. fBodyAcc-std()-X
45. fBodyAcc-std()-Y
46. fBodyAcc-std()-Z
47. fBodyAcc-meanFreq()-X
48. fBodyAcc-meanFreq()-Y
49. fBodyAcc-meanFreq()-Z
50. fBodyAccJerk-mean()-X
51. fBodyAccJerk-mean()-Y
52. fBodyAccJerk-mean()-Z
53. fBodyAccJerk-std()-X
54. fBodyAccJerk-std()-Y
55. fBodyAccJerk-std()-Z
56. fBodyAccJerk-meanFreq()-X
57. fBodyAccJerk-meanFreq()-Y
58. fBodyAccJerk-meanFreq()-Z
59. fBodyGyro-mean()-X
60. fBodyGyro-mean()-Y
61. fBodyGyro-mean()-Z
62. fBodyGyro-std()-X
63. fBodyGyro-std()-Y
64. fBodyGyro-std()-Z
65. fBodyGyro-meanFreq()-X
66. fBodyGyro-meanFreq()-Y
67. fBodyGyro-meanFreq()-Z
68. fBodyAccMag-mean()
69. fBodyAccMag-std()
70. fBodyAccMag-meanFreq()
71. fBodyBodyAccJerkMag-mean()
72. fBodyBodyAccJerkMag-std()
73. fBodyBodyAccJerkMag-meanFreq()
74. fBodyBodyGyroMag-mean()
75. fBodyBodyGyroMag-std()
76. fBodyBodyGyroMag-meanFreq()
77. fBodyBodyGyroJerkMag-mean()
78. fBodyBodyGyroJerkMag-std()
79. fBodyBodyGyroJerkMag-meanFreq()

## Full List of Feature Variable Names in *averaged.data* ##
1. Mean of tBodyAcc-mean()-X
2. Mean of tBodyAcc-mean()-Y
3. Mean of tBodyAcc-mean()-Z
4. Mean of tBodyAcc-std()-X
5. Mean of tBodyAcc-std()-Y
6. Mean of tBodyAcc-std()-Z
7. Mean of tGravityAcc-mean()-X
8. Mean of tGravityAcc-mean()-Y
9. Mean of tGravityAcc-mean()-Z
10. Mean of tGravityAcc-std()-X
11. Mean of tGravityAcc-std()-Y
12. Mean of tGravityAcc-std()-Z
13. Mean of tBodyAccJerk-mean()-X
14. Mean of tBodyAccJerk-mean()-Y
15. Mean of tBodyAccJerk-mean()-Z
16. Mean of tBodyAccJerk-std()-X
17. Mean of tBodyAccJerk-std()-Y
18. Mean of tBodyAccJerk-std()-Z
19. Mean of tBodyGyro-mean()-X
20. Mean of tBodyGyro-mean()-Y
21. Mean of tBodyGyro-mean()-Z
22. Mean of tBodyGyro-std()-X
23. Mean of tBodyGyro-std()-Y
24. Mean of tBodyGyro-std()-Z
25. Mean of tBodyGyroJerk-mean()-X
26. Mean of tBodyGyroJerk-mean()-Y
27. Mean of tBodyGyroJerk-mean()-Z
28. Mean of tBodyGyroJerk-std()-X
29. Mean of tBodyGyroJerk-std()-Y
30. Mean of tBodyGyroJerk-std()-Z
31. Mean of tBodyAccMag-mean()
32. Mean of tBodyAccMag-std()
33. Mean of tGravityAccMag-mean()
34. Mean of tGravityAccMag-std()
35. Mean of tBodyAccJerkMag-mean()
36. Mean of tBodyAccJerkMag-std()
37. Mean of tBodyGyroMag-mean()
38. Mean of tBodyGyroMag-std()
39. Mean of tBodyGyroJerkMag-mean()
40. Mean of tBodyGyroJerkMag-std()
41. Mean of fBodyAcc-mean()-X
42. Mean of fBodyAcc-mean()-Y
43. Mean of fBodyAcc-mean()-Z
44. Mean of fBodyAcc-std()-X
45. Mean of fBodyAcc-std()-Y
46. Mean of fBodyAcc-std()-Z
47. Mean of fBodyAcc-meanFreq()-X
48. Mean of fBodyAcc-meanFreq()-Y
49. Mean of fBodyAcc-meanFreq()-Z
50. Mean of fBodyAccJerk-mean()-X
51. Mean of fBodyAccJerk-mean()-Y
52. Mean of fBodyAccJerk-mean()-Z
53. Mean of fBodyAccJerk-std()-X
54. Mean of fBodyAccJerk-std()-Y
55. Mean of fBodyAccJerk-std()-Z
56. Mean of fBodyAccJerk-meanFreq()-X
57. Mean of fBodyAccJerk-meanFreq()-Y
58. Mean of fBodyAccJerk-meanFreq()-Z
59. Mean of fBodyGyro-mean()-X
60. Mean of fBodyGyro-mean()-Y
61. Mean of fBodyGyro-mean()-Z
62. Mean of fBodyGyro-std()-X
63. Mean of fBodyGyro-std()-Y
64. Mean of fBodyGyro-std()-Z
65. Mean of fBodyGyro-meanFreq()-X
66. Mean of fBodyGyro-meanFreq()-Y
67. Mean of fBodyGyro-meanFreq()-Z
68. Mean of fBodyAccMag-mean()
69. Mean of fBodyAccMag-std()
70. Mean of fBodyAccMag-meanFreq()
71. Mean of fBodyBodyAccJerkMag-mean()
72. Mean of fBodyBodyAccJerkMag-std()
73. Mean of fBodyBodyAccJerkMag-meanFreq()
74. Mean of fBodyBodyGyroMag-mean()
75. Mean of fBodyBodyGyroMag-std()
76. Mean of fBodyBodyGyroMag-meanFreq()
77. Mean of fBodyBodyGyroJerkMag-mean()
78. Mean of fBodyBodyGyroJerkMag-std()
79. Mean of fBodyBodyGyroJerkMag-meanFreq()
