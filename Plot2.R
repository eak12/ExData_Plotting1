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
initial<-read.csv("../exdata_data_household_power_consumption/household_power_consumption.txt", 
                  sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#7. step seven - have only values 1/2/2007 or 2/2/2007 for the date column
SubsetInitial<-subset(initial, initial$Date=="1/2/2007"|initial$Date=="2/2/2007")

#8. step eight - create a date time column, i.e. concatenate columns Date and Time as strings

library(dplyr)
SubsetInitial<-mutate(SubsetInitial, DateTime=paste(Date, Time))

#9. step nine - remove columns Date and Time

SubsetInitial<-select(SubsetInitial, -(Date:Time))

#10. step ten - create a posixct variable

library(lubridate)
SubsetInitial<-mutate(SubsetInitial, DateTime=dmy_hms(DateTime))
#11. step 11 - send graph to png device and give a file name
png(filename = "Plot2.png")

#12. step 12 - create a line graph 
#type="l" means to make a line graph
with(SubsetInitial, plot(DateTime, Global_active_power, type = "l", 
                         xlab = "", ylab = "Global Actve Power(Kilowatts)"))

#13. step 13 - close devise, so that png exists in working directory

dev.off()