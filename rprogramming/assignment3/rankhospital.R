#outcome = "heart attack"
#num = 20

rankhospital <- function(state, outcome, num = "best") {
    require(dplyr)
    
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClass="character", header=TRUE)
    
    #define column constants
    ratecols <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    colnames(data)[ratecols] = names(ratecols)
    endcols <- c("Hospital.Name", "State")
    
    ## Check that state and outcome are valid
    validstates <- levels(as.factor(data$State))
    if(length(validstates[validstates==state])==0) {
        stop("invalid state")
    }
    
    validnums <- c("best", "worst")
    if(!((is.numeric(num) & as.numeric(num) > 0) | sum(validnums==num)>0)) {
        stop("invalid num")
    } else if(num == "best") { num <- 1 }
    
    validoutcomes <- names(ratecols)
    if(length(validoutcomes[validoutcomes==outcome])==0) {
        stop("invalid outcome")
    }
    
    data.numeric <- data.frame(data %>% select(Hospital.Name, State),lapply(data %>% select(outcomecol=ratecols[outcome]), FUN=as.numeric)) %>%
                                        filter(!is.na(outcomecol) & State==state) %>%
                                        arrange(outcomecol, Hospital.Name) %>%
                                        mutate(rank=rank(outcomecol, ties.method="first"))
                               
    if(is.numeric(num) | num == "best") {
        data.numeric <- filter(data.numeric, rank==num)
    } else {
        data.numeric <- filter(data.numeric, rank==max(rank))
    }
    
    data.numeric[1,"Hospital.Name"]
}

# rankhospital("TX", "heart failure", 4)
# rankhospital("MD", "heart attack", "worst")
# rankhospital("MN", "heart attack", 5000)
