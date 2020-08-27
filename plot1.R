
#Installing sqldf package for subset the dataset household_power_consumption in time of read
install.packages("sqldf")
require(sqldf)

#Reading and subsetting the household_power_consumption data  
household_power_consumption  = read.csv.sql('household_power_consumption.txt', header = T, sep = ';', 
                      colClasses = "character",
                      sql = "select * from file where Date IN ('1/2/2007','2/2/2007')", eol = '\n')

#Ploting histogram for Global_active_power variable
hist(as.numeric(household_power_consumption$Global_active_power), col = 'red', xlab = 'Global Active Power (kilowatts)', 
     main = 'Global Active Power')

#Copying the plot from screen device to png device (by default it's 480x480 pixels)
dev.copy(png, file = 'plot1.png')
dev.off()


