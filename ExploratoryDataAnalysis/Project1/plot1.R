
library(data.table)

# Load relevant data in
powerConsumption <- read.table("./household_power_consumption.txt",
                               na.strings='?',sep=';', header=TRUE)

# extract only the dates of interest. Date format is: dd/mm/yyyy
df <- subset(powerConsumption, (powerConsumption$Date == '2/2/2007' | 
                                powerConsumption$Date == '1/2/2007'))

# plot a histogram and save as a 480 by 480 png
png('plot1.png', width = 480, height = 480)
hist(df$Global_active_power, col='red', xlab='Global Active Power (kilowatts)',
     main = 'Global Active Power') 
dev.off()
