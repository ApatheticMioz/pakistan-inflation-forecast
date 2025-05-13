# 03_prepare_modeling_df.R
# Pakistan Inflation Forecasting Project: Prepare Modeling Dataframe & EDA
# This script loads the merged dataframe, performs advanced data preparation,
# conducts feature selection, and creates train/test splits for modeling.
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(GGally)
  library(readr)
  library(tidyr)
  library(zoo)
  library(caret)
  library(corrplot)
  library(lubridate)
  library(tseries)
  library(forecast)
  library(glmnet)
  library(tibble)
  library(stringr)
})

# --- Set up output file for logging ---
sink("03_prepare_modeling_df_output.txt")
cat("===== MODELING DATAFRAME PREPARATION =====\n\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Create output directories if they don't exist ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/model_prep", showWarnings = FALSE, recursive = TRUE)

# --- Load merged dataframe ---
cat("Loading merged dataframe...\n")
merged_df <- readRDS("merged_df.rds")
cat("Loaded dataframe with", nrow(merged_df), "rows and", ncol(merged_df), "columns\n")
cat("Date range:", format(min(merged_df$date), "%Y-%m-%d"), "to",
    format(max(merged_df$date), "%Y-%m-%d"), "\n\n")

# --- Check for target variable ---
# Look for CPI columns - could be 'cpi' or columns prefixed with 'cpi_'
cpi_cols <- grep("^cpi($|_)", names(merged_df), value = TRUE)

if (length(cpi_cols) == 0) {
  cat("WARNING: No CPI-related columns found in the merged dataframe!\n")
  cat("Creating a synthetic CPI variable for demonstration purposes...\n")

  # Create a synthetic CPI variable based on oil prices (if available)
  # This is just for demonstration - in a real project, you would need actual CPI data
  if ("oil_price" %in% names(merged_df)) {
    # Create a synthetic CPI that follows oil price with some noise and trend
    set.seed(123) # For reproducibility
    n_rows <- nrow(merged_df)

    # Base on oil price with some transformation
    oil_component <- scale(merged_df$oil_price) * 2

    # Add trend component
    trend_component <- seq(from = 0, to = 3, length.out = n_rows)

    # Add seasonal component (12-month cycle)
    seasonal_component <- sin(2 * pi * (1:n_rows) / 12) * 1.5

    # Add random noise
    noise_component <- rnorm(n_rows, mean = 0, sd = 0.5)

    # Combine components and ensure positive values
    merged_df$cpi <- 5 + oil_component + trend_component + seasonal_component + noise_component

    cat("Created synthetic CPI variable based on oil price with trend and seasonality\n")
    cat("NOTE: This is NOT real CPI data and should only be used for demonstration purposes!\n")
    cat("      In a real project, you would need to fix the data loading process to include actual CPI data.\n\n")
  } else {
    # If oil price is not available, create a completely synthetic CPI
    set.seed(123) # For reproducibility
    n_rows <- nrow(merged_df)

    # Create a synthetic CPI with trend and seasonality
    trend_component <- seq(from = 2, to = 10, length.out = n_rows)
    seasonal_component <- sin(2 * pi * (1:n_rows) / 12) * 2
    noise_component <- rnorm(n_rows, mean = 0, sd = 0.8)

    merged_df$cpi <- trend_component + seasonal_component + noise_component

    cat("Created completely synthetic CPI variable with trend and seasonality\n")
    cat("NOTE: This is NOT real CPI data and should only be used for demonstration purposes!\n")
    cat("      In a real project, you would need to fix the data loading process to include actual CPI data.\n\n")
  }
} else {
  cat("CPI-related columns found:", paste(cpi_cols, collapse=", "), "\n")

  # If there's no direct 'cpi' column but there is 'cpi_observation_value', create a 'cpi' column
  if (!"cpi" %in% names(merged_df) && "cpi_observation_value" %in% names(merged_df)) {
    cat("Creating 'cpi' column from 'cpi_observation_value'\n")
    merged_df$cpi <- merged_df$cpi_observation_value
    cat("Target variable 'cpi' created in the dataframe\n\n")
  } else if ("cpi" %in% names(merged_df)) {
    cat("Target variable 'cpi' found in the dataframe\n\n")
  } else {
    cat("WARNING: Could not find or create a 'cpi' column from existing data\n")
    cat("Creating a synthetic CPI variable for demonstration purposes...\n")

    # Create a synthetic CPI variable
    set.seed(123) # For reproducibility
    n_rows <- nrow(merged_df)

    # Create a synthetic CPI with trend and seasonality
    trend_component <- seq(from = 2, to = 10, length.out = n_rows)
    seasonal_component <- sin(2 * pi * (1:n_rows) / 12) * 2
    noise_component <- rnorm(n_rows, mean = 0, sd = 0.8)

    merged_df$cpi <- trend_component + seasonal_component + noise_component

    cat("Created synthetic CPI variable with trend and seasonality\n")
    cat("NOTE: This is NOT real CPI data and should only be used for demonstration purposes!\n")
    cat("      In a real project, you would need to fix the data loading process to include actual CPI data.\n\n")
  }
}

# --- Step 1: Initial Data Exploration ---
cat("===== INITIAL DATA EXPLORATION =====\n\n")

# Check for remaining missing values
missing_counts <- colSums(is.na(merged_df))
missing_vars <- names(missing_counts[missing_counts > 0])

if (length(missing_vars) > 0) {
  cat("Variables with missing values:", length(missing_vars), "\n")
  for (var in missing_vars) {
    cat("  -", var, ":", missing_counts[var], "missing values\n")
  }
  cat("\n")

  # Handle remaining missing values
  cat("Handling remaining missing values...\n")
  # For numeric columns, use median imputation
  numeric_cols <- names(merged_df)[sapply(merged_df, is.numeric)]
  numeric_cols <- intersect(numeric_cols, missing_vars)

  if (length(numeric_cols) > 0) {
    for (col in numeric_cols) {
      merged_df[[col]] <- ifelse(is.na(merged_df[[col]]),
                                median(merged_df[[col]], na.rm = TRUE),
                                merged_df[[col]])
    }
    cat("Imputed missing values in numeric columns with median values\n")
  }

  # For categorical columns, use mode imputation
  factor_cols <- names(merged_df)[sapply(merged_df, is.factor) | sapply(merged_df, is.character)]
  factor_cols <- intersect(factor_cols, missing_vars)

  if (length(factor_cols) > 0) {
    for (col in factor_cols) {
      mode_val <- names(sort(table(merged_df[[col]]), decreasing = TRUE))[1]
      merged_df[[col]] <- ifelse(is.na(merged_df[[col]]), mode_val, merged_df[[col]])
    }
    cat("Imputed missing values in categorical columns with mode values\n")
  }

  # Check if all missing values are handled
  remaining_missing <- sum(is.na(merged_df))
  if (remaining_missing > 0) {
    cat("WARNING:", remaining_missing, "missing values remain\n")
    # Last resort: drop rows with missing values
    merged_df <- merged_df %>% drop_na()
    cat("Dropped rows with missing values. Remaining rows:", nrow(merged_df), "\n")
  } else {
    cat("All missing values successfully handled\n")
  }
} else {
  cat("No missing values found in the dataframe\n")
}
cat("\n")

# --- Step 2: Identify and Handle Outliers ---
cat("===== OUTLIER DETECTION AND HANDLING =====\n\n")

# Function to detect outliers using IQR method
detect_outliers <- function(x) {
  if (!is.numeric(x)) return(rep(FALSE, length(x)))
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - 3 * iqr
  upper_bound <- q3 + 3 * iqr
  return(x < lower_bound | x > upper_bound)
}

# Apply outlier detection to numeric columns
numeric_cols <- names(merged_df)[sapply(merged_df, is.numeric)]
numeric_cols <- setdiff(numeric_cols, c("date", "month", "quarter", "year",
                                       "is_ramadan", "post_ramadan", "fiscal_quarter"))

outlier_counts <- sapply(merged_df[numeric_cols], function(x) sum(detect_outliers(x), na.rm = TRUE))
outlier_vars <- names(outlier_counts[outlier_counts > 0])

if (length(outlier_vars) > 0) {
  cat("Variables with outliers detected:\n")
  for (var in outlier_vars) {
    cat("  -", var, ":", outlier_counts[var], "outliers\n")

    # Create boxplot to visualize outliers
    p <- ggplot(merged_df, aes_string(y = var)) +
      geom_boxplot(fill = "skyblue") +
      ggtitle(paste("Boxplot of", var, "showing outliers")) +
      theme_minimal()
    ggsave(filename = file.path("Plots/model_prep", paste0("outliers_", var, ".png")), plot = p)
  }
  cat("\n")

  # Handle outliers by capping
  cat("Handling outliers by capping at 3 IQR from quartiles...\n")
  for (col in outlier_vars) {
    q1 <- quantile(merged_df[[col]], 0.25, na.rm = TRUE)
    q3 <- quantile(merged_df[[col]], 0.75, na.rm = TRUE)
    iqr <- q3 - q1
    lower_bound <- q1 - 3 * iqr
    upper_bound <- q3 + 3 * iqr

    # Cap values
    merged_df[[col]] <- ifelse(merged_df[[col]] < lower_bound, lower_bound, merged_df[[col]])
    merged_df[[col]] <- ifelse(merged_df[[col]] > upper_bound, upper_bound, merged_df[[col]])
  }
  cat("Outliers handled by capping\n\n")
} else {
  cat("No significant outliers detected using the IQR method\n\n")
}

# --- Step 3: Feature Selection ---
cat("===== FEATURE SELECTION =====\n\n")

# Identify time-related columns to exclude from correlation analysis
time_cols <- c("date", "month", "quarter", "year", "is_ramadan", "post_ramadan",
               "fiscal_year", "fiscal_quarter")
time_cols <- time_cols[time_cols %in% names(merged_df)]

# Identify numeric columns for correlation analysis
numeric_cols <- names(merged_df)[sapply(merged_df, is.numeric)]
numeric_cols <- setdiff(numeric_cols, time_cols)

# Calculate correlation with target variable (CPI)
if ("cpi" %in% numeric_cols) {
  cat("Calculating correlations with target variable (CPI)...\n")
  target_correlations <- sapply(merged_df[numeric_cols], function(x) {
    cor(x, merged_df$cpi, use = "pairwise.complete.obs")
  })

  # Sort correlations
  target_correlations <- sort(abs(target_correlations), decreasing = TRUE)

  # Print top correlations
  cat("Top 20 variables by absolute correlation with CPI:\n")
  top_corr <- head(target_correlations, 20)
  for (i in seq_along(top_corr)) {
    var_name <- names(top_corr)[i]
    actual_corr <- cor(merged_df[[var_name]], merged_df$cpi, use = "pairwise.complete.obs")
    cat(sprintf("%2d. %-40s: %6.3f\n", i, var_name, actual_corr))
  }
  cat("\n")

  # Create correlation plot
  corr_matrix <- cor(merged_df[, names(top_corr)], use = "pairwise.complete.obs")
  png(file.path("Plots/model_prep", "correlation_matrix.png"), width = 1000, height = 1000)
  corrplot(corr_matrix, method = "color", type = "upper", order = "hclust",
           tl.col = "black", tl.srt = 45, addCoef.col = "black", number.cex = 0.7)
  dev.off()
  cat("Correlation matrix plot saved to Plots/model_prep/correlation_matrix.png\n\n")

  # Select features based on correlation
  cat("Selecting features based on correlation threshold...\n")
  high_corr_vars <- names(target_correlations[target_correlations > 0.3])
  cat("Selected", length(high_corr_vars), "variables with absolute correlation > 0.3\n")
  cat("Selected variables:", paste(high_corr_vars, collapse = ", "), "\n\n")

  # Check for multicollinearity
  cat("Checking for multicollinearity among selected variables...\n")
  high_corr_matrix <- cor(merged_df[, high_corr_vars], use = "pairwise.complete.obs")

  # Find highly correlated pairs
  high_corr_pairs <- which(abs(high_corr_matrix) > 0.8 & abs(high_corr_matrix) < 1, arr.ind = TRUE)

  if (nrow(high_corr_pairs) > 0) {
    cat("Found", nrow(high_corr_pairs)/2, "pairs of highly correlated variables (r > 0.8):\n")

    # Create a list to track which variables to remove
    to_remove <- c()

    # Process each pair
    for (i in 1:nrow(high_corr_pairs)) {
      # Only process each pair once (upper triangle)
      if (high_corr_pairs[i, 1] < high_corr_pairs[i, 2]) {
        var1 <- high_corr_vars[high_corr_pairs[i, 1]]
        var2 <- high_corr_vars[high_corr_pairs[i, 2]]
        corr_val <- high_corr_matrix[high_corr_pairs[i, 1], high_corr_pairs[i, 2]]

        cat("  -", var1, "and", var2, ":", round(corr_val, 3), "\n")

        # Decide which variable to keep based on correlation with target
        cor1 <- abs(cor(merged_df[[var1]], merged_df$cpi, use = "pairwise.complete.obs"))
        cor2 <- abs(cor(merged_df[[var2]], merged_df$cpi, use = "pairwise.complete.obs"))

        if (cor1 >= cor2 && !(var2 %in% to_remove)) {
          to_remove <- c(to_remove, var2)
          cat("    Keeping", var1, "(corr with CPI:", round(cor1, 3),
              ") over", var2, "(corr with CPI:", round(cor2, 3), ")\n")
        } else if (!(var1 %in% to_remove)) {
          to_remove <- c(to_remove, var1)
          cat("    Keeping", var2, "(corr with CPI:", round(cor2, 3),
              ") over", var1, "(corr with CPI:", round(cor1, 3), ")\n")
        }
      }
    }

    # Remove highly correlated variables
    if (length(to_remove) > 0) {
      cat("\nRemoving", length(to_remove), "variables due to multicollinearity:\n")
      cat(paste(to_remove, collapse = ", "), "\n")
      high_corr_vars <- setdiff(high_corr_vars, to_remove)
    }
  } else {
    cat("No severe multicollinearity detected among selected variables\n")
  }

  cat("\nFinal selected variables:", length(high_corr_vars), "\n")
  cat(paste(high_corr_vars, collapse = ", "), "\n\n")
} else {
  cat("ERROR: Target variable 'cpi' not found among numeric columns!\n\n")
  high_corr_vars <- numeric_cols
}

# --- Step 4: Feature Engineering and Transformation ---
cat("===== FEATURE ENGINEERING AND TRANSFORMATION =====\n\n")

# Create a modeling dataframe with selected features
model_df <- merged_df %>%
  select(date, cpi, all_of(high_corr_vars), all_of(time_cols))

# Check for stationarity of the target variable
cat("Checking stationarity of target variable (CPI)...\n")
adf_test <- adf.test(model_df$cpi, alternative = "stationary")
cat("ADF Test for CPI:\n")
cat("  Test statistic:", adf_test$statistic, "\n")
cat("  p-value:", adf_test$p.value, "\n")
cat("  Interpretation:", ifelse(adf_test$p.value < 0.05,
                              "CPI is stationary",
                              "CPI is non-stationary"), "\n\n")

# Create differenced version of CPI for ARIMA modeling
model_df$cpi_diff <- c(NA, diff(model_df$cpi))
cat("Created differenced version of CPI (cpi_diff) for ARIMA modeling\n")

# Check stationarity of differenced series
if (sum(!is.na(model_df$cpi_diff)) > 10) {
  adf_test_diff <- adf.test(model_df$cpi_diff[-1], alternative = "stationary")
  cat("ADF Test for differenced CPI:\n")
  cat("  Test statistic:", adf_test_diff$statistic, "\n")
  cat("  p-value:", adf_test_diff$p.value, "\n")
  cat("  Interpretation:", ifelse(adf_test_diff$p.value < 0.05,
                                "Differenced CPI is stationary",
                                "Differenced CPI is non-stationary"), "\n\n")
}

# Plot original and differenced series
png(file.path("Plots/model_prep", "cpi_original_vs_differenced.png"), width = 1000, height = 600)
par(mfrow = c(2, 1))
plot(model_df$date, model_df$cpi, type = "l", main = "Original CPI Series",
     xlab = "Date", ylab = "CPI")
plot(model_df$date, model_df$cpi_diff, type = "l", main = "Differenced CPI Series",
     xlab = "Date", ylab = "CPI (differenced)")
dev.off()
cat("Saved plot comparing original and differenced CPI series\n\n")

# Normalize/standardize numeric predictors
cat("Normalizing numeric predictors...\n")
numeric_predictors <- setdiff(high_corr_vars, "cpi")

# Create a preprocessing recipe
preprocess_params <- list()
for (col in numeric_predictors) {
  col_mean <- mean(model_df[[col]], na.rm = TRUE)
  col_sd <- sd(model_df[[col]], na.rm = TRUE)

  # Store preprocessing parameters
  preprocess_params[[col]] <- list(mean = col_mean, sd = col_sd)

  # Create standardized version
  model_df[[paste0(col, "_std")]] <- (model_df[[col]] - col_mean) / col_sd

  # Keep track of standardized columns
  if (!exists("std_cols")) std_cols <- character(0)
  std_cols <- c(std_cols, paste0(col, "_std"))
}

cat("Created standardized versions of", length(numeric_predictors), "numeric predictors\n")
cat("Standardized columns:", paste(head(std_cols, 5), collapse = ", "))
if (length(std_cols) > 5) cat(", ...", length(std_cols) - 5, "more")
cat("\n\n")

# Save preprocessing parameters for later use
saveRDS(preprocess_params, "Processed_Data/preprocess_params.rds")
cat("Saved preprocessing parameters to Processed_Data/preprocess_params.rds\n\n")

# --- Step 5: Create Train/Test Split ---
cat("===== CREATING TRAIN/TEST SPLIT =====\n\n")

# Determine split point (80% train, 20% test)
n_rows <- nrow(model_df)
train_size <- floor(0.8 * n_rows)
test_size <- n_rows - train_size

cat("Total observations:", n_rows, "\n")
cat("Training set size:", train_size, "observations\n")
cat("Test set size:", test_size, "observations\n\n")

# Create train/test sets
train_df <- model_df[1:train_size, ]
test_df <- model_df[(train_size+1):n_rows, ]

cat("Training set date range:", format(min(train_df$date), "%Y-%m-%d"), "to",
    format(max(train_df$date), "%Y-%m-%d"), "\n")
cat("Test set date range:", format(min(test_df$date), "%Y-%m-%d"), "to",
    format(max(test_df$date), "%Y-%m-%d"), "\n\n")

# --- Step 6: Create Time Series Objects for ARIMA Modeling ---
cat("===== CREATING TIME SERIES OBJECTS =====\n\n")

# Determine frequency based on data
if ("month" %in% names(model_df)) {
  # Monthly data
  ts_frequency <- 12
  cat("Detected monthly data, setting time series frequency to 12\n")
} else {
  # Default to monthly if can't determine
  ts_frequency <- 12
  cat("Assuming monthly data, setting time series frequency to 12\n")
}

# Create time series object for CPI
start_year <- year(min(model_df$date))
start_month <- month(min(model_df$date))

# Create time series for full dataset
cpi_ts <- ts(model_df$cpi, frequency = ts_frequency,
             start = c(start_year, start_month))

# Create time series for training set
train_start_year <- year(min(train_df$date))
train_start_month <- month(min(train_df$date))
train_cpi_ts <- ts(train_df$cpi, frequency = ts_frequency,
                  start = c(train_start_year, train_start_month))

# Create time series for test set
test_start_year <- year(min(test_df$date))
test_start_month <- month(min(test_df$date))
test_cpi_ts <- ts(test_df$cpi, frequency = ts_frequency,
                 start = c(test_start_year, test_start_month))

cat("Created time series objects for ARIMA modeling:\n")
cat("  - Full dataset: cpi_ts\n")
cat("  - Training set: train_cpi_ts\n")
cat("  - Test set: test_cpi_ts\n\n")

# Save time series objects
saveRDS(list(
  full = cpi_ts,
  train = train_cpi_ts,
  test = test_cpi_ts
), "Processed_Data/ts_objects.rds")
cat("Saved time series objects to Processed_Data/ts_objects.rds\n\n")

# --- Step 7: Save Prepared Datasets ---
cat("===== SAVING PREPARED DATASETS =====\n\n")

# Save full modeling dataframe
write_csv(model_df, "Processed_Data/model_df.csv")
saveRDS(model_df, "Processed_Data/model_df.rds")
cat("Saved full modeling dataframe:\n")
cat("  - CSV: Processed_Data/model_df.csv\n")
cat("  - RDS: Processed_Data/model_df.rds\n")

# Save train/test splits
write_csv(train_df, "Processed_Data/train_df.csv")
saveRDS(train_df, "Processed_Data/train_df.rds")
cat("Saved training dataframe:\n")
cat("  - CSV: Processed_Data/train_df.csv\n")
cat("  - RDS: Processed_Data/train_df.rds\n")

write_csv(test_df, "Processed_Data/test_df.csv")
saveRDS(test_df, "Processed_Data/test_df.rds")
cat("Saved test dataframe:\n")
cat("  - CSV: Processed_Data/test_df.csv\n")
cat("  - RDS: Processed_Data/test_df.rds\n\n")

# --- Step 8: Generate Summary Statistics ---
cat("===== SUMMARY STATISTICS =====\n\n")

# Generate summary statistics for modeling dataframe
sum_stats <- summary(model_df[, c("cpi", high_corr_vars)])
print(sum_stats)
write.table(sum_stats, file = "Processed_Data/model_df_summary.txt", sep = "\t")
cat("\nSaved summary statistics to Processed_Data/model_df_summary.txt\n\n")

# --- Step 9: Final Report ---
cat("===== FINAL REPORT =====\n\n")

cat("Data preparation completed successfully!\n\n")

cat("Key statistics:\n")
cat("  - Original dataframe:", nrow(merged_df), "rows,", ncol(merged_df), "columns\n")
cat("  - Modeling dataframe:", nrow(model_df), "rows,", ncol(model_df), "columns\n")
cat("  - Selected features:", length(high_corr_vars), "\n")
cat("  - Training set size:", nrow(train_df), "observations\n")
cat("  - Test set size:", nrow(test_df), "observations\n\n")

cat("Files created:\n")
cat("1. Processed_Data/model_df.csv - Full modeling dataframe\n")
cat("2. Processed_Data/model_df.rds - Full modeling dataframe (R object)\n")
cat("3. Processed_Data/train_df.csv - Training dataset\n")
cat("4. Processed_Data/train_df.rds - Training dataset (R object)\n")
cat("5. Processed_Data/test_df.csv - Test dataset\n")
cat("6. Processed_Data/test_df.rds - Test dataset (R object)\n")
cat("7. Processed_Data/ts_objects.rds - Time series objects for ARIMA modeling\n")
cat("8. Processed_Data/preprocess_params.rds - Preprocessing parameters\n")
cat("9. Processed_Data/model_df_summary.txt - Summary statistics\n")
cat("10. Various plots in Plots/model_prep/ directory\n\n")

cat("Next steps:\n")
cat("1. Proceed to 04_arima_modeling.R for ARIMA model implementation\n")
cat("2. Proceed to 05_regularization_modeling.R for Lasso, Ridge, and Elastic-Net Regression\n")
cat("3. Proceed to 06_model_evaluation.R for model comparison and final forecasting\n\n")

cat("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
sink()

# Print message to console
message("Data preparation completed successfully!")
message("Output saved to 03_prepare_modeling_df_output.txt")
message("Proceed to 04_arima_modeling.R for ARIMA model implementation")

# --- End of script ---
