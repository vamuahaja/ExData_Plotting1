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

#Joining date and hour
attach(household_power_consumption)
household_power_consumption$dataHora <- paste(myDate, Time)
attach(household_power_consumption)
household_power_consumption$dataHora <- strptime(dataHora, '%d/%m/%y %H:%M:%S')

#Multiples times series plots by row
par(mfrow = c(2,2))
household_power_consumption$Global_active_power <- as.numeric(Global_active_power)
attach(household_power_consumption)

#First plot 
plot(dataHora, Global_active_power, type = 'l', ylab = 'Global Active Power', xlab = '')

#Second plot
plot(dataHora, Voltage, type = 'l', xlab = 'datetime')

#Third plot
plot(dataHora, as.numeric(Sub_metering_1), xlab = '', type = 'l', col = 'black', ylab = 'Energy sub metering')
lines(dataHora, as.numeric(Sub_metering_2), type = 'l', col = 'red')
lines(dataHora, as.numeric(Sub_metering_3), type = 'l', col = 'blue')
legend('topright', lty = 1,col = c('black','red', 'blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#Fourth plot
plot(dataHora, as.numeric(Global_reactive_power), type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')

#Copying the plot from screen device to png device (by default it's 480x480 pixels)
dev.copy(png, file = 'plot4.png')
dev.off()