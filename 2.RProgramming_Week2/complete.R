complete <- function(directory, id = 1:332){
    completeCaseSummary <- data.frame(ID = integer(), nobs = integer(), stringsAsFactors = FALSE)
    
    for (i in id) {
        
        fileName <- formatC(i, width = 3, format = "d", flag = "0")
        
        path <- paste(directory, "\\", fileName, ".csv", sep = "")
        
        data <- read.csv(path)
        
        completeCases <- sum(complete.cases(data))
        
        completeCaseSummary <- rbind(completeCaseSummary, data.frame(i, completeCases))
    }
    
    completeCaseSummary
}