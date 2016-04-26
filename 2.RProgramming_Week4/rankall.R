## The 'rankall' function will find the hospital by rank per state in terms of
## mortality rate for the given state and medical outcome and return their names as a data frame.
## Paramters:
##      outcome = One of three possible medical outcomes to choose from "heart attack", "heart failure" or "pneumonia"
##      num = The rank to be found, values can be "best", "worst" or a number.

rankall <- function(outcome = character(), num = numeric()) {
    
    outcomeData <- read.csv(file = "outcome-of-care-measures.csv")
    
    rows <- nrow(outcomeData)
    
    states <- unique(outcomeData$State)
    
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("invalid outcome")
    }
    
    allStateData <- data.frame(hospital = character(), state = character())
    
    for (state in states) {
        
        stateData <- subset(outcomeData, State == state)
        
        if (outcome == "heart attack") {
            outcomeColumnNumber <- 11
        }
        else if (outcome == "heart failure") {
            outcomeColumnNumber <- 17
        }
        else if (outcome == "pneumonia") {
            outcomeColumnNumber <- 23
        }
        
        stateData[,outcomeColumnNumber] <- as.numeric(stateData[,outcomeColumnNumber])
        
        stateData <- subset(stateData, !is.na(stateData[,outcomeColumnNumber]) && !is.nan(stateData[,outcomeColumnNumber]))
        
        sortData <- stateData[order(stateData[,outcomeColumnNumber], stateData$Hospital.Name), names(stateData)]
        
        if(num == "best")
        {
            rank <- 1
        }
        else if (num == "worst")
        {
            rank <- nrow(sortData)
        }
        else
        {
            rank <- num
        }
        
        ranker <- c(1:nrow(sortData))
        
        final <- cbind(sortData, data.frame(ranker))
        
        hospital <- as.character(final[ranker == rank, 2])
        
        if (length(hospital) == 0)
        {
            hospital <- NA
        }
        
        allStateData <- rbind(allStateData, data.frame(hospital, state))
        
    }
    
    allStateData
    
}