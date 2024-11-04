#### Preamble ####
# Purpose: Simulates a dataset of the US presidential general election polling outcomes,
# for a specific pollster which includes the polling duration, sample size,
# and answers (candidate name)
# Author: Uma Sadhwani
# Date: 20 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: N/A
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(tidyverse)
set.seed(242)

# Read the original data
polling_data <- read.csv("data/01-raw_data/president_polls.csv")

#### Simulate data ####

# Define simulation parameters
num_simulations <- 1000
candidates <- c("Candidate_A", "Candidate_B")
population_size <- 1000000 # Total population for simulation purposes
sample_sizes <- sample(500:3000, num_simulations, replace = TRUE) # Randomly select sample sizes for each simulation

# Simulate polling data for each candidate
simulated_data <- data.frame(
  simulation_id = 1:num_simulations,
  sample_size = sample_sizes,
  Candidate_A_support = rbeta(num_simulations, shape1 = 52, shape2 = 48), # Shape parameters are based on 52% support for Candidate A
  Candidate_B_support = rbeta(num_simulations, shape1 = 48, shape2 = 52)  # Shape parameters for 48% support for Candidate B
)

# Normalize the data so that support adds up to 1
simulated_data <- simulated_data %>%
  mutate(total_support = Candidate_A_support + Candidate_B_support,
         Candidate_A_support = Candidate_A_support / total_support,
         Candidate_B_support = Candidate_B_support / total_support)

# Introduce non-response bias
simulated_data <- simulated_data %>%
  mutate(Candidate_A_support = ifelse(runif(num_simulations) < 0.1, Candidate_A_support * 1.05, Candidate_A_support), # 10% chance of bias increasing support by 5%
         Candidate_B_support = 1 - Candidate_A_support)

# Use pollsters from the original dataset
pollsters <- unique(polling_data$pollster)
simulated_data$pollster <- sample(pollsters, num_simulations, replace = TRUE)

# Add a small random effect for each pollster
pollster_effect <- rnorm(length(pollsters), mean = 0, sd = 0.02) # Small random effect with mean 0 and SD 0.02
names(pollster_effect) <- pollsters

simulated_data <- simulated_data %>%
  rowwise() %>%
  mutate(Candidate_A_support = Candidate_A_support + pollster_effect[pollster],
         Candidate_A_support = pmin(pmax(Candidate_A_support, 0), 1), # Ensure values are between 0 and 1
         Candidate_B_support = 1 - Candidate_A_support)

#### Save data ####
write.csv(simulated_data, "data/00-simulated_data/simulated_data.csv", row.names = FALSE)
