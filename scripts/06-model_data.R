#### Preamble ####
# Purpose: Models the US presidential election polling data by predicting candidate support based on pollster score and sample size.
# Author: Uma Sadhwani
# Date: 21 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `rstanarm` packages must be installed and loaded.
# Any other information needed? Ensure the analysis dataset is located in the correct file path.

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
# Load the cleaned dataset for analysis
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Model data ####
# Define the Bayesian model: Predict candidate support based on pollster score and sample size
election_model <-
  stan_glm(
    formula = candidate_support ~ pollster_score + sample_size,
    data = analysis_data,
    family = gaussian(),  # Assuming continuous candidate support as the outcome
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Define normal prior for coefficients
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Normal prior for intercept
    prior_aux = exponential(rate = 1, autoscale = TRUE),  # Exponential prior for auxiliary parameter
    seed = 242  # Set seed for reproducibility
  )

#### Save model ####
# Save the fitted model for future analysis
saveRDS(
  election_model,
  file = "models/election_model.rds"
)

#### Conclusion ####
print("Model fitting completed and saved successfully.")
