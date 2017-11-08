library(data.table)

# Load relevant data in
powerConsumption <- read.table("./household_power_consumption.txt",
                               na.strings='?',sep=';', header=TRUE)

# extract only the dates of interest. Date format is: dd/mm/yyyy
df <- subset(powerConsumption, (powerConsumption$Date == '2/2/2007' | 
                                powerConsumption$Date == '1/2/2007'))

# plot power consumption by dow of week. First, convert Date into date format
df$Date <- as.Date(df$Date, format = '%d/%m/%Y')
# combine date and time 
df$DateTime <- as.POSIXct(paste(df$Date, df$Time))

# make plot2:
png("plot2.png", width = 480, height = 480)
plot(df$DateTime, df$Global_active_power, type="l", ylab= "Global Active Power(kilowatts)", xlab="")
dev.off() 
