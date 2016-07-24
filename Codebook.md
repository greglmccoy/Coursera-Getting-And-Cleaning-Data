# Intro and Background

The script run_analysis.R performs the 5 steps described in the course project's definition (detailed within the ReadMe file within this repository).

* After data is loaded, all similar data is merged using the `rbind()` function. Refers to the data size and labels for comparison.
* All columns with mean and standard deviation measures are taken from the dataset.
* After extracting these columns, they are given the correct names, taken from `features.txt`.
* The activity names and IDs from activity_labels.txt are substituted in the dataset.
* Finally, a tidy dataset is produced with the average measures for each subject and activity type. The file Getting_Cleaning_Data_Tidy_Data.txt is uploaded within this repository.

# Variables

* `X_train`, `y_train`, `X_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `Rawdata`, `Activity`, `ActivityID` and `SubjectID` merge the previous datasets to further analysis.
* `features` contains the correct names for the `X_data` dataset loaded from the features.txt file.
* `Alldata` merges `SubjectID`, `Raw` and `Activity` in a big dataset.
*  Finally, `TidyData` contains the refined data that will be used.
