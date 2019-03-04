#goal - make subset date for values 1/2/2007 or 2/2/2007

#1. step one - unzip the folder exdata_data_household_power_consumption.zip to the folder ExData_Plotting1
#set the working directory to the folder ExData_Plotting1
#load the household_power_consumption.txt
#replace ? with Na values
#stringsAsFactors = FALSE is require to subset in step two
initial<-read.csv("../exdata_data_household_power_consumption/household_power_consumption.txt", 
                  sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#2. step two - have only values 1/2/2007 or 2/2/2007 for the date column
SubsetInitial<-subset(initial, initial$Date=="1/2/2007"|initial$Date=="2/2/2007")

#3. step three - create a date time column, i.e. concatenate columns Date and Time as strings

library(dplyr)
SubsetInitial<-mutate(SubsetInitial, DateTime=paste(Date, Time))

#4. step four - remove columns Date and Time

SubsetInitial<-select(SubsetInitial, -(Date:Time))

#5. step five - create a posixct variable

library(lubridate)
SubsetInitial<-mutate(SubsetInitial, DateTime=dmy_hms(DateTime))
#6. step six - send graph to png device and give a file name
png(filename = "Plot2.png")

#7. step seven - create a line graph 
#type="l" means to make a line graph
with(SubsetInitial, plot(DateTime, Global_active_power, type = "l", 
                         xlab = "", ylab = "Global Actve Power(Kilowatts)"))

#8. step eight - close devise, so that png exists in working directory

dev.off()