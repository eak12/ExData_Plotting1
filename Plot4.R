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
png(filename = "Plot4.png")

#7. step seven - change it so one device/png file has four graphs contained 
par(mfrow=c(2,2))

#8. step eight - change parameter
par(mar=c(4,4,2,2))

#9. step nine - create a line graph of type="l" (line/time-series graph of Global Actve Power)
with(SubsetInitial, plot(DateTime, Global_active_power, type = "l", 
                         xlab = "", ylab = "Global Actve Power"))

#10. step ten - create a line graph of type="l" (line/time-series graph of Voltage)
with(SubsetInitial, plot(DateTime, Voltage, type = "l", 
                         xlab = "datetime", ylab = "Voltage"))

#11. step seven - create a line/time-series graph of Energy sub metering, i.e. Sub_metering_1 & Sub_metering_2 & Sub_metering_3 
#type="n" means not put data yet
with(SubsetInitial, plot(DateTime, Sub_metering_1, type = "n", 
                         xlab = "",
                         ylab = "Energy sub metering"))

#12. step 12 - add the points from Sub_metering_1 column to the line/time-series graph (see step 11) of Sub_metering_1

with(SubsetInitial, points(DateTime, Sub_metering_1, type = "l"))

#13. step 13 - add the points from Sub_metering_2 column to the line/time-series graph (see step 11) of Sub_metering_2

with(SubsetInitial, points(DateTime, Sub_metering_2, type = "l", col="red"))

#14. step 14 - add the points from Sub_metering_3 column to the line/time-series graph (see step 11) of Sub_metering_3

with(SubsetInitial, points(DateTime, Sub_metering_3, type = "l", col="blue"))

#15. step 15 - add legend to the graph & byt="n"(do not include surrounding box) & lty=1(have line bullet points)
#col= c("black", "red", "blue") [have legend colors corresspond to lines in graph]
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1",
                                                                        "Sub_metering_2", "Sub_metering_3"), bty = "n")

#16. step 16 - create a line graph of type="l" (line/time-series graph of Global_reactive_power)

with(SubsetInitial, plot(DateTime, Global_reactive_power, type = "l", 
                         xlab = "datetime", ylab = "Global_reactive_power"))

#17. step nine - close devise, so that png exists in working directory

dev.off()