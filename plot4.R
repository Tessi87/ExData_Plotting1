#loading necessary libraries
library(dplyr)

#loading data
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings=c("?"))
head(data)

#adjusting dataset for visualisation
data$Date<-as.character(data$Date)
data$Time<-as.character(data$Time)
data<-mutate(data,Date_Time=paste(Date,Time))
data$Date_Time<-as.POSIXct(strptime(data$Date_Time,"%d/%m/%Y %H:%M:%S"))
timeframe<-filter(data,Date_Time>=as.POSIXct("2007-02-01 00:00:00"),Date_Time<=as.POSIXct("2007-02-02 23:59:59"))

#plotting and saving plot

png(file="plot3.png",width=480,height=480,units="px")

par(mfrow=c(2,2))
#plot1
plot(Global_active_power~Date_Time,data=timeframe,type="l",xlab=c(""),ylab=c("Global Active Power"),main=c(""))

#plot2
plot(Voltage~Date_Time,data=timeframe,type="l",xlab=c("datetime"),ylab=c("Voltage"),main=c(""))

#plot3
plot(Sub_metering_1~Date_Time,data=timeframe,type="l",xlab=c(""),ylab=c("Energy sub metering"),main=c(""))
lines(Sub_metering_2~Date_Time,data=timeframe,col="red",xlab=c(""),main=c(""))
lines(Sub_metering_3~Date_Time,data=timeframe,col="blue",xlab=c(""),main=c(""))
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

#plot1
plot(Global_reactive_power~Date_Time,data=timeframe,type="l",xlab=c("datetime"),ylab=c("Global_reactive_power"),main=c(""))



dev.off()
