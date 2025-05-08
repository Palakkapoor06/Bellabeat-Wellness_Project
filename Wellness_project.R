#Install and load the tidyverse
install.packages('tidyverse')
library(tidyverse)

daily_activity <- read.csv("dailyActivity_merged.csv")

sleep_day <- read.csv("sleepDay_merged.csv")
head(daily_activity)
colnames(daily_activity)
head(sleep_day)
colnames(sleep_day)

# Both datasets have the 'Id' field - 
# this can be used to merge the datasets.
# It looks like there may be more participants in the daily activity 
# dataset than the sleep dataset.

n_distinct(daily_activity$Id)
n_distinct(sleep_day$Id)
nrow(daily_activity)
nrow(sleep_day)
daily_activity %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes) %>%
  summary()

sleep_day %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()
ggplot(data=daily_activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point()

ggplot(data=sleep_day, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + geom_point()

## Merging these two datasets together 
combined_data <- merge(sleep_day, daily_activity, by="Id")

n_distinct(combined_data$Id)
ggplot(combined_data, aes(x = TotalMinutesAsleep, y = TotalSteps)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Trend Between Sleep and Steps")


