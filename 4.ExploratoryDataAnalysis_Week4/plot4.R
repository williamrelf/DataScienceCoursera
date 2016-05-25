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
CoalCombustion <- select(subset(Joint, EI.Sector %in% c("Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal", "Fuel Comb - Comm/Institutional - Coal")), year, Emissions)

##Calculate the yearly total
YearTotal <- with(CoalCombustion, tapply(Emissions, year, sum, na.rm = TRUE))

##Plot the year on year totals against each other
plot(x = names(YearTotal), y = YearTotal, type = "l", ylab = "Emissions (Tons)", xlab = "Year", main = "Coal Combustion Emissions by Year")

dev.copy(png, "plot4.png")
dev.off()