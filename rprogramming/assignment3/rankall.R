#outcome = "heart attack"
#num = 20

rankall <- function(outcome, num = "best") {
    require(dplyr)
    
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClass="character", header=TRUE)
    
    #define column constants
    ratecols <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    colnames(data)[ratecols] = names(ratecols)
    states <- levels(as.factor(data$State))
    endcols <- c("hospital", "state")

    ## Check that state and outcome are valid
    validnums <- c("best", "worst")
    if(!((is.numeric(num) & as.numeric(num) > 0) | sum(validnums==num)>0)) {
        stop("invalid num")
    } else if(num == "best") { num <- 1 }
    
    validoutcomes <- names(ratecols)
    if(length(validoutcomes[validoutcomes==outcome])==0) {
        stop("invalid outcome")
    }

    data.numeric <- data.frame(data %>% select(state=State, hospital=Hospital.Name),lapply(data %>% select(outcomecol=ratecols[outcome]), FUN=as.numeric)) %>%
        filter(!is.na(outcomecol)) %>% group_by(state) %>% arrange(state, outcomecol, hospital) %>% 
        mutate(rank=rank(outcomecol, ties.method="first"))
     if(is.numeric(num) | num == "best") {
         data.numeric <- filter(data.numeric, rank==num)
     } else {
         data.numeric <- filter(data.numeric, rank==max(rank))
     }

    rval <- data.frame()
    
    for(s in states) {
        lu <- data.numeric[data.numeric$state == s,endcols]
        if(nrow(lu) == 0) {
            lu <- rbind(lu, c("<NA>", s))
            names(lu) <- endcols
        }
        rval <- rbind(rval, lu[1,])
        row.names(rval) <- rval$state
    }
    rval
}

# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)
