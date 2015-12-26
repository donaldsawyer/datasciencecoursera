#Two functions are in this r script.
# 1. makeCacheMatrix creates a 'special' matrix used for caching the inverse of the matrix.
# 2. cacheSolve calculates the inverse of the 'special

#creates a special matrix data structure using get/set operations.
#  If the inverse of the matrix is needed, it is calculated only once.
#  All subsequent calls to the inverse will return a cached version.
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    
    #setter of the original matrix
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    
    #getter of the original matrix
    get <- function() x
    
    #set the stored version of the inverse of x
    setInverseMatrix <- function(invMatrix) m <<- invMatrix
    
    #get the cached version of the inverse of x
    getInverseMatrix <- function() m
    
    #list of available functions for the "special matrix"
    list(set = set, 
         get = get, 
         setInverseMatrix = setInverseMatrix, 
         getInverseMatrix = getInverseMatrix)
}


#returns the inverse of a matrix.
#  if the inverse is already cached, the cached version is returned.
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    
    # attempt to retrieve the cached inverse matrix
    m <- x$getInverseMatrix()
    
    #if the cache was not empty, don't recalculate the inverse, rather return the cached version
    #only have a single RETURN statement per good coding practices
    if(!is.null(m)) {
        #m does not need to be modified, it will be returned below
        message("getting cached inverse matrix")
    } else {
        #get the matrix to inverse and calculate the inverse
        data <- x$get()
        m <- solve(data, ...)
        #set the cached inverse
        x$setInverseMatrix(m)
    }
    
    #return the inverse matrix, cached or not.  This is the SINGLE return of the function
    m
}

## TESTS ##
#c=rbind(c(4,3), c(3,2))
#yy <- makeCacheMatrix(c)
#cacheSolve(yy) # does not use cache
#cacheSolve(yy) # uses cache
## INVERSE RESULT
#       [,1] [,2]
# [1,]   -2    3
# [2,]    3   -4

## 3x3 TEST ##
# c = rbind(c(1,2,3), c(0, 1, 4), c(5,6,0))
# yy <- makeCacheMatrix(c)
# cacheSolve(yy)
# cacheSolve(yy)
## INVERSE RESULT
#       [,1] [,2] [,3]
# [1,]  -24   18    5
# [2,]   20  -15   -4
# [3,]   -5    4    1