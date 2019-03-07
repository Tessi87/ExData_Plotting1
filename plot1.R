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
gap<-timeframe$Global_active_power

png(file="plot1.png",width=480,height=480,units="px")
hist(as.numeric(gap),ylab=c("Frequency"),xlab=c("Global Active Power (kilowatts)"),col="red",main=c("Global Active Power"))
dev.off()
