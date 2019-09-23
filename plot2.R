##Check if the directory exists, if nor we create it:
if(!file.exists("./data")){dir.create("./data")}

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##Check if we have already downloaded the zip file, if not we do it:
if (!file.exists("./data/file.zip")) { 
  download.file(url, destfile ="./data/file.zip",method="curl")
}

##Check if we have already unzipped the zip file, if not we do it:
if (!file.exists("./data/household_power_consumption")) { 
  unzip(zipfile = "./data/file.zip", exdir = "./data")
}

#Reading the data file
data<-read.table("./data/household_power_consumption.txt",sep=";",header=TRUE)
#>Convert the date to Date format
data$Datef <- as.Date(data$Date,"%d/%m/%Y")

#Set english language
Sys.setlocale(locale = 'en_US.UTF-8')

#Subset with the appropiate time
bar <- subset(data, data$Datef =="2007-02-01"|data$Datef=="2007-02-02")

PowerKw <- as.numeric(as.character(bar$Global_active_power))
Timef <- strptime(bar$Time,"%H:%M:%S")
Datef <- as.Date(bar$Date,"%d/%m/%Y")
totaldate<-strptime(paste(bar$Date, bar$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#open the png file
png("plot2.png", width=480, height=480)
#define the histogram
plot(totaldate, PowerKw, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#close the png
dev.off()
