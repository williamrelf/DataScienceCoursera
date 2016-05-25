##Download the zip file, if not exists, containing the data and unpack it
if(!file.exists("FNEI_data/summarySCC_PM25.rds")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.zip")
    unzip(zipfile = "FNEI_data.zip", exdir = "FNEI_data")
}

##install.packages("ggplot2")
##install.packages("reshape2")
##library(ggplot2)
##library(reshape2)

##Load in the two containing files
SourceClassificationCode <- readRDS("FNEI_data/Source_Classification_Code.rds")
SummarySccPM25 <- readRDS("FNEI_data/summarySCC_PM25.rds")

##Subset the baltimore city data by type
BaltimorePoint <- subset(SummarySccPM25, fips == "24510" & type == "POINT")
BaltimoreNonPoint <- subset(SummarySccPM25, fips == "24510" & type == "NONPOINT")
BaltimoreOnRoad <- subset(SummarySccPM25, fips == "24510" & type == "ON-ROAD")
BaltimoreNonRoad <- subset(SummarySccPM25, fips == "24510" & type == "NON-ROAD")

##Calculate the yearly total
YearTotalPoint <- as.numeric(with(BaltimorePoint, tapply(Emissions, as.character(year), sum, na.rm = TRUE)))
YearTotalNonPoint <- as.numeric(with(BaltimoreNonPoint, tapply(Emissions, as.character(year), sum, na.rm = TRUE)))
YearTotalOnRoad <- as.numeric(with(BaltimoreOnRoad, tapply(Emissions, as.character(year), sum, na.rm = TRUE)))
YearTotalNonRoad <- as.numeric(with(BaltimoreNonRoad, tapply(Emissions, as.character(year), sum, na.rm = TRUE)))

DataFrame <- data.frame(YearTotalPoint, YearTotalNonPoint, YearTotalOnRoad, YearTotalNonRoad, Year = c(1999, 2002, 2005, 2008))
DataFrame <- melt(DataFrame, id.vars = c("Year"))

##Plot the year on year totals against each other
ggplot(data = DataFrame, aes(Year, value, group=variable, colour=variable)) + geom_line(size=1) + ylab("Emissions(Tons)")

ggsave("plot3.png")