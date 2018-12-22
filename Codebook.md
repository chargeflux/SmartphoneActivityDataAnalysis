# Codebook

## Data

The dataset `Human Activity Recognition Using Smartphones Data Set` by Anguita et al. was obtained from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). That link has extensive details about the data set and the various measurements and experiments that were done.

An overall description of the data set (directly from the above link) is as follows:

> "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

> "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

The following data files were used in this analysis:

- UCI HAR Dataset/train/X_train.txt & UCI HAR Dataset/test/X_test.txt (contains the main data for the training and test sets)
- UCI HAR Dataset/features.txt (contains labels for the 561-feature vector in the training and test sets)
- UCI HAR Dataset/train/Y_train.txt & UCI HAR Dataset/test/Y_test.txt (contains activity ids that represent the activity being performed)
- UCI HAR Dataset/activity_labels.txt (contains the activity name that correspond the numeric value)
- UCI HAR Dataset/train/subject_train.txt & UCI HAR Dataset/test/subject_test.txt (contains the subject identifier for each experiment)

## Variables

For this analysis, only the mean and standard deviation of the measurements were used to form the cleaned main data set. This means other measurements like the median absolute deviation (mad), maximum and minimum value in array, and signal magnitude area (sma) were excluded. It is recommended to read `features_info.txt` at the root of the `Human Activity Recognition Using Smartphones Data Set` folder for details and definitions about the signals collected from the smartphone device, measurements of those signals, and related variables. It will assist in understanding the column names in the main data set for this analysis as well.

The following columns were added to hold the additional data not contained in `X_train.txt` and `X_test.txt` and relevant information for the data set in this analysis:

- `subject_id`: the subject identifier representing 1 of the 30 subjects who participated in this study
- `type`: the type represents where the data for an experiment was from the training or test data set (`train`,`test`)
  - `type` is only available in `merged`, the main merged dataset variable in the R environment after `run_analysis.R` is "sourced"; the script does not write out `merged` via `write.table()`. `type` is not available in [tidy dataset](./tidy_dataset.txt), which holds the mean and standard deviation by subject and by activity, since such a dataset makes no distinction of type).
- `activity`: the activity that was done (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`)

## References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.