Data-Gathering-Course-Project
=============================

Contains code for the creation of a tidy data set for the course project.

These are the steps I took to organize and clean the data.

1. Uploaded the data into tables in R using read.table. 
2. Merged the data from the test and train data sets to create unified datasets for X, Y and subjects. 
3. I extracted the relevant columns from the X data set. Those columns were determined based on the features_info.txt file, and were renamed. I removed the word “Body” from the variable names because of how ubiquitous it was in each variable. Instead, each variable includes, in order, the type of measurement (Acceleration, Gravity Acceleration, Gyroscope), whether it’s jerk, whether it’s a magnitude,  whether it’s dimensional (X, Y, or Z) and which dimension, whether it’s a frequency, and whether it’s a mean or standard deviation. In order to save some space, I used StdDev instead of Standard Deviation. So, for instance, if you wanted the mean of the Z-dimensional Gyroscope Jerk, the variable would be GyroscopeJerkZMean. A note on whether it’s a frequency: I considered time as the DEFAULT variable here. That is, if the word Frequency does not appear in the variable name, it is assumed to be measured in terms of time. I stored this data in a new table called ‘newxdata’ with these variable names.
4. I merged this newly labeled data with the merged Y data (the subject IDs) and the activity labels.
5. I used a for loop to create a new matrix with the appropriate averages for each variable, divided by subject ID and activity ID.
6. I then changed the activity IDs in the matrix to strings stating the actual activities.
7. I printed the final data set, sorted by subject ID and activity. Each row contains the subject ID, activity name and the averaged variables. 
