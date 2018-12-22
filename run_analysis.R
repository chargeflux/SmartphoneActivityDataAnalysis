library(dplyr)

if (!(file.exists("UCI HAR Dataset"))) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,"dataset.zip",method="curl")
  unzip("dataset.zip")
}

# Load main data tables
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt") %>% tbl_df()
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt") %>% tbl_df()

# Load activity ids from train_y/test_y
train_y <- read.table("./UCI HAR Dataset/train/Y_train.txt") %>% tbl_df()
test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt") %>% tbl_df()

# Load feature labels for train_x/test_x
feature_labels <- read.table("./UCI HAR Dataset/features.txt") %>% tbl_df()

# Load activity labels that correspond to activity id in train_y/test_y
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") %>% tbl_df()

# Load subject identifiers
subject_id_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") %>% tbl_df()
subject_id_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") %>% tbl_df()

# add origin label before full_join
train_x <- mutate(train_x,type="train")
test_x <- mutate(test_x,type="test")

# add subject_id to train_x and test_x
train_x$subject_id <- subject_id_train$V1
test_x$subject_id <- subject_id_test$V1

# merge training and test data sets
merged <- full_join(train_x,test_x)

# add custom labels, "type" and "subject_id", to feature_labels for merged table
feature_labels_main <- c(as.character(feature_labels$V2),as.character("type"),as.character("subject_id"))

# set column names for merged table using feature labels vector
merged <- setNames(merged,feature_labels_main)

# get only the mean and std columns, e.g., -mean(), -mean()-X, along with custom columns
merged <- merged[grepl("mean\\(\\)|std\\(\\)|^type$|^subject_id$", names(merged))]

# remove "()" after mean/std in col name, e.g., XXXX-mean()-X --> XXXX-mean-X
names(merged) <- gsub("\\(\\)","",names(merged))

# map activity id in test_y/train_y with actual activity names
activity_test_labeled <- left_join(test_y,activity_labels)$V2
activity_train_labeled <- left_join(train_y,activity_labels)$V2

# add activity data to merged
merged <- mutate(merged,activity=c(as.character(activity_train_labeled),as.character(activity_test_labeled)))

# create independent dataset containing averages of each variable by activity and subject
dataset_mean_subject_id_activity <- merged %>% 
  group_by(subject_id,activity) %>% 
  select(-type) %>% 
  summarise_all(funs(mean))

# write out 
write.table(dataset_mean_subject_id_activity, "tidy_dataset.txt",row.names=FALSE)