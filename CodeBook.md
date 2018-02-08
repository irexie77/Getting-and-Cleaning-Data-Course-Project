## Data

- The following are the variables used and can be downloaded at [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

`activity_labels.txt`

`features.txt`

`subject_test.txt`

`subject_train.txt`

`X_test.txt`

`X_train.txt`

`y_test.txt`

`y_train.txt`

- Similar data like `X_train`, `X_test`, etc. are merged using the `rbind()` function.
- Taking only the mean and standard deviation of the entire data set.
- correct names are then given using the `features.txt` file.
- `activity_labels.txt` are then substituted in the dataset.
- Generating the new data set `tidyDATA.txt` where it contains the average measure of each subject.
