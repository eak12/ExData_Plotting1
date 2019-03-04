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


#3. step three - send graph (in step 4) to png device
png(filename = "Plot1.png")

#4. step four - create histogram of variable Global Active Power (Kilowatts)
hist(SubsetInitial$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)"
     , col = "red")

#5. step five - close devise, so that png exists in working directory

dev.off()