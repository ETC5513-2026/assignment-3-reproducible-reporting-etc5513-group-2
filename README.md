# ETC5513 Assignment 3: Student Mental Health & Study Habits

## Team Members
- Member 1 (Setup & Integration Lead)
- Member 2 (Data Manager)
- Member 3 (Analysis Lead)
- Member 4 (Discussion & Synthesis Lead)

## Research Question
How do sleep quality, study habits, and access to mental health support
relate to stress and anxiety in student populations?

## How to Reproduce
### 1. Restore packages
renv::restore()

### 2. Run pipeline
source("R/00_setup.R")
source("scripts/01_data_loading.R")
source("scripts/02_data_cleaning.R")
source("scripts/03_analysis.R")

### 3. Render report
quarto render index.qmd --to pdf