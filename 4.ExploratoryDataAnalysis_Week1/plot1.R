library(plyr)
library(dplyr)
library(lattice)

source("LoadHouseholdPowerConsumptionData.R")

##The file can be downloaded from here: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
HPC <- tbl_df(LoadHouseholdPowerConsumptionData("exdata-data-household_power_consumption/household_power_consumption.txt"))

HPC <- filter(HPC, Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfcol = c(1, 1))

hist(HPC$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

dev.copy(png, "plot1.png", width = 480, height = 480, units = 'px')
dev.off()