pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    allData <- data.frame(Date = as.Date(character()), sulfate = numeric(), nitrate = numeric(), ID = integer(), stringsAsFactors = FALSE)
    
    for (i in id) {
        
        fileName <- formatC(i, width = 3, format = "d", flag = "0")
        
        path <- paste(directory, "\\", fileName, ".csv", sep = "")
        
        data <- read.csv(path)
        
        allData <- rbind(allData, data)
    }
    
    pollutantData <- allData[,pollutant]
    
    pollutantData <- pollutantData[!is.na(pollutantData)]
    
    mean(pollutantData)
}