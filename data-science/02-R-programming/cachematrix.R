###
# Create the matrixCacheVector to manipulate the cache
# 
# return an list with some functions:
#  set: set a new value to the matrix, clean the cache
#  get: get the current value of the matrix
#  setInverse: set a new value of the inverse cache. 
#  getInverse: get the current cache value, can be null
###
makeCacheMatrix <- function(matrixValue = matrix()) {
  inverse <- NULL
  set <- function(newValue) {
    matrixValue <<- newValue
    inverse <<- NULL
  }
  get <- function() matrixValue
  setInverse <- function(inverseValue) inverse <<- inverseValue
  getInverse <- function() inverse
  list(
      set = set, 
      get = get,
      setInverse = setInverse,
      getInverse = getInverse
  )
}

###
# Return the inverse value of the received matrix
#
#  1. try use the cached inverse value if exists
#  2. calculate and save the inverse value if not exists
#  3. returns the inverse value
#
# @param   matrixCacheVector
# @params  params of the solve function
# @return  the inverse value of the matrix
###
cacheSolve <- function(matrixCacheVector, ...) {

  # try get the inverse value from the cache
  cachedInverseValue <- matrixCacheVector$getInverse()

  # if value was found into cache, returns it
  if(!is.null(cachedInverseValue)) {
    return(cachedInverseValue)
  }
  
  # get the matrix data
  matrixData <- matrixCacheVector$get()
  
  # calculate the inverse value from the matrix data
  calculatedInverseValue <- solve(matrixData, ...)
  
  # save the inverse value into cache
  matrixCacheVector$setInverse(calculatedInverseValue)

  # return calculated inverse value  
  return(calculatedInverseValue)
}

# Define the assertion functions that will be used in the code test

###
# Assert some validation that expected and received value are equals.
###
assertEquals <- function( validation, expected, received ) {
  if( ! all.equal(received,expected) ) {
    warning( paste( "error in assert equals: ", validation ) )
  }  else {
    print( paste( "pass in assert equals: ", validation ) )
  }
}

###
# Assert some validation that received value should be null.
###
assertNull <- function( validation, received ) {
  if( !is.null( received ) ) {
    warning( paste( "error in assert null: ", validation ) )
  }  else {
    print( paste( "pass in assert null: ", validation ) )
  }
}


###
# Testing the cache matrix
#
# Set, get and change the matrix value and its cache value to check it work properly
###
testCacheMatrix <- function() {
  
  # set matrix value
  testMatrix <- matrix( 
    c(1, 2, 3, 4), 
    nrow=2, 
    ncol=2
  )
  
  # set inverse value
  testAnswerInverse <- solve( testMatrix )
  
  # create the matrixCacheVector
  testMatrixCacheVector <- makeCacheMatrix( testMatrix )
  
  assertEquals(
    "assert that the matrixCacheVector has the original testMatrix value",
    testMatrix, testMatrixCacheVector$get()
  )
  
  assertNull( 
    "assert that the cache start null",
    testMatrixCacheVector$getInverse()
  )
  
  # receive the cacheSolve answer
  testCacheSolveAnswer <- cacheSolve( testMatrixCacheVector )
  
  assertEquals(
    "assert that the cacheSolve returns the matrix solve",
    testAnswerInverse,
    testCacheSolveAnswer
  )
  
  assertEquals(
    "assert that the cache receives the solve value",
    testAnswerInverse,
    testMatrixCacheVector$getInverse()
  )
  
  # create a new matrix value
  testNewMatrixValue <- matrix( 
    c(4, 3, 2, 1), 
    nrow=2, 
    ncol=2
  )
  
  # update the matrix value of the cache matrix
  testMatrixCacheVector$set( testNewMatrixValue )
  testNewAnswerInverse <- solve( testNewMatrixValue )
  
  assertEquals(
    "assert that the matrixCacheVector value can be updated",
    testNewMatrixValue, testMatrixCacheVector$get()
  )
  
  assertNull( 
    "assert that the cache is set to null after value update",
    testMatrixCacheVector$getInverse()
  )
  
  # receive the cacheSolve answer
  testNewCacheSolveAnswer <- cacheSolve( testMatrixCacheVector )
  
  assertEquals(
    "assert that the cacheSolve returns the matrix solve",
    testNewAnswerInverse,
    testNewCacheSolveAnswer
  )
  
  assertEquals(
    "assert that the cache receives the solve value",
    testNewAnswerInverse,
    testMatrixCacheVector$getInverse()
  )
}

# run the test cache matrix
testCacheMatrix()
