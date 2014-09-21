# This script supposes the raw dataset (as downloaded for the course project) is in a folder named "UCI HAR Dataset" in your working directory.

# Read all the data into tables in R. 
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt"); 
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "activityid");
subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "id");
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt");
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "activityid");
subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "id");

# Merge the test and train data.
mergedx <- rbind(xtest, xtrain);
mergedy <- rbind(ytest, ytrain);
mergedsubj <- rbind(subjtest, subjtrain);

# Extract the columns from mergedx that correspond to the means and standard deviations.
# Rename the columns accordingly. 
namevector <- c("AccelerationXMean", "AccelerationYMean", "AccelerationZMean", 
                "AccelerationXStdDev", "AccelerationYStdDev", "AccelerationZStdDev",
                "GravityAcclerationXMean", "GravityAcclerationYMean", "GravityAcclerationZMean",
                "GravityAccelerationXStdDev", "GravityAccelerationYStdDev", "GravityAccelerationZStdDev",
                "AccelerationJerkXMean", "AccelerationJerkYMean", "AccelerationJerkZMean",
                "AccelerationJerkXStdDev", "AccelerationJerkYStdDev", "AccelerationJerkZStdDev",
                "GyroscopeXMean", "GyroscopeYMean", "GyroscopeZMean",
                "GyroscopeXStdDev", "GyroscopeYStdDev", "GyroscopeZStdDev",
                "GyroscopeJerkXMean", "GyroscopeJerkYMean", "GyroscopeJerkZMean",
                "GyroscopeJerkXStdDev", "GyroscopeJerkYStdDev", "GyroscopeJerkZStdDev",
                "AccelerationMagnitudeMean", "AccelerationMagnitudeStdDev",
                "GravityAccelerationMagnitudeMean", "GravityAccelerationMagnitudeStdDev",
                "AccelerationJerkMagnitudeMean", "AccelerationJerkMagnitudeStdDev",
                "GyroscopeMagnitudeMean", "GyroscopeMagnitudeStdDev",
                "GyroscopeJerkMagnitudeMean", "GyroscopeJerkMagnitudeStdDev",
                "AccelerationXFrequencyMean", "AccelerationYFrequencyMean", "AccelerationZFrequencyMean",
                "AccelerationXFrequencyStdDev", "AccelerationYFrequencyStdDev", "AccelerationZFrequencyStdDev",
                "AccelerationJerkXFrequencyMean", "AccelerationJerkYFrequencyMean", "AccelerationJerkZFrequencyMean",
                "AccelerationJerkXFrequencyStdDev", "AccelerationJerkYFrequencyStdDev", "AccelerationJerkZFrequencyStdDev",
                "GyroscopeXFrequencyMean", "GyroscopeYFrequencyMean", "GyroscopeZFrequencyMean",
                "GyroscopeXFrequencyStdDev", "GyroscopeYFrequencyStdDev", "GyroscopeZFrequencyStdDev",
                "AccelerationMagnitudeFrequencyMean", "AccelerationMagnitudeFrequencyStdDev",
                "AccelerationJerkMagnitudeFrequencyMean", "AccelerationJerkMagnitudeFrequencyStdDev",
                "GyroscopeMagnitudeFrequencyMean", "GyroscopeMagnitudeFrequencyStdDev",
                "GyroscopeJerkMagnitudeFrequencyMean", "GyroscopeJerkMagnitudeFrequencyStdDev");

columnnums <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 
                214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 
                424:429, 503:504, 516:517, 529:530, 542:543);
newxdata <- mergedx[,columnnums];
colnames(newxdata) <- namevector;

# Merge the cleaned data with the subject id's and activity id's.
totaldata <- cbind(mergedsubj, mergedy, newxdata);

# Using a for loop, create the desired means divided by subject and activity.
tidydata <- matrix(, nrow = 0, ncol = 68);
for(i in 1:30) {
        for(j in 1:6) {
                tidydata <- rbind(tidydata, colMeans(totaldata[(totaldata$id == i & totaldata$activityid == j), ]))
        }
}

# Alter the tidy data to change the activityid's to the activity names.
activities <- matrix(c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"), nrow = 6)
for(i in 1:nrow(tidydata)) {
        index <- as.numeric(tidydata[i,2])
        tidydata[i,2] <- activities[index, ]
}

# Print the data set.
tidydata