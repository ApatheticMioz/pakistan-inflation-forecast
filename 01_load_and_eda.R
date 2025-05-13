# 01_load_and_eda.R
# Pakistan Inflation Forecasting Project: Data Loading and EDA
# This script loads all datasets, performs EDA, and saves outputs for further analysis.
#
# Purpose:
# 1. Load data from various sources (SBP, FAO, FRED, Finance.gov.pk)
# 2. Clean and standardize datasets
# 3. Perform exploratory data analysis
# 4. Save processed datasets for modeling
#
# Author: <Your Name>
# Date: 2025-05-13
#
# NOTES FOR DEMO:
# - This is the foundation of our entire analysis - careful data loading and cleaning is crucial
# - Pakistani datasets often have inconsistent missing value representations (hashtags, dots, etc.)
# - We're implementing thorough validation checks to ensure data quality
# - The summary statistics will help us understand the distribution of each variable
# - Box plots and scatter plots will help identify outliers and relationships between variables
# - We need at least 5 independent variables with 35+ observations for robust modeling

# --- Set working directory to project root (if running interactively) ---
# This ensures consistent file paths regardless of where the script is run from
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# Load required libraries - I've organized these by purpose for clarity
suppressPackageStartupMessages({
  # Data manipulation
  library(readr)      # Fast CSV reading
  library(dplyr)      # Data manipulation
  library(tidyr)      # Data tidying
  library(janitor)    # Clean column names

  # Date handling
  library(lubridate)  # Date manipulation
  library(zoo)        # Time series objects

  # Visualization and analysis
  library(ggplot2)    # Plotting
  library(VIM)        # Missingness visualization
  library(tseries)    # Time series tests
  library(forecast)   # Forecasting functions

  # Utilities
  library(tools)      # File utilities
})

# Create output directories - for plots and processed data
dir.create("Plots", showWarnings = FALSE, recursive = TRUE)
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)

# --- Set data directory paths ---
# Organized by data source for clarity during the demo
main_data_dir <- "Data"
combined_data_dir <- file.path(main_data_dir, "data_combined")  # Combined datasets
easydata_dir <- file.path(main_data_dir, "easydata")            # State Bank of Pakistan
fao_dir <- file.path(main_data_dir, "fao")                      # Food and Agriculture Org
fred_dir <- file.path(main_data_dir, "fred")                    # Federal Reserve Economic Data
finance_dir <- file.path(main_data_dir, "finanaceGovPk")        # Pakistan Ministry of Finance
old_data_dir <- file.path(main_data_dir, "old_data")            # Legacy datasets

# --- Source-specific Data Loading Functions ---
# I've created specialized loaders for each data source to handle their unique formats
# These functions are critical for ensuring data consistency across sources

# Helper function to standardize column names
standardize_names <- function(df) {
  names(df) <- tolower(gsub("[ .-]", "_", names(df)))
  return(df)
}

# Helper function to convert columns to numeric
convert_to_numeric <- function(df, exclude_cols = c()) {
  for (col in setdiff(names(df), exclude_cols)) {
    if (!is.numeric(df[[col]])) {
      df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
    }
  }
  return(df)
}

# Load data from State Bank of Pakistan's EasyData portal
load_easydata <- function(filename) {
  # Handle SBP EasyData format - typically has observation_date and observation_value columns
  message(paste("Loading EasyData file:", basename(filename)))
  tryCatch({
    # Special handling for CPI data
    if (grepl("CPI National", basename(filename), ignore.case = TRUE)) {
      message("Special handling for CPI data")
      # Read CSV with custom NA strings
      na_strings <- c("NA", "N/A", "n/a", "#", ".", "-", "", "NULL", "null", "MISSING", "missing")
      df <- readr::read_csv(filename, na = na_strings, show_col_types = FALSE) %>%
        standardize_names()

      # Handle date column - SBP uses various date formats
      if ("observation_date" %in% names(df)) {
        df$observation_date <- as.Date(parse_date_time(df$observation_date, orders = c("dmy", "ymd")))
        df$date <- df$observation_date  # Add standard date column
      }

      # Ensure observation_value is numeric
      if ("observation_value" %in% names(df)) {
        df$observation_value <- as.numeric(df$observation_value)
        # Print some debug info
        message("CPI data loaded: ", nrow(df), " rows, observation_value range: ",
                min(df$observation_value, na.rm = TRUE), " to ",
                max(df$observation_value, na.rm = TRUE))
      }
    } else {
      # Standard handling for other EasyData files
      df <- readr::read_csv(filename, show_col_types = FALSE) %>%
        standardize_names()

      # Handle date column - SBP uses various date formats
      if ("observation_date" %in% names(df)) {
        df$observation_date <- as.Date(parse_date_time(df$observation_date, orders = c("dmy", "ymd")))
        df$date <- df$observation_date  # Add standard date column
      }

      # Ensure observation_value is numeric
      if ("observation_value" %in% names(df)) {
        df$observation_value <- as.numeric(df$observation_value)
      }
    }

    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

# Load data from Food and Agriculture Organization
load_fao <- function(filename) {
  # Handle FAO format - typically has Date column and various metadata rows
  message(paste("Loading FAO file:", basename(filename)))

  # Check if we have a cleaned version of the file
  clean_fao_file <- file.path("Processed_Data", "clean_fao_food_price_index.csv")

  # If the file is the Global Food Price Index and we have a cleaned version, use that
  if (basename(filename) == "Global Food Price Index.csv" && file.exists(clean_fao_file)) {
    message("Using pre-cleaned FAO data file")
    tryCatch({
      df <- readr::read_csv(clean_fao_file, show_col_types = FALSE)
      # Ensure date is properly formatted
      if ("date" %in% names(df) && !inherits(df$date, "Date")) {
        df$date <- as.Date(df$date)
      }
      return(df)
    }, error = function(e) {
      warning(paste("Error loading cleaned FAO file:", e$message, "- Falling back to original file"))
      # Fall through to standard loading if clean file can't be loaded
    })
  }

  # Standard loading procedure for FAO files
  tryCatch({
    # Find the header line by looking for "Date" in the first few rows
    lines <- readLines(filename)
    header_line <- which(grepl("^Date,|^Date\\s", lines))[1]
    if (is.na(header_line)) header_line <- which(grepl("Date|Month|Year", lines))[1]

    # Handle special missing value indicators
    na_strings <- c("NA", "N/A", "n/a", "#", ".", "-", "", "NULL", "null", "MISSING", "missing")

    # Read CSV starting from the header line
    df <- readr::read_csv(filename, skip = header_line - 1, col_names = TRUE,
                         na = na_strings, show_col_types = FALSE)
    df <- df[!is.na(df$Date) & df$Date != "", ]  # Remove rows with empty dates

    # For FAO Global Food Price Index, select only the first 7 columns (others are empty)
    if (basename(filename) == "Global Food Price Index.csv" && ncol(df) > 7) {
      df <- df[, 1:7]
      # Rename columns to standard names
      if (ncol(df) == 7) {
        names(df) <- c("Date", "food_price_index", "meat_index", "dairy_index",
                      "cereals_index", "oils_index", "sugar_index")
      }
    }

    # Try multiple date formats - FAO uses various formats
    if ("Date" %in% names(df)) {
      # For FAO Global Food Price Index, we know it's in YYYY-MM format
      if (basename(filename) == "Global Food Price Index.csv") {
        df$date <- as.Date(paste0(df$Date, "-01"), format = "%Y-%m-%d")
      } else {
        # Try common formats for other FAO files
        formats <- c("%Y-%m", "%b-%Y", "%Y-%m-%d", "%m/%Y", "%Y/%m")
        for (fmt in formats) {
          parsed_dates <- suppressWarnings(as.Date(as.yearmon(df$Date, fmt)))
          if (!all(is.na(parsed_dates))) {
            df$date <- parsed_dates
            break
          }
        }

        # Fallback to yearmon if all formats fail
        if (!"date" %in% names(df) || all(is.na(df$date))) {
          df$date <- as.Date(as.yearmon(df$Date))
        }
      }
    }

    # Convert all non-date columns to numeric
    df <- convert_to_numeric(df, exclude_cols = c("Date", "date"))

    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

# Load data from Federal Reserve Economic Data
load_fred <- function(filename) {
  # Handle FRED format - typically has observation_date column
  message(paste("Loading FRED file:", basename(filename)))
  tryCatch({
    # Read CSV and standardize column names
    df <- readr::read_csv(filename, show_col_types = FALSE) %>%
      standardize_names()

    # Handle date column - FRED uses ISO format
    if ("observation_date" %in% names(df)) {
      df$observation_date <- as.Date(df$observation_date)
      df$date <- df$observation_date  # Add standard date column
    }

    # Convert all non-date columns to numeric
    df <- convert_to_numeric(df, exclude_cols = c("observation_date", "date"))

    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

# Load data from Pakistan Ministry of Finance
load_financegovpk <- function(filename) {
  # Handle finance.gov.pk format - typically has fiscal year columns
  message(paste("Loading Finance.gov.pk file:", basename(filename)))
  tryCatch({
    # Read CSV and standardize column names
    df <- readr::read_csv(filename, show_col_types = FALSE) %>%
      standardize_names()

    # Try to identify fiscal year column
    fiscal_cols <- grep("fiscal|year", names(df), ignore.case = TRUE)
    if (length(fiscal_cols) > 0) {
      fiscal_col <- fiscal_cols[1]
      fiscal_years <- df[[names(df)[fiscal_col]]]

      # Extract start year from fiscal year format (e.g., "2013-14")
      # In Pakistan, fiscal year runs from July to June
      start_years <- suppressWarnings(as.numeric(substr(fiscal_years, 1, 4)))
      if (!all(is.na(start_years))) {
        # Use July 1st of the start year as the date
        df$date <- as.Date(paste0(start_years, "-07-01"))
      }
    }

    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

# Auto-detect file format and load accordingly
load_olddata <- function(filename) {
  # Smart loader that detects file format and uses appropriate loader
  message(paste("Loading old data file:", basename(filename)))

  # Read a few lines to detect format
  tryCatch({
    lines <- readLines(filename, n = 10)

    # Detect format based on header patterns
    if (any(grepl("Dataset Name|Series Key", lines))) {
      # SBP EasyData format
      return(load_easydata(filename))
    } else if (any(grepl("observation_date", lines))) {
      # FRED format
      return(load_fred(filename))
    } else if (any(grepl("Date,|Date\\s", lines))) {
      # FAO format
      return(load_fao(filename))
    } else {
      # Generic CSV - try basic loader
      df <- readr::read_csv(filename, show_col_types = FALSE) %>%
        standardize_names()

      # Try to identify date columns
      date_cols <- grep("date|time|month|year", names(df), ignore.case = TRUE)
      if (length(date_cols) > 0) {
        date_col <- names(df)[date_cols[1]]
        df$date <- suppressWarnings(as.Date(parse_date_time(df[[date_col]],
                                                           orders = c("ymd", "dmy", "mdy"))))
      }

      return(df)
    }
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

# --- Function to load all data by source ---
load_all_by_source <- function() {
  # Load data from each source directory
  easydata_files <- list.files(easydata_dir, full.names = TRUE, pattern = "*.csv")
  easydata <- lapply(easydata_files, load_easydata)
  names(easydata) <- basename(easydata_files)

  fao_files <- list.files(fao_dir, full.names = TRUE, pattern = "*.csv")
  fao <- lapply(fao_files, load_fao)
  names(fao) <- basename(fao_files)

  finance_files <- list.files(finance_dir, full.names = TRUE, pattern = "*.csv")
  financegovpk <- lapply(finance_files, load_financegovpk)
  names(financegovpk) <- basename(finance_files)

  fred_files <- list.files(fred_dir, full.names = TRUE, pattern = "*.csv")
  fred <- lapply(fred_files, load_fred)
  names(fred) <- basename(fred_files)

  olddata_files <- list.files(old_data_dir, full.names = TRUE, pattern = "*.csv")
  old_data <- lapply(olddata_files, load_olddata)
  names(old_data) <- basename(olddata_files)

  return(list(
    easydata = easydata,
    fao = fao,
    financegovpk = financegovpk,
    fred = fred,
    old_data = old_data
  ))
}

# --- Load data from combined directory ---
# This is the main data loading section that creates key dataframes
# I've organized this to load all critical economic indicators needed for our model
message("Loading combined data files...")

# Create Logs directory if it doesn't exist
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# For demo purposes, we'll print key information to the console instead of a log file
message("===== PAKISTAN INFLATION FORECASTING PROJECT =====")
message("===== DATA LOADING AND EDA =====")
message("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
message("This script loads all datasets, performs EDA, and saves outputs for further analysis.")

# Create a function to safely load files with proper error handling and logging
# DEMO NOTE: This function handles different file formats and provides detailed error messages
safe_load <- function(file_path, loader_function, description) {
  message("Loading:", basename(file_path), " - ", description)

  if (file.exists(file_path)) {
    tryCatch({
      result <- loader_function(file_path)
      if (!is.null(result)) {
        message("  SUCCESS:", nrow(result), "rows,", ncol(result), "columns")
        if ("date" %in% names(result)) {
          message("  Date range:", format(min(result$date, na.rm = TRUE), "%Y-%m-%d"), "to",
                format(max(result$date, na.rm = TRUE), "%Y-%m-%d"))
        }
        return(result)
      } else {
        message("  FAILURE: Loader returned NULL - possible format issue or data corruption")
        return(NULL)
      }
    }, error = function(e) {
      message("  ERROR:", e$message)
      return(NULL)
    })
  } else {
    message("  FAILURE: File not found")
    return(NULL)
  }
}

# Initialize datasets list
datasets <- list()

# --- DEPENDENT VARIABLE (TARGET) ---
message("\n===== LOADING TARGET VARIABLE =====\n")

# CPI - our primary target variable
datasets$cpi <- safe_load(
  file.path(combined_data_dir, "CPI National -YoY.csv"),
  load_easydata,
  "Consumer Price Index (CPI) - Year-on-Year percentage change, our target variable for inflation forecasting"
)

# Core inflation - alternative target variable
datasets$core_inflation <- safe_load(
  file.path(combined_data_dir, "Core Inflation NFNE.csv"),
  load_easydata,
  "Non-Food Non-Energy (NFNE) Core Inflation - Measures underlying inflation by excluding volatile components"
)

# --- MONETARY VARIABLES ---
message("\n===== LOADING MONETARY VARIABLES =====\n")

# KIBOR - Karachi Interbank Offered Rate
datasets$kibor <- safe_load(
  file.path(combined_data_dir, "KIBOR.csv"),
  load_easydata,
  "Karachi Interbank Offered Rate - Key interest rate in Pakistan's money market"
)

# Policy Rate - SBP's key monetary policy tool
datasets$policy_rate <- safe_load(
  file.path(combined_data_dir, "Policy Rate.csv"),
  load_easydata,
  "SBP Policy Rate - Central bank's key interest rate for monetary policy"
)

# Money Supply - M2 (Broad Money)
datasets$monetary_aggregate <- safe_load(
  file.path(combined_data_dir, "Monthly Monetary Aggregate.csv"),
  load_easydata,
  "Monetary Aggregates - Includes M2 (Broad Money) which affects inflation through quantity theory of money"
)

# T-Bills - Short-term government securities
datasets$t_bills <- safe_load(
  file.path(combined_data_dir, "T-Bills Rates.csv"),
  load_easydata,
  "Treasury Bills Rates - Short-term government securities rates, indicator of monetary conditions"
)

# --- EXTERNAL SECTOR VARIABLES ---
message("\n===== LOADING EXTERNAL SECTOR VARIABLES =====\n")

# Exchange Rate - PKR/USD
datasets$exchange_rate <- safe_load(
  file.path(combined_data_dir, "Pakistan Exchange Rate Per USD.csv"),
  load_easydata,
  "PKR/USD Exchange Rate - Critical for imported inflation and overall price levels"
)

# Exports and Imports
datasets$exports_imports <- safe_load(
  file.path(combined_data_dir, "Exports and Imports.csv"),
  load_easydata,
  "Exports and Imports - Trade data affecting balance of payments and exchange rate pressures"
)

# Current Account Balance
datasets$current_account_balance <- safe_load(
  file.path(combined_data_dir, "Current Account Balance.csv"),
  load_financegovpk,
  "Current Account Balance - Broader measure of external balance affecting exchange rate stability"
)

# Foreign Exchange Reserves
datasets$forex_reserves <- safe_load(
  file.path(combined_data_dir, "Foreign Exchange Reserves.csv"),
  load_easydata,
  "Foreign Exchange Reserves - Buffer against external shocks, affects exchange rate stability"
)

# --- REAL SECTOR VARIABLES ---
message("\n===== LOADING REAL SECTOR VARIABLES =====\n")

# Industrial Production (QIM)
datasets$industrial_production <- safe_load(
  file.path(combined_data_dir, "Industrial Production Index.csv"),
  load_easydata,
  "Quantum Index of Manufacturing (QIM) - Measure of industrial output, indicator of economic activity"
)

# GDP Growth
datasets$growth_rate <- safe_load(
  file.path(combined_data_dir, "Growth Rate.csv"),
  load_financegovpk,
  "GDP Growth Rate - Overall economic growth, related to inflation through Phillips curve"
)

# Sectoral GDP Shares
datasets$pakistan_share_gdp <- safe_load(
  file.path(combined_data_dir, "Pakistan's Share in GDP.csv"),
  load_financegovpk,
  "Sectoral Shares in GDP - Structure of economy affecting inflation dynamics"
)

# Consumption and Investment
datasets$consumption_investment_gdp <- safe_load(
  file.path(combined_data_dir, "Consumption and Invesment of GDP.csv"),
  load_financegovpk,
  "Consumption and Investment - Components of aggregate demand affecting inflation"
)

# --- GLOBAL FACTORS ---
message("\n===== LOADING GLOBAL FACTORS =====\n")

# International Oil Prices
datasets$oil_prices <- safe_load(
  file.path(combined_data_dir, "International Oil Prices.csv"),
  load_fred,
  "Brent Crude Oil Prices - Major global factor affecting domestic energy prices and transportation costs"
)

# Global Food Price Index
datasets$global_food <- safe_load(
  file.path(combined_data_dir, "Global Food Price Index.csv"),
  load_fao,
  "FAO Food Price Index - Global food prices affecting domestic food inflation, which has high weight in Pakistan's CPI"
)

# --- ADDITIONAL/LEGACY DATASETS ---
message("\n===== LOADING ADDITIONAL/LEGACY DATASETS =====\n")

# Check for inflation_base_2015.csv in both locations
combined_inflation_file <- file.path(combined_data_dir, "inflation_base_2015.csv")
old_inflation_file <- file.path(old_data_dir, "inflation_base_2015.csv")

# Try combined directory first, then old_data
if (file.exists(combined_inflation_file)) {
  datasets$inflation_base_2015 <- safe_load(
    combined_inflation_file,
    load_olddata,
    "Inflation Base 2015 - Alternative CPI series with 2015 base year"
  )
} else if (file.exists(old_inflation_file)) {
  datasets$inflation_base_2015 <- safe_load(
    old_inflation_file,
    load_olddata,
    "Inflation Base 2015 - Alternative CPI series with 2015 base year (from old_data)"
  )
} else {
  cat("\n--- LOADING: inflation_base_2015.csv ---\n")
  cat("Description: Inflation Base 2015 - Alternative CPI series with 2015 base year\n")
  cat("Status: File NOT FOUND in either location\n")
  cat("Result: FAILURE\n")
}

# Check for additional datasets in old_data directory
message("\n===== CHECKING OLD_DATA DIRECTORY FOR ADDITIONAL DATASETS =====\n")

# T-Bills from old_data
old_t_bills_path <- file.path(old_data_dir, "t_bills.csv")
if (!("t_bills" %in% names(datasets)) || is.null(datasets$t_bills)) {
  datasets$t_bills <- safe_load(
    old_t_bills_path,
    load_olddata,
    "Treasury Bills Rates from old_data - Alternative source for T-Bills rates"
  )
}

# Foreign reserves from old_data
old_reserves_path <- file.path(old_data_dir, "gold_foreign_exchange_reserves.csv")
if (!("forex_reserves" %in% names(datasets)) || is.null(datasets$forex_reserves)) {
  datasets$forex_reserves <- safe_load(
    old_reserves_path,
    load_olddata,
    "Foreign Exchange Reserves from old_data - Alternative source for forex reserves"
  )
}

# Remove any NULL datasets
null_datasets <- names(datasets)[sapply(datasets, is.null)]
if (length(null_datasets) > 0) {
  message("\n===== REMOVING NULL DATASETS =====\n")
  message("The following datasets could not be loaded and will be removed:",
      paste(null_datasets, collapse = ", "))
  datasets <- datasets[!sapply(datasets, is.null)]
}

# Summary of loaded datasets
message("\n===== DATA LOADING SUMMARY =====\n")
message("Total datasets attempted: ", length(null_datasets) + length(datasets))
message("Successfully loaded datasets: ", length(datasets))
message("Failed to load datasets: ", length(null_datasets))
message("\nSuccessfully loaded dataset names:")
message(paste("- ", names(datasets), collapse = "\n"))

message(paste("Successfully loaded", length(datasets), "datasets"))

# --- Load all data by source for comprehensive EDA ---
# This loads ALL files for thorough EDA
message("Loading all data from all sources...")
all_datasets <- load_all_by_source()

# --- Clean column names and parse dates for all datasets ---
# Note: This is a critical step for data consistency. I've made it robust to handle
# various date formats and ensure all datasets have a standardized structure.
message("Cleaning datasets and summarizing...")
eda_summary <- list()

# Define a function to clean each dataset - handles date parsing, duplicates, and missingness
clean_dataset <- function(df, name) {
  if (is.null(df)) {
    message(paste("Skipping NULL dataset:", name))
    return(NULL)
  }

  # Clean column names - makes them R-friendly
  df <- janitor::clean_names(df)

  # Identify and standardize date column - crucial for time series analysis
  date_cols <- grep("date|time|month|year", names(df), ignore.case = TRUE)
  if (length(date_cols) > 0 && "date" %in% names(df)) {
    # Use existing date column if present
    date_col <- "date"
  } else if (length(date_cols) > 0) {
    # Use first date-like column
    date_col <- names(df)[date_cols[1]]
    df$date <- df[[date_col]]
  } else {
    # No date column found
    date_col <- NULL
  }

  # Attempt to parse date if it exists and isn't already a Date
  # Try multiple formats to be robust - important for merging later
  if (!is.null(date_col) && !inherits(df$date, "Date")) {
    # First try lubridate's parse_date_time with common formats
    date_formats <- c("ymd", "dmy", "mdy")
    for (fmt in date_formats) {
      parsed_dates <- suppressWarnings(parse_date_time(df$date, orders = fmt))
      if (!all(is.na(parsed_dates))) {
        df$date <- as.Date(parsed_dates)
        break
      }
    }

    # If parsing failed, try yearmon for monthly data
    if (!inherits(df$date, "Date")) {
      tryCatch({
        df$date <- as.Date(as.yearmon(df$date))
      }, error = function(e) {
        message(paste("Warning: Could not parse dates in", name))
      })
    }
  }

  # Remove duplicate rows - important for data quality
  n_before <- nrow(df)
  df <- distinct(df)
  n_after <- nrow(df)

  # Get date range if date column exists - useful for EDA
  date_range <- if ("date" %in% names(df) && inherits(df$date, "Date")) {
    range(df$date, na.rm = TRUE)
  } else {
    c(NA, NA)
  }

  # Calculate missingness - helps identify data quality issues
  miss <- sapply(df, function(x) sum(is.na(x)))

  # Save summary for reporting
  eda_summary[[name]] <<- list(
    n_before = n_before,
    n_after = n_after,
    date_range = date_range,
    missing = miss,
    variables = names(df)
  )

  return(df)
}

# Apply cleaning function to each dataset
# Note: Using a named list approach to avoid the deparse(substitute()) issue
cleaned_datasets <- list()
for (name in names(datasets)) {
  cleaned_datasets[[name]] <- clean_dataset(datasets[[name]], name)
}
datasets <- cleaned_datasets

# --- Create output files for EDA results ---
# These files will help us understand the data structure and quality
# I've organized them by purpose for easy reference during the demo
message("Writing EDA output files...")

# Create Logs directory if it doesn't exist
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# Define output file paths
eda_output_file <- "Logs/eda_output.txt"           # Main EDA summary
colnames_output_file <- "Logs/eda_colnames.txt"    # Column names reference
all_data_eda_file <- "Logs/eda_all_csvs_output.txt" # All source files summary
eda_target_file <- "Logs/eda_target_analysis.txt"  # Detailed analysis of target variable
eda_correlation_file <- "Logs/eda_correlation_analysis.txt" # Correlation analysis

# --- Generate main EDA summary file ---
# This file contains detailed analysis of each dataset
sink(eda_output_file)
cat("===== PAKISTAN INFLATION FORECASTING PROJECT =====\n")
cat("===== EXPLORATORY DATA ANALYSIS SUMMARY =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Loop through each dataset and generate summary
dataset_names <- names(datasets)
for (name in dataset_names) {
  df <- datasets[[name]]
  if (is.null(df)) {
    cat("\n===== ", name, " =====\n")
    cat("NULL dataset - file may be missing or corrupted\n")
    next
  }

  # Dataset overview
  cat("\n===== ", name, " =====\n")
  cat("Dimensions:", dim(df), "\n")
  cat("Variables:", paste(names(df), collapse = ", "), "\n\n")

  # Sample data - useful for understanding structure
  cat("Sample data (first 3 rows):\n")
  print(head(df, 3))
  cat("\n")

  cat("Sample data (last 3 rows):\n")
  print(tail(df, 3))
  cat("\n")

  # Statistical summary - key for understanding distributions
  cat("Summary statistics:\n")
  print(summary(df))
  cat("\n")

  # Data quality metrics
  cat("Data quality metrics:\n")
  cat("- Missing values by column:\n")
  missing_counts <- eda_summary[[name]]$missing
  missing_pct <- round(missing_counts / nrow(df) * 100, 2)
  missing_df <- data.frame(
    Column = names(missing_counts),
    Missing_Count = missing_counts,
    Missing_Percent = missing_pct
  )
  print(missing_df[missing_df$Missing_Count > 0, ])

  # Duplicate handling results
  cat("\n- Duplicate rows removed:",
      eda_summary[[name]]$n_before - eda_summary[[name]]$n_after,
      "out of", eda_summary[[name]]$n_before,
      sprintf("(%.2f%%)", (eda_summary[[name]]$n_before - eda_summary[[name]]$n_after) /
                eda_summary[[name]]$n_before * 100), "\n")

  # Time range - important for time series analysis
  if (all(!is.na(eda_summary[[name]]$date_range))) {
    date_range <- eda_summary[[name]]$date_range
    cat("- Date range:", format(date_range[1], "%Y-%m-%d"), "to",
        format(date_range[2], "%Y-%m-%d"),
        sprintf("(%d months)", round(difftime(date_range[2], date_range[1], units = "days") / 30.44)), "\n")
  }

  # Time series properties for key variables
  if ("date" %in% names(df) && "observation_value" %in% names(df) && is.numeric(df$observation_value)) {
    cat("\nTime Series Properties (for observation_value):\n")
    tryCatch({
      # Order by date and create time series object
      ordered_df <- df[order(df$date), ]
      ts_data <- ts(ordered_df$observation_value, frequency = 12)

      # Stationarity test - critical for ARIMA modeling
      cat("- ADF Test (stationarity):\n")
      adf_result <- adf.test(ts_data, alternative = "stationary")
      cat("  p-value:", adf_result$p.value,
          ifelse(adf_result$p.value < 0.05,
                 "- Series appears stationary",
                 "- Series appears non-stationary"), "\n")
    }, error = function(e) {
      cat("  Could not perform time series analysis:", e$message, "\n")
    })
  }

  cat("\n", rep("-", 80), "\n", sep = "")
}
sink()

# --- Generate column names reference file ---
# This file provides a quick reference of all variables in each dataset
sink(colnames_output_file)
cat("===== COLUMN NAMES REFERENCE =====\n")
cat("This file provides a quick reference of all variables in each dataset\n\n")

for (name in dataset_names) {
  cat("\n===== ", name, " =====\n")
  df <- datasets[[name]]
  if (is.null(df)) {
    cat("NULL dataset\n")
    next
  }

  # Print column names with types
  col_types <- sapply(df, class)
  col_df <- data.frame(
    Column = names(df),
    Type = col_types,
    stringsAsFactors = FALSE
  )
  print(col_df)
}
sink()

# --- Generate comprehensive source file summary ---
# This file contains information about all individual source files
sink(all_data_eda_file)
cat("===== ALL SOURCE FILES SUMMARY =====\n")
cat("This file provides an overview of all individual source files\n\n")

# Function to describe datasets from a specific source
describe_datasets <- function(dataset_list, source_name) {
  cat("\n\n==================== ", toupper(source_name), " ====================\n")
  cat("Number of files:", length(dataset_list), "\n\n")

  for (name in names(dataset_list)) {
    df <- dataset_list[[name]]
    if (is.null(df)) {
      cat("\n--- ", name, " ---\n")
      cat("NULL dataset - file may be missing or corrupted\n")
      next
    }

    # Basic dataset info
    cat("\n--- ", name, " ---\n")
    cat("Dimensions:", dim(df), "\n")
    cat("Variables:", paste(names(df), collapse = ", "), "\n\n")

    # Sample data
    cat("Sample data:\n")
    print(head(df, 3))
    cat("\n")

    # Basic summary of key columns
    cat("Summary of key columns:\n")
    # Select first 5 columns or fewer if dataset is smaller
    cols_to_summarize <- names(df)[1:min(5, ncol(df))]
    print(summary(df[, cols_to_summarize, drop = FALSE]))
    cat("\n")
  }
}

# Apply the function to each data source
describe_datasets(all_datasets$easydata, "State Bank of Pakistan (EasyData)")
describe_datasets(all_datasets$fao, "Food and Agriculture Organization (FAO)")
describe_datasets(all_datasets$financegovpk, "Pakistan Ministry of Finance")
describe_datasets(all_datasets$fred, "Federal Reserve Economic Data (FRED)")
describe_datasets(all_datasets$old_data, "Legacy Datasets")

sink()

# --- Generate detailed target variable analysis ---
# This file focuses specifically on the inflation data (our target variable)
if (!is.null(datasets$cpi)) {
  sink(eda_target_file)
  cat("===== DETAILED ANALYSIS OF TARGET VARIABLE (INFLATION) =====\n")
  cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

  # Basic information
  cat("1. BASIC INFORMATION\n")
  cat("Dataset: CPI (Consumer Price Index)\n")
  cat("Description: Year-on-Year percentage change in CPI, our target variable for forecasting\n")
  cat("Dimensions:", nrow(datasets$cpi), "rows,", ncol(datasets$cpi), "columns\n")
  if ("date" %in% names(datasets$cpi)) {
    date_range <- range(datasets$cpi$date, na.rm = TRUE)
    cat("Time period:", format(date_range[1], "%Y-%m-%d"), "to",
        format(date_range[2], "%Y-%m-%d"),
        sprintf("(%d months)\n", round(difftime(date_range[2], date_range[1], units = "days") / 30.44)))
  }
  cat("\n")

  # Detailed statistics
  cat("2. DETAILED STATISTICS\n")
  if ("observation_value" %in% names(datasets$cpi)) {
    cpi_values <- datasets$cpi$observation_value
    cat("Min:", min(cpi_values, na.rm = TRUE), "\n")
    cat("Max:", max(cpi_values, na.rm = TRUE), "\n")
    cat("Mean:", mean(cpi_values, na.rm = TRUE), "\n")
    cat("Median:", median(cpi_values, na.rm = TRUE), "\n")
    cat("Standard Deviation:", sd(cpi_values, na.rm = TRUE), "\n")
    cat("Quartiles:\n")
    print(quantile(cpi_values, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))

    # Distribution analysis
    cat("\nDistribution characteristics:\n")
    cat("Skewness:", moments::skewness(cpi_values, na.rm = TRUE),
        "(Positive values indicate right skew, negative values indicate left skew)\n")
    cat("Kurtosis:", moments::kurtosis(cpi_values, na.rm = TRUE),
        "(Values > 3 indicate heavy tails compared to normal distribution)\n")

    # Check for normality
    tryCatch({
      shapiro_test <- shapiro.test(cpi_values)
      cat("Shapiro-Wilk normality test p-value:", shapiro_test$p.value,
          ifelse(shapiro_test$p.value < 0.05,
                 "- Distribution is significantly different from normal",
                 "- Cannot reject normality"), "\n")
    }, error = function(e) {
      cat("Could not perform Shapiro-Wilk test:", e$message, "\n")
    })
  }
  cat("\n")

  # Time series properties
  cat("3. TIME SERIES PROPERTIES\n")
  if ("date" %in% names(datasets$cpi) && "observation_value" %in% names(datasets$cpi)) {
    # Order by date
    ordered_cpi <- datasets$cpi[order(datasets$cpi$date), ]

    # Create time series object
    ts_cpi <- ts(ordered_cpi$observation_value, frequency = 12)

    # Decomposition
    cat("Seasonal decomposition:\n")
    tryCatch({
      decomp <- decompose(ts_cpi)
      cat("- Trend component range:", range(decomp$trend, na.rm = TRUE), "\n")
      cat("- Seasonal component range:", range(decomp$seasonal, na.rm = TRUE), "\n")
      cat("- Random component range:", range(decomp$random, na.rm = TRUE), "\n")

      # Seasonality strength
      seasonal_strength <- max(decomp$seasonal, na.rm = TRUE) - min(decomp$seasonal, na.rm = TRUE)
      cat("- Seasonal strength (max-min):", seasonal_strength, "\n")

      # Trend strength
      trend_range <- max(decomp$trend, na.rm = TRUE) - min(decomp$trend, na.rm = TRUE)
      cat("- Trend strength (max-min):", trend_range, "\n")
    }, error = function(e) {
      cat("Could not perform seasonal decomposition:", e$message, "\n")
    })

    # Stationarity tests
    cat("\nStationarity tests:\n")

    # ADF Test
    tryCatch({
      adf_test <- adf.test(ts_cpi, alternative = "stationary")
      cat("- Augmented Dickey-Fuller Test p-value:", adf_test$p.value,
          ifelse(adf_test$p.value < 0.05,
                 "- Series appears stationary",
                 "- Series appears non-stationary"), "\n")
    }, error = function(e) {
      cat("Could not perform ADF test:", e$message, "\n")
    })

    # KPSS Test
    tryCatch({
      kpss_test <- kpss.test(ts_cpi)
      cat("- KPSS Test p-value:", kpss_test$p.value,
          ifelse(kpss_test$p.value < 0.05,
                 "- Series appears non-stationary",
                 "- Series appears stationary"), "\n")
    }, error = function(e) {
      cat("Could not perform KPSS test:", e$message, "\n")
    })

    # Autocorrelation
    cat("\nAutocorrelation analysis:\n")
    tryCatch({
      # Box-Ljung test for autocorrelation
      box_test <- Box.test(ts_cpi, lag = 12, type = "Ljung-Box")
      cat("- Ljung-Box Test p-value:", box_test$p.value,
          ifelse(box_test$p.value < 0.05,
                 "- Significant autocorrelation present",
                 "- No significant autocorrelation detected"), "\n")

      # Calculate autocorrelations
      acf_values <- acf(ts_cpi, plot = FALSE)
      significant_lags <- which(abs(acf_values$acf[-1]) > qnorm(0.975)/sqrt(length(ts_cpi)))
      if (length(significant_lags) > 0) {
        cat("- Significant autocorrelation at lags:", paste(significant_lags, collapse = ", "), "\n")
      } else {
        cat("- No significant autocorrelation at any lag\n")
      }
    }, error = function(e) {
      cat("Could not perform autocorrelation analysis:", e$message, "\n")
    })
  }
  cat("\n")

  # Implications for modeling
  cat("4. IMPLICATIONS FOR MODELING\n")
  cat("Based on the analysis above, the following considerations are important for modeling:\n")

  # Stationarity implications
  if (exists("adf_test") && adf_test$p.value >= 0.05) {
    cat("- The series appears non-stationary based on the ADF test. Consider differencing or transformation before ARIMA modeling.\n")
  } else if (exists("adf_test")) {
    cat("- The series appears stationary based on the ADF test, which is suitable for ARIMA modeling without differencing.\n")
  }

  # Seasonality implications
  if (exists("decomp") && (max(decomp$seasonal, na.rm = TRUE) - min(decomp$seasonal, na.rm = TRUE)) > 1) {
    cat("- Significant seasonality detected. Consider using SARIMA models or including seasonal dummy variables in regression models.\n")
  } else if (exists("decomp")) {
    cat("- Limited seasonality detected. Simple ARIMA models may be sufficient.\n")
  }

  # Autocorrelation implications
  if (exists("box_test") && box_test$p.value < 0.05) {
    cat("- Significant autocorrelation present. ARIMA models should capture this temporal dependence.\n")
  } else if (exists("box_test")) {
    cat("- Limited autocorrelation detected. Simple AR terms may be sufficient, or consider focusing on exogenous variables.\n")
  }

  # Distribution implications
  if (exists("shapiro_test") && shapiro_test$p.value < 0.05) {
    cat("- Non-normal distribution detected. Consider robust estimation methods or transformations.\n")
  } else if (exists("shapiro_test")) {
    cat("- Distribution appears approximately normal, which is favorable for standard modeling approaches.\n")
  }

  sink()
}

# --- Generate correlation analysis ---
# This file analyzes correlations between inflation and potential predictors
sink(eda_correlation_file)
cat("===== CORRELATION ANALYSIS FOR INFLATION FORECASTING =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Function to extract monthly time series from datasets
extract_monthly_series <- function(df, value_col = "observation_value", name = NULL) {
  if (is.null(df) || !("date" %in% names(df)) || !(value_col %in% names(df))) {
    return(NULL)
  }

  result <- df[, c("date", value_col)]
  names(result)[2] <- ifelse(is.null(name), value_col, name)
  return(result)
}

# Extract key variables
cat("Extracting key variables for correlation analysis...\n")
series_list <- list()

# Target variable (CPI)
if (!is.null(datasets$cpi) && "observation_value" %in% names(datasets$cpi)) {
  series_list$cpi <- extract_monthly_series(datasets$cpi, "observation_value", "cpi")
  cat("- CPI (target variable) extracted\n")
}

# Monetary variables
if (!is.null(datasets$policy_rate) && "observation_value" %in% names(datasets$policy_rate)) {
  series_list$policy_rate <- extract_monthly_series(datasets$policy_rate, "observation_value", "policy_rate")
  cat("- Policy rate extracted\n")
}

# Extract KIBOR (need to handle multiple observations per date)
if (!is.null(datasets$kibor) && "observation_value" %in% names(datasets$kibor)) {
  # Try to find 6-month KIBOR
  if ("series_name" %in% names(datasets$kibor)) {
    kibor_6m <- datasets$kibor[grepl("6 ?months", datasets$kibor$series_name, ignore.case = TRUE), ]
    if (nrow(kibor_6m) > 0) {
      # Aggregate to monthly
      kibor_monthly <- aggregate(observation_value ~ format(date, "%Y-%m-01"),
                                data = kibor_6m, FUN = mean)
      names(kibor_monthly) <- c("date", "kibor_6m")
      kibor_monthly$date <- as.Date(kibor_monthly$date)
      series_list$kibor <- kibor_monthly
      cat("- 6-month KIBOR extracted\n")
    }
  }
}

# Money supply (M2)
if (!is.null(datasets$monetary_aggregate)) {
  # Try to find M2 series
  if ("series_name" %in% names(datasets$monetary_aggregate)) {
    m2_series <- datasets$monetary_aggregate[grepl("M2|Broad Money",
                                                 datasets$monetary_aggregate$series_name,
                                                 ignore.case = TRUE), ]
    if (nrow(m2_series) > 0) {
      series_list$m2 <- extract_monthly_series(m2_series, "observation_value", "m2")
      cat("- M2 money supply extracted\n")
    }
  }
}

# Exchange rate
if (!is.null(datasets$exchange_rate) && "observation_value" %in% names(datasets$exchange_rate)) {
  series_list$exchange_rate <- extract_monthly_series(datasets$exchange_rate, "observation_value", "exchange_rate")
  cat("- Exchange rate extracted\n")
}

# Oil prices
if (!is.null(datasets$oil_prices) && "mcoilbrenteu" %in% names(datasets$oil_prices)) {
  series_list$oil_price <- extract_monthly_series(datasets$oil_prices, "mcoilbrenteu", "oil_price")
  cat("- Oil price extracted\n")
}

# Global food index
if (!is.null(datasets$global_food) && "food_price_index" %in% names(datasets$global_food)) {
  series_list$food_index <- extract_monthly_series(datasets$global_food, "food_price_index", "food_index")
  cat("- Global food price index extracted\n")
}

# Industrial production
if (!is.null(datasets$industrial_production) && "observation_value" %in% names(datasets$industrial_production)) {
  series_list$industrial_production <- extract_monthly_series(datasets$industrial_production,
                                                           "observation_value", "industrial_production")
  cat("- Industrial production extracted\n")
}

# Merge all series into a single dataframe
cat("\nMerging series for correlation analysis...\n")
if (length(series_list) > 0) {
  # Start with the first series
  merged_series <- series_list[[1]]

  # Merge with remaining series
  if (length(series_list) > 1) {
    for (i in 2:length(series_list)) {
      merged_series <- merge(merged_series, series_list[[i]], by = "date", all = TRUE)
    }
  }

  cat("Merged dataframe dimensions:", nrow(merged_series), "rows,", ncol(merged_series), "columns\n")
  cat("Variables:", paste(names(merged_series), collapse = ", "), "\n\n")

  # Calculate correlations
  cat("===== CORRELATION WITH INFLATION (CPI) =====\n\n")
  if ("cpi" %in% names(merged_series)) {
    # Calculate correlations with CPI
    correlations <- sapply(merged_series[, -which(names(merged_series) %in% c("date", "cpi"))],
                         function(x) cor(x, merged_series$cpi, use = "pairwise.complete.obs"))

    # Sort by absolute correlation
    correlations <- sort(correlations, decreasing = TRUE)

    # Print correlations
    cat("Contemporaneous correlations:\n")
    for (i in seq_along(correlations)) {
      cat(sprintf("%2d. %-25s: %6.3f\n", i, names(correlations)[i], correlations[i]))
    }

    # Calculate lagged correlations
    cat("\n===== LAGGED CORRELATIONS WITH INFLATION =====\n")
    cat("(Positive lag means variable leads inflation, negative lag means variable lags inflation)\n\n")

    # Function to calculate lagged correlations
    calc_lagged_cor <- function(x, y, max_lag = 12) {
      lags <- seq(-max_lag, max_lag)
      cors <- numeric(length(lags))

      for (i in seq_along(lags)) {
        lag_val <- lags[i]
        if (lag_val > 0) {
          # x leads y
          cors[i] <- cor(x[1:(length(x)-lag_val)], y[(lag_val+1):length(y)],
                        use = "pairwise.complete.obs")
        } else if (lag_val < 0) {
          # x lags y
          lag_val <- abs(lag_val)
          cors[i] <- cor(x[(lag_val+1):length(x)], y[1:(length(y)-lag_val)],
                        use = "pairwise.complete.obs")
        } else {
          # Contemporaneous
          cors[i] <- cor(x, y, use = "pairwise.complete.obs")
        }
      }

      return(data.frame(lag = lags, correlation = cors))
    }

    # Calculate lagged correlations for key variables
    key_vars <- c("policy_rate", "exchange_rate", "oil_price", "food_index", "industrial_production")
    key_vars <- key_vars[key_vars %in% names(merged_series)]

    for (var in key_vars) {
      cat("\nLagged correlations for", var, "with CPI:\n")
      lagged_cors <- calc_lagged_cor(merged_series[[var]], merged_series$cpi)

      # Find max correlation and corresponding lag
      max_cor_idx <- which.max(abs(lagged_cors$correlation))
      max_cor <- lagged_cors$correlation[max_cor_idx]
      max_lag <- lagged_cors$lag[max_cor_idx]

      cat("Maximum correlation:", round(max_cor, 3), "at lag", max_lag, "months\n")
      cat("(", ifelse(max_lag > 0,
                     paste(var, "leads CPI by", max_lag, "months"),
                     ifelse(max_lag < 0,
                           paste(var, "lags CPI by", abs(max_lag), "months"),
                           "Contemporaneous correlation")), ")\n\n")

      # Print all lagged correlations
      cat("All lagged correlations:\n")
      cat("Lag (months) | Correlation\n")
      cat("--------------------------\n")
      for (i in 1:nrow(lagged_cors)) {
        cat(sprintf("%12d | %10.3f %s\n",
                  lagged_cors$lag[i],
                  lagged_cors$correlation[i],
                  ifelse(i == max_cor_idx, " (maximum)", "")))
      }
      cat("\n")
    }
  } else {
    cat("CPI variable not found in merged dataset. Cannot calculate correlations.\n")
  }
} else {
  cat("No series available for correlation analysis.\n")
}

cat("\n===== IMPLICATIONS FOR MODELING =====\n")
cat("Based on the correlation analysis, consider the following for modeling:\n")

if (exists("correlations") && length(correlations) > 0) {
  # Identify strong contemporaneous correlations
  strong_cors <- names(correlations)[abs(correlations) > 0.5]
  if (length(strong_cors) > 0) {
    cat("1. Strong contemporaneous correlations with CPI:\n")
    cat("   ", paste(strong_cors, collapse = ", "), "\n")
    cat("   These variables should be considered as key predictors in regression models.\n\n")
  } else {
    cat("1. No variables show strong contemporaneous correlations with CPI.\n")
    cat("   Consider using lagged relationships or transformations.\n\n")
  }

  # Identify variables with strong lagged relationships
  if (exists("key_vars") && length(key_vars) > 0) {
    cat("2. Variables with significant lead/lag relationships:\n")
    for (var in key_vars) {
      # Calculate lagged correlations for this variable
      if (var %in% names(merged_series)) {
        var_lagged_cors <- calc_lagged_cor(merged_series[[var]], merged_series$cpi)
        max_cor_idx <- which.max(abs(var_lagged_cors$correlation))
        var_max_cor <- var_lagged_cors$correlation[max_cor_idx]
        var_max_lag <- var_lagged_cors$lag[max_cor_idx]

        if (abs(var_max_cor) > 0.3) {
          cat("   - ", var, ": Maximum correlation at lag", var_max_lag, "months\n")
        }
      }
    }
    cat("   Consider including these variables with appropriate lags in your models.\n\n")
  }

  cat("3. For ARIMAX and regression models:\n")
  cat("   - Include variables with strong correlations as exogenous predictors\n")
  cat("   - Consider using lagged values based on the lag analysis\n")
  cat("   - For variables with changing correlation patterns, consider including interaction terms\n\n")

  cat("4. For regularized regression (Lasso, Ridge, Elastic Net):\n")
  cat("   - Include all variables, even those with moderate correlations\n")
  cat("   - The regularization will automatically select the most relevant predictors\n")
  cat("   - Include various lags to allow the model to select the optimal lag structure\n")
} else {
  cat("Insufficient data for detailed modeling recommendations.\n")
}

sink()

# --- Save cleaned datasets for reproducibility and next steps ---
message("Saving cleaned datasets...")

# Also save all_datasets for potential use in subsequent scripts
saveRDS(datasets, file = "cleaned_datasets.rds")
saveRDS(all_datasets, file = "all_datasets.rds")

# Create a summary output file as required
sink("01_load_and_eda_output.txt")
cat("===== 01_LOAD_AND_EDA.R OUTPUT =====\n")
cat("Execution completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

cat("===== DATASETS LOADED =====\n")
cat("Number of combined datasets:", length(datasets), "\n")
cat("Combined datasets:", paste(names(datasets), collapse = ", "), "\n\n")

cat("Number of datasets by source:\n")
cat("- EasyData (SBP):", length(all_datasets$easydata), "\n")
cat("- FAO:", length(all_datasets$fao), "\n")
cat("- Finance.gov.pk:", length(all_datasets$financegovpk), "\n")
cat("- FRED:", length(all_datasets$fred), "\n")
cat("- Old data:", length(all_datasets$old_data), "\n\n")

cat("===== FILES CREATED =====\n")
cat("1. cleaned_datasets.rds - Cleaned datasets for use in subsequent scripts\n")
cat("2. all_datasets.rds - All datasets by source for reference\n")
cat("3. eda_output.txt - EDA summary for combined datasets\n")
cat("4. eda_colnames.txt - Column names for all datasets\n")
cat("5. eda_all_csvs_output.txt - EDA summary for all individual source files\n")
cat("6. eda_target_analysis.txt - Detailed analysis of the target variable (CPI)\n")
cat("7. eda_correlation_analysis.txt - Correlation analysis between CPI and predictors\n")
cat("8. 01_data_loading_log.txt - Detailed log of the data loading process\n")
cat("9. Various plots in the Plots/ directory\n")
cat("10. 01_load_and_eda_output.txt - This summary output file\n\n")

cat("Data loading and initial EDA completed successfully!\n")
sink()

# --- Generate basic visualizations for key variables ---
message("Generating basic visualizations...")

# Create plots directory
dir.create("Plots", showWarnings = FALSE, recursive = TRUE)

# Plot CPI over time (main target variable)
if (!is.null(datasets$cpi) && "date" %in% names(datasets$cpi) &&
    "observation_value" %in% names(datasets$cpi)) {
  p <- ggplot(datasets$cpi, aes(x = date, y = observation_value)) +
    geom_line() +
    labs(title = "CPI Inflation Rate (Year-on-Year) Over Time",
         x = "Date", y = "Inflation Rate (%)") +
    theme_minimal() +
    theme(plot.title = element_text(size = 14, face = "bold"))

  ggsave("Plots/cpi_inflation_trend.png", p, width = 10, height = 6)

  # Plot ACF and PACF of CPI
  png("Plots/cpi_acf_pacf.png", width = 800, height = 600)
  par(mfrow = c(2, 1))
  acf(datasets$cpi$observation_value, main = "ACF of Inflation Rate")
  pacf(datasets$cpi$observation_value, main = "PACF of Inflation Rate")
  dev.off()
}

# Plot exchange rate over time
if (!is.null(datasets$exchange_rate) && "date" %in% names(datasets$exchange_rate) &&
    "observation_value" %in% names(datasets$exchange_rate)) {
  p <- ggplot(datasets$exchange_rate, aes(x = date, y = observation_value)) +
    geom_line() +
    labs(title = "PKR/USD Exchange Rate Over Time",
         x = "Date", y = "Exchange Rate") +
    theme_minimal() +
    theme(plot.title = element_text(size = 14, face = "bold"))

  ggsave("Plots/exchange_rate_trend.png", p, width = 10, height = 6)
}

# Plot oil prices over time
if (!is.null(datasets$oil_prices) && "date" %in% names(datasets$oil_prices) &&
    "mcoilbrenteu" %in% names(datasets$oil_prices)) {
  p <- ggplot(datasets$oil_prices, aes(x = date, y = mcoilbrenteu)) +
    geom_line() +
    labs(title = "Brent Crude Oil Price Over Time",
         x = "Date", y = "Price (USD/barrel)") +
    theme_minimal() +
    theme(plot.title = element_text(size = 14, face = "bold"))

  ggsave("Plots/oil_price_trend.png", p, width = 10, height = 6)
}

# Missingness visualization for main datasets
for (name in c("cpi", "exchange_rate", "oil_prices", "global_food")) {
  df <- datasets[[name]]
  if (!is.null(df) && ncol(df) > 2) {
    tryCatch({
      png(paste0("Plots/missingness_", name, ".png"), width = 800, height = 600)
      VIM::aggr(df, numbers = TRUE, sortVars = TRUE, cex.axis = 0.7, gap = 3,
                ylab = c("Missing data", "Pattern"))
      dev.off()
    }, error = function(e) {
      message(paste("Could not create missingness plot for", name, ":", e$message))
    })
  }
}

# Create Output and Processed_Data directories if they don't exist
dir.create("Output", showWarnings = FALSE, recursive = TRUE)
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)

# Generate comprehensive summary statistics for all numeric variables
generate_summary_stats <- function(df, name) {
  cat("\nGenerating comprehensive summary statistics for", name, "...\n")

  # Identify numeric columns
  numeric_cols <- sapply(df, is.numeric)
  if (sum(numeric_cols) == 0) return(NULL)

  # Initialize results dataframe
  result <- data.frame(
    Dataset = character(),
    Variable = character(),
    Mean = numeric(),
    Median = numeric(),
    Mode = character(),
    Min = numeric(),
    Q1 = numeric(),
    Q2 = numeric(),
    Q3 = numeric(),
    Max = numeric(),
    SD = numeric(),
    IQR = numeric(),
    stringsAsFactors = FALSE
  )

  # Calculate statistics for each numeric column
  for (col in names(df)[numeric_cols]) {
    x <- df[[col]]
    if (all(is.na(x))) next

    # Calculate mode (most frequent value)
    tab <- table(x)
    if (length(tab) > 0) {
      mode_val <- as.numeric(names(tab)[which.max(tab)])
      if (length(mode_val) == 0 || is.na(mode_val)) mode_val <- NA
    } else {
      mode_val <- NA
    }

    # Calculate quartiles
    quants <- quantile(x, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)

    # Add to results
    result <- rbind(result, data.frame(
      Dataset = name,
      Variable = col,
      Mean = mean(x, na.rm = TRUE),
      Median = median(x, na.rm = TRUE),
      Mode = as.character(mode_val),
      Min = min(x, na.rm = TRUE),
      Q1 = quants[1],
      Q2 = quants[2],
      Q3 = quants[3],
      Max = max(x, na.rm = TRUE),
      SD = sd(x, na.rm = TRUE),
      IQR = IQR(x, na.rm = TRUE)
    ))
  }

  return(result)
}

# Generate summary statistics for key datasets
message("Generating comprehensive summary statistics...")
all_stats_list <- list()

# CPI dataset
if (!is.null(datasets$cpi)) {
  all_stats_list$cpi <- generate_summary_stats(datasets$cpi, "CPI")
}

# Exchange rate dataset
if (!is.null(datasets$exchange_rate)) {
  all_stats_list$exchange_rate <- generate_summary_stats(datasets$exchange_rate, "Exchange_Rate")
}

# Oil prices dataset
if (!is.null(datasets$oil_prices)) {
  all_stats_list$oil_prices <- generate_summary_stats(datasets$oil_prices, "Oil_Prices")
}

# Global food dataset
if (!is.null(datasets$global_food)) {
  all_stats_list$global_food <- generate_summary_stats(datasets$global_food, "Global_Food")
}

# Policy rate dataset
if (!is.null(datasets$policy_rate)) {
  all_stats_list$policy_rate <- generate_summary_stats(datasets$policy_rate, "Policy_Rate")
}

# KIBOR dataset
if (!is.null(datasets$kibor)) {
  all_stats_list$kibor <- generate_summary_stats(datasets$kibor, "KIBOR")
}

# Combine all statistics
all_stats <- do.call(rbind, all_stats_list)

# Save summary statistics
write.csv(all_stats, "Processed_Data/summary_statistics.csv", row.names = FALSE)
message("Comprehensive summary statistics saved to Processed_Data/summary_statistics.csv")

# Save as RDS for use in subsequent scripts
dir.create("Output", showWarnings = FALSE, recursive = TRUE)
saveRDS(datasets, "Output/all_datasets.rds")
saveRDS(cleaned_datasets, "Output/cleaned_datasets.rds")

# Print summary information to console
message("===== PAKISTAN INFLATION FORECASTING PROJECT =====")
message("===== DATA LOADING AND EDA SUMMARY =====")
message("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
message("Successfully loaded", length(datasets), "datasets")
message("Datasets saved to Output/all_datasets.rds and Output/cleaned_datasets.rds")
message("Plots saved to Plots/ directory")

message("Data loading and initial EDA completed successfully!")
message("Output files saved to Logs/ directory")
message("RDS files saved to Output/ directory")
message("Proceed to 02_merge_datasets.R for data merging and feature engineering")

# --- End of script ---
