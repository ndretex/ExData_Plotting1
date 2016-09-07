## set directory to your working directory where the data folder "ExData_household.zip" is located
setwd("C:/Users/Joel/OneDrive/DataScience/4-exploratoty analysis/w1/ExData_Plotting1")

workingdir <- getwd()

## checking if the data is in the working directory, 
## if not, i download the zip file and extract it 
## (it will create the data directory)

## I suppose that if the "ExData_household" folder is present
## the data is present as extracted from the zip file
datafile <-file.path(workingdir,"household_power_consumption.txt")
if(!file.exists(datafile)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","ExData_household.zip")
  unzip("ExData_household.zip")
}

library(data.table)

powercons<-read.table("household_power_consumption.txt",sep=";",header=TRUE,nrows=200000,na.strings="?",colClasses = c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## subsetting data
x<-paste(powercons$Date,powercons$Time)
powercons$DateTime<-(strptime(x,format="%d/%m/%Y %H:%M:%S"))
powercons2<-subset(powercons,as.Date(Date,format="%d/%m/%Y")>=as.Date("01/02/2007",format="%d/%m/%Y") & as.Date(Date,format="%d/%m/%Y")<=as.Date("02/02/2007",format="%d/%m/%Y"))
head(powercons2)
names(powercons2)

##plotting 
png(filename = "plot2.png")
plot(powercons2$DateTime,powercons2$Global_active_power,xlab="",type="l",ylab = "Global Active Power (kilowatts)")
dev.off()
