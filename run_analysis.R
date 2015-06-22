#run_analysis.R - 


#Part 1

#Read in training data (561 columns)
train <- read.table("train/X_train.txt")

#Read in test data (561 columns)
test <- read.table("test/X_test.txt")

#1. Merges the training and the test sets to create one data set. (tt short for trainAndTest)
tt <- rbind(train, test)



#Part 2
#Read in features
features <- read.table("features.txt")

#Get standard deviation feature rows
fstd <- grep("std", features[,2]) 
fstdNames <- features[fstd,2]

#Get feature rows having to do with means
fmean <- grep("mean", features[,2]) 
fmeanNames <- features[fmean,2]

#Get all rows having to do with standard deviation and means
fstdMean <- c(fstd, fmean)
fstdMeanNames <- features[fstdMean,2]


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
ttTidy <- tt[, fstdMean]



#Part 3

#Read in test subject information
trainSubject <- read.table("train/subject_train.txt")
testSubject <- read.table("test/subject_test.txt")
ttSubject <- rbind(trainSubject, testSubject)


#Read in activity levels
activities <- read.table("activity_labels.txt")

trainActvities <- read.table("train/y_train.txt")
testActivities <- read.table("test/y_test.txt")
tidyActivities <- rbind(trainActvities, testActivities)

#Give names to all train and test activities; <row names> = <row Index>_<subject>_<activity>
for(i in activities[,1]){
  tidyActivities[tidyActivities$V1 == i,] <- as.character(activities[i,2])
}

subjectActivity = c()
for(i in  seq_along(ttSubject$V1)){
  subAct <- paste(ttSubject[i,1], tidyActivities[i,1], sep="_")
  if(!(subAct %in% subjectActivity)){
    subjectActivity <- c(subjectActivity, subAct)
  }
  tidyActivities[i,1] <- paste(as.character(i), subAct, sep="_")
  #print(paste(as.character(i), ttSubject[i,1], tidyActivities[i,1], sep="_"))
}

#3. Uses descriptive activity names to name the activities in the data set
row.names(ttTidy) <- tidyActivities[,]


#4. Appropriately labels the data set with descriptive variable names.
colnames(ttTidy) <- fstdMeanNames


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

ttTidyRowNames <- row.names(ttTidy)

ttTidy2 <- data.frame(NULL) #Result Tidy Dataset
subjAct <- c() #List of Subject and Activity Information
for(i in seq_along(subjectActivity)){
  subjAct <- c(subjAct, subjectActivity[i])
  rowsSA <- grep(subjectActivity[i], ttTidyRowNames)
  SAcolMeans <- colMeans(ttTidy[rowsSA,]) 
  ttTidy2<- rbind(ttTidy2, SAcolMeans) 
}
colnames(ttTidy2) <- fstdMeanNames
ttTidy2<- cbind(subjAct, ttTidy2)

write.table(ttTidy, file="tidyTestAndTraining.txt", row.name=TRUE) #Write text file out - include row names
write.table(ttTidy2, file="tidySubjectActivitySummary.txt", row.name=FALSE) #Write text file out; row names are in their own column subjAct