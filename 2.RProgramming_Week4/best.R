## The 'best' function will find the best rated hospital in terms of
## mortality rate for the given state and medical outcome and return it's name
## Paramters:
##      state = The state abreviation, for example Texus is TX
##      outcome = One of three possible medical outcomes to choose from "heart attack", "heart failure" or "pneumonia"

best <- function(state = character(), outcome = character()) {
    
    outcomeData <- read.csv(file = "outcome-of-care-measures.csv")
    
    stateData <- subset(outcomeData, outcomeData$State == state)
    
    if (nrow(stateData) == 0) {
        stop("An invalid state was provided")
    }
    else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("An invalid outcome was provided")
    }
             
    if (outcome == "heart attack") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, stateData$Hospital.Name), c("Hospital.Name")]
    }
    else if (outcome == "heart failure") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, stateData$Hospital.Name), c("Hospital.Name")]
    }
    else if (outcome == "pneumonia") {
        
        sortData <- stateData[order(stateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, stateData$Hospital.Name), c("Hospital.Name")]
    }
    
    as.character(sortData[1])
    
}