#goal - make subset date for values 1/2/2007 or 2/2/2007

#1. step one - create a url
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#2. step two - unzip the folder exdata_data_household_power_consumption.zip to the folder ExData_Plotting1

if (!file.exists("ExData_Plotting1")){dir.create("ExData_Plotting1")}

#3. step three - set the working directory to the folder ExData_Plotting1

#4. step four - download the file from the fileurl
download.file(fileurl, destfile = "../ExData_Plotting1/ExData_Plotting1.zip")

#5.step five - unzip the file called ExData_Plotting1.zip

unzip(zipfile = "../ExData_Plotting1/ExData_Plotting1.zip")
#6. step six - load the household_power_consumption.txt
#replace ? with Na values
#stringsAsFactors = FALSE is require to subset in step two
initial<-read.csv("../ExData_Plotting1/household_power_consumption.txt", 
                  sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#7. step seven - have only values 1/2/2007 or 2/2/2007 for the date column
SubsetInitial<-subset(initial, initial$Date=="1/2/2007"|initial$Date=="2/2/2007")


#8. step eight - send graph (in step 4) to png device
png(filename = "Plot1.png")

#9. step nine - create histogram of variable Global Active Power (Kilowatts)
hist(SubsetInitial$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)"
     , col = "red")

#10. step ten - close devise, so that png exists in working directory

dev.off()