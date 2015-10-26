setwd("test")
test_ldata=read.table("y_test.txt")
test_data=read.table("X_test.txt")
testsubject_data = read.table("subject_test.txt")
final_test<-cbind(test_ldata, testsubject_data, test_data)

setwd("../train")
train_ldata = read.table("y_train.txt")
trainsubject_data = read.table("subject_train.txt")
train_data = read.table("X_train.txt")
final_train<-cbind(train_ldata, trainsubject_data, train_data)
new_data<-rbind(final_test,final_train)

setwd("../")
features<-read.table("features.txt")
m<-grep("mean",features[,2])
std<-grep("std",features[,2])
mean_data<-new_data[,m]
std_data<-new_data[,std]

activity<-rbind(test_ldata,train_ldata)


for (i in 1:nrow(activity)){
  if (activity[i,1] == 1) {
    activity[i,2] <- "walking"
  }   
  else if (activity[i,1] == 2) {
    activity[i,2] <- "walking upstairs"
  } 
  else if (activity[i,1] == 3) {
    activity[i,2] <- "walking downstairs"
  }
  else if (activity[i,1] == 4) {
    activity[i,2] <- "sitting"}
  else if (activity[i,1] == 5) {
    activity[i,2] <- "standing"
  }
  else if (activity[i,1] == 6) {
    activity[i,2] <- "laying"}
}

new_data[,1]<-activity[,2]

lab_use[1]<-"activity"
lab_use[2]<-"subject"
labels<-read.table("features.txt")
lab_use[3:563]<-as.vector(labels[,2])
colnames(new_data)<-lab_use

tidy<-ddply(new_data, .(activity,subject), function(x){
     y <- subset(x, select= -activity)
      apply(y, 2, mean) })