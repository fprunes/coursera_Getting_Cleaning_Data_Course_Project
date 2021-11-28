library(dplyr)
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)
x_test <-  read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
x <- rbind(x_train,x_test)
rm("x_train")
rm("x_test")
f <- read.table("./data/UCI HAR Dataset/features.txt",header = FALSE)
names(f) <- c("featnum","featname")
new_featnames <- tolower(f$featname)
new_featnames <- gsub("\\(\\)","",new_featnames)
new_featnames <- gsub("\\(","_",new_featnames)
new_featnames <- gsub("\\)","",new_featnames)
new_featnames <- gsub("-","_",new_featnames)
new_featnames <- gsub(",","_",new_featnames)
names(x) <- new_featnames
# fbodyacc_bandsenergy variables are duplicated
xt <- as_tibble(x, .name_repair="universal") 

xts <- select(xt,contains("mean") | contains("std"))

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
y <- rbind(y_train,y_test)
rm("y_train")
rm("y_test")
names(y) <- "class_label"
yt <- as_tibble(y)
rm("y")
ac_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                         header = FALSE)
names(ac_labels) <- c("class_label","activity_name")
y_labels <- as_tibble(ac_labels)
rm("ac_labels")
yt2 <- select(merge(yt,y_labels),activity_name)

result_step4 <- cbind(xts,yt2)
rm("xts")
rm("yt2")
names4 <- names(result_step4)
names4 <- gsub("acc","_acceleration",names4) 
names4 <- gsub("jerk","_jerk",names4) 
names4 <- gsub("gyro","_gyro",names4) 
names4 <- gsub("mag","_magnitude",names4)
names(result_step4) <- names4
rm("names4")

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                           header = FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                           header = FALSE)
subject <- rbind(subject_train,subject_test)
rm("subject_train")
rm("subject_test")
names(subject) <- "subject_id"

x3 <- cbind(result_step4,subject)

x4 <- group_by(x3,activity_name,subject_id)
rm("x3")

result_step5 <- summarise_all(x4,mean)

names5 <- names(result_step5)
names52 <- paste0("average_",names5[3:length(names5)])
names53 <- c(names5[1:2],names52)

names(result_step5) <- names53

#write(names(result_step4),"names_result_step4.txt")
#write.csv(result_step4,"result_step4.csv")

#write(names(result_step5),"names_result_step5.txt")
#write.csv(result_step5,"result_step5.csv")

write.table(result_step5,"result_step5_nonames.txt",row.names=FALSE)
