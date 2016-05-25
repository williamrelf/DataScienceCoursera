##Download the zip file, if not exists, containing the data and unpack it
if(!file.exists("FNEI_data/summarySCC_PM25.rds")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.zip")
    unzip(zipfile = "FNEI_data.zip", exdir = "FNEI_data")
}

##Load in the two containing files
SourceClassificationCode <- readRDS("FNEI_data/Source_Classification_Code.rds")
SummarySccPM25 <- readRDS("FNEI_data/summarySCC_PM25.rds")

##Subset the baltimore city data
Baltimore <- subset(SummarySccPM25, fips == "24510")

##Calculate the yearly total
YearTotal <- with(Baltimore, tapply(Emissions, as.character(year), sum, na.rm = TRUE))

##Plot the year on year totals against each other
plot(x = names(YearTotal), y = YearTotal, type = "l", xlab = "Year", ylab = "Total Emissions (Tons)", main = "The total emissions for Baltimore City, in tons, by year.")

##Save to file
dev.copy(png, "plot2.png")
dev.off()