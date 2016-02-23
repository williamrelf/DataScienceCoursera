corr <- function(directory, threshold = 0){
    
    allCompleteData <- data.frame(Date = as.Date(character()), sulfate = numeric(), nitrate = numeric(), ID = integer(), stringsAsFactors = FALSE)
    
    completeCaseSummary <- data.frame(ID = integer(), nobs = integer(), stringsAsFactors = FALSE)
    
    id = 1:332
    
    for (i in id) {
        fileName <- formatC(i, width = 3, format = "d", flag = "0")
        
        path <- paste(directory, "\\", fileName, ".csv", sep = "")
        
        data <- read.csv(path)
        
        allCompleteData <- rbind(allCompleteData, data[complete.cases(data),])
        
        completeCases <- sum(complete.cases(data))
        
        completeCaseSummary <- rbind(completeCaseSummary, data.frame(i, completeCases))
    }
    
    qualifyingIDs <- subset(completeCaseSummary, completeCaseSummary$completeCases >= threshold)[,1]
    
    correlations <- 0
    
    increment <- 1
    
    for(i in qualifyingIDs) {
        subData <- subset(allCompleteData, allCompleteData$ID == i)
        
        correlations[increment] <- cor(subData$nitrate, subData$sulfate)
        
        increment <- increment + 1
    }
    
    correlations
}