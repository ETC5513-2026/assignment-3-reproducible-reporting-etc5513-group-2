# scripts/00_generate_data.R
# Purpose: Generate reproducible synthetic student mental health dataset
# Author:  Member 2
# Date:    2026-05

library(tidyverse)

set.seed(42)
n <- 1200

student_data <- tibble(
  student_id             = 1:n,
  hours_studied_per_week = pmax(1L, pmin(40L,
                                         as.integer(round(rnorm(n, 22, 8))))),
  gpa                    = pmax(0,  pmin(10,
                                         round(rnorm(n, 6.5, 1.5), 1))),
  stress_level           = pmax(1L, pmin(10L,
                                         as.integer(round(rnorm(n, 6.4, 2))))),
  anxiety_score          = pmax(1L, pmin(10L,
                                         as.integer(round(rnorm(n, 5.2, 2.5))))),
  sleep_quality          = pmax(1L, pmin(10L,
                                         as.integer(round(rnorm(n, 5.8, 2))))),
  has_counseling_access  = sample(c(0L, 1L), n,
                                  replace = TRUE, prob = c(0.35, 0.65))
)

write_csv(student_data, "data/raw/student_data.csv")
cat("Generated:", nrow(student_data), "students,",
    ncol(student_data), "variables\n")