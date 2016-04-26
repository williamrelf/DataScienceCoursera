source("LoadHouseholdPowerConsumptionData.R")

##The file can be downloaded from here: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
HPC <- LoadHouseholdPowerConsumptionData("exdata-data-household_power_consumption/household_power_consumption.txt")

HPC$FullDate <- strptime(paste(HPC$Date, HPC$Time), format = "%Y-%m-%d %H:%M:%S")

HPC <- subset(HPC, Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfcol = c(1, 1))

plot(HPC$FullDate, HPC$Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "")

dev.copy(png, "plot2.png", width = 480, height = 480, units = 'px')
dev.off()