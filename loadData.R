# --- Set Working Directory ---
# !! IMPORTANT: Make sure this path is correct for your system !!
# !! Using forward slashes is generally safer in R for paths !!
base::setwd("D:/work/Semester4/AdvStats/pakistan-inflation-forecast")
base::cat(paste("Working directory set to:", base::getwd(), "\n"))

# --- Load Necessary Libraries ---
# Ensure packages are installed first if needed
# install.packages(c("readr", "dplyr", "lubridate", "stringr"))
library(readr)
library(dplyr)
library(lubridate)
library(stringr)

# --- Define File Paths and Categories ---
data_folder <- "Data"
# Define the output file name FOR DETAILED OVERVIEW
output_filename <- "data_overview_output_detailed_R_v6.txt" # New filename

# Common strings representing missing values (Expanded List)
common_na_values <- c(
  "", " ", "-", ".", "..", "...", # Empty, space, hyphen, periods
  "NA", "#N/A", "N/A", "n/a",    # Variations of NA
  "NULL", "null",               # Null values
  "NaN", "nan",                 # Not a Number
  "Missing", "missing",         # Explicit missing text
  "No data", "no data",         # No data text
  "?",                          # Question mark
  "<NA>",                       # Tidyverse style NA
  "###", "####", "#####", "######", "#######", "########" # Hashtags
)

# 1. Standard CSV Files (Comma-separated, Quoted Fields, Header=TRUE)
standard_files <- c(
  't_bills.csv', 'seasonal_worker_remittance.csv', 'REER.csv',
  'quaterly_gdp_2015.csv', 'policy_rate.csv', 'm2_broad_money.csv',
  'kibor_kibid.csv', 'inflation_base_2015.csv', 'inflation_base_2007.csv', # Kept here
  'gdp_domestic_2005.csv', 'foreign_invest_sectors.csv',
  'foreign_invest_countires.csv', 'exchange_rate.csv',
  'consumer_confidence_survey.csv', 'country_wise_remittance.csv',
  'borrow_loans.csv', 'LSM_QIM_2015.csv', 'LSM_QIM_2005.csv',
  'gold_foreign_exchange_reserves.csv'
)
# Column name to parse as date in standard files
standard_date_col_name <- "Observation Date"
# Expected date format for standard files
standard_date_format <- "%d-%b-%Y" # e.g., 26-Mar-2025

# 2. Wide Time-Series Files (Header=TRUE, Years as Columns)
# Removed country-specific inflation files, added trade_partner_inflations.csv
wide_files <- c(
  'transport_and_communications.csv', 'trade_and_payments.csv',
  'public_debt.csv', 'population,_labor_force_and_employment.csv',
  'money_and_credit.csv', 'manufacturing_and_mining.csv',
  'inflation.csv', # Kept here
  'health_and_nutrition.csv', 'growth_and_investment.csv',
  'fiscal_development.csv', 'energy.csv', 'education.csv',
  'economic_and_social_indicators.csv',
  'capital_markets_and_corporate_sector.csv', 'agriculture.csv',
  'trade_partner_inflations.csv' # Added new file
)

# 3. World Bank Commodity Data (Metadata Above Header)
cmo_files <- list(
  `CMO_historical_data_monthly.csv` = list(skip = 4, date_col_index = 1), # Header row index (0-based) -> skip = 4, date col index (1-based)
  `CMO_historical_data_indices.csv` = list(skip = 5, date_col_index = 1)  # Header row index (0-based) -> skip = 5, date col index (1-based)
)

# 4. Empty Files (To be skipped)
empty_files <- c(
  'social_protection.csv',
  'information_technology_and_telecommunication.csv'
)

# --- Function to identify year-like columns ---
get_year_columns <- function(df) {
  year_cols <- c()
  # Regex to match 4 digits possibly separated by hyphen/slash (e.g., 1999, 2000-01)
  # Also matches just 4 digits (e.g., 1980)
  year_pattern <- "^(\\d{4}(?:[-\\/]\\d{2,4})?|\\d{4})$"
  for (col_name in names(df)) {
    # Check if the column name matches the year pattern
    if (stringr::str_detect(col_name, year_pattern)) { # Use stringr::str_detect
      year_cols <- c(year_cols, col_name)
    }
  }
  return(year_cols)
}

# --- Function to safely convert columns to numeric ---
# Handles potential warnings if coercion introduces NAs
safe_as_numeric <- function(x) {
  suppressWarnings(as.numeric(as.character(x)))
}

# --- Function to check for suspicious non-alphanumeric values ---
# Returns unique suspicious values found, or NULL if none
find_suspicious_values <- function(column) {
  # Pattern to match strings consisting ONLY of non-alphanumeric chars (excluding NA)
  # Allows for internal spaces, periods, commas, hyphens if needed for specific formats,
  # but focuses on values that are *primarily* symbols or just punctuation.
  # This regex looks for strings that do NOT contain any letters or numbers.
  # It allows NA values to pass through without being flagged.
  suspicious_pattern <- "^[^a-zA-Z0-9]+$"
  
  # Find unique non-NA values that match the pattern
  suspicious_vals <- unique(column[!is.na(column) & stringr::str_detect(column, suspicious_pattern)])
  
  if (length(suspicious_vals) > 0) {
    return(suspicious_vals)
  } else {
    return(NULL)
  }
}


# --- Initialize list to store dataframes ---
dataframes_list <- list()

# --- Load DataFrames (Outputting progress to console) ---

cat("--- Loading Standard CSV Files ---\n")
for (filename in standard_files) {
  file_path <- base::file.path(data_folder, filename)
  cat(base::paste("Processing:", filename, "\n")) # Progress to console
  tryCatch({
    col_spec <- readr::cols(.default = readr::col_character()) # Read all as character initially
    df_char <- readr::read_csv(file_path, quote = '"', na = common_na_values, col_types = col_spec, guess_max = 1)
    
    # Now define specific types for conversion
    col_spec_final <- readr::cols(.default = readr::col_guess(),
                                  !!standard_date_col_name := readr::col_datetime(format = standard_date_format))
    
    df <- readr::read_csv(
      file_path,
      quote = '"',
      na = common_na_values,
      col_types = col_spec_final,
      guess_max = 10000
    )
    
    if ("Observation Value" %in% names(df)) {
      df <- df %>% dplyr::mutate(`Observation Value` = safe_as_numeric(`Observation Value`))
    }
    
    # Store both for analysis later if needed, but primarily use the typed one
    dataframes_list[[filename]] <- list(typed = df, char_version = df_char)
    cat(base::paste("Successfully loaded:", filename, "\n")) # Progress to console
  }, error = function(e) {
    cat(base::paste("Error loading", filename, ":", e$message, "\n")) # Error to console
  })
}

cat("\n--- Loading Wide Time-Series Files ---\n")
for (filename in wide_files) {
  file_path <- base::file.path(data_folder, filename)
  cat(base::paste("Processing:", filename, "\n")) # Progress to console
  tryCatch({
    # Read all as character first to check for suspicious values
    df_char <- readr::read_csv(file_path, na = common_na_values, col_types = cols(.default = "c"), guess_max = 1)
    
    # Now read again with type guessing
    df <- readr::read_csv(
      file_path,
      na = common_na_values,
      guess_max = 10000
    )
    
    # Identify and convert year columns to numeric after load
    year_columns <- get_year_columns(df)
    if (base::length(year_columns) > 0) {
      cat(base::paste("Found potential year columns in", filename, ":", base::paste(year_columns, collapse=", "), "\n")) # Progress to console
      df <- df %>%
        dplyr::mutate(dplyr::across(dplyr::all_of(year_columns), safe_as_numeric))
      
    } else {
      cat(base::paste("Could not identify year columns automatically in", filename, "\n")) # Progress to console
    }
    
    dataframes_list[[filename]] <- list(typed = df, char_version = df_char)
    cat(base::paste("Successfully loaded:", filename, "\n")) # Progress to console
  }, error = function(e) {
    cat(base::paste("Error loading", filename, ":", e$message, "\n")) # Error to console
  })
}

cat("\n--- Loading CMO Files ---\n")
for (filename in names(cmo_files)) {
  file_path <- base::file.path(data_folder, filename)
  params <- cmo_files[[filename]]
  cat(base::paste("Processing:", filename, "\n")) # Progress to console
  tryCatch({
    # Read all as character first
    df_char <- readr::read_csv(file_path, skip = params$skip, na = common_na_values, col_types = cols(.default = "c"), guess_max = 1)
    
    # Read again with type guessing and date parsing
    df <- readr::read_csv(
      file_path,
      skip = params$skip,
      na = common_na_values,
      guess_max = 5000
    )
    
    date_col_name <- names(df)[params$date_col_index]
    df <- df %>% dplyr::mutate(!!sym(date_col_name) := lubridate::parse_date_time(!!sym(date_col_name), orders = c("Ymd", "Ym", "Y")))
    
    other_cols <- names(df)[-params$date_col_index]
    df <- df %>%
      dplyr::mutate(dplyr::across(dplyr::all_of(other_cols), safe_as_numeric))
    
    dataframes_list[[filename]] <- list(typed = df, char_version = df_char)
    cat(base::paste("Successfully loaded:", filename, "\n")) # Progress to console
  }, error = function(e) {
    cat(base::paste("Error loading", filename, ":", e$message, "\n")) # Error to console
  })
}

cat(base::paste("\n--- Skipping Empty Files:", base::paste(empty_files, collapse=", "), "---\n")) # Progress to console

cat(base::paste("\nTotal DataFrames loaded:", base::length(dataframes_list), "\n")) # Progress to console


# --- Write MOST Comprehensive Overview to Text File ---
cat(base::paste("\n\n--- Writing MOST Comprehensive Overview to File:", output_filename, "---\n"))
tryCatch({
  # Open sink for the detailed output file
  sink(output_filename)
  
  cat("--- MOST Comprehensive Overview of Loaded DataFrames ---\n")
  cat("\nNote: Missing values identified from the 'common_na_values' list during loading are represented as 'NA' below.\n")
  
  # Set display options
  base::options(max.print = 10000)
  base::options(width = 200)
  
  for (filename in names(dataframes_list)) {
    df_data <- dataframes_list[[filename]]
    df <- df_data$typed # Use the dataframe with inferred types for most analysis
    df_char <- df_data$char_version # Use the character version for suspicious value check
    
    cat(base::paste0("\n\n", base::paste(base::rep("=", 80), collapse=""), "\n"))
    cat(paste("   Dataset:", filename, "\n"))
    cat(paste0(paste(rep("=", 80), collapse=""), "\n"))
    
    cat("\n--- Dimensions (Rows, Columns) ---\n")
    base::print(base::dim(df))
    
    cat("\n--- Column Names ---\n")
    base::print(base::names(df))
    
    cat("\n--- Column Data Types (Classes) ---\n")
    base::print(base::sapply(df, class))
    
    cat("\n--- First 10 Rows (head) ---\n")
    base::print(utils::head(df, 10))
    
    cat("\n--- Last 5 Rows (tail) ---\n")
    base::print(utils::tail(df, 5))
    
    cat("\n--- DataFrame Structure (str) ---\n")
    str_output <- utils::capture.output(utils::str(df))
    cat(base::paste(str_output, collapse = "\n"), "\n")
    
    cat("\n--- Missing Value Counts (colSums(is.na())) ---")
    cat("\n(Values indicate count of R's NA identifier after attempting to load common missing strings as NA)\n")
    base::print(base::colSums(base::is.na(df)))
    
    cat("\n--- Suspicious Non-Alphanumeric Value Check ---")
    cat("\n(Checking columns initially read as character for values like '###', '...', etc., that might indicate missed NAs)\n")
    suspicious_found_in_df <- FALSE
    for (col in names(df_char)) {
      # Check only character columns from the initial read
      if(is.character(df_char[[col]])) {
        suspicious_vals <- find_suspicious_values(df_char[[col]])
        if (!is.null(suspicious_vals)) {
          cat(paste0("Column '", col, "' contains suspicious non-alphanumeric values: ", paste(suspicious_vals, collapse=", "), "\n"))
          suspicious_found_in_df <- TRUE
        }
      }
    }
    if (!suspicious_found_in_df) {
      cat("No obvious suspicious non-alphanumeric values found in character columns.\n")
    }
    
    
    cat("\n--- Unique Value Counts & Values (if <= 50 unique) ---\n")
    for (col in names(df)) {
      num_unique_non_na <- dplyr::n_distinct(df[[col]], na.rm = TRUE)
      has_na <- any(is.na(df[[col]]))
      num_unique_total <- num_unique_non_na + ifelse(has_na, 1, 0)
      
      cat(paste0("\nColumn: '", col, "' - Number of Unique Values (incl. NA if present): ", num_unique_total, "\n"))
      
      if (num_unique_total <= 50) {
        cat("Unique Values (NA shown if present):\n")
        unique_vals_output <- utils::capture.output(base::table(df[[col]], useNA = "ifany"))
        cat(paste(names(base::table(df[[col]], useNA = "ifany")), collapse = ", "), "\n")
      } else {
        cat("(More than 50 unique values, not listing all)\n")
      }
    }
    
    cat("\n--- Most Common Values (Top 30 per column, including NA) ---\n")
    for (col in names(df)) {
      cat(paste0("\nColumn: '", col, "'\n"))
      # Create frequency table (including NA)
      freq_table <- base::table(df[[col]], useNA = "ifany")
      # Sort by frequency in descending order
      sorted_table <- sort(freq_table, decreasing = TRUE)
      # Print top 30
      print(utils::head(sorted_table, 30))
    }
    
    
    cat("\n--- Summary Statistics (summary) ---\n")
    summary_output <- utils::capture.output(base::summary(df))
    cat(base::paste(summary_output, collapse = "\n"), "\n")
    
  } # End of loop through dataframes
  
  cat("\n\n--- End of MOST Comprehensive Data Overview File ---\n")
  
  # Close the sink connection
  sink()
  cat(base::paste("MOST Comprehensive overview successfully written to:", output_filename, "\n")) # Message to console
  
}, error = function(e) {
  cat(base::paste("Error writing detailed overview to file:", e$message, "\n")) # Error to console
  # Ensure sink is closed even on error
  if(sink.number() > 0) { sink() }
})

# Reset console width if desired
# options(width = 80)

cat("\n--- Script Finished ---\n") # Message to console

# The detailed output was written to the output_filename.
# The console only shows loading progress and final messages.

# --- Save the loaded dataframes list ---
# Define the filename for the saved data object
saved_data_filename <- "loaded_dataframes.rds"
# Save the list object to an RDS file
base::saveRDS(dataframes_list, file = saved_data_filename)
base::cat(paste("\n--- Loaded dataframes list saved to:", saved_data_filename, "---\n"))

cat("\n--- Script Finished ---\n") # Message to console

