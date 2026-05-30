# scripts/02_data_cleaning.R
# Purpose: Clean and preprocess student mental health data
# Author:  Member 2
# Date:    2026-05

library(tidyverse)
library(janitor)

cat("\n=== CLEANING DATA ===\n")

student_data_raw <- read_csv("data/raw/student_data.csv",
                             show_col_types = FALSE)

student_data_clean <- student_data_raw |>
  clean_names() |>
  drop_na() |>
  mutate(
    stress_category = case_when(
      stress_level <= 3 ~ "Low",
      stress_level <= 6 ~ "Moderate",
      TRUE              ~ "High"
    ),
    sleep_category = case_when(
      sleep_quality <= 3 ~ "Poor",
      sleep_quality <= 6 ~ "Fair",
      TRUE               ~ "Good"
    ),
    counseling_access = ifelse(has_counseling_access == 1, "Yes", "No")
  )

write_csv(student_data_clean,
          "data/processed/student_data_clean.csv")

cat("Original rows:", nrow(student_data_raw), "\n")
cat("Cleaned rows: ", nrow(student_data_clean), "\n")