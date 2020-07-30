#Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzip dataSet
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#read data
dataset <-  read.table("./data/household_power_consumption.txt",header = TRUE, sep = ";", stringsAsFactors = FALSE)

#change data types
dataset <- within(dataset, {DateTime=strptime(paste(Date, Time), "%d/%m/%Y%H:%M:%S") })
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
dataset[,3:9] <- lapply(dataset[,3:9],as.numeric)

#subsettig data
dataset2 <- dataset[dataset$Date >= "2007-02-01" & dataset$Date <= "2007-02-02",]

#Plot 2
with(dataset2, plot(DateTime, Global_active_power, type = "l", lty = 1,xlab = "", ylab = "Global Active Power (kilowatts)" ))
dev.copy(png, file = "plot2.png",width = 480, height = 480, units = "px") #copy plot to a PNG fie
dev.off()
