# 02b_advanced_missing_value_handling.R
# Pakistan Inflation Forecasting Project: Advanced Missing Value Handling
# This script implements advanced techniques for handling missing values in time series data
#
# Purpose:
# 1. Implement multiple imputation using mice
# 2. Implement Kalman smoothing for time series imputation
# 3. Implement seasonal decomposition-based imputation
# 4. Compare different imputation methods
#
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(lubridate)
  library(zoo)
  library(mice)
  library(imputeTS)
  library(forecast)
  library(ggplot2)
  library(gridExtra)
  library(stringr)
})

# --- Create output directories ---
dir.create("Processed_Data/imputation", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/imputation", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/02b_advanced_missing_value_handling.txt"
sink(log_file)
cat("===== ADVANCED MISSING VALUE HANDLING =====\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Load merged dataframe with missing values ---
cat("Loading merged dataframe with missing values...\n")
if (file.exists("Processed_Data/merged_df_with_missing.csv")) {
  merged_df <- read_csv("Processed_Data/merged_df_with_missing.csv", show_col_types = FALSE)
  cat("Loaded dataframe with", nrow(merged_df), "rows and", ncol(merged_df), "columns\n")
  cat("Date range:", format(min(merged_df$date), "%Y-%m-%d"), "to",
      format(max(merged_df$date), "%Y-%m-%d"), "\n\n")
} else {
  cat("ERROR: Could not find merged_df_with_missing.csv\n")
  cat("Please run 02_merge_datasets.R first to create this file\n\n")
  stop("File not found: Processed_Data/merged_df_with_missing.csv")
}

# --- Analyze missing data patterns ---
cat("===== ANALYZING MISSING DATA PATTERNS =====\n\n")

# Calculate missingness by column
missingness <- colSums(is.na(merged_df)) / nrow(merged_df) * 100
missingness_df <- data.frame(
  Variable = names(missingness),
  Missing_Percent = missingness
)
missingness_df <- missingness_df[order(-missingness_df$Missing_Percent), ]

# Print summary of missingness
cat("Top 20 variables with highest missingness:\n")
print(head(missingness_df, 20))
cat("\n")

# Identify variables with different levels of missingness
high_missingness <- names(missingness[missingness > 30])
moderate_missingness <- names(missingness[missingness > 10 & missingness <= 30])
low_missingness <- names(missingness[missingness > 0 & missingness <= 10])

cat("Variables with high missingness (>30%):", length(high_missingness), "\n")
cat("Variables with moderate missingness (10-30%):", length(moderate_missingness), "\n")
cat("Variables with low missingness (0-10%):", length(low_missingness), "\n\n")

# --- Select key variables for imputation comparison ---
cat("Selecting key variables for imputation comparison...\n")

# Ensure CPI is included if available
key_vars <- c("cpi")

# Add some variables with different levels of missingness
if (length(moderate_missingness) > 0) {
  key_vars <- c(key_vars, head(moderate_missingness, 2))
}
if (length(low_missingness) > 0) {
  key_vars <- c(key_vars, head(low_missingness, 2))
}

# Add important economic indicators if available
potential_indicators <- c("exchange_rate", "policy_rate", "oil_price",
                         "global_food_index", "industrial_production")
for (var in potential_indicators) {
  if (var %in% names(merged_df)) {
    key_vars <- c(key_vars, var)
  }
}

# Remove duplicates and ensure all variables exist in the dataframe
key_vars <- unique(key_vars)
key_vars <- key_vars[key_vars %in% names(merged_df)]

cat("Selected", length(key_vars), "key variables for imputation comparison:\n")
cat(paste(key_vars, collapse = ", "), "\n\n")

# Create a subset with only key variables and date
imputation_df <- merged_df %>%
  select(date, all_of(key_vars))

# --- Method 1: Last Observation Carried Forward (LOCF) ---
cat("===== METHOD 1: LAST OBSERVATION CARRIED FORWARD (LOCF) =====\n\n")

# Apply LOCF imputation
locf_df <- imputation_df %>%
  arrange(date)

# Apply na.locf from zoo package for each column
for (col in setdiff(names(locf_df), "date")) {
  locf_df[[col]] <- zoo::na.locf(locf_df[[col]], na.rm = FALSE)
}

# Apply NOCB for any remaining missing values at the beginning
for (col in setdiff(names(locf_df), "date")) {
  locf_df[[col]] <- zoo::na.locf(locf_df[[col]], fromLast = TRUE, na.rm = FALSE)
}

# Calculate imputation statistics
missing_before <- colSums(is.na(imputation_df))
missing_after_locf <- colSums(is.na(locf_df))
imputed_locf <- missing_before - missing_after_locf

cat("LOCF imputation statistics:\n")
for (var in key_vars) {
  if (missing_before[var] > 0) {
    cat(sprintf("%-25s: %4d of %4d missing values imputed (%.1f%%)\n",
                var, imputed_locf[var], missing_before[var],
                imputed_locf[var] / missing_before[var] * 100))
  }
}
cat("\n")

# --- Method 2: Multiple Imputation using mice ---
cat("===== METHOD 2: MULTIPLE IMPUTATION USING MICE =====\n\n")

# Set seed for reproducibility
set.seed(123)

# Configure mice parameters
mice_method <- rep("pmm", length(key_vars))  # Predictive mean matching
names(mice_method) <- key_vars

# Run mice with 5 imputations
cat("Running multiple imputation with 5 iterations...\n")
mice_imp <- tryCatch({
  mice(imputation_df[, key_vars], m = 5, method = mice_method,
       maxit = 5, printFlag = FALSE)
}, error = function(e) {
  cat("Error in mice imputation:", e$message, "\n")
  cat("Falling back to simpler imputation method\n")
  NULL
})

# Extract the first completed dataset
if (!is.null(mice_imp)) {
  mice_df <- complete(mice_imp, 1)
  mice_df <- cbind(date = imputation_df$date, mice_df)

  # Calculate imputation statistics
  missing_after_mice <- colSums(is.na(mice_df))
  imputed_mice <- missing_before - missing_after_mice

  cat("MICE imputation statistics:\n")
  for (var in key_vars) {
    if (missing_before[var] > 0) {
      cat(sprintf("%-25s: %4d of %4d missing values imputed (%.1f%%)\n",
                  var, imputed_mice[var], missing_before[var],
                  imputed_mice[var] / missing_before[var] * 100))
    }
  }
} else {
  cat("MICE imputation failed, skipping statistics\n")
  # Create an empty dataframe with the same structure
  mice_df <- imputation_df
}
cat("\n")

# --- Method 3: Kalman Smoothing ---
cat("===== METHOD 3: KALMAN SMOOTHING =====\n\n")

# Apply Kalman smoothing to each variable
kalman_df <- imputation_df
for (var in key_vars) {
  if (sum(is.na(imputation_df[[var]])) > 0) {
    tryCatch({
      # Convert to time series
      ts_data <- ts(imputation_df[[var]], frequency = 12)

      # Apply Kalman smoothing
      kalman_result <- na_kalman(ts_data)

      # Replace values in dataframe
      kalman_df[[var]] <- as.numeric(kalman_result)

      cat(sprintf("Applied Kalman smoothing to %s\n", var))
    }, error = function(e) {
      cat(sprintf("Error applying Kalman smoothing to %s: %s\n", var, e$message))
    })
  }
}

# Calculate imputation statistics
missing_after_kalman <- colSums(is.na(kalman_df))
imputed_kalman <- missing_before - missing_after_kalman

cat("Kalman smoothing imputation statistics:\n")
for (var in key_vars) {
  if (missing_before[var] > 0) {
    cat(sprintf("%-25s: %4d of %4d missing values imputed (%.1f%%)\n",
                var, imputed_kalman[var], missing_before[var],
                imputed_kalman[var] / missing_before[var] * 100))
  }
}
cat("\n")

# --- Method 4: Seasonal Decomposition-Based Imputation ---
cat("===== METHOD 4: SEASONAL DECOMPOSITION-BASED IMPUTATION =====\n\n")

# Apply seasonal decomposition-based imputation to each variable
seadec_df <- imputation_df
for (var in key_vars) {
  if (sum(is.na(imputation_df[[var]])) > 0 && sum(!is.na(imputation_df[[var]])) >= 24) {
    tryCatch({
      # Convert to time series
      ts_data <- ts(imputation_df[[var]], frequency = 12)

      # Apply seasonal decomposition imputation
      seadec_result <- na_seadec(ts_data, algorithm = "interpolation")

      # Replace values in dataframe
      seadec_df[[var]] <- as.numeric(seadec_result)

      cat(sprintf("Applied seasonal decomposition imputation to %s\n", var))
    }, error = function(e) {
      cat(sprintf("Error applying seasonal decomposition to %s: %s\n", var, e$message))
    })
  } else if (sum(!is.na(imputation_df[[var]])) < 24) {
    cat(sprintf("Not enough non-NA values in %s for seasonal decomposition (need at least 24)\n", var))
  }
}

# Calculate imputation statistics
missing_after_seadec <- colSums(is.na(seadec_df))
imputed_seadec <- missing_before - missing_after_seadec

cat("Seasonal decomposition imputation statistics:\n")
for (var in key_vars) {
  if (missing_before[var] > 0) {
    cat(sprintf("%-25s: %4d of %4d missing values imputed (%.1f%%)\n",
                var, imputed_seadec[var], missing_before[var],
                imputed_seadec[var] / missing_before[var] * 100))
  }
}
cat("\n")

# --- Compare Imputation Methods ---
cat("===== COMPARING IMPUTATION METHODS =====\n\n")

# Create comparison plots for each variable
for (var in key_vars) {
  if (missing_before[var] > 0) {
    cat(sprintf("Creating comparison plot for %s...\n", var))

    # Ensure all columns are of the same type (numeric)
    original_values <- as.numeric(imputation_df[[var]])
    locf_values <- as.numeric(locf_df[[var]])
    mice_values <- as.numeric(mice_df[[var]])
    kalman_values <- as.numeric(kalman_df[[var]])
    seadec_values <- as.numeric(seadec_df[[var]])

    # Create a dataframe for plotting
    plot_df <- data.frame(
      date = imputation_df$date,
      original = original_values,
      locf = locf_values,
      mice = mice_values,
      kalman = kalman_values,
      seadec = seadec_values
    )

    # Convert to long format for plotting
    plot_df_long <- tidyr::pivot_longer(plot_df, cols = -date, names_to = "method", values_to = "value")

    # Create plot
    p <- ggplot(plot_df_long, aes(x = date, y = value, color = method)) +
      geom_line() +
      labs(title = paste("Comparison of Imputation Methods for", var),
           subtitle = paste(missing_before[var], "missing values out of", nrow(imputation_df)),
           x = "Date", y = var) +
      theme_minimal() +
      theme(legend.position = "bottom")

    # Save plot
    ggsave(file.path("Plots/imputation", paste0("imputation_comparison_", var, ".png")),
           p, width = 10, height = 6)

    # Create a zoomed-in plot focusing on periods with missing data
    # Find periods with missing data
    na_indices <- which(is.na(imputation_df[[var]]))
    if (length(na_indices) > 0) {
      # Get a window around the first missing value period
      start_idx <- max(1, min(na_indices) - 5)
      end_idx <- min(nrow(imputation_df), max(na_indices) + 5)

      # Create zoomed plot
      p_zoom <- ggplot(plot_df_long[plot_df_long$date >= imputation_df$date[start_idx] &
                                    plot_df_long$date <= imputation_df$date[end_idx], ],
                       aes(x = date, y = value, color = method)) +
        geom_line() +
        geom_point() +
        labs(title = paste("Zoomed Comparison of Imputation Methods for", var),
             subtitle = paste("Focusing on period with missing values"),
             x = "Date", y = var) +
        theme_minimal() +
        theme(legend.position = "bottom")

      # Save zoomed plot
      ggsave(file.path("Plots/imputation", paste0("imputation_comparison_zoom_", var, ".png")),
             p_zoom, width = 10, height = 6)
    }
  }
}

# --- Save Imputed Datasets ---
cat("\n===== SAVING IMPUTED DATASETS =====\n\n")

# Save each imputed dataset
write_csv(locf_df, "Processed_Data/imputation/locf_imputed.csv")
cat("Saved LOCF imputed dataset to Processed_Data/imputation/locf_imputed.csv\n")

if (!is.null(mice_imp)) {
  write_csv(mice_df, "Processed_Data/imputation/mice_imputed.csv")
  cat("Saved MICE imputed dataset to Processed_Data/imputation/mice_imputed.csv\n")

  # Save all 5 mice imputations for sensitivity analysis
  for (i in 1:5) {
    complete_i <- complete(mice_imp, i)
    complete_i <- cbind(date = imputation_df$date, complete_i)
    write_csv(complete_i, paste0("Processed_Data/imputation/mice_imputed_", i, ".csv"))
  }
  cat("Saved all 5 MICE imputations to Processed_Data/imputation/mice_imputed_*.csv\n")
}

write_csv(kalman_df, "Processed_Data/imputation/kalman_imputed.csv")
cat("Saved Kalman imputed dataset to Processed_Data/imputation/kalman_imputed.csv\n")

write_csv(seadec_df, "Processed_Data/imputation/seadec_imputed.csv")
cat("Saved seasonal decomposition imputed dataset to Processed_Data/imputation/seadec_imputed.csv\n")

# --- Create Combined Imputed Dataset ---
cat("\n===== CREATING COMBINED IMPUTED DATASET =====\n\n")

# For each variable, select the best imputation method based on characteristics
combined_df <- imputation_df
for (var in key_vars) {
  if (missing_before[var] > 0) {
    # Check if the variable has seasonal patterns
    has_seasonality <- FALSE
    if (sum(!is.na(imputation_df[[var]])) >= 24) {
      ts_data <- ts(imputation_df[[var]], frequency = 12)
      decomp <- tryCatch({
        decompose(na.interpolation(ts_data))
      }, error = function(e) {
        NULL
      })

      if (!is.null(decomp)) {
        seasonal_strength <- max(decomp$seasonal, na.rm = TRUE) - min(decomp$seasonal, na.rm = TRUE)
        has_seasonality <- seasonal_strength > 0.5
      }
    }

    # Choose imputation method based on characteristics
    if (has_seasonality) {
      cat(sprintf("%s has seasonal patterns, using seasonal decomposition imputation\n", var))
      combined_df[[var]] <- seadec_df[[var]]
    } else if (sum(!is.na(imputation_df[[var]])) >= 10) {
      cat(sprintf("%s has sufficient data, using Kalman smoothing\n", var))
      combined_df[[var]] <- kalman_df[[var]]
    } else {
      cat(sprintf("%s has limited data, using LOCF/NOCB\n", var))
      combined_df[[var]] <- locf_df[[var]]
    }
  }
}

# Save combined imputed dataset
write_csv(combined_df, "Processed_Data/imputation/combined_imputed.csv")
cat("Saved combined imputed dataset to Processed_Data/imputation/combined_imputed.csv\n")

# Also save as RDS for use in subsequent scripts
saveRDS(combined_df, "Processed_Data/imputation/combined_imputed.rds")
cat("Saved combined imputed dataset as RDS to Processed_Data/imputation/combined_imputed.rds\n\n")

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Advanced missing value handling completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat("- Processed_Data/imputation/locf_imputed.csv\n")
if (!is.null(mice_imp)) {
  cat("- Processed_Data/imputation/mice_imputed.csv\n")
  cat("- Processed_Data/imputation/mice_imputed_*.csv (5 files)\n")
}
cat("- Processed_Data/imputation/kalman_imputed.csv\n")
cat("- Processed_Data/imputation/seadec_imputed.csv\n")
cat("- Processed_Data/imputation/combined_imputed.csv\n")
cat("- Processed_Data/imputation/combined_imputed.rds\n")
cat("\nPlots created:\n")
for (var in key_vars) {
  if (missing_before[var] > 0) {
    cat(sprintf("- Plots/imputation/imputation_comparison_%s.png\n", var))
    cat(sprintf("- Plots/imputation/imputation_comparison_zoom_%s.png\n", var))
  }
}

cat("\nNext steps:\n")
cat("1. Use the combined imputed dataset in subsequent modeling scripts\n")
cat("2. Consider sensitivity analysis using different imputation methods\n\n")

# Close the log file
sink()

# Print message to console
message("Advanced missing value handling completed!")
message("Log saved to ", log_file)
message("Proceed to use the imputed datasets in subsequent modeling scripts")
