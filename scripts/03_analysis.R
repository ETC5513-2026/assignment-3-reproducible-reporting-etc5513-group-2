# scripts/03_analysis.R
# Purpose: Compute key statistics and save analysis figures
# Author:  Member 3
# Date:    2026-05

library(tidyverse)
library(ggplot2)

cat("\n=== ANALYSIS ===\n")

student_data <- read_csv("data/processed/student_data_clean.csv",
                         show_col_types = FALSE) |>
  mutate(sleep_category = factor(sleep_category,
                                 levels = c("Poor", "Fair", "Good")))

# Key statistics — note the r values printed, use them in Results text
cor_study_gpa <- cor(student_data$hours_studied_per_week,
                     student_data$gpa, use = "complete.obs")
cor_sleep_stress <- cor(student_data$sleep_quality,
                        student_data$stress_level, use = "complete.obs")

cat("Study hours vs GPA    r =", round(cor_study_gpa,   2), "\n")
cat("Sleep    vs Stress    r =", round(cor_sleep_stress, 2), "\n")

# Figure 1: Study hours vs GPA
p1 <- ggplot(student_data, aes(x = hours_studied_per_week, y = gpa)) +
  geom_point(alpha = 0.4, color = "#2E86AB", size = 1.5) +
  geom_smooth(method = "lm", color = "#A23B72", se = TRUE, alpha = 0.2) +
  labs(x = "Hours Studied per Week", y = "GPA (0-10)") +
  theme_minimal(base_size = 11)

ggsave("figures/fig_study_gpa.png", p1, width = 6, height = 4, dpi = 300)

# Figure 2: Sleep quality vs stress
p2 <- ggplot(student_data,
             aes(x = sleep_category, y = stress_level, fill = sleep_category)) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_fill_manual(
    values = c("Poor" = "#d73027", "Fair" = "#fee090", "Good" = "#1a9850")
  ) +
  labs(x = "Sleep Quality", y = "Stress Level (1-10)") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank())

ggsave("figures/fig_sleep_stress.png", p2, width = 6, height = 4, dpi = 300)

# Figure 3: Counseling access vs mean anxiety
counseling_data <- student_data |>
  group_by(counseling_access) |>
  summarise(
    mean_anxiety = mean(anxiety_score, na.rm = TRUE),
    se           = sd(anxiety_score, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  ) |>
  mutate(ci_low  = mean_anxiety - 1.96 * se,
         ci_high = mean_anxiety + 1.96 * se)

p3 <- ggplot(counseling_data,
             aes(x = counseling_access, y = mean_anxiety, fill = counseling_access)) +
  geom_col(alpha = 0.8, show.legend = FALSE) +
  geom_errorbar(aes(ymin = ci_low, ymax = ci_high),
                width = 0.2, linewidth = 0.9) +
  scale_fill_manual(values = c("No" = "#d73027", "Yes" = "#1a9850")) +
  labs(x = "Counseling Access", y = "Mean Anxiety Score (1-10)") +
  theme_minimal(base_size = 11)

ggsave("figures/fig_counseling_anxiety.png", p3, width = 5, height = 4, dpi = 300)

cat("All 3 figures saved to figures/\n")
