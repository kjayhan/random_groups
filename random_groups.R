library(tidyverse)
library(randomizr)
library(readr)

# Random names dataset I found from internet
# https://www.briandunning.com/sample-data/

students <- read.csv("us-500-adjusted.csv")

# number of groups
groups <- 1:16

# Set seed to always get the same sampling
set.seed(123)

# I need to put students into 
# three different teams for three different tasks.
students$game_group <- complete_ra(length(students$first_name), num_arms = length(groups))
# Check the number of students to make sure all is well.
length(students$game_group[students$game_group == "T3"])

set.seed(20220903)
students$debate_group <- complete_ra(length(students$first_name), num_arms = length(groups))

set.seed(1905)
students$presentation_group <- complete_ra(length(students$first_name), num_arms = length(groups))

# randomizr makes teams as factors (T1, T2 etc.). 
# I Change them to numbers.

students$game_group <- as.character(students$game_group)
students$game_group <- parse_number(students$game_group)

students$debate_group <- as.character(students$debate_group)
students$debate_group <- parse_number(students$debate_group)

students$presentation_group <- as.character(students$presentation_group)
students$presentation_group <- parse_number(students$presentation_group)

write.csv(students, "grouped_students.csv")
