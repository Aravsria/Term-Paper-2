#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US presidential  
# election polling dataset.
# Author: Uma Sadhwani
# Date: 20 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: N/A
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(tidyverse)

# Load the simulated dataset
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

#### Structure Testing ####
# Check the structure of the dataset
glimpse(simulated_data)

# Check for any missing values in the dataset
missing_data <- sum(is.na(simulated_data))
print(paste("Number of missing values: ", missing_data))

# Ensure that the 'Candidate_A_support' and 'Candidate_B_support' columns sum to 1 (validity check)
support_sum_check <- simulated_data %>%
  mutate(total_support = Candidate_A_support + Candidate_B_support) %>%
  summarise(valid_support_sum = all(abs(total_support - 1) < 1e-6))

print(paste("Are all support sums valid (sum to 1)?", support_sum_check$valid_support_sum))

#### Descriptive Statistics ####
# Get summary statistics of key columns
summary(simulated_data)

# Check the distribution of sample sizes
ggplot(simulated_data, aes(x = sample_size)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(title = "Distribution of Sample Sizes", x = "Sample Size", y = "Count")

# Plot the distribution of Candidate A and B support
ggplot(simulated_data, aes(x = Candidate_A_support)) +
  geom_histogram(bins = 30, fill = "red", color = "black") +
  labs(title = "Distribution of Candidate A Support", x = "Candidate A Support", y = "Count")

ggplot(simulated_data, aes(x = Candidate_B_support)) +
  geom_histogram(bins = 30, fill = "green", color = "black") +
  labs(title = "Distribution of Candidate B Support", x = "Candidate B Support", y = "Count")

#### Pollster Analysis ####
# Count the number of simulations per pollster
pollster_count <- simulated_data %>%
  group_by(pollster) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

print(pollster_count)

# Plot the distribution of pollsters used in the simulations
ggplot(pollster_count, aes(x = reorder(pollster, -count), y = count)) +
  geom_bar(stat = "identity", fill = "orange") +
  coord_flip() +
  labs(title = "Number of Simulations per Pollster", x = "Pollster", y = "Number of Simulations")

#### Save Results ####
# Save the pollster count as a CSV for further review
write_csv(pollster_count, "/home/rstudio/polling_data/polling_data/data/02-analysis_results/pollster_count.csv")

#### Conclusion ####
print("All tests completed.")

