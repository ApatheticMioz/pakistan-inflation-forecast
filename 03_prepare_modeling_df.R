# 03_prepare_modeling_df.R
# Pakistan Inflation Forecasting Project: Prepare Modeling Dataframe & EDA
# This script loads the merged dataframe, handles missing data, generates summary statistics, and performs EDA visualizations.
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
library(dplyr)
library(ggplot2)
library(GGally)
library(readr)
library(tidyr)
library(zoo)

# --- Load merged dataframe ---
merged_df <- readRDS("merged_df.rds")

# --- Step 1: Handle missing data ---
# For demo: drop rows with any NA (can be changed to imputation later)
model_df <- merged_df %>% drop_na()

# Report dropped rows
missing_rows <- nrow(merged_df) - nrow(model_df)
cat("Rows dropped due to missing data:", missing_rows, "\n")

# --- Step 2: Summary statistics ---
sum_stats <- summary(model_df)
write.table(sum_stats, file = "model_df_summary.txt", sep = "\t")

# --- Step 3: EDA Visualizations ---
# Boxplots for each variable (excluding date)
boxplot_dir <- "Plots/boxplots"
dir.create(boxplot_dir, showWarnings = FALSE, recursive = TRUE)
for (col in names(model_df)[-1]) {
  p <- ggplot(model_df, aes_string(y = col)) +
    geom_boxplot(fill = "skyblue") +
    ggtitle(paste("Boxplot of", col)) +
    theme_minimal()
  ggsave(filename = file.path(boxplot_dir, paste0("boxplot_", col, ".png")), plot = p)
}

# Scatterplot matrix (excluding date)
png("Plots/scatterplot_matrix.png", width = 1200, height = 1200)
ggpairs(model_df[, -1])
dev.off()

# --- Save cleaned modeling dataframe ---
write_csv(model_df, "Processed_Data/model_df.csv")

# --- End of script ---
# Next: Modeling (ARIMA, ARIMAX, penalized regression)
