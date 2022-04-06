# Nested for loop ---------------------------------
# create a sample matrix 
mat <- matrix(sample(1:10, size=9),
              nrow=3,
              ncol=3)
print(mat)

# writing the for loop
# first part of the for loop is the header/iterator 
for(i in 1:nrow(mat)) {
  for(j in 1:ncol(mat)){
    print (mat[i,j]) # is going to print all columns in mat 
  }
}
    
  
# i is the counter variable and hold the repitition, does from starting number to rnow in the matrix 
# 2 counter variable running at the same time 
# runs the first row, then the second, then the third 

# use a nested for loop on the assignment, but generally do not do this 

# Part 2: putting custom functions in for loops -----------------
# simulating temp data at 3 different sites
site1 <- runif(min=60,max=70,n=10)
site2 <- runif(min=60,max=70,n=10)
site3 <- runif(min=40,max=50,n=10)

# put then in a df: 
temps_df <- cbind(site1,site2,site3)
head(temps_df)

# function to convert to Celcius
degF_to_degC <- function(x) {
  degC <- (x-32)*(5/9)
  return(degC)
}

# repeat a function using a for loop
# apply the formula to each column in the data frame using a for loop
for (i in 1:ncol(temps_df)) {
  print(degF_to_degC(x=temps_df[,i]))
}










