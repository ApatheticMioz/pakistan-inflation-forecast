# 02_merge_datasets.R
# Pakistan Inflation Forecasting Project: Merge Datasets
# This script loads the cleaned datasets, merges them based on date,
# creates derived features, and saves merged dataset for modeling.
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(lubridate)
  library(zoo)
  library(purrr)
  library(forecast)
  library(tibble)
})

# --- Load cleaned datasets from 01_load_and_eda.R ---
message("Loading cleaned datasets...")
datasets <- readRDS("cleaned_datasets.rds")

# --- Standardize date format and prepare datasets for merging ---
message("Preparing datasets for merging...")

prepare_dataset <- function(df, name, value_col = "observation_value") {
  if (is.null(df)) {
    message(paste("Skipping NULL dataset:", name))
    return(NULL)
  }
  
  # Ensure date column exists and is of Date type
  if (!"date" %in% names(df)) {
    warning(paste("No date column in", name))
    return(NULL)
  }
  
  if (!inherits(df$date, "Date")) {
    warning(paste("Invalid date format in", name))
    return(NULL)
  }
  
  # For simpler datasets with just date and value, rename for easier merging
  if (value_col %in% names(df) && ncol(df) <= 3) {
    df_prep <- df %>%
      select(date, !!sym(value_col)) %>%
      rename(!!name := !!sym(value_col))
    return(df_prep)
  }
  
  # For datasets with multiple columns, make them all prefixed with dataset name
  df_prep <- df %>%
    rename_with(~paste0(name, "_", .), .cols = -date)
  
  return(df_prep)
}

# --- Prepare each dataset for merging ---
# For each dataset, extract key time series for merging
# We'll prioritize these series as the most relevant for inflation forecasting
prepared_datasets <- list()

# CPI (dependent variable) - our target for prediction
if (!is.null(datasets$cpi)) {
  prepared_datasets$cpi <- prepare_dataset(datasets$cpi, "cpi")
}

# Key macroeconomic variables
if (!is.null(datasets$exchange_rate)) {
  prepared_datasets$exchange_rate <- prepare_dataset(datasets$exchange_rate, "exchange_rate")
}

if (!is.null(datasets$policy_rate)) {
  prepared_datasets$policy_rate <- prepare_dataset(datasets$policy_rate, "policy_rate")
}

if (!is.null(datasets$kibor)) {
  # For KIBOR, we may have multiple tenors - isolate 6-month KIBOR
  if ("series_name" %in% names(datasets$kibor)) {
    kibor_6m <- datasets$kibor %>%
      filter(grepl("6 ?months", series_name, ignore.case = TRUE))
    
    if (nrow(kibor_6m) > 0) {
      prepared_datasets$kibor_6m <- prepare_dataset(kibor_6m, "kibor_6m")
    } else {
      prepared_datasets$kibor <- prepare_dataset(datasets$kibor, "kibor")
    }
  } else {
    prepared_datasets$kibor <- prepare_dataset(datasets$kibor, "kibor")
  }
}

# Oil prices
if (!is.null(datasets$oil_prices) && "mcoilbrenteu" %in% names(datasets$oil_prices)) {
  prepared_datasets$oil_prices <- datasets$oil_prices %>%
    select(date, mcoilbrenteu) %>%
    rename(oil_price = mcoilbrenteu)
}

# Global food index
if (!is.null(datasets$global_food)) {
  # Extract the food price index if multiple columns exist
  food_index_cols <- grep("food.*index|index.*food", 
                        names(datasets$global_food), 
                        ignore.case = TRUE)
  
  if (length(food_index_cols) > 0) {
    food_col <- names(datasets$global_food)[food_index_cols[1]]
    prepared_datasets$global_food <- datasets$global_food %>%
      select(date, !!sym(food_col)) %>%
      rename(global_food_index = !!sym(food_col))
  } else if ("value" %in% names(datasets$global_food)) {
    # If there's just a generic 'value' column
    prepared_datasets$global_food <- datasets$global_food %>%
      select(date, value) %>%
      rename(global_food_index = value)
  } else {
    # Take the first numeric column if nothing else worked
    num_cols <- names(datasets$global_food)[sapply(datasets$global_food, is.numeric)]
    if (length(num_cols) > 0) {
      prepared_datasets$global_food <- datasets$global_food %>%
        select(date, !!sym(num_cols[1])) %>%
        rename(global_food_index = !!sym(num_cols[1]))
    }
  }
}

# Monthly monetary aggregate (M2)
if (!is.null(datasets$monetary_aggregate)) {
  # Try to find M2 column
  m2_col <- grep("m2|broad.*money", names(datasets$monetary_aggregate), ignore.case = TRUE)
  if (length(m2_col) > 0) {
    prepared_datasets$m2 <- datasets$monetary_aggregate %>%
      select(date, !!sym(names(datasets$monetary_aggregate)[m2_col[1]])) %>%
      rename(m2 = !!sym(names(datasets$monetary_aggregate)[m2_col[1]]))
  } else {
    # If can't identify M2 specifically, use observation_value
    prepared_datasets$m2 <- prepare_dataset(datasets$monetary_aggregate, "m2")
  }
}

# Industrial production
if (!is.null(datasets$industrial_production)) {
  prepared_datasets$industrial_production <- prepare_dataset(
    datasets$industrial_production, "industrial_production")
}

# Exports and imports
if (!is.null(datasets$exports_imports)) {
  # Try to separate exports and imports columns
  export_col <- grep("export", names(datasets$exports_imports), ignore.case = TRUE)
  import_col <- grep("import", names(datasets$exports_imports), ignore.case = TRUE)
  
  if (length(export_col) > 0) {
    prepared_datasets$exports <- datasets$exports_imports %>%
      select(date, !!sym(names(datasets$exports_imports)[export_col[1]])) %>%
      rename(exports = !!sym(names(datasets$exports_imports)[export_col[1]]))
  }
  
  if (length(import_col) > 0) {
    prepared_datasets$imports <- datasets$exports_imports %>%
      select(date, !!sym(names(datasets$exports_imports)[import_col[1]])) %>%
      rename(imports = !!sym(names(datasets$exports_imports)[import_col[1]]))
  }
}

# Current account balance
if (!is.null(datasets$current_account_balance)) {
  prepared_datasets$current_account <- prepare_dataset(
    datasets$current_account_balance, "current_account")
}

# --- Load Old Data If Needed ---
# Check for important datasets from old_data
if ("old_data" %in% names(all_datasets)) {
  # Check for additional useful series in old datasets
  if (!is.null(all_datasets$old_data$t_bills.csv)) {
    t_bills <- all_datasets$old_data$t_bills.csv
    if ("date" %in% names(t_bills)) {
      prepared_datasets$t_bills <- prepare_dataset(t_bills, "t_bills")
    }
  }
  
  # Load foreign reserves if available
  if (!is.null(all_datasets$old_data$gold_foreign_exchange_reserves.csv)) {
    reserves <- all_datasets$old_data$gold_foreign_exchange_reserves.csv
    if ("date" %in% names(reserves)) {
      prepared_datasets$reserves <- prepare_dataset(reserves, "reserves")
    }
  }
}

# --- Remove NULL datasets ---
prepared_datasets <- prepared_datasets[!sapply(prepared_datasets, is.null)]
message(paste("Number of prepared datasets:", length(prepared_datasets)))

# --- Merge Datasets ---
message("Merging datasets...")

# First, determine the complete date range across all datasets
all_dates <- do.call(c, lapply(prepared_datasets, function(df) df$date))
date_range <- range(all_dates, na.rm = TRUE)

# Create a complete sequence of months
monthly_seq <- seq.Date(from = floor_date(date_range[1], "month"),
                       to = ceiling_date(date_range[2], "month") - days(1),
                       by = "month")

# Create base dataframe with all dates
merged_df <- tibble(date = monthly_seq)

# Function to join a dataset with proper handling of missing values
join_dataset <- function(merged_df, df, name) {
  message(paste("Joining dataset:", name))
  if (is.null(df)) return(merged_df)
  
  # Join by date, keeping all dates from merged_df
  merged_df %>%
    left_join(df, by = "date")
}

# Join all prepared datasets
for (name in names(prepared_datasets)) {
  merged_df <- join_dataset(merged_df, prepared_datasets[[name]], name)
}

# --- Feature Engineering ---
message("Creating derived features...")

# Sort by date before feature engineering
merged_df <- merged_df %>% arrange(date)

# 1. Create lag variables for key predictors (1, 3, 6, 12 months)
lag_variables <- function(df, var_name, lags = c(1, 3, 6, 12)) {
  if (!var_name %in% names(df)) return(df)
  
  for (lag in lags) {
    lag_name <- paste0(var_name, "_lag", lag)
    df[[lag_name]] <- lag(df[[var_name]], lag)
  }
  return(df)
}

# Create lags for important variables
key_vars <- c("cpi", "exchange_rate", "oil_price", "global_food_index", 
              "policy_rate", "kibor_6m", "m2")

for (var in key_vars) {
  if (var %in% names(merged_df)) {
    merged_df <- lag_variables(merged_df, var)
  }
}

# 2. Create moving averages for key variables (3, 6, 12 months)
ma_variables <- function(df, var_name, windows = c(3, 6, 12)) {
  if (!var_name %in% names(df)) return(df)
  
  for (window in windows) {
    ma_name <- paste0(var_name, "_ma", window)
    df[[ma_name]] <- rollmean(df[[var_name]], k = window, 
                             fill = NA, align = "right")
  }
  return(df)
}

# Create moving averages for important variables
for (var in key_vars) {
  if (var %in% names(merged_df)) {
    merged_df <- ma_variables(merged_df, var)
  }
}

# 3. Create growth rates (month over month and year over year)
growth_variables <- function(df, var_name) {
  if (!var_name %in% names(df)) return(df)
  
  # Month-over-month percent change
  mom_name <- paste0(var_name, "_mom_pct")
  df[[mom_name]] <- (df[[var_name]] / lag(df[[var_name]], 1) - 1) * 100
  
  # Year-over-year percent change
  yoy_name <- paste0(var_name, "_yoy_pct")
  df[[yoy_name]] <- (df[[var_name]] / lag(df[[var_name]], 12) - 1) * 100
  
  return(df)
}

# Create growth rates for important variables
growth_vars <- c("exchange_rate", "oil_price", "global_food_index", "m2")
for (var in growth_vars) {
  if (var %in% names(merged_df)) {
    merged_df <- growth_variables(merged_df, var)
  }
}

# 4. Create seasonal indicators
merged_df <- merged_df %>%
  mutate(
    month = month(date),
    quarter = quarter(date),
    year = year(date),
    is_ramadan = month %in% c(9, 10)  # Approximate Ramadan months (varies)
  )

# If data on actual Ramadan dates is available, use that instead
# For now, using a simple approximation

# 5. Create interaction terms for key variables
# Interaction between oil price and exchange rate (impacts import costs)
if (all(c("oil_price", "exchange_rate") %in% names(merged_df))) {
  merged_df <- merged_df %>%
    mutate(oil_exchange_interaction = oil_price * exchange_rate)
}

# --- Trim dates to periods with adequate data ---
# Find when most series begin having data
data_coverage <- sapply(merged_df %>% select(-date, -month, -quarter, -year, -is_ramadan),
                       function(x) which(!is.na(x))[1])
earliest_complete_idx <- max(data_coverage, na.rm = TRUE)
merged_df_trimmed <- merged_df[earliest_complete_idx:nrow(merged_df),]

# --- Handle Missing Data ---
message("Handling missing values...")

# Compute missingness by column
missingness <- colSums(is.na(merged_df_trimmed)) / nrow(merged_df_trimmed) * 100
high_missingness <- names(missingness[missingness > 30])

if (length(high_missingness) > 0) {
  message("Variables with >30% missing: ", paste(high_missingness, collapse = ", "))
  
  # Drop variables with excessive missingness
  merged_df_trimmed <- merged_df_trimmed %>%
    select(-all_of(high_missingness))
}

# For remaining variables, impute missing values with last observation carried forward
# and next observation carried backward
merged_df_imputed <- merged_df_trimmed %>%
  mutate(across(-c(date, month, quarter, year, is_ramadan), 
                ~zoo::na.locf(.x, na.rm = FALSE))) %>%
  mutate(across(-c(date, month, quarter, year, is_ramadan), 
                ~zoo::na.locf(.x, fromLast = TRUE, na.rm = FALSE)))

# Check if imputation was successful
missing_after <- colSums(is.na(merged_df_imputed))
still_missing <- names(missing_after[missing_after > 0])

if (length(still_missing) > 0) {
  message("Variables still containing missing values: ", 
          paste(still_missing, collapse = ", "))
  
  # For any remaining missing values, use median imputation
  merged_df_imputed <- merged_df_imputed %>%
    mutate(across(all_of(still_missing), 
                  ~ifelse(is.na(.x), median(.x, na.rm = TRUE), .x)))
}

# --- Save the final merged datasets ---
message("Saving merged datasets...")

# Save both versions: one with original missing values, one imputed
write_csv(merged_df_trimmed, "Processed_Data/merged_df_with_missing.csv")
write_csv(merged_df_imputed, "Processed_Data/merged_df_imputed.csv")
saveRDS(merged_df_imputed, "merged_df.rds")  # For use in next scripts

# --- Generate Validation Report ---
sink("merge_report.txt")
cat("===== DATASET MERGING REPORT =====\n\n")
cat("Number of original datasets:", length(datasets), "\n")
cat("Number of prepared datasets:", length(prepared_datasets), "\n")
cat("Date range in merged data:", as.character(range(merged_df$date)), "\n")
cat("Number of rows in full merged data:", nrow(merged_df), "\n")
cat("Number of rows in trimmed data:", nrow(merged_df_trimmed), "\n")
cat("Number of columns in final dataset:", ncol(merged_df_imputed), "\n\n")

cat("===== VARIABLES IN FINAL DATASET =====\n\n")
cat(paste(names(merged_df_imputed), collapse = "\n"))

cat("\n\n===== SUMMARY STATISTICS =====\n\n")
print(summary(merged_df_imputed))

cat("\n\n===== CORRELATION WITH TARGET (CPI) =====\n\n")
if ("cpi" %in% names(merged_df_imputed)) {
  correlations <- sapply(
    merged_df_imputed %>% select(-date, -month, -quarter, -year, -is_ramadan),
    function(x) cor(x, merged_df_imputed$cpi, use = "complete.obs")
  )
  correlations <- correlations[!is.na(correlations) & names(correlations) != "cpi"]
  correlations <- sort(correlations, decreasing = TRUE)
  print(correlations)
}
sink()

message("Merge complete! Datasets saved to Processed_Data/ directory.")
message("Merge report saved to merge_report.txt")

# --- End of script ---
