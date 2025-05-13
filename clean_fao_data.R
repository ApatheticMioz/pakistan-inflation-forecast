# clean_fao_data.R
# Pakistan Inflation Forecasting Project: FAO Data Cleaning
# This script cleans the FAO Global Food Price Index data file by removing
# unnecessary columns, fixing date formats, and handling missing values.
#
# Purpose:
# 1. Clean the FAO Global Food Price Index data
# 2. Remove unnecessary columns and metadata
# 3. Fix date formats and standardize column names
# 4. Save a clean version for use in the main analysis
#
# Author: <Your Name>
# Date: 2025-05-13

# --- Set working directory to project root (if running interactively) ---
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(readr)      # Fast CSV reading
  library(dplyr)      # Data manipulation
  library(tidyr)      # Data tidying
  library(lubridate)  # Date manipulation
  library(janitor)    # Clean column names
})

# --- Create output directories ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)

# --- Set file paths ---
input_file <- "Data/fao/Global Food Price Index.csv"
output_file <- "Processed_Data/clean_fao_food_price_index.csv"
log_file <- "clean_fao_data_log.txt"

# --- Start logging ---
sink(log_file)
cat("===== FAO GLOBAL FOOD PRICE INDEX CLEANING LOG =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")
cat("Input file:", input_file, "\n")
cat("Output file:", output_file, "\n\n")

# --- Read the original FAO file ---
cat("Reading original FAO file...\n")
tryCatch({
  # Read the file, skipping the first 2 rows (metadata)
  raw_data <- readr::read_csv(input_file, skip = 2, show_col_types = FALSE)
  cat("Successfully read file with dimensions:", nrow(raw_data), "rows,", ncol(raw_data), "columns\n")
  
  # Display the first few rows
  cat("\nFirst 5 rows of raw data:\n")
  print(head(raw_data, 5))
  
  # Check for missing values in the raw data
  na_count <- sum(is.na(raw_data))
  na_pct <- na_count / (nrow(raw_data) * ncol(raw_data)) * 100
  cat("\nMissing values in raw data:", na_count, sprintf("(%.2f%%)", na_pct), "\n")
  
  # Check for empty columns
  empty_cols <- colSums(!is.na(raw_data)) == 0
  cat("Number of completely empty columns:", sum(empty_cols), "\n")
  
}, error = function(e) {
  cat("ERROR: Failed to read the input file:", e$message, "\n")
  sink()
  stop("Failed to read the input file")
})

# --- Clean the data ---
cat("\nCleaning the data...\n")

# 1. Select only the non-empty columns (first 7 columns)
clean_data <- raw_data %>%
  select(1:7)

cat("Selected first 7 columns (non-empty columns)\n")

# 2. Rename columns to standard names
original_names <- names(clean_data)
names(clean_data) <- c("date", "food_price_index", "meat_index", "dairy_index", 
                      "cereals_index", "oils_index", "sugar_index")

cat("Renamed columns:\n")
for (i in 1:length(original_names)) {
  cat("  -", original_names[i], "->", names(clean_data)[i], "\n")
}

# 3. Convert date to proper Date format
cat("\nConverting dates...\n")
clean_data <- clean_data %>%
  mutate(original_date = date,
         date = as.Date(paste0(date, "-01"), format = "%Y-%m-%d"))

cat("Date range:", format(min(clean_data$date, na.rm = TRUE), "%Y-%m-%d"), "to",
    format(max(clean_data$date, na.rm = TRUE), "%Y-%m-%d"), "\n")

# 4. Handle missing values
cat("\nHandling missing values...\n")

# Check for special missing value indicators
special_na_indicators <- c(".", "-", "NA", "N/A", "")

# Replace special NA indicators with actual NA
for (col in names(clean_data)[2:7]) {  # Skip date column
  for (indicator in special_na_indicators) {
    # Count occurrences before replacement
    count_before <- sum(clean_data[[col]] == indicator, na.rm = TRUE)
    if (count_before > 0) {
      clean_data[[col]][clean_data[[col]] == indicator] <- NA
      cat("Replaced", count_before, indicator, "values with NA in column", col, "\n")
    }
  }
}

# Check for missing values after cleaning
na_count_after <- sum(is.na(clean_data))
na_pct_after <- na_count_after / (nrow(clean_data) * ncol(clean_data)) * 100
cat("\nMissing values after cleaning:", na_count_after, sprintf("(%.2f%%)", na_pct_after), "\n")

# 5. Convert all index columns to numeric
cat("\nConverting index columns to numeric...\n")
for (col in names(clean_data)[2:7]) {  # Skip date column
  clean_data[[col]] <- as.numeric(clean_data[[col]])
}

# 6. Remove rows with missing date
clean_data <- clean_data %>%
  filter(!is.na(date))

cat("Removed rows with missing date\n")
cat("Final dimensions:", nrow(clean_data), "rows,", ncol(clean_data), "columns\n")

# --- Save the cleaned data ---
cat("\nSaving cleaned data to", output_file, "...\n")
write_csv(clean_data, output_file)
cat("Successfully saved cleaned data\n")

# --- Generate summary statistics ---
cat("\n===== SUMMARY STATISTICS =====\n")
for (col in names(clean_data)[2:7]) {  # Skip date column
  cat("\nColumn:", col, "\n")
  summary_stats <- summary(clean_data[[col]])
  print(summary_stats)
  
  # Calculate missingness
  na_count_col <- sum(is.na(clean_data[[col]]))
  na_pct_col <- na_count_col / nrow(clean_data) * 100
  cat("Missing values:", na_count_col, sprintf("(%.2f%%)", na_pct_col), "\n")
}

# --- Generate validation report ---
cat("\n===== VALIDATION REPORT =====\n")

# Check for duplicate dates
duplicate_dates <- clean_data %>%
  group_by(date) %>%
  filter(n() > 1) %>%
  pull(date) %>%
  unique()

if (length(duplicate_dates) > 0) {
  cat("WARNING: Found", length(duplicate_dates), "duplicate dates\n")
  print(duplicate_dates)
} else {
  cat("No duplicate dates found\n")
}

# Check for gaps in monthly data
dates <- clean_data$date
date_diffs <- diff(dates)
gaps <- which(date_diffs > 31)

if (length(gaps) > 0) {
  cat("WARNING: Found", length(gaps), "gaps in monthly data\n")
  for (i in gaps) {
    cat("Gap between", format(dates[i], "%Y-%m-%d"), "and", format(dates[i+1], "%Y-%m-%d"), 
        ":", date_diffs[i], "days\n")
  }
} else {
  cat("No gaps found in monthly data\n")
}

# --- Finish logging ---
cat("\n===== CLEANING PROCESS COMPLETED =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Input file:", input_file, "\n")
cat("Output file:", output_file, "\n")
cat("Original dimensions:", nrow(raw_data), "rows,", ncol(raw_data), "columns\n")
cat("Final dimensions:", nrow(clean_data), "rows,", ncol(clean_data), "columns\n")
cat("Missing values reduced from", sprintf("%.2f%%", na_pct), "to", sprintf("%.2f%%", na_pct_after), "\n")
sink()

# Print completion message
message("FAO data cleaning complete!")
message("Output file saved:", output_file)
message("Log file saved:", log_file)

# --- End of script ---
