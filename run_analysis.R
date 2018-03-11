library(dplyr)

##This is assumiong the files are already downloaded and moved into the WD

#read the training data
X_train <- read.table("X_train.txt")
Y_train <- read.table("Y_train.txt")
Sub_train <- read.table("subject_train.txt")

#read  the test data
X_test <- read.table("X_test.txt")
Y_test <- read.table("Y_test.txt")
Sub_test <- read.table("subject_test.txt")

#read data description
var_names <- read.table("features.txt")

#read the activity labels
activity_labels <- read.table("activity_labels.txt")

##1. Merges the training and the test sets to create one data set.
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
Sub <- rbind(Sub_train, Sub_test)

##2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_sd <- var_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X <- X[,mean_sd[,1]]

##3. Uses descriptive activity names to name the activities in the data set
colnames(Y) <- "activity"
Y$activitylabel <- factor(Y$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y[,-1]

##4. Appropriately labels the data set with descriptive variable names.
colnames(X) <- var_names[mean_sd[,1],2]

##5 Independent tidy data set with the average # of each variable for each activity and each subject.
colnames(Sub) <- "subject"
total <- cbind(X, activitylabel, Sub)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarise_all(funs(mean))
write.table(total_mean, file = "/Users/Jacob/Documents/R/tidydata.txt", row.names = FALSE, col.names = TRUE)
