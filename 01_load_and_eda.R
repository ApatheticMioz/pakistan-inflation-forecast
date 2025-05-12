# 01_load_and_eda.R
# Pakistan Inflation Forecasting Project: Data Loading and EDA
# This script loads all datasets, performs EDA, and saves outputs for further analysis.
# Author: <Your Name>
# Date: 2025-05-13

# --- Set working directory to project root (if running interactively) ---
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# Load required libraries
suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(lubridate)
  library(zoo)
  library(tidyr)
  library(janitor)    # For clean_names
  library(VIM)        # For missingness visualization
  library(ggplot2)    # For basic plotting
  library(tseries)    # For time series analysis
  library(forecast)   # For forecasting functions
  library(tools)      # For file utilities
})

# Create output directory for EDA results
dir.create("Plots", showWarnings = FALSE)

# --- Set data directory paths ---
main_data_dir <- "Data"
combined_data_dir <- file.path(main_data_dir, "data_combined")
easydata_dir <- file.path(main_data_dir, "easydata") 
fao_dir <- file.path(main_data_dir, "fao")
fred_dir <- file.path(main_data_dir, "fred")
finance_dir <- file.path(main_data_dir, "finanaceGovPk")
old_data_dir <- file.path(main_data_dir, "old_data")

# --- Source-specific Data Loading Functions ---
load_easydata <- function(filename) {
  # Handle SBP EasyData format
  message(paste("Loading EasyData file:", basename(filename)))
  tryCatch({
    df <- readr::read_csv(filename, show_col_types = FALSE)
    names(df) <- tolower(gsub("[ .-]", "_", names(df)))
    
    date_col <- NULL
    if ("observation_date" %in% names(df)) {
      date_col <- "observation_date"
      # Handle multiple date formats from SBP EasyData
      df[[date_col]] <- as.Date(parse_date_time(df[[date_col]], orders = c("dmy", "ymd")))
    }
    
    if ("observation_value" %in% names(df)) {
      df$observation_value <- as.numeric(df$observation_value)
    }
    
    # Add a standard 'date' column if possible
    if (!is.null(date_col)) {
      df$date <- df[[date_col]]
    }
    
    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

load_fao <- function(filename) {
  # Handle FAO format with variable headers and formats
  message(paste("Loading FAO file:", basename(filename)))
  tryCatch({
    lines <- readLines(filename)
    header_line <- which(grepl("^Date,", lines))[1]
    if (is.na(header_line)) header_line <- which(grepl("Date|Month|Year", lines))[1]
    
    df <- readr::read_csv(filename, skip = header_line - 1, col_names = TRUE, show_col_types = FALSE)
    df <- df[!is.na(df$Date) & df$Date != "", ]
    
    # Try parsing date with multiple formats
    date_formats <- c("%Y-%m", "%b-%Y", "%Y-%m-%d")
    for (fmt in date_formats) {
      parsed_dates <- suppressWarnings(as.Date(as.yearmon(df$Date, fmt)))
      if (!all(is.na(parsed_dates))) {
        df$date <- as.Date(as.yearmon(df$Date, fmt))
        break
      }
    }
    
    # If all attempts fail, use yearmon directly
    if (!"date" %in% names(df) || all(is.na(df$date))) {
      df$date <- as.Date(as.yearmon(df$Date))
    }
    
    # Convert numeric columns
    for (col in setdiff(names(df), c("Date", "date"))) {
      df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
    }
    
    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

load_fred <- function(filename) {
  # Handle FRED format
  message(paste("Loading FRED file:", basename(filename)))
  tryCatch({
    df <- readr::read_csv(filename, show_col_types = FALSE)
    names(df) <- tolower(gsub("[ .-]", "_", names(df)))
    
    if ("observation_date" %in% names(df)) {
      df$observation_date <- as.Date(df$observation_date)
      df$date <- df$observation_date
    }
    
    # Convert all columns except date to numeric
    for (col in names(df)) {
      if (!grepl("date", col)) {
        df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
      }
    }
    
    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

load_financegovpk <- function(filename) {
  # Handle finance.gov.pk format
  message(paste("Loading Finance.gov.pk file:", basename(filename)))
  tryCatch({
    df <- readr::read_csv(filename, show_col_types = FALSE)
    names(df) <- tolower(gsub("[ .-]", "_", names(df)))
    
    # Try to identify fiscal year column
    fiscal_col <- grep("fiscal|year", names(df), ignore.case = TRUE)[1]
    if (!is.na(fiscal_col)) {
      # Convert fiscal years (e.g., "2013-14") to dates
      fiscal_years <- df[[fiscal_col]]
      
      # Extract years and create proper date strings
      start_years <- as.numeric(substr(fiscal_years, 1, 4))
      if (!any(is.na(start_years))) {
        # Use July 1st of the start year as the date (start of fiscal year in Pakistan)
        df$date <- as.Date(paste0(start_years, "-07-01"))
      }
    }
    
    return(df)
  }, error = function(e) {
    warning(paste("Error loading:", basename(filename), "-", e$message))
    return(NULL)
  })
}

load_olddata <- function(filename) {
  # Try to determine file format and use appropriate loader
  message(paste("Loading old data file:", basename(filename)))
  
  # Read a few lines to detect format
  lines <- readLines(filename, n = 10)
  
  if (any(grepl("Dataset Name", lines)) || any(grepl("Series Key", lines))) {
    # Looks like SBP format
    return(load_easydata(filename))
  } else if (any(grepl("observation_date", lines))) {
    # Looks like FRED format
    return(load_fred(filename))
  } else if (any(grepl("Date,", lines))) {
    # Might be FAO format
    return(load_fao(filename))
  } else {
    # Try as general CSV
    tryCatch({
      df <- readr::read_csv(filename, show_col_types = FALSE)
      names(df) <- tolower(gsub("[ .-]", "_", names(df)))
      return(df)
    }, error = function(e) {
      warning(paste("Error loading:", basename(filename), "-", e$message))
      return(NULL)
    })
  }
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
message("Loading combined data files...")
tryCatch({
  # Load primary datasets
  cpi <- load_easydata(file.path(combined_data_dir, "CPI National -YoY.csv"))
  kibor <- load_easydata(file.path(combined_data_dir, "KIBOR.csv"))
  policy_rate <- load_easydata(file.path(combined_data_dir, "Policy Rate.csv"))
  exchange_rate <- load_easydata(file.path(combined_data_dir, "Pakistan Exchange Rate Per USD.csv"))
  exports_imports <- load_easydata(file.path(combined_data_dir, "Exports and Imports.csv"))
  monetary_aggregate <- load_easydata(file.path(combined_data_dir, "Monthly Monetary Aggregate.csv"))
  industrial_production <- load_easydata(file.path(combined_data_dir, "Industrial Production Index.csv"))
  oil_prices <- load_fred(file.path(combined_data_dir, "International Oil Prices.csv"))
  
  # Use FAO loader for global food price index
  global_food <- load_fao(file.path(combined_data_dir, "Global Food Price Index.csv"))
  
  # Finance.gov.pk datasets
  consumption_investment_gdp <- load_financegovpk(file.path(combined_data_dir, "Consumption and Invesment of GDP.csv"))
  current_account_balance <- load_financegovpk(file.path(combined_data_dir, "Current Account Balance.csv"))
  growth_rate <- load_financegovpk(file.path(combined_data_dir, "Growth Rate.csv"))
  pakistan_share_gdp <- load_financegovpk(file.path(combined_data_dir, "Pakistan's Share in GDP.csv"))
  
  # Check if we have inflation_base_2015.csv in combined or old_data, load from either
  base_inflation_file <- file.path(combined_data_dir, "inflation_base_2015.csv")
  if (file.exists(base_inflation_file)) {
    inflation_base_2015 <- load_olddata(base_inflation_file)
  } else {
    base_inflation_file <- file.path(old_data_dir, "inflation_base_2015.csv")
    if (file.exists(base_inflation_file)) {
      inflation_base_2015 <- load_olddata(base_inflation_file)
    }
  }
  
  # Collect all datasets in a list
  datasets <- list(
    cpi = cpi,
    kibor = kibor,
    policy_rate = policy_rate,
    exchange_rate = exchange_rate,
    exports_imports = exports_imports,
    monetary_aggregate = monetary_aggregate,
    industrial_production = industrial_production,
    oil_prices = oil_prices,
    global_food = global_food,
    consumption_investment_gdp = consumption_investment_gdp,
    current_account_balance = current_account_balance,
    growth_rate = growth_rate,
    pakistan_share_gdp = pakistan_share_gdp
  )
  
  # Add inflation_base_2015 if loaded
  if (exists("inflation_base_2015")) {
    datasets$inflation_base_2015 <- inflation_base_2015
  }
}, error = function(e) {
  stop(paste("Error loading combined data:", e$message))
})

# --- Load all data by source for comprehensive EDA ---
# This loads ALL files for thorough EDA
message("Loading all data from all sources...")
all_datasets <- load_all_by_source()

# --- Clean column names and parse dates for all datasets ---
message("Cleaning datasets and summarizing...")
eda_summary <- list()
clean_dataset <- function(df, name) {
  if (is.null(df)) {
    message(paste("Skipping NULL dataset:", name))
    return(NULL)
  }
  
  df <- janitor::clean_names(df)
  
  # Identify and standardize date column
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
  if (!is.null(date_col) && !inherits(df$date, "Date")) {
    date_formats <- c("ymd", "dmy", "mdy")
    for (fmt in date_formats) {
      parsed_dates <- suppressWarnings(parse_date_time(df$date, orders = fmt))
      if (!all(is.na(parsed_dates))) {
        df$date <- as.Date(parsed_dates)
        break
      }
    }
    
    # If parsing failed, try yearmon
    if (!inherits(df$date, "Date")) {
      df$date <- as.Date(as.yearmon(df$date))
    }
  }
  
  # Remove duplicate rows
  n_before <- nrow(df)
  df <- distinct(df)
  n_after <- nrow(df)
  
  # Get date range if date column exists
  date_range <- if ("date" %in% names(df) && inherits(df$date, "Date")) {
    range(df$date, na.rm = TRUE)
  } else {
    c(NA, NA)
  }
  
  # Calculate missingness
  miss <- sapply(df, function(x) sum(is.na(x)))
  
  # Save summary
  eda_summary[[name]] <<- list(
    n_before = n_before,
    n_after = n_after,
    date_range = date_range,
    missing = miss,
    variables = names(df)
  )
  
  return(df)
}

# Clean all combined datasets
datasets <- lapply(names(datasets), function(name) {
  clean_dataset(datasets[[name]], name)
})
names(datasets) <- names(eda_summary)

# --- Create output files ---
eda_output_file <- "eda_output.txt"
colnames_output_file <- "eda_colnames.txt"
all_data_eda_file <- "eda_all_csvs_output.txt"

message("Writing EDA output files...")

# EDA for combined datasets
sink(eda_output_file)
cat("\n\n===== COMBINED DATASETS EDA SUMMARY =====\n")
dataset_names <- names(datasets)
for (name in dataset_names) {
  df <- datasets[[name]]
  if (is.null(df)) {
    cat("\n\n===== ", name, " =====\n")
    cat("NULL dataset\n")
    next
  }
  
  cat("\n\n===== ", name, " =====\n")
  cat("Dimensions:", dim(df), "\n")
  cat("Variables:", paste(names(df), collapse = ", "), "\n\n")
  
  # Print first few rows for demonstration
  cat("Head:\n")
  print(head(df, 3))
  cat("\n")
  
  # Print last few rows
  cat("Tail:\n")
  print(tail(df, 3))
  cat("\n")
  
  # Print summary statistics
  cat("Summary:\n")
  print(summary(df))
  cat("\n")
  
  # Print missingness
  cat("Missing values per column:\n")
  print(eda_summary[[name]]$missing)
  
  # Print duplicate info
  cat("\nRows before deduplication:", eda_summary[[name]]$n_before, 
      ", after:", eda_summary[[name]]$n_after, "\n")
  
  # Print date range
  cat("Date range:", paste(eda_summary[[name]]$date_range, collapse = " to "), "\n")
  
  # For time series data, also print ACF/PACF info if applicable
  if ("date" %in% names(df) && is.numeric(df$observation_value)) {
    cat("\nTime Series Properties:\n")
    tryCatch({
      ts_data <- with(df[order(df$date),], ts(observation_value, 
                                              frequency = 12))
      cat("ADF Test (stationarity):\n")
      print(adf.test(ts_data, alternative = "stationary"))
    }, error = function(e) {
      cat("Could not perform time series analysis:", e$message, "\n")
    })
  }
}
sink()

# Column names output
sink(colnames_output_file)
for (name in dataset_names) {
  cat("\n\n===== ", name, " =====\n")
  df <- datasets[[name]]
  if (is.null(df)) {
    cat("NULL dataset\n")
    next
  }
  print(colnames(df))
}
sink()

# EDA for all individual source files
sink(all_data_eda_file)

describe_datasets <- function(dataset_list, source_name) {
  cat("\n\n==================== ", toupper(source_name), " ====================\n")
  for (name in names(dataset_list)) {
    df <- dataset_list[[name]]
    if (is.null(df)) {
      cat("\n--- ", name, " ---\n")
      cat("NULL dataset\n")
      next
    }
    
    cat("\n--- ", name, " ---\n")
    cat("Dimensions:", dim(df), "\n")
    cat("Variables:", paste(names(df), collapse = ", "), "\n\n")
    
    # Print first few rows
    cat("Head:\n")
    print(head(df, 3))
    cat("\n")
    
    # Print summary
    cat("Summary:\n")
    print(summary(df[, 1:min(5, ncol(df))]))  # Show summary of first 5 columns
    cat("\n")
  }
}

describe_datasets(all_datasets$easydata, "easydata")
describe_datasets(all_datasets$fao, "fao")
describe_datasets(all_datasets$financegovpk, "finanaceGovPk")
describe_datasets(all_datasets$fred, "fred")
describe_datasets(all_datasets$old_data, "old_data")

sink()

# --- Save cleaned datasets for reproducibility and next steps ---
message("Saving cleaned datasets...")
saveRDS(datasets, file = "cleaned_datasets.rds")

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

message("Data loading and initial EDA completed successfully!")

# --- End of script ---
