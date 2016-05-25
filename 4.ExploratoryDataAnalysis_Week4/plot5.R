##Download the zip file, if not exists, containing the data and unpack it
if(!file.exists("FNEI_data/summarySCC_PM25.rds")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.zip")
    unzip(zipfile = "FNEI_data.zip", exdir = "FNEI_data")
}

##install.packages("dplyr")
##library(dplyr)

##Load in the two containing files
SourceClassificationCode <- readRDS("FNEI_data/Source_Classification_Code.rds")
SummarySccPM25 <- readRDS("FNEI_data/summarySCC_PM25.rds")

#Join data frames
Joint <- merge(SummarySccPM25, SourceClassificationCode, by = "SCC")

##Subset the data
MotorVehicles <- select(subset(Joint, fips == "24510" & EI.Sector %in% c("Mobile - On-Road Gasoline Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Diesel Heavy Duty Vehicles")), year, Emissions)

##Calculate the yearly total
YearTotal <- with(MotorVehicles, tapply(Emissions, year, sum, na.rm = TRUE))

##Plot the year on year totals against each other
plot(x = names(YearTotal), y = YearTotal, type = "l", ylab = "Emissions (Tons)", xlab = "Year", main = "Motor Vehicle Emissions by Year for Baltimore")

dev.copy(png, "plot5.png")
dev.off()