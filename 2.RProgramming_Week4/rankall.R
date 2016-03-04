## The 'rankall' function will find the hospital by rank per state in terms of
## mortality rate for the given state and medical outcome and return their names as a data frame.
## Paramters:
##      outcome = One of three possible medical outcomes to choose from "heart attack", "heart failure" or "pneumonia"
##      best = The rank to be found, values can be "best", "worst" or a number.

rankall <- function(outcome = character(), best = numeric()) {
    
    outcomeData <- read.csv(file = "outcome-of-care-measures.csv")
    
    rows <- nrow(outcomeData)
    
    states <- unique(outcomeData$State)
    
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("An invalid outcome was provided")
    }
    else if (!best %in% c("best", "worst", 0:rows)) {
        stop("An invalid best was provided")
    }
    
    if (best == "worst") {
        desc <- TRUE
    }
    else {
        desc <- FALSE
    }
    
    if (best %in% c("best", "worst")) {
        r <- 1
    }
    else {
        r <- as.numeric(best)
    }
    
    allStateData <- data.frame(hospital = character(), state = character())
    
    for (s in states) {
        
        stateData <- subset(outcomeData, State == s)
        
        if (outcome == "heart attack") {
            
            sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
        }
        else if (outcome == "heart failure") {
            
            sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
        }
        else if (outcome == "pneumonia") {
            
            sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
        }
        
        hospital <- as.character(sortData[r])
        
        allStateData <- rbind(allStateData, data.frame(c(hospital, s)))
        
    }
    
    allStateData
    
}