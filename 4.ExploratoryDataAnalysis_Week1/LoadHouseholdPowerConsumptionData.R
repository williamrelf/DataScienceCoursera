
##The function relies on the file being made present at the passed location.
##The file can be downloaded from here: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

LoadHouseholdPowerConsumptionData <- function(filepath = "") {
    
    library(plyr)
    library(dplyr)
    
    if (file.exists(filepath)) {
        HPC <- read.delim(filepath, header = TRUE, sep = ";", na.strings = "?")
        
        HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")
        
        return(HPC)
    }
    else {
        stop("The provided file path is invalid")
    }
}