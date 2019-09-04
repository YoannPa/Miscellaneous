##Projects Kalendar Generator

#Create days
days<-rep(c(seq(31),seq(30)),3)

#Create months
months<-c("Mars","Avril","Mai","Juin","Juillet","Aout")
mnth_string<-rep(months,rep(c(31,30),3))

#Make days-months Kalendar
kal<-as.data.frame(cbind(days,mnth_string)[-c(184:189),])
day_month<-paste(kal$days,kal$mnth_string)

#Week kalendar
kal<-matrix(day_month,ncol = 7,byrow = T)
#Remove Week end and convert back to vector
kal<-as.vector(t(kal[,-c(2,3)]))[-c(132:135)]

#Add projects
projects<-c("PhD CUPs Classifier","DNMT1 Hypomorph","DNMT3A AML",
            "R Package BiocompR","EpiCWL","EpiAnnotator Maintenance/Devel.",
            "MASTER Project")
proj_weight<-c(0.7,0.1,rep(0.04,5))

kal_proj<-sample(projects,size = length(kal),replace = T,prob = proj_weight)

kal<-paste(kal,kal_proj,sep = " - ")
kal<-as.data.frame(matrix(kal,ncol = 5,byrow = T))
colnames(kal)<-c("Friday","Monday","Thuesday","Wednesday","Thursday")


max.print <- getOption('max.print')
options(max.print=nrow(kal) * ncol(kal))
sink('test_kalendar.txt')
kal
sink()
options(max.print=max.print)