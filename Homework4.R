# Bio381 week 4: Vectors & Such 
# 02/09/2022
#GED

#Question 1
x <- 1.1
a <- 2.2
b <- 3.3
z <- x^a^b
print(z)
z <- (x^a)^b
print(z)
z <- (3*x^3) + (2*x^2) + 1
print(z)

# Question 2
a <- seq(from = 1, to = 8)
b <- seq(from = 7, to = 1)
c <- c(a,b)
print(c)
rep(1:5, c(1,2,3,4,5))
rep(5:1, c(1,2,3,4,5))

# Question 3
runif(2)
x <- 0.9449264
y <- 0.4901533
theta <- atan(y/x)
print(theta)
r <- sqrt((x^2)+(y^2))
print(r)

# Question 4
queue <- c("sheep", "fox", "owl", "ant")
print(queue)
c(queue, "serpent")
queue <- c(queue, "serpent")
queue <- queue[-1]
queue
queue <- c("donkey", queue)
print(queue)
queue <- queue[-5]
print(queue)
queue <- queue[-3]
print(queue)
c(queue[1], queue[2],"aphid", queue[3])
append(queue, "aphid", after = 2)
queue <- append(queue, "aphid", after = 2)
print(queue)
# The Aphid is 3rd in line

# Question 5
vector <- c(1:100)
print(vector)
which(vector%%2!=0 & vector%%3!=0 & vector%%7!=0)
vector <- which(vector%%2!=0 & vector%%3!=0 & vector%%7!=0)
print(vector)
