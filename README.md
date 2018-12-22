# Analyzing Activity Data from Smartphones

## Analysis Script

Run `source('run_analyis.R')` to initiate analysis. This script requires the package `dplyr`.

`run_analysis.R` performs a series of steps to get and clean data from the data set, [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by Anguita et al.

1) Loads `dplyr`

2) If the data set does not exist in the working directory as a folder `UCI HAR Dataset`, the script will attempt to download it via CURL

3) The following files are imported:

    - UCI HAR Dataset/train/X_train.txt & UCI HAR Dataset/test/X_test.txt (contains the main data for the training and test sets)
    - UCI HAR Dataset/features.txt (contains labels for the 561-feature vector in the training and test sets)
    - UCI HAR Dataset/train/Y_train.txt & UCI HAR Dataset/test/Y_test.txt (contains activity ids that represent the activity being performed)
    - UCI HAR Dataset/activity_labels.txt (contains the activity name that correspond the numeric value)
    - UCI HAR Dataset/train/subject_train.txt & UCI HAR Dataset/test/subject_test.txt (Contains the subject identifier for each experiment)

4) A column was added to training and test data tables identifying its type to identify origin of data in the merged dataset. The subject identifier data was also added to the respective training and test data tables

5) `full_join()` combined the training and test data sets into a single data table, `merged`

6) Along with the values `subject_id` and `type`, a feature label vector was created from `features.txt` to serve as the column names for merged table

7) The mean and standard deviation columns for each measurement was extracted from `merged` into `merged_main` using `grepl()` and regex, along with the custom columns

8) `left_join()` remapped the activity IDs in `test_y` and `train_y` with actual activity names and the newly labeled activity data was added to `merged` data table

9) A new dataset was created using `group_by()`, `select()` and `summarise_all()` were used to find averages of measurements for each activity and each subject

10) The dataset was written out to `tidy_dataset.txt` using `write.table()`

## Study Design

From the data set provided by Anguita et al., the training and test data sets were used as the foundation of the main data set to be cleaned. `features.txt` contained the labels for the measurements in training sets and was combined accordingly into the main data set. The training and test data set were accompanied by 2 respective lists containing the activities that were done (as IDs) and were parsed accordingly from `activity_labels.txt` to get the actual name. Similarly, the subject identifer for each experiment conducted were parsed and added to the main data set. A column describing the origin of the data in the main data set, `type`, was important when the training and test data were merged to form the main data set. Of the measurements, only the measurements that were the mean and standard deviation of each variable, i.e., variables like `tBodyAcc-X` and `tBodyGyro-Y`, were used in the final main data set because only mean and standard deviation were relevant to this analysis. Thus, measurements like `tBodyGyro-mean()-X` and `tBodyAcc-X-std()-Y` were chosen and measurements like `tBodyAcc-iqr()-X` or `tBodyAcc-correlation()-X,Y` were discarded. There were some minor cleaning of the column names to remove the closed parentheses after mean and std.

Please see the [Codebook.md](./Codebook.md) for more information about the relevant measurements and variables.

## References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
