library(tidyverse)
library(randomizr)
library(readr)

# Random names dataset I found from internet
# https://www.briandunning.com/sample-data/

students <- read.csv("us-500-adjusted.csv")

# number of groups
groups <- 1:7


# Set seed to always get the same sampling
set.seed(123)

# I need to put students into 
# three different teams for three different tasks.
students$game_group <- complete_ra(length(students$first_name), num_arms = length(groups),
                                   conditions= c("England", "France", "Austria", "Germany", "Russia", "Turkey", "Italy"))
# Check the number of students to make sure all is well.
length(students$game_group[students$game_group == "England"])

set.seed(123)
students$debate_group <- complete_ra(length(students$first_name), num_arms = length(groups))

set.seed(123)
students$presentation_group <- complete_ra(length(students$first_name), num_arms = length(groups))

# randomizr makes teams as factors (T1, T2 etc.). 
# I Change them to numbers.

students$debate_group <- as.character(students$debate_group)
students$debate_group <- parse_number(students$debate_group)

students$presentation_group <- as.character(students$presentation_group)
students$presentation_group <- parse_number(students$presentation_group)

write.csv(students, "grouped_students.csv")
