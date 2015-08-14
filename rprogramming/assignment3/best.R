best <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv", colClass="character", header=TRUE)
    
    #define column constants
    ratecols <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    colnames(data)[ratecols] = names(ratecols)
    
    # check that the inputs are valid
    validstates <- levels(as.factor(data$State))
    if(length(validstates[validstates==state])==0) {
        stop("invalid state")
    }
    
    validoutcomes <- names(ratecols)
    if(length(validoutcomes[validoutcomes==outcome])==0) {
        stop("invalid outcome")
    }
    
    #Return hospital name in that state with the lowest 30-day death rate
    data.state = data[data$State==state, c(2,ratecols[outcome])]
    names(data.state) <- c("hospital", "mortality")
    #data.state
    sort(data.state[as.numeric(data.state$mortality) == min(as.numeric(data.state$mortality), na.rm=TRUE),"hospital"])
    #min(data.state$mortality, na.rm=TRUE)
}

