# dplyr
# GED
# 03/02/2022

## what is dplyr?:
# a new(er) package that provides a set of tools for manipulating datasets in R
# part of the tidyverse: an opinionated collection of R packages which share philosophy, grammar, and data structure
#specifically written to be fast!
#has individual functions that correspond to the most common operations
# makes it easier for you to figure out what to do with your data and analyze data 

## Core Verbs 
#filter(): pick/subset observations by their values (rows)
# arrange(): reordering rows
# select(): choose variables (columns) by names
# summarize() and group_by(): collapses many values down to a single summary 
# mutate(): creating new valuables with functions of existing variable 

library(tidyverse)
data(starwars)
class(starwars)

# tbl = tibble
# modern take on data frames
# said to keep the great aspects of data frames and drops the frustrating ones 

glimpse(starwars)
head(starwars)

# complete cases to clean up data
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
glimpse(starwarsClean)
#is.na(starwarsClean)
anyNA(starwarsClean)

head(starwarsClean)

## Filter()
# subset function by rows
# use <,>,<=,>=,!=,== for conditional statements 
# logical operators &, |, !
# filter auto. excludes NAs - have to ask 

filter(starwarsClean, gender=="masculine", height < 180)
# commands can be used 
filter(starwarsClean, gender=="masculine", height < 180, height > 100)

filter(starwarsClean, eye_color%in%c("blue","brown"))

## Arrange()
# reordering rows 
arrange(starwarsClean, by=desc(height))
arrange(starwarsClean, height, desc(mass))# mass is the tie breaker in height
tail(arrange(starwars, by=height))

## Select()
# chooses variables by their names 
# these all do the same thing
starwarsClean[,1:10]
select(starwarsClean, 1:10)
select(starwarsClean, name:homeworld)       
select(starwarsClean, -(films:starships))

# rearrange columns
select(starwarsClean, name, gender, species, everything())
select(starwarsClean, contains("color")) # other helper function: ends_with(), starts_with(), matches(), num_range()

# rename columns
select(starwarsClean, name, haircolor= hair_color, everything())

## Mutate()
# creates new variables with functions of existing variables
mutate(starwarsClean, ratio = height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2) # converts kilos to lbs in new column
select(starwars_lbs, 1:3, mass_lbs, everything())

#transmute --> temporary change that does not affect your whole data set
transmute(starwarsClean, mass_lbs = mass*2.2)

## Summarize() and group_by() collapses values and provides summary
summarize(starwarsClean, meanHeight = mean(height, na.rm=T),TotalN = n())
summarize(starwars, meanHeight = mean(height, na.rm=T),TotalN = n())
# group_by()
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)
summarize(starwarsGenders, meanHeight = mean(height, na.rm=T),TotalN = n())

## Piping
#%>%
# used to emphasize a sequence of actions
# let's you pass an intermediate result onto the next function - it takes the output of one statement/function and uses it as the input of the next statement/function
#avoid when manipulating more than one object, or if you have intermediate meaningful objects
# formatting: always have a space before pipe %>% and usually followed by a new line (with auto. indent) 
starwarsClean %>%  
  group_by(gender) %>%  
  summarize(meanHeight=mean(height), number = n())
# case_when() useful for multiple ifelse statements 
starwarsClean$SexID <- ifelse(starwarsClean$gender=="feminine", "F", "M")

starwarsClean %>% 
  mutate(sp = case_when(species == "Human" ~ "Humanoid", TRUE ~ "Non-human")) %>%
  select(name,sp,everything())
starwarsClean %>%
  group_by(films) %>%
  mutate(
    sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human"),
    status = case_when(str_detect(films, "A New Hope") ~ "OG", TRUE ~ "Later")) %>%
  select(name,sp, status, everything()) %>%
  arrange(status) %>%
  {starwarsOGstatus <<- .}
glimpse(starwarsOGstatus)

## Convert long to wide format and vice-versa
glimpse(starwarsClean)
wideSW <- starwarsClean %>% 
  select(name,sex, height) %>%
  pivot_wider(names_from=sex, values_from=height, values_fill=0)

## Long format
wideSW %>%
  pivot_longer(cols=male:female, 
               names_to="sex",
               values_to="height",
               values_drop_na=T)

##last example
starwars %>%
  select(name, homeworld) %>%
  group_by(homeworld) %>%
  mutate(rn = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = homeworld, values_from=name) %>%
  select(-rn)


