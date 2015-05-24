##########################################  Merging the data  ################################
## Reading and processing train dataset
# Save initial working directory
init.dir<-getwd()

# Change to train directory
train.dir<-paste(init.dir,"/train",sep="")
setwd(train.dir)

# Read train dataset
train.dat<-read.table("X_train.txt",header=FALSE)

# Read train activity
train.act<-scan("y_train.txt")

# Read train subject
train.sub<-scan("subject_train.txt")

# Create full train dataset by adding activity and subjects columns
train.dat<-cbind(train.act,train.sub,train.dat)


## Reading and processing test dataset
# Change to test directory
test.dir<-paste(init.dir,"/test",sep="")
setwd(test.dir)

# Read test dataset
test.dat<-read.table("X_test.txt",header=FALSE)

# Read test activity
test.act<-scan("y_test.txt")

# Read test subject
test.sub<-scan("subject_test.txt")

# Create full test dataset by adding activity and subjects columns
test.dat<-cbind(test.act,test.sub,test.dat)

# Reset to initial working directory
setwd(init.dir)

# Merge test and train datasets
names(train.dat)[1:2]<-c("activ","subject") # changing 1st two variable names for merging with rbind
names(test.dat)[1:2]<-c("activ","subject")  # changing 1st two variable names for merging with rbind
dat.full<-rbind(test.dat,train.dat)


###############################   Extracting variables with Mean and std  #########################
# Read variable names
var.names<-read.table("features.txt",stringsAsFactors=FALSE,sep=" ",header=FALSE)

# Extract indices with mean values
mean.ind<-grep("mean",var.names$V2,fixed=TRUE)

# Extract indices with std values
std.ind<-grep("std",var.names$V2,fixed=TRUE)

# Merge both mean and std indices
both.ind<-append(mean.ind,std.ind) 

# Extracting data with means and std only
mean_std.dat<-dat.full[,c(1:2,both.ind+2)]  # adding 2 to skip the subject and activities columns

###############################  Adding descriptive names for activities  ###########################
# Read activity description
desc.act<-read.table("activity_labels.txt",stringsAsFactors=FALSE,sep=" ",header=FALSE)

# Extracting activity codes and converting them to characters for substitution
dummy.act<-as.character(mean_std.dat$activ)

# Cycling through activity names and assigning description based on code index.
for (i in desc.act$V1) {
    ind<-which(mean_std.dat$activ==i)
    dummy.act[ind]<-desc.act$V2[i]
    }

# Replacing activity code columns with description
mean_std.dat$activ<-dummy.act

#################################   Appropriately Labelling Variables  #############################
# Create variable names vector
newvarnames<-var.names$V2[both.ind]

# Deleting string "()" from names
newvarnames<-gsub("()","",newvarnames,fixed=TRUE)

# Replacing "-" by "_" in variable names
newvarnames<-gsub("-","_",newvarnames,fixed=TRUE)

# Assign new labels to dataset
n.count<-length(names(mean_std.dat))
names(mean_std.dat)[3:n.count]<-newvarnames

###############  Constructing final dataset (Averages of variables per subject and per activity) ##################
# Summarizing data

final.dat<-ddply(mean_std.dat, .(subject, activ), colwise(mean))


