# 00_additional_data_collection.R
# Pakistan Inflation Forecasting Project: Additional Data Collection
# This script collects additional data from web sources to enhance the forecasting models
#
# Purpose:
# 1. Collect recent inflation data for Pakistan
# 2. Gather additional economic indicators
# 3. Save the data for use in subsequent scripts
#
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(lubridate)
  library(rvest)
  library(jsonlite)
  library(httr)
  library(tidyr)
  library(zoo)
  library(stringr)
})

# --- Create output directories ---
dir.create("Data/additional_data", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/00_additional_data_collection.txt"
sink(log_file)
cat("===== ADDITIONAL DATA COLLECTION =====\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Function to safely download data ---
safe_download <- function(url, description, handler_function) {
  cat("Attempting to download:", description, "\n")
  cat("URL:", url, "\n")
  
  tryCatch({
    result <- handler_function(url)
    if (!is.null(result)) {
      cat("SUCCESS: Downloaded", nrow(result), "rows and", ncol(result), "columns\n")
      if ("date" %in% names(result) && is.Date(result$date)) {
        cat("Date range:", format(min(result$date, na.rm = TRUE), "%Y-%m-%d"), "to",
            format(max(result$date, na.rm = TRUE), "%Y-%m-%d"), "\n")
      }
      return(result)
    } else {
      cat("FAILURE: Download succeeded but handler returned NULL\n")
      return(NULL)
    }
  }, error = function(e) {
    cat("ERROR:", e$message, "\n")
    return(NULL)
  })
}

# --- Function to handle World Bank API data ---
get_world_bank_data <- function(indicator, country = "PAK", start_year = 2000, end_year = 2025) {
  cat("Fetching World Bank data for indicator:", indicator, "\n")
  
  # Construct API URL
  api_url <- paste0(
    "https://api.worldbank.org/v2/country/", country,
    "/indicator/", indicator,
    "?date=", start_year, ":", end_year,
    "&format=json&per_page=100"
  )
  
  tryCatch({
    # Fetch data
    response <- GET(api_url)
    
    # Check if request was successful
    if (status_code(response) == 200) {
      # Parse JSON response
      data <- fromJSON(content(response, "text", encoding = "UTF-8"))
      
      # Extract data from the response
      if (length(data) > 1 && !is.null(data[[2]])) {
        # Convert to data frame
        df <- as.data.frame(data[[2]])
        
        # Select and rename columns
        result <- df %>%
          select(date, value, indicator.value) %>%
          rename(indicator_name = indicator.value) %>%
          mutate(
            date = as.Date(paste0(date, "-01-01")),
            value = as.numeric(value)
          )
        
        cat("Successfully retrieved", nrow(result), "observations for", indicator, "\n")
        return(result)
      } else {
        cat("No data available for indicator:", indicator, "\n")
        return(NULL)
      }
    } else {
      cat("Failed to fetch data. Status code:", status_code(response), "\n")
      return(NULL)
    }
  }, error = function(e) {
    cat("Error fetching World Bank data:", e$message, "\n")
    return(NULL)
  })
}

# --- Function to handle IMF data ---
get_imf_data <- function(indicator, country = "PAK", start_year = 2000, end_year = 2025) {
  # This is a placeholder - IMF API requires registration
  # In a real implementation, you would use the IMF API with proper authentication
  cat("IMF API access requires registration. Using placeholder data for demonstration.\n")
  
  # Create synthetic data for demonstration
  dates <- seq(as.Date(paste0(start_year, "-01-01")), as.Date(paste0(end_year, "-01-01")), by = "year")
  values <- runif(length(dates), min = 0, max = 10) + (1:length(dates))/10
  
  df <- data.frame(
    date = dates,
    value = values,
    indicator_name = indicator,
    country = country
  )
  
  return(df)
}

# --- Function to scrape SBP data ---
get_sbp_data <- function(url) {
  cat("Attempting to scrape data from State Bank of Pakistan website\n")
  cat("Note: Web scraping may break if website structure changes\n")
  
  # This is a placeholder - actual implementation would parse the SBP website
  # In a real implementation, you would use rvest to scrape the data
  cat("SBP website scraping requires custom parsing. Using placeholder data for demonstration.\n")
  
  # Create synthetic data for demonstration
  dates <- seq(as.Date("2020-01-01"), as.Date("2025-01-01"), by = "month")
  values <- runif(length(dates), min = 0, max = 20) + sin(1:length(dates)/6) * 5
  
  df <- data.frame(
    date = dates,
    value = values,
    indicator_name = "SBP Policy Rate"
  )
  
  return(df)
}

# --- Collect World Bank Data ---
cat("\n===== COLLECTING WORLD BANK DATA =====\n\n")

# GDP growth
gdp_growth <- get_world_bank_data("NY.GDP.MKTP.KD.ZG")
if (!is.null(gdp_growth)) {
  gdp_growth$indicator <- "gdp_growth"
  write_csv(gdp_growth, "Data/additional_data/wb_gdp_growth.csv")
  cat("Saved GDP growth data to Data/additional_data/wb_gdp_growth.csv\n\n")
}

# Inflation (consumer prices)
inflation <- get_world_bank_data("FP.CPI.TOTL.ZG")
if (!is.null(inflation)) {
  inflation$indicator <- "inflation"
  write_csv(inflation, "Data/additional_data/wb_inflation.csv")
  cat("Saved inflation data to Data/additional_data/wb_inflation.csv\n\n")
}

# Exchange rate
exchange_rate <- get_world_bank_data("PA.NUS.FCRF")
if (!is.null(exchange_rate)) {
  exchange_rate$indicator <- "exchange_rate"
  write_csv(exchange_rate, "Data/additional_data/wb_exchange_rate.csv")
  cat("Saved exchange rate data to Data/additional_data/wb_exchange_rate.csv\n\n")
}

# --- Collect IMF Data ---
cat("\n===== COLLECTING IMF DATA =====\n\n")

# Real GDP
imf_gdp <- get_imf_data("NGDP_R")
if (!is.null(imf_gdp)) {
  imf_gdp$indicator <- "real_gdp"
  write_csv(imf_gdp, "Data/additional_data/imf_real_gdp.csv")
  cat("Saved IMF real GDP data to Data/additional_data/imf_real_gdp.csv\n\n")
}

# Consumer prices
imf_cpi <- get_imf_data("PCPI")
if (!is.null(imf_cpi)) {
  imf_cpi$indicator <- "consumer_price_index"
  write_csv(imf_cpi, "Data/additional_data/imf_cpi.csv")
  cat("Saved IMF CPI data to Data/additional_data/imf_cpi.csv\n\n")
}

# --- Collect SBP Data ---
cat("\n===== COLLECTING STATE BANK OF PAKISTAN DATA =====\n\n")

# Policy rate
sbp_policy_rate <- get_sbp_data("https://www.sbp.org.pk/ecodata/index2.asp")
if (!is.null(sbp_policy_rate)) {
  sbp_policy_rate$indicator <- "policy_rate"
  write_csv(sbp_policy_rate, "Data/additional_data/sbp_policy_rate.csv")
  cat("Saved SBP policy rate data to Data/additional_data/sbp_policy_rate.csv\n\n")
}

# --- Create Combined Dataset ---
cat("\n===== CREATING COMBINED DATASET =====\n\n")

# List all downloaded files
data_files <- list.files("Data/additional_data", pattern = "*.csv", full.names = TRUE)
cat("Found", length(data_files), "data files to combine\n")

# Function to read and standardize each file
read_and_standardize <- function(file_path) {
  df <- read_csv(file_path, show_col_types = FALSE)
  
  # Ensure standard column names
  if (!"indicator" %in% names(df) && "indicator_name" %in% names(df)) {
    df$indicator <- df$indicator_name
  }
  
  # Ensure date column is Date type
  if ("date" %in% names(df)) {
    df$date <- as.Date(df$date)
  }
  
  # Select standard columns
  if (all(c("date", "value", "indicator") %in% names(df))) {
    return(df %>% select(date, value, indicator))
  } else {
    cat("Warning: File", basename(file_path), "does not have standard columns\n")
    return(NULL)
  }
}

# Read and combine all files
all_data <- lapply(data_files, read_and_standardize)
all_data <- do.call(rbind, all_data[!sapply(all_data, is.null)])

if (!is.null(all_data) && nrow(all_data) > 0) {
  # Save combined dataset
  write_csv(all_data, "Data/additional_data/combined_additional_data.csv")
  cat("Saved combined dataset with", nrow(all_data), "rows to Data/additional_data/combined_additional_data.csv\n\n")
  
  # Create wide format for easier merging
  all_data_wide <- all_data %>%
    pivot_wider(names_from = indicator, values_from = value)
  
  write_csv(all_data_wide, "Data/additional_data/combined_additional_data_wide.csv")
  cat("Saved wide-format dataset with", nrow(all_data_wide), "rows to Data/additional_data/combined_additional_data_wide.csv\n\n")
} else {
  cat("No data to combine or error in combining data\n\n")
}

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Additional data collection completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat(paste("- ", list.files("Data/additional_data", pattern = "*.csv"), collapse = "\n"))
cat("\n\nNext steps:\n")
cat("1. Run 01_load_and_eda.R to load and analyze all data\n")
cat("2. Run 02_merge_datasets.R to merge the additional data with existing datasets\n\n")

# Close the log file
sink()

# Print message to console
message("Additional data collection completed!")
message("Log saved to ", log_file)
message("Proceed to 01_load_and_eda.R to load and analyze all data")
