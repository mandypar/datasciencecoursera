### Setup local directories where the files are or will be
datafile <- "getdata-projectfiles-UCI.zip"
datadir  <- "/Users/Mandy/Documents/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset"
testdir  <- paste(datadir, "test", sep="/")
traindir <- paste(datadir, "train", sep="/")

### Required packages for the rest of the code
if (!require("plyr")) {
  install.packages("plyr")
  require("plyr")
}
if (!require("reshape2")) {
  install.packages("reshape2")
  require("reshape2")
}

### Download file and unzip if necessary
# if (!file.exists(datafile)){
#    fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#    download.file(fileURL, datafile, method="curl")
# }  
# if (!file.exists(datadir)) { 
#    unzip(datafile) 
# }
###
#1.- Merge the training and the test sets to create one data set.
### Reading data files
subject_test  <- read.table(paste(testdir, "subject_test.txt", sep="/"), sep="\n", strip.white=T)
subject_train <- read.table(paste(traindir, "subject_train.txt", sep="/"), sep="\n", strip.white=T)

feature_names <- read.table(paste(datadir, "features.txt", sep="/"), sep="\n", strip.white=T)
feature_names <- gsub("^[0-9]+ ", "", feature_names$V1)

train_y <- read.table(paste(traindir, "y_train.txt", sep="/"), sep="\n", strip.white=T)
test_y  <- read.table(paste(testdir, "y_test.txt", sep="/"), sep="\n", strip.white=T)
train_x <- read.table(paste(traindir, "X_train.txt", sep="/"), sep="\n", strip.white=T)
test_x  <- read.table(paste(testdir, "X_test.txt", sep="/"), sep="\n", strip.white=T)

# Extract only the measurements on the mean and standard deviation for each measurement.
# Keep only mean or std values
keep_features <- grepl("mean|std", feature_names)

# Break single column into multiples
train_x <- ldply(strsplit(gsub(" {2,}", " ", train_x$V1), " "))
test_x  <- ldply(strsplit(gsub(" {2,}", " ", test_x$V1), " "))

# Cbind predicted value with subject and features
train <- cbind(train_y, subject_train, train_x)
test  <- cbind(test_y, subject_test, test_x)

# tidy-up R used objects no longer required
rm(datafile, datadir, testdir, traindir)
rm(train_y, train_x, test_y, test_x, subject_train, subject_test)

# Combine train and test data sets
combined <- rbind(train, test)

# Take data frame columns 
combined <- combined[,c(TRUE, TRUE, keep_features)]

# Add activity names to the data set.
column_headers <- c("activity", "subject", feature_names[keep_features])

# Use activity names on the dataset.
colnames(combined) <- column_headers

# make factor values numeric values
for (i in 3:ncol(combined)){
  combined[,i] <- as.numeric(combined[,i])
}
write.table(combined, file="data_set.txt")

# Create a tidy data set with the average of each variable.
means <- aggregate(combined[,3] ~ combined$subject + combined$activity, data = combined, FUN = mean)

for (i in 4:ncol(combined)){
  means[,i] <- aggregate( combined[,i] ~ combined$subject + combined$activity, data = combined, FUN = mean )[,3]
}
colnames(means) <- column_headers

write.table(means, file="avg_variables.txt",row.name=FALSE)