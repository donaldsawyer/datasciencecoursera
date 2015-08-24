#1
set.seed(1)
rpois(5, 2)

#what function for standard normal rand variables?
#?rnorm

#When simulating data, why is set.seed important?
# consistency and reproducibility

?qpois
?dpois

#Which function can be used to evaluate the inverse cumulative distribution function for the Poisson distribution?
# ppois? Nope.

#5
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
x
#generate data from a normal linear model

#What R function can be used to generate Binomial random variables?
#rbinom

#What aspect of the R runtime does the profiler keep track of when an R expression is evaluated?
#the function call stack

#8
library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
#100%

#9 When using 'system.time()', what is the user time?
# time spent by CPU evaluating expression

#10 If a computer has more than one available processor and R is able to take advantage of that, then which of the following is true when using 'system.time()'?
# elapsed time may be smaller than user time