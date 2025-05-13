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
  library(stringr)
})

# --- Create output directories if they don't exist ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)
dir.create("Output", showWarnings = FALSE, recursive = TRUE)

# --- Load cleaned datasets from 01_load_and_eda.R ---
message("Loading cleaned datasets...")
datasets <- readRDS("Output/cleaned_datasets.rds")

# --- Set up output file for logging ---
sink("Logs/merge_process.txt")
cat("===== PAKISTAN INFLATION FORECASTING PROJECT =====\n")
cat("===== DATASET MERGING PROCESS LOG =====\n\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")
cat("Number of datasets loaded:", length(datasets), "\n")
print(names(datasets))
cat("\n")

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
  # Special handling for CPI dataset to ensure we get a single 'cpi' column
  if ("observation_value" %in% names(datasets$cpi)) {
    # Debug info
    cat("CPI dataset info before preparation:\n")
    cat("- Dimensions:", nrow(datasets$cpi), "rows,", ncol(datasets$cpi), "columns\n")
    cat("- Date range:", format(min(datasets$cpi$date, na.rm = TRUE), "%Y-%m-%d"), "to",
        format(max(datasets$cpi$date, na.rm = TRUE), "%Y-%m-%d"), "\n")
    cat("- Missing values in observation_value:", sum(is.na(datasets$cpi$observation_value)),
        sprintf("(%.1f%%)", sum(is.na(datasets$cpi$observation_value))/nrow(datasets$cpi)*100), "\n")

    # Create a clean CPI dataset with proper date handling
    prepared_datasets$cpi <- datasets$cpi %>%
      select(date, observation_value) %>%
      rename(cpi = observation_value) %>%
      # Ensure date is properly formatted as Date
      mutate(date = as.Date(date)) %>%
      # Remove any duplicate dates (keep first occurrence)
      distinct(date, .keep_all = TRUE) %>%
      # Sort by date
      arrange(date)

    # Debug info after preparation
    cat("CPI dataset prepared with special handling to create 'cpi' column\n")
    cat("- Dimensions after preparation:", nrow(prepared_datasets$cpi), "rows,",
        ncol(prepared_datasets$cpi), "columns\n")
    cat("- Date range after preparation:", format(min(prepared_datasets$cpi$date, na.rm = TRUE), "%Y-%m-%d"), "to",
        format(max(prepared_datasets$cpi$date, na.rm = TRUE), "%Y-%m-%d"), "\n")
    cat("- Missing values in cpi column:", sum(is.na(prepared_datasets$cpi$cpi)),
        sprintf("(%.1f%%)", sum(is.na(prepared_datasets$cpi$cpi))/nrow(prepared_datasets$cpi)*100), "\n")
  } else {
    # Fallback to standard preparation
    prepared_datasets$cpi <- prepare_dataset(datasets$cpi, "cpi")
    cat("CPI dataset prepared with standard method\n")
  }
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
  # Check if we have the cleaned FAO data with standardized column names
  if ("food_price_index" %in% names(datasets$global_food)) {
    # Use the main food price index
    prepared_datasets$global_food <- datasets$global_food %>%
      select(date, food_price_index) %>%
      rename(global_food_index = food_price_index)

    # Also extract individual food component indices
    if (all(c("meat_index", "dairy_index", "cereals_index", "oils_index", "sugar_index") %in%
            names(datasets$global_food))) {
      # Meat index
      prepared_datasets$meat_index <- datasets$global_food %>%
        select(date, meat_index) %>%
        rename(meat_price_index = meat_index)

      # Dairy index
      prepared_datasets$dairy_index <- datasets$global_food %>%
        select(date, dairy_index) %>%
        rename(dairy_price_index = dairy_index)

      # Cereals index
      prepared_datasets$cereals_index <- datasets$global_food %>%
        select(date, cereals_index) %>%
        rename(cereals_price_index = cereals_index)

      # Oils index
      prepared_datasets$oils_index <- datasets$global_food %>%
        select(date, oils_index) %>%
        rename(oils_price_index = oils_index)

      # Sugar index
      prepared_datasets$sugar_index <- datasets$global_food %>%
        select(date, sugar_index) %>%
        rename(sugar_price_index = sugar_index)

      cat("Extracted all food component indices from FAO data\n")
    }
  } else {
    # Fallback to the old approach if we don't have standardized column names
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
cat("Checking for old data files...\n")

# Define a function to load old data files
load_old_data_file <- function(file_path) {
  if (file.exists(file_path)) {
    message("Loading old data file: ", basename(file_path))
    tryCatch({
      # Try to determine file format and use appropriate loader
      lines <- readLines(file_path, n = 10)

      if (any(grepl("Dataset Name", lines)) || any(grepl("Series Key", lines))) {
        # Looks like SBP format
        df <- readr::read_csv(file_path, show_col_types = FALSE)
        names(df) <- tolower(gsub("[ .-]", "_", names(df)))

        # Handle date column
        if ("observation_date" %in% names(df)) {
          df$observation_date <- as.Date(parse_date_time(df$observation_date, orders = c("dmy", "ymd")))
          df$date <- df$observation_date
        }

        return(df)
      } else if (any(grepl("observation_date", lines))) {
        # Looks like FRED format
        df <- readr::read_csv(file_path, show_col_types = FALSE)
        names(df) <- tolower(gsub("[ .-]", "_", names(df)))

        if ("observation_date" %in% names(df)) {
          df$observation_date <- as.Date(df$observation_date)
          df$date <- df$observation_date
        }

        return(df)
      } else {
        # Try as general CSV
        df <- readr::read_csv(file_path, show_col_types = FALSE)
        names(df) <- tolower(gsub("[ .-]", "_", names(df)))

        # Try to identify date column
        date_cols <- grep("date|time|month|year", names(df), ignore.case = TRUE)
        if (length(date_cols) > 0) {
          date_col <- names(df)[date_cols[1]]
          df$date <- parse_date_time(df[[date_col]], orders = c("ymd", "dmy", "mdy"))
        }

        return(df)
      }
    }, error = function(e) {
      warning(paste("Error loading:", basename(file_path), "-", e$message))
      return(NULL)
    })
  } else {
    message("File not found: ", basename(file_path))
    return(NULL)
  }
}

# Try to load t_bills from old_data
old_data_dir <- "Data/old_data"
t_bills_path <- file.path(old_data_dir, "t_bills.csv")
t_bills <- load_old_data_file(t_bills_path)
if (!is.null(t_bills) && "date" %in% names(t_bills)) {
  cat("T-bills data loaded successfully\n")
  prepared_datasets$t_bills <- prepare_dataset(t_bills, "t_bills")
}

# Load foreign reserves if available
reserves_path <- file.path(old_data_dir, "gold_foreign_exchange_reserves.csv")
reserves <- load_old_data_file(reserves_path)
if (!is.null(reserves) && "date" %in% names(reserves)) {
  cat("Foreign reserves data loaded successfully\n")
  prepared_datasets$reserves <- prepare_dataset(reserves, "reserves")
}

# --- Remove NULL datasets ---
prepared_datasets <- prepared_datasets[!sapply(prepared_datasets, is.null)]
message(paste("Number of prepared datasets:", length(prepared_datasets)))

# --- Merge Datasets ---
message("Merging datasets...")
cat("\n===== DATASET MERGING PROCESS =====\n\n")

# First, determine the complete date range across all datasets
all_dates <- do.call(c, lapply(prepared_datasets, function(df) df$date))
date_range <- range(all_dates, na.rm = TRUE)
cat("Complete date range across all datasets:", format(date_range[1], "%Y-%m-%d"), "to",
    format(date_range[2], "%Y-%m-%d"), "\n")
cat("Total time span:", round(difftime(date_range[2], date_range[1], units = "days") / 365.25, 1), "years\n\n")

# Check if CPI data is available and get its date range
cpi_date_range <- NULL
if ("cpi" %in% names(prepared_datasets)) {
  cpi_data <- prepared_datasets[["cpi"]]
  if (!is.null(cpi_data) && "date" %in% names(cpi_data) && nrow(cpi_data) > 0) {
    cpi_date_range <- range(cpi_data$date, na.rm = TRUE)
    cat("CPI data date range:", format(cpi_date_range[1], "%Y-%m-%d"), "to",
        format(cpi_date_range[2], "%Y-%m-%d"), "\n")
  }
}

# Create a complete sequence of months - limit to CPI date range if available
if (!is.null(cpi_date_range)) {
  # Use CPI date range to limit the sequence
  cat("Limiting date range to CPI data availability\n")
  monthly_seq <- seq.Date(from = floor_date(cpi_date_range[1], "month"),
                         to = ceiling_date(cpi_date_range[2], "month") - days(1),
                         by = "month")
} else {
  # Use full date range if CPI data is not available
  monthly_seq <- seq.Date(from = floor_date(date_range[1], "month"),
                         to = ceiling_date(date_range[2], "month") - days(1),
                         by = "month")
}
cat("Created monthly sequence with", length(monthly_seq), "months\n\n")

# Create base dataframe with all dates
merged_df <- tibble(date = monthly_seq)
cat("Base dataframe created with date column\n\n")

# Function to join a dataset with proper handling of missing values
join_dataset <- function(merged_df, df, name) {
  cat("Joining dataset:", name, "\n")
  if (is.null(df)) {
    cat("  Dataset is NULL, skipping\n")
    return(merged_df)
  }

  # Print dataset info before joining
  cat("  Dimensions before join:", nrow(merged_df), "rows,", ncol(merged_df), "columns\n")
  cat("  Dataset to join:", nrow(df), "rows,", ncol(df), "columns\n")

  # Check date range of the dataset
  if ("date" %in% names(df)) {
    df_date_range <- range(df$date, na.rm = TRUE)
    cat("  Dataset date range:", format(df_date_range[1], "%Y-%m-%d"), "to",
        format(df_date_range[2], "%Y-%m-%d"), "\n")

    # Calculate coverage
    date_coverage <- nrow(df) / length(monthly_seq) * 100
    cat("  Date coverage: ", sprintf("%.1f%%", date_coverage),
        "(", nrow(df), "dates out of", length(monthly_seq), "possible)\n")
  }

  # Join by date, keeping all dates from merged_df
  result <- merged_df %>%
    left_join(df, by = "date")

  # Calculate missingness after join
  if (ncol(df) > 1) {  # More than just the date column
    new_cols <- setdiff(names(result), names(merged_df))
    missing_counts <- colSums(is.na(result[, new_cols, drop = FALSE]))
    missing_pcts <- missing_counts / nrow(result) * 100

    cat("  New columns added:", paste(new_cols, collapse = ", "), "\n")
    cat("  Missingness in new columns:\n")
    for (col in new_cols) {
      cat("    ", col, ": ", sprintf("%.1f%%", missing_pcts[col]),
          "(", missing_counts[col], "out of", nrow(result), ")\n")
    }
  }

  cat("  Dimensions after join:", nrow(result), "rows,", ncol(result), "columns\n\n")
  return(result)
}

# Join all prepared datasets
cat("Starting to join all prepared datasets\n")
cat("Number of datasets to join:", length(prepared_datasets), "\n")
cat("Dataset names:", paste(names(prepared_datasets), collapse = ", "), "\n\n")

# Check if CPI (target variable) is present
if ("cpi" %in% names(prepared_datasets)) {
  cat("TARGET VARIABLE (CPI) IS PRESENT - Good!\n\n")
} else {
  cat("WARNING: TARGET VARIABLE (CPI) IS MISSING!\n")
  cat("This will cause problems for modeling. Check the data loading process.\n\n")
}

# Join datasets in a specific order to prioritize important variables
# First join the target variable (CPI)
if ("cpi" %in% names(prepared_datasets)) {
  # Special handling for CPI to ensure it's properly merged
  cpi_data <- prepared_datasets[["cpi"]]

  # Debug the CPI data before joining
  cat("CPI data before joining:\n")
  cat("- Dimensions:", nrow(cpi_data), "rows,", ncol(cpi_data), "columns\n")
  cat("- Date range:", format(min(cpi_data$date, na.rm = TRUE), "%Y-%m-%d"), "to",
      format(max(cpi_data$date, na.rm = TRUE), "%Y-%m-%d"), "\n")
  cat("- Date class:", class(cpi_data$date), "\n")
  cat("- First few dates:", paste(format(head(cpi_data$date, 5), "%Y-%m-%d"), collapse = ", "), "\n")

  # Ensure the date column in merged_df is also Date type
  merged_df$date <- as.Date(merged_df$date)

  # Debug the merged_df date column
  cat("merged_df date column before joining:\n")
  cat("- Date class:", class(merged_df$date), "\n")
  cat("- First few dates:", paste(format(head(merged_df$date, 5), "%Y-%m-%d"), collapse = ", "), "\n")

  # Fix the date issue: CPI dates are end-of-month, merged_df dates are start-of-month
  cat("Converting CPI dates from end-of-month to start-of-month format...\n")

  # Create a mapping between month-year and CPI values
  cpi_data$year_month <- format(cpi_data$date, "%Y-%m")

  # Create the same mapping for merged_df
  merged_df$year_month <- format(merged_df$date, "%Y-%m")

  # Join by year-month instead of exact date
  merged_df <- merged_df %>%
    left_join(cpi_data %>% select(year_month, cpi), by = "year_month") %>%
    select(-year_month)  # Remove the temporary column

  # Check if CPI was successfully joined
  na_count <- sum(is.na(merged_df$cpi))
  cat("After joining CPI by year-month:\n")
  cat("- Dimensions:", nrow(merged_df), "rows,", ncol(merged_df), "columns\n")
  cat("- Missing values in cpi column:", na_count,
      sprintf("(%.1f%%)", na_count/nrow(merged_df)*100), "\n")

  # If we still have issues, try another approach
  if (na_count == nrow(merged_df)) {
    cat("WARNING: All CPI values are NA after joining. Trying a direct approach...\n")

    # Create a dataframe with just the CPI values
    cpi_values <- data.frame(
      date = floor_date(cpi_data$date, "month"),
      cpi = cpi_data$cpi
    )

    # Remove the NA cpi column and join again
    merged_df <- merged_df %>%
      select(-cpi) %>%
      left_join(cpi_values, by = "date")

    # Check if this worked better
    na_count_new <- sum(is.na(merged_df$cpi))
    cat("After direct join with adjusted dates:\n")
    cat("- Missing values in cpi column:", na_count_new,
        sprintf("(%.1f%%)", na_count_new/nrow(merged_df)*100), "\n")
  }

  # If we still have all NAs, print a warning
  if (sum(is.na(merged_df$cpi)) == nrow(merged_df)) {
    cat("WARNING: Failed to join CPI data. All values are still NA.\n")
    cat("This will prevent modeling. Check the data loading and merging process.\n")
  }
} else {
  cat("WARNING: CPI dataset not found in prepared datasets!\n")
}

# Then join key monetary and external sector variables
key_vars <- c("exchange_rate", "policy_rate", "kibor_6m", "kibor",
              "oil_price", "global_food_index", "m2")
for (var in key_vars) {
  if (var %in% names(prepared_datasets)) {
    merged_df <- join_dataset(merged_df, prepared_datasets[[var]], var)
  }
}

# Join remaining variables
remaining_vars <- setdiff(names(prepared_datasets), c("cpi", key_vars))
for (var in remaining_vars) {
  merged_df <- join_dataset(merged_df, prepared_datasets[[var]], var)
}

# Summarize the merged dataset
cat("===== MERGED DATASET SUMMARY =====\n")
cat("Final dimensions:", nrow(merged_df), "rows,", ncol(merged_df), "columns\n")
cat("Date range:", format(min(merged_df$date), "%Y-%m-%d"), "to",
    format(max(merged_df$date), "%Y-%m-%d"), "\n")
cat("Variables:", paste(names(merged_df), collapse = ", "), "\n\n")

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

# 4. Create seasonal indicators and calendar effects
cat("Creating seasonal indicators and calendar effects...\n")
merged_df <- merged_df %>%
  mutate(
    month = month(date),
    quarter = quarter(date),
    year = year(date)
  )

# Create more accurate Ramadan indicators using known Ramadan dates
# Ramadan dates from 2000-2025 (approximate start dates in Gregorian calendar)
ramadan_dates <- data.frame(
  year = c(2000:2025),
  start_date = as.Date(c(
    "2000-11-27", "2001-11-17", "2002-11-06", "2003-10-27", "2004-10-15",
    "2005-10-04", "2006-09-24", "2007-09-13", "2008-09-01", "2009-08-22",
    "2010-08-11", "2011-08-01", "2012-07-20", "2013-07-09", "2014-06-28",
    "2015-06-18", "2016-06-06", "2017-05-27", "2018-05-16", "2019-05-06",
    "2020-04-24", "2021-04-13", "2022-04-02", "2023-03-23", "2024-03-11",
    "2025-03-01"
  ))
)

# Add end dates (approximately 29-30 days after start)
ramadan_dates$end_date <- ramadan_dates$start_date + 29

# Function to check if a date falls within Ramadan
is_ramadan <- function(date, ramadan_df) {
  year_val <- year(date)

  # Check if year exists in our data
  if (year_val %in% ramadan_df$year) {
    ramadan_row <- ramadan_df[ramadan_df$year == year_val, ]
    return(date >= ramadan_row$start_date & date <= ramadan_row$end_date)
  }

  # Fallback for years not in our data
  return(month(date) %in% c(9, 10))
}

# Apply the function to create is_ramadan column
merged_df$is_ramadan <- sapply(merged_df$date, function(d) is_ramadan(d, ramadan_dates))

# Create month after Ramadan indicator (for potential lagged effects)
merged_df$post_ramadan <- sapply(merged_df$date, function(d) {
  year_val <- year(d)
  if (year_val %in% ramadan_dates$year) {
    ramadan_row <- ramadan_dates[ramadan_dates$year == year_val, ]
    post_start <- ramadan_row$end_date + 1
    post_end <- post_start + 30
    return(d >= post_start & d <= post_end)
  }
  return(FALSE)
})

# Create fiscal year indicator (Pakistan's fiscal year runs July-June)
merged_df <- merged_df %>%
  mutate(
    fiscal_year = ifelse(month >= 7,
                         paste0(year, "-", substr(as.character(year + 1), 3, 4)),
                         paste0(year - 1, "-", substr(as.character(year), 3, 4))),
    fiscal_quarter = case_when(
      month %in% c(7, 8, 9) ~ 1,
      month %in% c(10, 11, 12) ~ 2,
      month %in% c(1, 2, 3) ~ 3,
      month %in% c(4, 5, 6) ~ 4
    )
  )

# 5. Create interaction terms for key variables
cat("Creating interaction terms...\n")

# Interaction between oil price and exchange rate (impacts import costs)
if (all(c("oil_price", "exchange_rate") %in% names(merged_df))) {
  merged_df <- merged_df %>%
    mutate(oil_exchange_interaction = oil_price * exchange_rate)
}

# Interaction between global food index and exchange rate
if (all(c("global_food_index", "exchange_rate") %in% names(merged_df))) {
  merged_df <- merged_df %>%
    mutate(food_exchange_interaction = global_food_index * exchange_rate)
}

# Interaction between policy rate and M2 growth
if (all(c("policy_rate", "m2_yoy_pct") %in% names(merged_df))) {
  merged_df <- merged_df %>%
    mutate(policy_m2_interaction = policy_rate * m2_yoy_pct)
}

# --- Trim dates to periods with adequate data ---
# Find when most series begin having data
data_coverage <- sapply(merged_df %>% select(-date, -month, -quarter, -year, -is_ramadan),
                       function(x) which(!is.na(x))[1])
earliest_complete_idx <- max(data_coverage, na.rm = TRUE)
merged_df_trimmed <- merged_df[earliest_complete_idx:nrow(merged_df),]

# --- Handle Missing Data ---
message("Handling missing values...")
cat("\n===== MISSING DATA ANALYSIS =====\n\n")

# Compute missingness by column
missingness <- colSums(is.na(merged_df_trimmed)) / nrow(merged_df_trimmed) * 100
cat("Missingness percentage by column:\n")
missingness_df <- data.frame(
  Variable = names(missingness),
  Missing_Percent = missingness
)
missingness_df <- missingness_df[order(-missingness_df$Missing_Percent), ]
print(head(missingness_df, 20))
cat("\n")

# Identify variables with high missingness
high_missingness <- names(missingness[missingness > 30])
moderate_missingness <- names(missingness[missingness > 10 & missingness <= 30])
low_missingness <- names(missingness[missingness > 0 & missingness <= 10])

# Make sure we NEVER drop the CPI column (our target variable)
if ("cpi" %in% high_missingness) {
  cat("NOTE: CPI (target variable) has high missingness but will NOT be dropped\n")
  high_missingness <- setdiff(high_missingness, "cpi")
}

cat("Variables with high missingness (>30%):", length(high_missingness), "\n")
if (length(high_missingness) > 0) {
  cat(paste(high_missingness, collapse = ", "), "\n\n")
  message("Variables with >30% missing: ", paste(high_missingness, collapse = ", "))

  # Drop variables with excessive missingness
  merged_df_trimmed <- merged_df_trimmed %>%
    select(-all_of(high_missingness))
}

cat("Variables with moderate missingness (10-30%):", length(moderate_missingness), "\n")
if (length(moderate_missingness) > 0) {
  cat(paste(moderate_missingness, collapse = ", "), "\n\n")
}

cat("Variables with low missingness (0-10%):", length(low_missingness), "\n")
if (length(low_missingness) > 0) {
  cat(paste(head(low_missingness, 10), collapse = ", "), "\n")
  if (length(low_missingness) > 10) {
    cat("... and", length(low_missingness) - 10, "more\n\n")
  } else {
    cat("\n\n")
  }
}

# Create a copy of the dataframe before imputation for comparison
merged_df_with_missing <- merged_df_trimmed

# For remaining variables, impute missing values with last observation carried forward
# and next observation carried backward
cat("Performing imputation using multiple methods:\n")
cat("1. Last observation carried forward (LOCF)\n")
cat("2. Next observation carried backward (NOCB)\n")
cat("3. Median imputation for any remaining missing values\n\n")

# Identify time-related columns to exclude from imputation
time_cols <- c("date", "month", "quarter", "year", "is_ramadan", "post_ramadan",
               "fiscal_year", "fiscal_quarter")
time_cols <- time_cols[time_cols %in% names(merged_df_trimmed)]

# Perform LOCF imputation
merged_df_imputed <- merged_df_trimmed %>%
  mutate(across(-all_of(time_cols), ~zoo::na.locf(.x, na.rm = FALSE)))

# Perform NOCB imputation on remaining missing values
merged_df_imputed <- merged_df_imputed %>%
  mutate(across(-all_of(time_cols), ~zoo::na.locf(.x, fromLast = TRUE, na.rm = FALSE)))

# Check if imputation was successful
missing_after <- colSums(is.na(merged_df_imputed))
still_missing <- names(missing_after[missing_after > 0])

if (length(still_missing) > 0) {
  cat("Variables still containing missing values after LOCF/NOCB:", length(still_missing), "\n")
  cat(paste(still_missing, collapse = ", "), "\n\n")
  message("Variables still containing missing values: ", paste(still_missing, collapse = ", "))

  # For any remaining missing values, use median imputation
  merged_df_imputed <- merged_df_imputed %>%
    mutate(across(all_of(still_missing), ~ifelse(is.na(.x), median(.x, na.rm = TRUE), .x)))

  # Check if any missing values remain
  final_missing <- colSums(is.na(merged_df_imputed))
  if (sum(final_missing) > 0) {
    cat("WARNING: Some missing values could not be imputed!\n")
    print(final_missing[final_missing > 0])
  } else {
    cat("All missing values successfully imputed.\n")
  }
} else {
  cat("All missing values successfully imputed using LOCF/NOCB methods.\n")
}

# Calculate imputation statistics
cat("\n===== IMPUTATION SUMMARY =====\n")
total_cells <- nrow(merged_df_with_missing) * (ncol(merged_df_with_missing) - length(time_cols))
total_missing_before <- sum(is.na(merged_df_with_missing[, !names(merged_df_with_missing) %in% time_cols]))
total_missing_after <- sum(is.na(merged_df_imputed[, !names(merged_df_imputed) %in% time_cols]))
imputation_percent <- (total_missing_before - total_missing_after) / total_cells * 100

cat("Total data cells:", total_cells, "\n")
cat("Missing values before imputation:", total_missing_before,
    sprintf("(%.2f%%)", total_missing_before/total_cells*100), "\n")
cat("Missing values after imputation:", total_missing_after, "\n")
cat("Percentage of data imputed:", sprintf("%.2f%%", imputation_percent), "\n\n")

# --- Perform Data Validation Checks ---
message("Performing data validation checks...")
cat("\n===== DATA VALIDATION CHECKS =====\n")

# Function to perform validation checks
validate_data <- function(df, name) {
  cat("Validating dataset:", name, "\n")
  validation_issues <- list()

  # Check 1: Ensure no missing values in critical columns
  critical_cols <- c("date", "cpi")
  critical_cols <- critical_cols[critical_cols %in% names(df)]

  for (col in critical_cols) {
    missing_count <- sum(is.na(df[[col]]))
    if (missing_count > 0) {
      issue <- paste("Critical column", col, "has", missing_count, "missing values")
      validation_issues <- c(validation_issues, issue)
      cat("  ISSUE:", issue, "\n")
    }
  }

  # Check 2: Ensure date column is properly sorted
  if ("date" %in% names(df)) {
    date_sorted <- all(diff(as.numeric(df$date)) >= 0)
    if (!date_sorted) {
      issue <- "Dates are not in ascending order"
      validation_issues <- c(validation_issues, issue)
      cat("  ISSUE:", issue, "\n")
    }

    # Check for duplicate dates
    duplicate_dates <- df$date[duplicated(df$date)]
    if (length(duplicate_dates) > 0) {
      issue <- paste("Found", length(duplicate_dates), "duplicate dates")
      validation_issues <- c(validation_issues, issue)
      cat("  ISSUE:", issue, "\n")
    }
  }

  # Check 3: Check for outliers in key numeric columns
  key_numeric_cols <- c("cpi", "exchange_rate", "policy_rate", "oil_price", "global_food_index")
  key_numeric_cols <- key_numeric_cols[key_numeric_cols %in% names(df)]

  for (col in key_numeric_cols) {
    values <- df[[col]]
    if (is.numeric(values)) {
      # Calculate IQR-based outlier bounds
      q1 <- quantile(values, 0.25, na.rm = TRUE)
      q3 <- quantile(values, 0.75, na.rm = TRUE)
      iqr <- q3 - q1
      lower_bound <- q1 - 3 * iqr
      upper_bound <- q3 + 3 * iqr

      # Count extreme outliers (3*IQR)
      outliers <- values[values < lower_bound | values > upper_bound]
      outliers <- outliers[!is.na(outliers)]

      if (length(outliers) > 0) {
        issue <- paste("Column", col, "has", length(outliers), "extreme outliers")
        validation_issues <- c(validation_issues, issue)
        cat("  ISSUE:", issue, "\n")
        cat("    Range:", min(outliers), "to", max(outliers), "\n")
      }
    }
  }

  # Check 4: Ensure no infinite values
  inf_counts <- sapply(df, function(x) sum(is.infinite(x), na.rm = TRUE))
  inf_cols <- names(inf_counts[inf_counts > 0])

  if (length(inf_cols) > 0) {
    for (col in inf_cols) {
      issue <- paste("Column", col, "has", inf_counts[col], "infinite values")
      validation_issues <- c(validation_issues, issue)
      cat("  ISSUE:", issue, "\n")
    }
  }

  # Check 5: Verify time series continuity (no gaps in monthly data)
  if ("date" %in% names(df)) {
    # Sort by date
    sorted_df <- df[order(df$date), ]
    dates <- sorted_df$date

    # Check for gaps in monthly sequence
    if (length(dates) > 1) {
      # Convert to yearmon for easier monthly comparison
      ym_dates <- as.yearmon(dates)
      # Calculate differences between consecutive months
      date_diffs <- diff(as.numeric(ym_dates))
      # Find gaps (difference > 1/12 year)
      gaps <- which(date_diffs > 1/12 + 0.001)  # Add small tolerance

      if (length(gaps) > 0) {
        issue <- paste("Found", length(gaps), "gaps in monthly sequence")
        validation_issues <- c(validation_issues, issue)
        cat("  ISSUE:", issue, "\n")

        # Show the first few gaps
        for (i in head(gaps, 3)) {
          cat("    Gap between", format(dates[i], "%Y-%m-%d"), "and",
              format(dates[i+1], "%Y-%m-%d"), "\n")
        }
        if (length(gaps) > 3) {
          cat("    ... and", length(gaps) - 3, "more gaps\n")
        }
      }
    }
  }

  # Summary
  if (length(validation_issues) == 0) {
    cat("  No validation issues found!\n")
    return(TRUE)
  } else {
    cat("  Found", length(validation_issues), "validation issues\n")
    return(FALSE)
  }
}

# Validate the datasets
with_missing_valid <- validate_data(merged_df_with_missing, "merged_df_with_missing")
imputed_valid <- validate_data(merged_df_imputed, "merged_df_imputed")

# --- Save the final merged datasets ---
message("Saving merged datasets...")
cat("\n===== SAVING DATASETS =====\n")

# Create directory if it doesn't exist (redundant but safe)
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Output", showWarnings = FALSE, recursive = TRUE)

# Save both versions: one with original missing values, one imputed
write_csv(merged_df_with_missing, "Processed_Data/merged_df_with_missing.csv")
cat("Saved: Processed_Data/merged_df_with_missing.csv\n")
cat("  Dimensions:", nrow(merged_df_with_missing), "rows,", ncol(merged_df_with_missing), "columns\n")
cat("  Validation:", ifelse(with_missing_valid, "PASSED", "ISSUES DETECTED"), "\n")

write_csv(merged_df_imputed, "Processed_Data/merged_df_imputed.csv")
cat("Saved: Processed_Data/merged_df_imputed.csv\n")
cat("  Dimensions:", nrow(merged_df_imputed), "rows,", ncol(merged_df_imputed), "columns\n")
cat("  Validation:", ifelse(imputed_valid, "PASSED", "ISSUES DETECTED"), "\n")

# Save as RDS for use in subsequent scripts
saveRDS(merged_df_imputed, "Output/merged_df.rds")
cat("Saved: Output/merged_df.rds (for use in subsequent scripts)\n")

# Save a smaller version with only key variables for quick analysis
key_variables <- c("date", "month", "quarter", "year", "fiscal_year", "fiscal_quarter",
                  "is_ramadan", "post_ramadan")

# Add CPI (target variable) if present
if ("cpi" %in% names(merged_df_imputed)) {
  key_variables <- c(key_variables, "cpi")
}

# Add key economic indicators if present
potential_key_indicators <- c("exchange_rate", "policy_rate", "kibor", "kibor_6m",
                             "oil_price", "global_food_index", "m2",
                             "industrial_production", "exports", "imports")

for (var in potential_key_indicators) {
  if (var %in% names(merged_df_imputed)) {
    key_variables <- c(key_variables, var)
  }
}

# Create and save the key variables dataset
key_vars_df <- merged_df_imputed %>%
  select(all_of(key_variables))

write_csv(key_vars_df, "Processed_Data/key_variables.csv")
cat("Saved: Processed_Data/key_variables.csv\n")
cat("  Dimensions:", nrow(key_vars_df), "rows,", ncol(key_vars_df), "columns\n")
cat("  Variables:", paste(names(key_vars_df), collapse = ", "), "\n\n")

# --- Generate Comprehensive Validation Report ---
cat("\n===== GENERATING FINAL REPORT =====\n")

# Close the current sink to merge_process.txt
sink()

# Create a comprehensive report
sink("merge_report.txt")
cat("===== PAKISTAN INFLATION FORECASTING PROJECT =====\n")
cat("===== DATASET MERGING REPORT =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Add project overview
cat("1. PROJECT OVERVIEW\n")
cat("This report summarizes the dataset merging process for the Pakistan Inflation Forecasting Project.\n")
cat("The goal is to create a comprehensive dataset for forecasting inflation using various regression techniques.\n\n")

# Add data sources
cat("2. DATA SOURCES\n")
cat("The following data sources were used in this project:\n")
cat("- State Bank of Pakistan (SBP) EasyData portal: Monetary and financial indicators\n")
cat("- Pakistan Bureau of Statistics (PBS): Price indices and economic indicators\n")
cat("- Food and Agriculture Organization (FAO): Global food price indices\n")
cat("- Federal Reserve Economic Data (FRED): International oil prices and global indicators\n")
cat("- Finance.gov.pk: Fiscal and economic data\n")
cat("- Legacy datasets from previous analyses\n\n")

cat("3. DATASET SUMMARY\n")
cat("Original datasets loaded:", length(datasets), "\n")
cat("Prepared datasets for merging:", length(prepared_datasets), "\n")
cat("Date range in merged data:", format(min(merged_df$date), "%Y-%m-%d"), "to",
    format(max(merged_df$date), "%Y-%m-%d"), "\n")
cat("Total time period:", round(difftime(max(merged_df$date), min(merged_df$date), units = "days") / 365.25, 1), "years\n")
cat("Number of rows in full merged data:", nrow(merged_df), "\n")
cat("Number of rows in trimmed data:", nrow(merged_df_trimmed),
    sprintf("(%.1f%% of full data)", nrow(merged_df_trimmed)/nrow(merged_df)*100), "\n")
cat("Number of columns in final dataset:", ncol(merged_df_imputed), "\n\n")

# Add information about key variables
cat("4. KEY VARIABLES\n")

# Check if target variable is present
if ("cpi" %in% names(merged_df_imputed)) {
  cat("Target variable (CPI) is present in the final dataset\n")

  # Check if we have non-NA values in CPI
  non_na_cpi <- merged_df_imputed$cpi[!is.na(merged_df_imputed$cpi)]
  if (length(non_na_cpi) > 0) {
    cat("CPI range:", min(non_na_cpi), "to", max(non_na_cpi), "\n")
    cat("CPI mean:", mean(non_na_cpi), "\n")
    cat("CPI standard deviation:", sd(non_na_cpi), "\n")
    cat("Number of non-NA CPI values:", length(non_na_cpi),
        sprintf("(%.1f%% of data)", length(non_na_cpi)/nrow(merged_df_imputed)*100), "\n\n")
  } else {
    cat("WARNING: CPI column contains only NA values!\n\n")
  }
} else {
  cat("WARNING: Target variable (CPI) is NOT present in the final dataset!\n\n")
}

# List key predictor variables
cat("Key predictor variables:\n")
key_predictors <- c("exchange_rate", "policy_rate", "kibor", "kibor_6m",
                   "oil_price", "global_food_index", "m2",
                   "industrial_production", "exports", "imports")

present_predictors <- key_predictors[key_predictors %in% names(merged_df_imputed)]
missing_predictors <- key_predictors[!key_predictors %in% names(merged_df_imputed)]

if (length(present_predictors) > 0) {
  cat("Present:", paste(present_predictors, collapse = ", "), "\n")
} else {
  cat("No key predictors present!\n")
}

if (length(missing_predictors) > 0) {
  cat("Missing:", paste(missing_predictors, collapse = ", "), "\n")
}
cat("\n")

cat("===== VARIABLES IN FINAL DATASET =====\n\n")
var_categories <- list(
  "Date and Time" = c("date", "month", "quarter", "year", "fiscal_year", "fiscal_quarter"),
  "Target Variable" = "cpi",
  "Monetary Variables" = c("policy_rate", "kibor", "m2"),
  "External Sector" = c("exchange_rate", "exports", "imports", "current_account"),
  "Real Sector" = "industrial_production",
  "Global Factors" = c("oil_price", "global_food_index"),
  "Derived Features" = c("is_ramadan", "post_ramadan")
)

# Print variables by category
for (category in names(var_categories)) {
  cat(category, ":\n")
  vars_in_category <- var_categories[[category]]
  vars_present <- vars_in_category[sapply(vars_in_category, function(pattern) {
    any(grepl(pattern, names(merged_df_imputed)))
  })]

  if (length(vars_present) > 0) {
    for (pattern in vars_present) {
      matching_vars <- names(merged_df_imputed)[grepl(pattern, names(merged_df_imputed))]
      cat("  - ", paste(matching_vars, collapse = "\n  - "), "\n")
    }
  } else {
    cat("  None found\n")
  }
  cat("\n")
}

# Print all variables alphabetically
cat("All Variables (Alphabetical):\n")
cat(paste(sort(names(merged_df_imputed)), collapse = "\n"))
cat("\n\n")

cat("===== SUMMARY STATISTICS =====\n\n")
# Print summary statistics for key variables only to keep the report readable
key_vars <- c("cpi", "exchange_rate", "policy_rate", "oil_price", "global_food_index",
              "industrial_production", "m2")
key_vars <- key_vars[key_vars %in% names(merged_df_imputed)]

for (var in key_vars) {
  cat("Summary for", var, ":\n")
  print(summary(merged_df_imputed[[var]]))
  cat("\n")
}

cat("\n===== CORRELATION WITH TARGET (CPI) =====\n\n")
if ("cpi" %in% names(merged_df_imputed) && sum(!is.na(merged_df_imputed$cpi)) > 0) {
  # Exclude non-numeric and time-related columns
  exclude_cols <- c("date", "month", "quarter", "year", "is_ramadan", "post_ramadan",
                   "fiscal_year", "fiscal_quarter")
  exclude_cols <- exclude_cols[exclude_cols %in% names(merged_df_imputed)]

  # Check if we have enough non-NA values in CPI
  non_na_cpi_count <- sum(!is.na(merged_df_imputed$cpi))
  cat("Number of non-NA values in CPI:", non_na_cpi_count, "\n")

  if (non_na_cpi_count > 1) {
    # Calculate correlations safely
    tryCatch({
      correlations <- sapply(
        merged_df_imputed %>% select(-all_of(exclude_cols)),
        function(x) {
          if (is.numeric(x) && sum(!is.na(x) & !is.na(merged_df_imputed$cpi)) > 1) {
            cor(x, merged_df_imputed$cpi, use = "complete.obs")
          } else {
            NA
          }
        }
      )

      # Filter and sort correlations
      correlations <- correlations[!is.na(correlations) & names(correlations) != "cpi"]

      if (length(correlations) > 0) {
        correlations <- sort(correlations, decreasing = TRUE)

        # Print top positive correlations
        pos_correlations <- correlations[correlations > 0]
        if (length(pos_correlations) > 0) {
          cat("Top", min(10, length(pos_correlations)), "Positive Correlations with CPI:\n")
          top_pos <- head(pos_correlations, 10)
          for (i in seq_along(top_pos)) {
            cat(sprintf("%2d. %-30s: %6.3f\n", i, names(top_pos)[i], top_pos[i]))
          }
        } else {
          cat("No positive correlations found with CPI\n")
        }
        cat("\n")

        # Print top negative correlations
        neg_correlations <- correlations[correlations < 0]
        if (length(neg_correlations) > 0) {
          cat("Top", min(10, length(neg_correlations)), "Negative Correlations with CPI:\n")
          top_neg <- head(sort(neg_correlations), 10)
          for (i in seq_along(top_neg)) {
            cat(sprintf("%2d. %-30s: %6.3f\n", i, names(top_neg)[i], top_neg[i]))
          }
        } else {
          cat("No negative correlations found with CPI\n")
        }
      } else {
        cat("No valid correlations could be calculated with CPI\n")
      }
    }, error = function(e) {
      cat("Error calculating correlations:", e$message, "\n")
    })
  } else {
    cat("Insufficient non-NA values in CPI to calculate correlations\n")
  }
} else {
  cat("CPI column is missing or contains only NA values\n")
}

cat("7. DATA QUALITY ASSESSMENT\n")
cat("The following data quality issues were identified and addressed:\n\n")

# Missing data summary
cat("Missing data:\n")
cat("- Variables with high missingness (>30%):", length(high_missingness), "\n")
if (length(high_missingness) > 0) {
  cat("  These variables were dropped:", paste(head(high_missingness, 10), collapse = ", "), "\n")
  if (length(high_missingness) > 10) {
    cat("  And", length(high_missingness) - 10, "more\n")
  }
}

cat("- Variables with moderate missingness (10-30%):", length(moderate_missingness), "\n")
if (length(moderate_missingness) > 0) {
  cat("  These were imputed:", paste(head(moderate_missingness, 10), collapse = ", "), "\n")
  if (length(moderate_missingness) > 10) {
    cat("  And", length(moderate_missingness) - 10, "more\n")
  }
}

# Imputation summary
cat("\nImputation summary:\n")
cat("- Total cells in dataset:", total_cells, "\n")
cat("- Missing values before imputation:", total_missing_before,
    sprintf("(%.2f%%)", total_missing_before/total_cells*100), "\n")
cat("- Missing values after imputation:", total_missing_after, "\n")
cat("- Percentage of data imputed:", sprintf("%.2f%%", imputation_percent), "\n\n")

# Date range issues
cat("Date range considerations:\n")
cat("- Full date range:", format(min(merged_df$date), "%Y-%m-%d"), "to",
    format(max(merged_df$date), "%Y-%m-%d"), "\n")
cat("- Trimmed date range:", format(min(merged_df_trimmed$date), "%Y-%m-%d"), "to",
    format(max(merged_df_trimmed$date), "%Y-%m-%d"), "\n")
cat("- Data was trimmed to periods with adequate coverage across variables\n\n")

cat("8. DERIVED FEATURES\n")
cat("The following types of derived features were created:\n")
cat("- Lag variables (1, 3, 6, 12 months) for key predictors\n")
cat("- Moving averages (3, 6, 12 months) for key predictors\n")
cat("- Growth rates (month-over-month and year-over-year) for key variables\n")
cat("- Seasonal indicators (month, quarter, Ramadan periods)\n")
cat("- Fiscal year indicators (Pakistan's fiscal year runs July-June)\n")
cat("- Interaction terms between related variables\n\n")

cat("9. NEXT STEPS\n")
cat("1. Review the merged dataset for any remaining anomalies or issues\n")
cat("2. Proceed to 03_prepare_modeling_df.R for final modeling preparation\n")
cat("3. Implement ARIMA modeling in 04_arima_modeling.R\n")
cat("4. Implement Lasso, Ridge, and Elastic-Net Regression in 05_regularization_modeling.R\n")
cat("5. Evaluate model performance and select the best model in 06_model_evaluation.R\n")
cat("6. Generate forecasts and visualizations\n\n")

cat("===== END OF REPORT =====\n")
sink()

# Create a separate output file as required
sink("Logs/02_merge_datasets_output.txt")
cat("===== 02_MERGE_DATASETS.R OUTPUT =====\n")
cat("Execution completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")
cat("This file provides a summary of the dataset merging process for the Pakistan Inflation Forecasting Project.\n\n")

cat("===== DATASET SUMMARY =====\n")
cat("Original datasets loaded:", length(datasets), "\n")
cat("Prepared datasets for merging:", length(prepared_datasets), "\n")
cat("Date range in merged data:", format(min(merged_df$date), "%Y-%m-%d"), "to",
    format(max(merged_df$date), "%Y-%m-%d"), "\n")
cat("Number of rows in full merged data:", nrow(merged_df), "\n")
cat("Number of rows in trimmed data:", nrow(merged_df_trimmed), "\n")
cat("Number of columns in final dataset:", ncol(merged_df_imputed), "\n\n")

cat("===== TARGET VARIABLE STATUS =====\n")
if ("cpi" %in% names(merged_df_imputed)) {
  cat("CPI (target variable) is PRESENT in the final dataset\n")

  # Check if we have non-NA values in CPI
  non_na_cpi <- merged_df_imputed$cpi[!is.na(merged_df_imputed$cpi)]
  missing_count <- sum(is.na(merged_df_imputed$cpi))
  missing_pct <- missing_count/nrow(merged_df_imputed)*100

  if (length(non_na_cpi) > 0) {
    cat("CPI statistics:\n")
    cat("- Range:", min(non_na_cpi), "to", max(non_na_cpi), "\n")
    cat("- Mean:", mean(non_na_cpi), "\n")
    cat("- Standard deviation:", sd(non_na_cpi), "\n")
    cat("- Non-NA values:", length(non_na_cpi),
        sprintf("(%.1f%%)", 100 - missing_pct), "\n")
    cat("- Missing values:", missing_count,
        sprintf("(%.1f%%)", missing_pct), "\n")
  } else {
    cat("WARNING: CPI column contains only NA values!\n")
    cat("This will prevent modeling. Check the data loading and merging process.\n")
  }
} else {
  cat("WARNING: CPI (target variable) is MISSING from the final dataset!\n")
  cat("This will prevent modeling. Check the data loading and merging process.\n")
}
cat("\n")

cat("===== KEY PREDICTOR VARIABLES =====\n")
key_vars <- c("exchange_rate", "policy_rate", "kibor", "kibor_6m", "oil_price",
              "global_food_index", "m2", "industrial_production", "exports", "imports")
present_vars <- key_vars[key_vars %in% names(merged_df_imputed)]
missing_vars <- key_vars[!key_vars %in% names(merged_df_imputed)]

cat("Present (", length(present_vars), "/", length(key_vars), "):\n", sep="")
if (length(present_vars) > 0) {
  for (var in present_vars) {
    cat("- ", var, ": Range ", min(merged_df_imputed[[var]], na.rm = TRUE), " to ",
        max(merged_df_imputed[[var]], na.rm = TRUE), "\n", sep="")
  }
} else {
  cat("No key predictor variables present!\n")
}

if (length(missing_vars) > 0) {
  cat("\nMissing (", length(missing_vars), "/", length(key_vars), "):\n", sep="")
  cat(paste("- ", missing_vars, collapse = "\n"), "\n")
}
cat("\n")

cat("===== DATA QUALITY SUMMARY =====\n")
cat("Variables with high missingness (>30%):", length(high_missingness), "\n")
cat("Variables with moderate missingness (10-30%):", length(moderate_missingness), "\n")
cat("Variables with low missingness (0-10%):", length(low_missingness), "\n")
cat("Missing values before imputation:", total_missing_before,
    sprintf("(%.2f%%)", total_missing_before/total_cells*100), "\n")
cat("Missing values after imputation:", total_missing_after, "\n\n")

cat("===== FILES CREATED =====\n")
cat("1. Processed_Data/merged_df_with_missing.csv - Merged data before imputation\n")
cat("   Dimensions:", nrow(merged_df_with_missing), "rows,", ncol(merged_df_with_missing), "columns\n")
cat("2. Processed_Data/merged_df_imputed.csv - Final merged data with imputation\n")
cat("   Dimensions:", nrow(merged_df_imputed), "rows,", ncol(merged_df_imputed), "columns\n")
cat("3. Processed_Data/key_variables.csv - Subset with only key variables\n")
cat("   Dimensions:", nrow(key_vars_df), "rows,", ncol(key_vars_df), "columns\n")
cat("4. Output/merged_df.rds - R data object for use in subsequent scripts\n")
cat("5. Logs/merge_report.txt - Comprehensive report on the merging process\n")
cat("6. Logs/merge_process.txt - Detailed log of the merging process\n")
cat("7. Logs/02_merge_datasets_output.txt - This summary output file\n\n")

cat("===== NEXT STEPS =====\n")
cat("1. Review the merged dataset for any remaining issues\n")
cat("2. Proceed to 03_prepare_modeling_df.R for final modeling preparation\n")
cat("3. Implement ARIMA and regularization models in subsequent scripts\n\n")

cat("Merge complete! Datasets saved to Processed_Data/ directory.\n")
sink()

message("Merge complete! Datasets saved to Processed_Data/ directory.")
message("RDS file saved to Output/merged_df.rds")
message("Reports saved to Logs/ directory")
message("Proceed to 03_prepare_modeling_df.R for final modeling preparation")

# --- End of script ---
