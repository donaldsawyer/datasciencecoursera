#question 1
library(datasets)
data(iris)
?iris
tapply(iris$Sepal.Length, iris$Species, FUN=mean)

#question 2
apply(iris[,1:4],2, FUN=mean)

#question 3
library(datasets)
data(mtcars)
?mtcars
tapply(mtcars$mpg, mtcars$cyl, mean)

#question 4
hps <- tapply(mtcars$hp, mtcars$cyl, mean)
abs(hps["8"]-hps["4"])

#question 5
undebug(ls)
ls()
