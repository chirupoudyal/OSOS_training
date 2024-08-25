#install.packages("jsonlite")
#install.packages(c("lubridate","wesanderson"))
#install.packages(c("sp","osmdata"))

library(jsonlite)
library(lubridate,wesanderson)
library(sp,osmdata)

jsonData = read_json("/Users/chiranjibipoudyal/Desktop/R-studio codes/Github folder/OSOS_training/veo_tripData_fromAPI_11-06-22_to_11-14-22.json",
                     simplifyVector = TRUE)
jsonData[1,]
table(unlist(jsonData$propulsion_types))
hist(jsonData$trip_distance)
sum(jsonData$trip_distance == 0)/nrow(jsonData)
sum(jsonData$trip_duration == 0)/nrow(jsonData)

#clean the data
filter <- (jsonData$trip_duration/ 60 > 5) & 
  (jsonData$trip_duration /3600 < 1) &
  (jsonData$trip_distance > 0) &
  (jsonData$trip_distance < 20000) 
  
#filter <- filter & (jsonData$trip_duration != 0)
jsonDataClean <- jsonData[filter,]
nrow(jsonDataClean)

hist(jsonDataClean$trip_distance)
hist(jsonDataClean$trip_duration)
nrow(jsonDataClean)/nrow(jsonData)


#convert start and end times
library(lubridate)


startTimes <- lubridate::as_datetime(jsonDataClean$start_time/1000) 
startTimes[1:5]
startTimes=with_tz(startTimes, label = TRUE)

weekday = as.character(wday(startTimes, label=TRUE))
weekday[1]

endTimes <- as_datetime(jsonDataClean$end_time/1000) 
startTimes <- with_tz(startTimes,"US/Central")
endTimes <- with_tz(endTimes,"US/Central")

hist(startTimes, breaks = 25)
startTimesDay = hour(startTimes) + minute(startTimes)/60
hist(startTimesDay)
histout = hist(startTimesDay)
str(histout)


#Tidyverse
#install.packages("tidyverse")
#install.packages("tidyverse")
library(dplyr)
library(tidyr)
library(ggplot2)
library(palmerpenguins)

print(penguins)


penguins_df = as.data.frame(penguins) 
# creata a data.frame by applying the as.dat
#a.frame() function to the penguin tibble
print(penguins_df)
str(penguins_df)

## Getting just one variable from the tibble, select(tibble, column)
select(penguins, body_mass_g) 

#Getting a column as a vector from tribble
pull(penguins, body_mass_g)

#Selecting two or more variable
names(penguins)
select(penguins, body_mass_g, sex)
pull(penguins, body_mass_g, sex)

#just pulling the variable that I sex specific
# Intermediate Steps #
bodyMassDat = select(penguins, body_mass_g, sex) 
# select body mass and sex and save as a new tibble
filter(bodyMassDat, sex == "female") 
# filter bodyMassDat for only the rows for which sex is female

# Nested Steps #
filter(select(penguins, body_mass_g, sex), sex == "female") 
# use select() inside filter() to select variables before filter

# Piping #
#pipeps forward the output of an operation to the next function
# We don't have to specify the data set agina for the "downstream" function
select(penguins, body_mass_g, sex) %>%
  filter(sex == "female") 
# use select, "pipe"output forward to filter()

select(penguins, island, body_mass_g, sex) %>% 
  # use select to get island, body mass, sex from the penguins data set, pipe output forward
filter(sex == "female" & island == "Torgersen") 
# then filter for rows where sex is female and island is Torgersen

####Mutate to create new variables
# mutate(data, newVariableName = ...)
mutate(penguins, pengPlumpInd = body_mass_g / flipper_length_mm) %>%
pull(pengPlumpInd)

filter(penguins, !is.na(sex)) %>% 
  mutate(pengPlumpInd = body_mass_g / flipper_length_mm)

####Split-apply-combine approach to data analysis
#group_by()
filter(penguins, !is.na(sex)) %>% group_by(sex) 
# filter for rows for which sex is *not* NA, and then group the result by sex.

#group by multiple variables
filter(penguins, !is.na(sex)) %>% group_by(sex, island) 
# filter for rows for which sex is *not* NA, and then group the result by sex and island.

#use the summarize(data, SummaryVariableName = how its calclulated)
# filter penguins to remove rows for which sex is unknown, then group the data by sex, and then calculate mean body mass for each group.
filter(penguins, !is.na(sex)) %>% 
  group_by(sex) %>% 
  summarize(meandBodyMassg = mean(body_mass_g))

filter(penguins, !is.na(sex)) %>% 
  group_by(sex) %>% 
  summarize(meanBodyMassg = mean(body_mass_g), sdBodyMassg = sd(body_mass_g))


# filter() to remove rows where sex is NA,
filter(penguins, !is.na(sex)) %>%
  # mutate() to calculate penguin plumpness index from body mass and flipper length
  mutate(pengPlumpInd = body_mass_g / flipper_length_mm) %>%
  # group data by sex
  group_by(sex) %>%
  # summarize groups in terms of mean body manss, sd in body mass, mean PPI, and sd in PPI
summarize(meanBodyMassg = mean(body_mass_g),
          sdBodyMassg = sd(body_mass_g),
          meanPPI = mean(pengPlumpInd),
          sdPPI = sd(pengPlumpInd))
