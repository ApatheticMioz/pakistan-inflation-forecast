# 02_merge_datasets.R
# Pakistan Inflation Forecasting Project: Merging Datasets
# This script merges all relevant datasets on a common monthly time index, handling missing data and frequency mismatches with extreme care.
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
library(dplyr)
library(tidyr)
library(lubridate)
library(zoo)

# --- Load cleaned datasets from code.R ---
# (Assume code.R has been sourced or run, so all cleaned dataframes are in the environment)

# --- Step 1: Extract and standardize time indices ---
# We'll use 'date' or 'observation_date' or 'Date' columns, converting all to yearmon for monthly alignment.

# Helper to extract and standardize date column as 'yearmon'
standardize_date <- function(df) {
  date_col <- intersect(names(df), c("date", "observation_date", "Date"))
  if (length(date_col) == 0) return(NULL)
  d <- df[[date_col[1]]]
  # Try to parse as Date, then as yearmon, then as character
  if (inherits(d, "Date")) {
    ym <- as.yearmon(d)
  } else if (inherits(d, "yearmon")) {
    ym <- d
  } else {
    # Try ymd, dmy, or yearmon string
    ym <- suppressWarnings(as.yearmon(ymd(d)))
    if (all(is.na(ym))) ym <- suppressWarnings(as.yearmon(dmy(d)))
    if (all(is.na(ym))) ym <- suppressWarnings(as.yearmon(d, "%Y-%m"))
  }
  return(ym)
}

# --- Step 2: Prepare all relevant series as time-indexed tibbles ---
# Only include variables needed for modeling (see code.R and guide)

# CPI (target)
cpi_df <- cpi %>%
  mutate(date = standardize_date(cpi)) %>%
  select(date, cpi_yoy = observation_value)

# KIBOR (monthly average of 1M KIBOR)
kibor_df <- kibor %>%
  mutate(date = standardize_date(kibor)) %>%
  filter(grepl("1KIBOR1M|One-Month", series_key) | grepl("1-Month", series_name, ignore.case = TRUE)) %>%
  group_by(date) %>%
  summarize(kibor_1m = mean(observation_value, na.rm = TRUE), .groups = "drop")

# Policy Rate (step function, use last value in month)
policy_rate_df <- policy_rate %>%
  mutate(date = standardize_date(policy_rate)) %>%
  group_by(date) %>%
  summarize(policy_rate = dplyr::last(observation_value), .groups = "drop")

# Exchange Rate (monthly average)
exchange_rate_df <- exchange_rate %>%
  mutate(date = standardize_date(exchange_rate)) %>%
  group_by(date) %>%
  summarize(exchange_rate = mean(observation_value, na.rm = TRUE), .groups = "drop")

# Exports and Imports (total monthly values)
exports_imports_df <- exports_imports %>%
  mutate(date = standardize_date(exports_imports)) %>%
  group_by(date) %>%
  summarize(exports = sum(observation_value[grepl("Export", series_display_name, ignore.case = TRUE)], na.rm = TRUE),
            imports = sum(observation_value[grepl("Import", series_display_name, ignore.case = TRUE)], na.rm = TRUE),
            .groups = "drop")

# Monetary Aggregate (M2, if available)
monetary_aggregate_df <- monetary_aggregate %>%
  mutate(date = standardize_date(monetary_aggregate)) %>%
  filter(grepl("M2", series_display_name, ignore.case = TRUE) | grepl("m2", series_key, ignore.case = TRUE)) %>%
  group_by(date) %>%
  summarize(m2 = sum(observation_value, na.rm = TRUE), .groups = "drop")

# Industrial Production Index (QIM)
industrial_production_df <- industrial_production %>%
  mutate(date = standardize_date(industrial_production)) %>%
  group_by(date) %>%
  summarize(qim = mean(observation_value, na.rm = TRUE), .groups = "drop")

# Oil Prices (Brent, monthly)
oil_prices_df <- oil_prices %>%
  mutate(date = standardize_date(oil_prices)) %>%
  group_by(date) %>%
  summarize(oil_price = mean(mcoilbrenteu, na.rm = TRUE), .groups = "drop")

# Global Food Price Index (monthly)
global_food_df <- global_food %>%
  mutate(date = standardize_date(global_food)) %>%
  group_by(date) %>%
  summarize(global_food_index = mean(`Food Price Index`, na.rm = TRUE), .groups = "drop")

# --- Step 3: Merge all series on the common monthly time index ---
# Start with the union of all dates
all_dates <- sort(unique(c(
  cpi_df$date, kibor_df$date, policy_rate_df$date, exchange_rate_df$date,
  exports_imports_df$date, monetary_aggregate_df$date, industrial_production_df$date,
  oil_prices_df$date, global_food_df$date
)))

merged_df <- tibble(date = all_dates) %>%
  left_join(cpi_df, by = "date") %>%
  left_join(kibor_df, by = "date") %>%
  left_join(policy_rate_df, by = "date") %>%
  left_join(exchange_rate_df, by = "date") %>%
  left_join(exports_imports_df, by = "date") %>%
  left_join(monetary_aggregate_df, by = "date") %>%
  left_join(industrial_production_df, by = "date") %>%
  left_join(oil_prices_df, by = "date") %>%
  left_join(global_food_df, by = "date")

# --- Step 4: Handle missing data with extreme care ---
# Do NOT interpolate or impute yet. Just report missingness for now.
missing_summary <- sapply(merged_df, function(x) sum(is.na(x)))
cat("\nMissing values per variable after merging:\n")
print(missing_summary)

# Save merged dataframe for next steps
saveRDS(merged_df, file = "merged_df.rds")

# --- End of merging script ---
# Next: Prepare modeling dataframe, impute or handle missing data, and perform EDA/visualization.
