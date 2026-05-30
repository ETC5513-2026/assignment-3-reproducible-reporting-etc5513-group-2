# scripts/01_data_loading.R
# Purpose: Load raw student mental health data
# Author:  Member 2
# Date:    2026-05

library(tidyverse)

cat("\n=== LOADING DATA ===\n")

student_data_raw <- read_csv("data/raw/student_data.csv",
                             show_col_types = FALSE)

cat("Rows:   ", nrow(student_data_raw), "\n")
cat("Columns:", ncol(student_data_raw), "\n")

print(head(student_data_raw, 5))