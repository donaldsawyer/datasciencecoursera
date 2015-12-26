# "Getting and Cleaning Data" Course Project #

The purpose of this section of the repo is to describe and store the solution for the course project.  The project is focused on the reading and tidying of the ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ""Human Activity Recognition Using Smartphones Data Set"") using R.

The main file to run is called "run_analysis.R" in the root directory.  The main file achieves the following objectives:

1. Combines all of the training and test data for the experiment
2. Extracts only mean and standard deviation measurements for the experiment's subjects & activities
3. Appropriately labels the activities
4. Appropriately names all the variables of the data set
5. Computes the mean for each measurement by subject/activity combinations

# Prerequisites #
To run run_analysis.R, the script must be located in a directory with the full experiment data in a folder in the same directory.  Once the dataset is unpacked, run_analysis.R must be placed in the same directory as the dataset directory.

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

# Running the Analysis #
From a command line: `Rscript run_analysis.R`.

From RStudio:
1. Open the run_analysis.R file
2. Set the working directory to the "Root Project Directory" name.
3. Run the script

# Outputs #
Two analyses are performed:
1. Generate a full tidy dataset (*all.data*)
2. Generate a tidy dataset of the means for all measurements grouped by subject/activity (*averaged.data*)

At the end of the script, the console will show the structure and first 6 rows of the two new datasets.

Two files are written in the "Root Project Directory" representing the new datasets in space-delimited tabular format:

1. all_data.txt
2. averaged_data.txt