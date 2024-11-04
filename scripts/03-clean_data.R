#### Preamble ####
# Purpose: Cleans the raw US presidential general election polling data used in the model.
# Author: Uma Sadhwani
# Date: 21 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `janitor` packages must be installed.
# Any other information needed? Ensure the raw data is located in the correct file path.

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
# Load the raw polling data
raw_data <- read_csv("data/01-raw_data/president_polls.csv")

# Clean the dataset
analysis_data <- 
  raw_data %>%
  janitor::clean_names() %>%  # Clean column names
  select(pollster, pollscore, sample_size, candidate_name, pct) %>%  # Select relevant columns
  filter(!is.na(pollscore), !is.na(sample_size), !is.na(pct)) %>%  # Filter out rows with missing data in key columns
  mutate(
    pct = as.numeric(pct),  # Ensure percentage (pct) is numeric
    pollscore = as.numeric(pollscore),  # Ensure pollscore is numeric
    sample_size = as.integer(sample_size)  # Ensure sample_size is integer
  ) %>%
  filter(pct >= 0 & pct <= 100) %>%  # Ensure pct values are between 0 and 100
  rename(
    candidate_support = pct,  # Rename pct column to make it more descriptive
    pollster_score = pollscore  # Rename pollscore column
  ) %>%
  drop_na()  # Drop any rows that still have NA values after cleaning

#### Save data ####
# Save the cleaned dataset
write_csv(analysis_data, "data/02-analysis_data/analysis_data.csv")
