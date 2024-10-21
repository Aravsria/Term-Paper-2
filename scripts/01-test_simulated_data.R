#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US presidential  
  # election polling dataset.
# Author: Arav Sri Agarwal
# Date: 20 October 2024
# Contact: arav.agarwal@mail.utoronto.ca
# License: N/A
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

# Load the simulated data
simulated_data <- read.csv("data/00-simulated_data/simulated_data.csv")

# Test if the data has been loaded successfully
stopifnot(!is.null(simulated_data))

# Check that the expected columns are present
expected_columns <- c("simulation_id", "Candidate_A_support", "Candidate_B_support")
stopifnot(all(expected_columns %in% colnames(simulated_data)))

# Test data types
stopifnot(is.numeric(simulated_data$Candidate_A_support))
stopifnot(is.numeric(simulated_data$Candidate_B_support))
stopifnot(is.integer(simulated_data$simulation_id))

# Test if support values are within the range [0, 1]
stopifnot(all(simulated_data$Candidate_A_support >= 0 & simulated_data$Candidate_A_support <= 1))
stopifnot(all(simulated_data$Candidate_B_support >= 0 & simulated_data$Candidate_B_support <= 1))

# Test if the sum of support for both candidates is approximately 1
tolerance <- 0.01
stopifnot(all(abs(simulated_data$Candidate_A_support + simulated_data$Candidate_B_support - 1) < tolerance))

# Test for unique simulation IDs
stopifnot(length(unique(simulated_data$simulation_id)) == nrow(simulated_data))

# Test if the average support for Candidate A is reasonable (e.g., around 0.5)
mean_candidate_A <- mean(simulated_data$Candidate_A_support)
stopifnot(mean_candidate_A > 0.4 & mean_candidate_A < 0.6)

# Test if the variance is not zero (indicating variation in the data)
var_candidate_A <- var(simulated_data$Candidate_A_support)
stopifnot(var_candidate_A > 0)

# If pollster information is present, ensure no missing values
if ("pollster" %in% colnames(simulated_data)) {
  stopifnot(!any(is.na(simulated_data$pollster)))
}

# Load the simulated data
simulated_data <- read.csv("data/00-simulated_data/simulated_data.csv")

# Test if the data has been loaded successfully
stopifnot(!is.null(simulated_data))

# Check that the expected columns are present
expected_columns <- c("simulation_id", "Candidate_A_support", "Candidate_B_support")
stopifnot(all(expected_columns %in% colnames(simulated_data)))

# Test data types
stopifnot(is.numeric(simulated_data$Candidate_A_support))
stopifnot(is.numeric(simulated_data$Candidate_B_support))
stopifnot(is.integer(simulated_data$simulation_id))

# Test if support values are within the range [0, 1]
stopifnot(all(simulated_data$Candidate_A_support >= 0 & simulated_data$Candidate_A_support <= 1))
stopifnot(all(simulated_data$Candidate_B_support >= 0 & simulated_data$Candidate_B_support <= 1))

# Test if the sum of support for both candidates is approximately 1
tolerance <- 0.01
stopifnot(all(abs(simulated_data$Candidate_A_support + simulated_data$Candidate_B_support - 1) < tolerance))

# Test for unique simulation IDs
stopifnot(length(unique(simulated_data$simulation_id)) == nrow(simulated_data))

# Test if the average support for Candidate A is reasonable (e.g., around 0.5)
mean_candidate_A <- mean(simulated_data$Candidate_A_support)
stopifnot(mean_candidate_A > 0.4 & mean_candidate_A < 0.6)

# Test if the variance is not zero (indicating variation in the data)
var_candidate_A <- var(simulated_data$Candidate_A_support)
stopifnot(var_candidate_A > 0)

# If pollster information is present, ensure no missing values
if ("pollster" %in% colnames(simulated_data)) {
  stopifnot(!any(is.na(simulated_data$pollster)))
}

cat("All tests passed successfully!\n")
