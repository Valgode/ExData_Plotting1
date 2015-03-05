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
#Step5.Plot3
Sys.setlocale("LC_TIME", "English")
png("plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
with(df,plot(DateTime,Global_active_power,type="l", xlab="", ylab="Global Active Power"))
mtext("Plot 4",side=3,adj=-0.35,line=2,font=2,cex=1.3)
with(df,plot(DateTime,Voltage,type="l", ylab="Voltage",xlab="datetime"))
with(df,plot(DateTime,Sub_metering_1,type="n", ylab="Energy submetering",xlab=""))
lines(df$DateTime,df$Sub_metering_1,col="grey")
lines(df$DateTime,df$Sub_metering_2,col="red")
lines(df$DateTime,df$Sub_metering_3,col="blue")
legend("topright",col=c("grey","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.9,bty="n",lty=c(1,1,1),lwd=c(1,1,1))
with(df,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))
dev.off()

