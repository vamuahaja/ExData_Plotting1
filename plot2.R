#Installing sqldf package for subset the dataset household_power_consumption in time of read
install.packages("sqldf")
require(sqldf)

#Reading and subsetting the household_power_consumption data  
household_power_consumption  = read.csv.sql('household_power_consumption.txt', header = T, sep = ';', 
                                            colClasses = "character",
                                            sql = "select * from file where Date IN ('1/2/2007','2/2/2007')", eol = '\n')

#Altering the data format
ano <- substr(household_power_consumption$Date, 7, 8)
diaMes <- substr(household_power_consumption$Date, 1,4)
household_power_consumption$myDate <- paste(diaMes, ano, sep = '')
household_power_consumption$myDate <- as.Date(myDate)

#Joining date and hour
attach(household_power_consumption)
household_power_consumption$dataHora <- paste(myDate, Time)
household_power_consumption$dataHora <- strptime(dataHora, '%d/%m/%y %H:%M:%S')

#Ploting time series for Global_active_power variable
household_power_consumption$Global_active_power <- as.numeric(Global_active_power)
attach(household_power_consumption)
plot(dataHora, Global_active_power, type= 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

#Copying the plot from screen device to png device (by default it's 480x480 pixels)
dev.copy(png, file = 'plot2.png')
dev.off()