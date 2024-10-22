#### Preamble ####
# Purpose: Tests the cleaned US presidential election polling dataset.
# Author: Uma Sadhwani
# Date: 21 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `testthat` packages must be installed and loaded.
# Any other information needed? Ensure the cleaned dataset is located in the correct file path.

#### Workspace setup ####
library(tidyverse)
library(testthat)

# Load the cleaned dataset
analysis_data <- read_csv("/home/rstudio/polling_data/polling_data/data/02-analysis_data/analysis_data.csv")

# Convert sample_size to integer (in case it's read as double)
analysis_data <- analysis_data %>%
  mutate(sample_size = as.integer(sample_size))

#### Test data ####

# Test that the dataset has the expected number of rows and columns
test_that("dataset has expected number of rows", {
  expect_gt(nrow(analysis_data), 0)  # Expect more than 0 rows
})

test_that("dataset has expected columns", {
  expect_equal(ncol(analysis_data), 5)  # 5 columns: pollster, pollster_score, sample_size, candidate_name, candidate_support
})

# Test that key columns are of correct data types
test_that("'pollster' is character", {
  expect_type(analysis_data$pollster, "character")
})

test_that("'pollster_score' is numeric", {
  expect_type(analysis_data$pollster_score, "double")
})

test_that("'sample_size' is integer", {
  expect_type(analysis_data$sample_size, "integer")  # Now sample_size is explicitly an integer
})

test_that("'candidate_name' is character", {
  expect_type(analysis_data$candidate_name, "character")
})

test_that("'candidate_support' is numeric", {
  expect_type(analysis_data$candidate_support, "double")
})

# Test that there are no missing values in key columns
test_that("no missing values in key columns", {
  expect_true(all(!is.na(analysis_data$pollster)))
  expect_true(all(!is.na(analysis_data$pollster_score)))
  expect_true(all(!is.na(analysis_data$sample_size)))
  expect_true(all(!is.na(analysis_data$candidate_name)))
  expect_true(all(!is.na(analysis_data$candidate_support)))
})

# Test that sample_size values are reasonable (e.g., greater than 0)
test_that("sample_size values are positive", {
  expect_true(all(analysis_data$sample_size > 0))
})

# Test that candidate_support is within the expected range (0 to 100)
test_that("candidate_support is within valid range", {
  expect_true(all(analysis_data$candidate_support >= 0 & analysis_data$candidate_support <= 100))
})

# Test that there are at least 2 unique candidates in the dataset
test_that("'candidate_name' column contains at least 2 unique values", {
  expect_true(length(unique(analysis_data$candidate_name)) >= 2)
})

# Test that there are no empty strings in 'pollster' or 'candidate_name'
test_that("no empty strings in 'pollster' or 'candidate_name'", {
  expect_false(any(analysis_data$pollster == "" | analysis_data$candidate_name == ""))
})

#### Conclusion ####
print("All tests completed successfully.")
