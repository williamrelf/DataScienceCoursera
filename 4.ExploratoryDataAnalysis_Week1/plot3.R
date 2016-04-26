source("LoadHouseholdPowerConsumptionData.R")

##The file can be downloaded from here: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
HPC <- LoadHouseholdPowerConsumptionData("exdata-data-household_power_consumption/household_power_consumption.txt")

HPC$FullDate <- strptime(paste(HPC$Date, HPC$Time), format = "%Y-%m-%d %H:%M:%S")

HPC <- subset(HPC, Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfcol = c(1, 1))

plot(HPC$FullDate, HPC$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(HPC$FullDate, HPC$Sub_metering_2, type = "l", col = "red")
points(HPC$FullDate, HPC$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=c(3,3,3), xjust = 1)

dev.copy(png, "plot3.png", width = 480, height = 480, units = 'px')
dev.off()