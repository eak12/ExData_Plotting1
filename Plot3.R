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
png(filename = "Plot3.png")


#7. step seven - create a line/time-series graph of Energy sub metering, i.e. Sub_metering_1 & Sub_metering_2 & Sub_metering_3  
#type="n" means not put data yet
with(SubsetInitial, plot(DateTime, Sub_metering_1, type = "n", 
                         xlab = "",
                         ylab = "Energy sub metering"))

#8. step eight - add the points from Sub_metering_1 column to the line/time-series graph (see step 7)

with(SubsetInitial, points(DateTime, Sub_metering_1, type = "l"))

#9. step nine - add the points from Sub_metering_2 column to the line/time-series graph (see step 7)

with(SubsetInitial, points(DateTime, Sub_metering_2, type = "l", col="red"))

#10. step nine - add the points from Sub_metering_3 column to the line/time-series graph (see step 7)

with(SubsetInitial, points(DateTime, Sub_metering_3, type = "l", col="blue"))

#11. step ten - add legend to the graph & byt="n"(do not include surrounding box) & lty=1(have line bullet points)
#col= c("black", "red", "blue") [have legend colors corresspond to lines in graph]
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1",
                                                                        "Sub_metering_2", "Sub_metering_3"))

#12. step 12 - close devise, so that png exists in working directory

dev.off()