# Purpose: Replicates graphs from the analysis of the US presidential election polling data.
# Author: Uma Sadhwani
# Date: 21 October 2024
# Contact: uma.sadhwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed and loaded.
# Any other information needed? Ensure the cleaned analysis dataset is available in the correct file path.

#### Workspace setup ####
library(tidyverse)

#### Load data ####
# Load the cleaned dataset for analysis
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Replicate graphs ####

# 1. Plot the distribution of candidate support
ggplot(analysis_data, aes(x = candidate_support)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(
    title = "Distribution of Candidate Support",
    x = "Candidate Support (%)",
    y = "Count"
  ) +
  theme_minimal()

# 2. Scatter plot of candidate support vs. pollster score
ggplot(analysis_data, aes(x = pollster_score, y = candidate_support)) +
  geom_point(alpha = 0.7, color = "red") +
  geom_smooth(method = "lm", color = "black", se = FALSE) +
  labs(
    title = "Candidate Support vs. Pollster Score",
    x = "Pollster Score",
    y = "Candidate Support (%)"
  ) +
  theme_minimal()

# 3. Scatter plot of candidate support vs. sample size
ggplot(analysis_data, aes(x = sample_size, y = candidate_support)) +
  geom_point(alpha = 0.7, color = "green") +
  geom_smooth(method = "lm", color = "black", se = FALSE) +
  labs(
    title = "Candidate Support vs. Sample Size",
    x = "Sample Size",
    y = "Candidate Support (%)"
  ) +
  theme_minimal()

# 4. Boxplot of candidate support by candidate name
ggplot(analysis_data, aes(x = candidate_name, y = candidate_support, fill = candidate_name)) +
  geom_boxplot() +
  labs(
    title = "Candidate Support by Candidate",
    x = "Candidate",
    y = "Candidate Support (%)"
  ) +
  theme_minimal()

#### Create directory if it doesn't exist ####
dir_path <- "outputs/graphs"

if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
}

# Print confirmation
if (dir.exists(dir_path)) {
  print(paste("Directory created or already exists:", dir_path))
} else {
  stop("Failed to create directory:", dir_path)
}

#### Save plots ####
ggsave("outputs/graphs/candidate_support_distribution.png", width = 8, height = 6)
ggsave("outputs/graphs/candidate_support_vs_pollster_score.png", width = 8, height = 6)
ggsave("outputs/graphs/candidate_support_vs_sample_size.png", width = 8, height = 6)
ggsave("outputs/graphs/candidate_support_by_candidate.png", width = 8, height = 6)

#### Conclusion ####
print("Graph replication completed and saved successfully.")

