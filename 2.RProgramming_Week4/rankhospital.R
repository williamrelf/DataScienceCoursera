## The 'rankhospital' function will find the hospital by rank in terms of
## mortality rate for the given state and medical outcome and return it's name
## Paramters:
##      state = The state abreviation, for example Texus is TX
##      outcome = One of three possible medical outcomes to choose from "heart attack", "heart failure" or "pneumonia"
##      best = The rank to be found, values can be "best", "worst" or a number.

rankhospital <- function(state = character(), outcome = character(), best = numeric()) {
    
    outcomeData <- read.csv(file = "outcome-of-care-measures.csv")
    
    stateData <- subset(outcomeData, outcomeData$State == state)
    
    rows <- nrow(stateData)
    
    if (nrow(stateData) == 0) {
        stop("An invalid state was provided")
    }
    else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
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
    
    if (outcome == "heart attack") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
    }
    else if (outcome == "heart failure") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
    }
    else if (outcome == "pneumonia") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name, decreasing = desc), c("Hospital.Name")]
    }
    
    if (best %in% c("best", "worst")) {
        r <- 1
    }
    else {
        r <- as.numeric(best)
    }
    
    as.character(sortData[r])
    
}