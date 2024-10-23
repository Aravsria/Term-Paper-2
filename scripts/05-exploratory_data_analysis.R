
#### Preamble ####
# Purpose: Models the relationship between pollster score, sample size, and candidate support in US presidential election polling data.
# Author: Uma Sadhwani
# Date: 21 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `rstanarm` packages must be installed and loaded.
# Any other information needed? Ensure the cleaned dataset is located in the correct file path.

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
# Load the cleaned dataset
analysis_data <- read_csv("/home/rstudio/polling_data/polling_data/data/02-analysis_data/analysis_data.csv")

#### Model data ####
# Define the model: Predict candidate support based on pollster score and sample size
election_model <-
  stan_glm(
    formula = candidate_support ~ pollster_score + sample_size,
    data = analysis_data,
    family = gaussian(),  # Assume a continuous outcome for candidate support
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 242  # Set seed for reproducibility
  )

#### Save model ####
# Save the fitted model to a file for future analysis
saveRDS(
  election_model,
  file = "/home/rstudio/polling_data/polling_data/models/election_model.rds"
)

#### Conclusion ####
print("Model fitting completed and saved successfully.")

