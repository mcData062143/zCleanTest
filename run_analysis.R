
## Read in training X_Train, subject, and activity files. Identify columns
##for mean, std dev. Give names to Subject & Activity
xtr<-read.table("./zdata/UCI HAR Dataset/train/X_train.txt")
subjtr<-read.table("./zdata/UCI HAR Dataset/train/subject_train.txt")
acttr<-read.table("./zdata/UCI HAR Dataset/train/y_train.txt")
xtrs<-xtr[,c(1:6,41:46,81:86,121:126,161:166)]
subjtr<-rename(subjtr, Subject=V1)
acttr<-rename(acttr, Activity=V1)

## Read in training X_Train, subject, and activity files. Identify columns 
## for mean, std dev.  Give names to Subject & Activity
xts<-read.table("./zdata/UCI HAR Dataset/test/X_test.txt")
subjts<-read.table("./zdata/UCI HAR Dataset/test/subject_test.txt")
actts<-read.table("./zdata/UCI HAR Dataset/test/y_test.txt")
xtss<-xts[,c(1:6,41:46,81:86,121:126,161:166)]
subjts<-rename(subjts, Subject=V1)
actts<-rename(actts, Activity=V1)

## Combine training & test X files
xcom<-xtrs
for (i in 1:2947){
  xcom<-rbind(xcom,xtss[i,])
}

##Combine the subject and activity columns for both training and test
subacttr<-cbind(subjtr,acttr)
subactts<-cbind(subjts,actts)

##combine the test subject and activity dataframe with that of the training 
subactcom<-subacttr
for (i in 1:2947){
  subactcom<-rbind(subactcom,subactts[i,])
}

##combine the sub/act file with x files.  Note, need to name X file columns
## to proceed with analysis
com<-subactcom
for(i in 1:30) {
  com<-cbind(com,xcom[,i])
}
names(com)<-c("Subject","Activity","tbodAmX","tbodAmY","tbodAmZ","tbodAsX","tbodAsY","tbodysZ","tgravAmX","tgravAmY","tgravAmZ","tgravAsX","tgravAsY","tgravAsZ","tbodAJmX","tbodAJmY","tbodAJmZ","tbodAJsX","tbodAJsY","tbodAJsZ","tbodGmX","tbodGmY","tbodGmZ","tbodGsX","tbodGsY","tbodGsZ","tbodGJmX","tbodGJmY","tbodGJmZ","tbodGJsX","tbodGJsY","tbodGJsZ")

## Now sort and order the data for each activity for each subject.
## Then take column means of the data for each Subject/activity combination.
## combine the averages into a dataframe with 180 rows and 32 columns 
dat<-data.frame()
for(i in 1:30){
for (j in 1:6) {
  tmp<-filter(com,Subject==i, Activity==j)
  dat<-rbind(dat,colMeans(tmp))
}
}

## Rename the columns and write to file
names(dat)<-c("Subject","Activity","tbodAmX","tbodAmY","tbodAmZ","tbodAsX","tbodAsY","tbodysZ","tgravAmX","tgravAmY","tgravAmZ","tgravAsX","tgravAsY","tgravAsZ","tbodAJmX","tbodAJmY","tbodAJmZ","tbodAJsX","tbodAJsY","tbodAJsZ","tbodGmX","tbodGmY","tbodGmZ","tbodGsX","tbodGsY","tbodGsZ","tbodGJmX","tbodGJmY","tbodGJmZ","tbodGJsX","tbodGJsY","tbodGJsZ")
write.table(dat,file="./zDataClean/FinalTally.txt",row.names=FALSE)

