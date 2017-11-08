library(data.table)

# Load relevant data in
powerConsumption <- read.table("./household_power_consumption.txt",
                               na.strings='?',sep=';', header=TRUE)

# extract only the dates of interest. Date format is: dd/mm/yyyy
df <- subset(powerConsumption, (powerConsumption$Date == '2/2/2007' | 
                                powerConsumption$Date == '1/2/2007'))

# Convert Date into date format
df$Date <- as.Date(df$Date, format = '%d/%m/%Y')
# Combine date and time 
df$DateTime <- as.POSIXct(paste(df$Date, df$Time))

# make plot4 (2 x 2):

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(df$DateTime, df$Global_active_power, type="l", ylab= "Global Active Power", xlab="")
plot(df$DateTime, df$Voltage, type="l", ylab= "Voltage", xlab="datetime")
plot(df$DateTime, df$Sub_metering_1, type = 'l', ylab='Energy Sub Metering', xlab="")
lines(df$DateTime, df$Sub_metering_2, type="l", col='red', ylab= "", xlab="")
lines(df$DateTime, df$Sub_metering_3, type="l", col='blue', ylab= "", xlab="")
legend('topright', lty = 1, col=c('black','red','blue'), bty='n',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
plot(df$DateTime, df$Global_reactive_power, type="l", ylab= "Global_active_power", xlab="datetime")
dev.off() 
