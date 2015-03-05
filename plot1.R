fileHPC<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileHPC,destfile="./HPC.zip")
unzip("./HPC.zip","household_power_consumption.txt")
#Step1.Reading Data
P1<-readLines("./household_power_consumption.txt")
#Step2.Selecting lines containing data
HPC<-grepl("^[1-2]/2/2007",P1)
dat<-P1[HPC]
#Step3.Split lines intoseparate fields
fieldlist<-strsplit(dat,split=";")
#Step4.Transform to data frame
M<-matrix(unlist(fieldlist),nrow=length(fieldlist),byrow=TRUE)
cnames<-read.csv2("./household_power_consumption.txt",header=FALSE,stringsAsFactors=FALSE,nrows=1)
colnames(M)<-cnames
df<-as.data.frame(M,stringsAsFactors=FALSE)
#Coerce to correct types
df$Date<-as.Date(df$Date,"%d/%m/%Y")
df$DateTime<-strptime(paste(df$Date,df$Time),"%Y-%m-%d %H:%M:%S")
df$Global_active_power<-as.numeric(df$Global_active_power)
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Voltage<-as.numeric(df$Voltage)
df$Global_intensity<-as.numeric(df$Global_intensity)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
#Step5.Plot1
png("plot1.png",width=480,height=480,units="px")
hist(df$Global_active_power,main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)")
mtext("Plot 1",side=3,at=-1,line=2,font=2,cex=1.3)
dev.off()