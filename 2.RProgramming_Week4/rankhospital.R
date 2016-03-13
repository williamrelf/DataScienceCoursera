## The 'rankhospital' function will find the given ranked hospital in terms of
## mortality rate for the given state and medical outcome and return it's name
## Paramters:
##      state = The state abreviation, for example Texus is TX
##      outcome = One of three possible medical outcomes to choose from "heart attack", "heart failure" or "pneumonia"
##      num = the rank of the hospital to retrun.

rankhospital <- function(state = character(), outcome = character(), num = character()) {
    
    outcomeData <- read.csv(file = "outcome-of-care-measures.csv")
    
    stateData <- subset(outcomeData, State == state)
    
    if (nrow(stateData) == 0) {
        stop("invalid state")
    }
    else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("invalid outcome")
    }
    
    outcomeColumnNumber = numeric()
    
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
    
    as.character(final[ranker == rank, 2])
}