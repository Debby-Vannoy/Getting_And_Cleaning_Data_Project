The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is located:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The attached R script (run_analysis.R) performs the following to clean up the data:

1) Merges the training and test sets to create one data set for subject, activity, and features.
   activity combines rows in test/Y_test.txt and train/Y_train.txt
   subject combines rows in train/subject_train.txt and test/subject_test.txt
   features combines rows in test/X_test.txt and train/X_train.txt

2) Extracts only the measurements on the mean and standard deviation for each measurement.

3) Reads the activity_labels.txt and applies descriptive activity names:
      walking
      walkingupstairs
      walkingdownstairs
      sitting
      standing
      laying

4) The script also appropriately labels the data set with descriptive names: 
   all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed.

5. Finally, the script creates a 2nd, independent tidy data set with the average of each measurement 
   for each activity and each subject.
