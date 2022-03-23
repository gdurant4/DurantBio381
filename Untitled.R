##############################################
# BIO 381 tutorial: data sims                #
# 16 Mar 2022                                #
##############################################

library(boot)

# why sim data?
# saves time: write parts of code before you have data
# baseline for comparisons: check assumptions in your data
# Test new stats techniques 

##############################################
# Part 1: Normally Distributed Data  ---------------------------------
# start with groups of data
# for t-tests of ANOVA

# simulate groups with 20 observations 
group1 <- rnorm(n=20,mean=2,sd=1)
hist(group1)

# change some parameters 
group2 <- rnorm(n=20,mean=5,sd=1)
group3 <- rnorm(n=20,mean=2,sd=3)

hist(group2)
hist(group3)
##############################################

##############################################
# Sim data for a linear model ---------------------------------
# two continuous normal variables 
# start simple: assume an intercept of 0
# call the slope beta1
# x is the predictor variable 

# start with constant slope
beta1 <- 1

# our predictor variable is normally distributed
x <- rnorm(n=20)

# linear model:
y <- beta1*x

# you can play with different slopes
beta1 <- 1.5
y <- beta1*x

# you can add an intercept
beta0 <- 2
y <- beta0+ beta1*x

# adding covariantes 
# you can draw covariate from a different distrubution 

##############################################
# Part 2: Abundance/count data ---------------------------------
# Option 1: data are normal-ish
# use round() to remove decimals 
abund1 <- round(rnorm(n=20,mean=50,sd=10))
hist(abund1)
# need sufficiently high mean and standard deviation

# Option 2: Poisson distribution
abund2 <- rpois(n=20, lambda=3)
barplot(table(abund2)) # table counts each time a number appears and sticks it in a bar plot
# lambda is like the mean of a poisson, which does not have a mean. Kind of like the center. It is the expected count, or the one you will get most often if the experiment is repeated several times
# the table function tallies the number of each value you get so the data makes sense in a bar graph
# usually abundance is not random

# Sometimes, the environment affects counts
# to account for that, we will first create our lambdas 
# then use lambdas to get abundances

# use a regression to get the initial values
pre_lambda <- beta0 + beta1*x
# lambdas always have to be positive, so use inverse log
lambda <- exp(pre_lambda)

# use created lambda values to get counts 
abund3 <- rpois(n=20,lambda=lambda)
hist(abund3)

##############################################
# Part 3: occupancy, presence/absense data ---------------------------------
# option 1: getting probs from a beta distributiom
probs <- rbeta(n=20,shape=1,shape2=1)
occ1 <- rbinom(n=20,size=1,prob=probs)
print(occ1)
# probs is the probability of success 
# this is usually non-random

# option 2: occupancy with a co-variate
# similar to above, except we are generating probabilities, not lambdas
pre_probs <- beta0 + beta1*x
print(pre_probs)
# convert to a 0-1 scale 
psi <- inv.logit(pre_probs)  #psi = occupancy probability 
# create new occupancy data
occ2 <- rbinom(n=20,size=1,prob=psi)
print(occ2)
##############################################
