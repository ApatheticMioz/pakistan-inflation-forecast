# 00_dataset_analysis.R
# Pakistan Inflation Forecasting Project: Detailed Dataset Analysis
# This script performs a comprehensive analysis of all datasets to understand
# their structure, missing value patterns, and other characteristics.
#
# Purpose:
# 1. Analyze each dataset's structure and format
# 2. Identify missing value patterns and representations
# 3. Examine date ranges and coverage
# 4. Generate detailed reports for data loading decisions
#
# Author: <Your Name>
# Date: 2025-05-13

# --- Set working directory to project root (if running interactively) ---
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# --- Function to install missing packages ---
install_if_missing <- function(packages) {
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) {
    message("Installing missing packages: ", paste(new_packages, collapse = ", "))
    install.packages(new_packages, repos = "https://cloud.r-project.org")
  }
}

# List of required packages
required_packages <- c(
  "readr", "dplyr", "tidyr", "janitor",  # Data manipulation
  "lubridate", "zoo",                    # Date handling
  "ggplot2", "VIM",                      # Visualization
  "tools", "stringr", "knitr"            # Utilities
)

# Install missing packages
install_if_missing(required_packages)

# --- Load required libraries ---
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
  if ("VIM" %in% installed.packages()[,"Package"]) {
    library(VIM)      # Missingness visualization
  }

  # Utilities
  library(tools)      # File utilities
  library(stringr)    # String manipulation
  library(knitr)      # Table formatting
})

# --- Create output directories ---
dir.create("Analysis_Reports", showWarnings = FALSE, recursive = TRUE)
dir.create("Analysis_Plots", showWarnings = FALSE, recursive = TRUE)

# --- Set data directory paths ---
main_data_dir <- "Data"
combined_data_dir <- file.path(main_data_dir, "data_combined")  # Combined datasets
easydata_dir <- file.path(main_data_dir, "easydata")            # State Bank of Pakistan
fao_dir <- file.path(main_data_dir, "fao")                      # Food and Agriculture Org
fred_dir <- file.path(main_data_dir, "fred")                    # Federal Reserve Economic Data
finance_dir <- file.path(main_data_dir, "finanaceGovPk")        # Pakistan Ministry of Finance
old_data_dir <- file.path(main_data_dir, "old_data")            # Legacy datasets

# --- Create main output file ---
sink("00_dataset_analysis_output.txt")
cat("===== PAKISTAN INFLATION FORECASTING PROJECT =====\n")
cat("===== DETAILED DATASET ANALYSIS =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")
cat("This analysis examines all datasets to understand their structure, missing value patterns,\n")
cat("and other characteristics to inform data loading and processing decisions.\n\n")

# --- Helper Functions ---

# Function to detect missing value patterns in a dataset
detect_missing_patterns <- function(file_path) {
  # Read the raw file as text to identify special missing value markers
  lines <- readLines(file_path, warn = FALSE)

  # Look for common missing value indicators
  missing_indicators <- list(
    hashtag = sum(grepl("#", lines)),
    dot = sum(grepl("\\.", lines)),
    na_text = sum(grepl("N/A|n/a", lines)),
    dash = sum(grepl("-", lines)),
    empty_quotes = sum(grepl('""', lines)),
    null_text = sum(grepl("NULL|null", lines)),
    missing_text = sum(grepl("MISSING|missing", lines))
  )

  # Filter to only indicators that were found
  found_indicators <- missing_indicators[missing_indicators > 0]

  return(found_indicators)
}

# Function to analyze a single dataset
analyze_dataset <- function(file_path, source_name) {
  filename <- basename(file_path)
  cat("\n===== ANALYZING DATASET:", filename, "=====\n")
  cat("Source:", source_name, "\n")
  cat("Full path:", file_path, "\n\n")

  # Check if file exists
  if (!file.exists(file_path)) {
    cat("ERROR: File does not exist\n\n")
    return(NULL)
  }

  # --- 1. Detect missing value patterns ---
  cat("1. MISSING VALUE PATTERNS\n")
  missing_patterns <- detect_missing_patterns(file_path)
  if (length(missing_patterns) > 0) {
    cat("Potential missing value indicators found:\n")
    for (name in names(missing_patterns)) {
      cat("  -", name, ":", missing_patterns[[name]], "occurrences\n")
    }
  } else {
    cat("No special missing value indicators detected\n")
  }
  cat("\n")

  # --- 2. Try different approaches to read the file ---
  cat("2. FILE READING ATTEMPTS\n")

  # Attempt 1: Standard read with default settings
  tryCatch({
    df_standard <- readr::read_csv(file_path, show_col_types = FALSE)
    cat("Standard read successful\n")
    cat("Dimensions:", nrow(df_standard), "rows,", ncol(df_standard), "columns\n")
    cat("Column names:", paste(names(df_standard), collapse = ", "), "\n\n")

    # Try to identify date columns
    date_cols <- grep("date|time|month|year", names(df_standard), ignore.case = TRUE)
    if (length(date_cols) > 0) {
      cat("Potential date columns:", paste(names(df_standard)[date_cols], collapse = ", "), "\n\n")
    }

    # Check for standard missing values
    na_count <- sum(is.na(df_standard))
    na_pct <- na_count / (nrow(df_standard) * ncol(df_standard)) * 100
    cat("Standard NA values:", na_count, sprintf("(%.2f%%)", na_pct), "\n\n")

    # Store the standard read result
    df <- df_standard
  }, error = function(e) {
    cat("Standard read failed:", e$message, "\n\n")
    df_standard <- NULL
  })

  # Attempt 2: Read with custom NA strings if standard read failed or has potential missing values
  if (is.null(df_standard) || length(missing_patterns) > 0) {
    tryCatch({
      na_strings <- c("NA", "N/A", "n/a", "#", ".", "-", "", "NULL", "null", "MISSING", "missing")
      df_custom <- readr::read_csv(file_path, na = na_strings, show_col_types = FALSE)
      cat("Custom NA strings read successful\n")
      cat("Dimensions:", nrow(df_custom), "rows,", ncol(df_custom), "columns\n")

      # Compare missing values with standard read
      if (!is.null(df_standard)) {
        na_count_custom <- sum(is.na(df_custom))
        na_count_standard <- sum(is.na(df_standard))
        na_diff <- na_count_custom - na_count_standard

        cat("Missing values with custom NA strings:", na_count_custom, "\n")
        cat("Difference from standard read:", na_diff, "additional missing values\n\n")

        if (na_diff > 0) {
          cat("RECOMMENDATION: Use custom NA strings for this file\n\n")
          df <- df_custom  # Use the custom read result
        }
      } else {
        df <- df_custom  # Use the custom read result if standard read failed
      }
    }, error = function(e) {
      cat("Custom NA strings read failed:", e$message, "\n\n")
      if (is.null(df_standard)) {
        cat("CRITICAL: Both standard and custom reads failed\n\n")
        return(NULL)
      }
    })
  }

  # If we don't have a dataframe at this point, return NULL
  if (!exists("df") || is.null(df)) {
    cat("Could not read file successfully\n\n")
    return(NULL)
  }

  # --- 3. Analyze dataset structure ---
  cat("3. DATASET STRUCTURE\n")

  # Column types
  col_types <- sapply(df, class)
  cat("Column types:\n")
  for (i in seq_along(col_types)) {
    cat("  -", names(df)[i], ":", col_types[i], "\n")
  }
  cat("\n")

  # Sample data
  cat("Sample data (first 5 rows):\n")
  print(head(df, 5))
  cat("\n")

  # --- 4. Analyze date columns ---
  cat("4. DATE COLUMN ANALYSIS\n")

  # Try to identify and parse date columns
  date_cols <- grep("date|time|month|year|fiscal", names(df), ignore.case = TRUE)
  if (length(date_cols) > 0) {
    for (col_idx in date_cols) {
      col_name <- names(df)[col_idx]
      col_values <- df[[col_name]]

      cat("Column:", col_name, "\n")
      cat("Sample values:", paste(head(col_values, 3), collapse = ", "), "...\n")

      # Try to parse dates with different formats
      if (!inherits(col_values, "Date")) {
        date_formats <- c("%Y-%m-%d", "%d-%b-%Y", "%m/%d/%Y", "%Y/%m/%d", "%Y-%m")
        format_results <- list()

        for (fmt in date_formats) {
          parsed_dates <- suppressWarnings(as.Date(col_values, format = fmt))
          success_rate <- sum(!is.na(parsed_dates)) / length(parsed_dates) * 100
          format_results[[fmt]] <- success_rate
        }

        # Find the best format
        best_format <- names(which.max(format_results))
        best_rate <- max(unlist(format_results))

        cat("Best date format:", best_format, sprintf("(%.2f%% success rate)", best_rate), "\n")

        if (best_rate > 50) {
          cat("RECOMMENDATION: Parse this column as date using format", best_format, "\n")
        } else {
          cat("WARNING: Could not reliably parse as date\n")
        }
      } else {
        cat("Already a Date object\n")
      }

      # Date range if parseable
      if (inherits(col_values, "Date") || best_rate > 50) {
        if (!inherits(col_values, "Date")) {
          parsed_dates <- as.Date(col_values, format = best_format)
        } else {
          parsed_dates <- col_values
        }

        date_range <- range(parsed_dates, na.rm = TRUE)
        cat("Date range:", format(date_range[1], "%Y-%m-%d"), "to",
            format(date_range[2], "%Y-%m-%d"), "\n")

        # Calculate time span
        time_span <- as.numeric(difftime(date_range[2], date_range[1], units = "days"))
        cat("Time span:", round(time_span / 365.25, 1), "years (",
            round(time_span / 30.44, 1), "months)\n")

        # Check for regular intervals
        if (length(parsed_dates) > 1) {
          sorted_dates <- sort(parsed_dates)
          diffs <- diff(sorted_dates)
          unique_diffs <- unique(diffs)

          if (length(unique_diffs) == 1) {
            interval <- unique_diffs[1]
            cat("Regular interval detected:", interval, "days\n")

            if (interval >= 28 && interval <= 31) {
              cat("RECOMMENDATION: This appears to be monthly data\n")
            } else if (interval >= 90 && interval <= 92) {
              cat("RECOMMENDATION: This appears to be quarterly data\n")
            } else if (interval >= 365 && interval <= 366) {
              cat("RECOMMENDATION: This appears to be annual data\n")
            }
          } else {
            cat("Irregular intervals detected\n")
            cat("Interval statistics: min =", min(diffs), "days, max =",
                max(diffs), "days, median =", median(diffs), "days\n")
          }
        }
      }
      cat("\n")
    }
  } else {
    cat("No date columns identified\n\n")
  }

  # --- 5. Analyze missing values by column ---
  cat("5. MISSING VALUE ANALYSIS BY COLUMN\n")

  # Calculate missingness by column
  na_by_col <- colSums(is.na(df))
  na_pct_by_col <- na_by_col / nrow(df) * 100

  # Create a data frame for display
  na_df <- data.frame(
    Column = names(na_by_col),
    Missing_Count = na_by_col,
    Missing_Percent = na_pct_by_col
  )
  na_df <- na_df[order(-na_df$Missing_Percent), ]

  # Display columns with missing values
  cols_with_na <- na_df[na_df$Missing_Count > 0, ]
  if (nrow(cols_with_na) > 0) {
    cat("Columns with missing values:\n")
    print(cols_with_na)

    # Recommendations based on missingness
    high_missing <- cols_with_na$Column[cols_with_na$Missing_Percent > 50]
    if (length(high_missing) > 0) {
      cat("\nWARNING: Columns with >50% missing values:",
          paste(high_missing, collapse = ", "), "\n")
      cat("RECOMMENDATION: Consider dropping these columns or using advanced imputation\n")
    }

    moderate_missing <- cols_with_na$Column[cols_with_na$Missing_Percent > 10 &
                                           cols_with_na$Missing_Percent <= 50]
    if (length(moderate_missing) > 0) {
      cat("\nNOTE: Columns with 10-50% missing values:",
          paste(moderate_missing, collapse = ", "), "\n")
      cat("RECOMMENDATION: Consider imputation strategies for these columns\n")
    }
  } else {
    cat("No missing values found in any column\n")
  }
  cat("\n")

  # --- 6. Analyze numeric columns ---
  cat("6. NUMERIC COLUMN ANALYSIS\n")

  numeric_cols <- names(df)[sapply(df, is.numeric)]
  if (length(numeric_cols) > 0) {
    cat("Found", length(numeric_cols), "numeric columns\n\n")

    for (col in numeric_cols) {
      values <- df[[col]]
      non_na_values <- values[!is.na(values)]

      if (length(non_na_values) == 0) {
        cat("Column:", col, "- All values are NA\n\n")
        next
      }

      cat("Column:", col, "\n")

      # Basic statistics
      stats <- summary(non_na_values)
      cat("Summary statistics:\n")
      print(stats)

      # Check for potential outliers
      q1 <- quantile(non_na_values, 0.25)
      q3 <- quantile(non_na_values, 0.75)
      iqr <- q3 - q1
      lower_bound <- q1 - 1.5 * iqr
      upper_bound <- q3 + 1.5 * iqr

      outliers <- non_na_values[non_na_values < lower_bound | non_na_values > upper_bound]
      if (length(outliers) > 0) {
        cat("Potential outliers detected:", length(outliers), "values\n")
        cat("Outlier range: [", min(outliers), ",", max(outliers), "]\n")
        cat("RECOMMENDATION: Check these values for data entry errors\n")
      } else {
        cat("No potential outliers detected\n")
      }

      # Check for zeros
      zero_count <- sum(non_na_values == 0)
      if (zero_count > 0) {
        zero_pct <- zero_count / length(non_na_values) * 100
        cat("Zero values:", zero_count, sprintf("(%.2f%%)", zero_pct), "\n")
        if (zero_pct > 20) {
          cat("WARNING: High percentage of zeros\n")
        }
      }

      # Check for negative values
      neg_count <- sum(non_na_values < 0)
      if (neg_count > 0) {
        neg_pct <- neg_count / length(non_na_values) * 100
        cat("Negative values:", neg_count, sprintf("(%.2f%%)", neg_pct), "\n")
      }

      cat("\n")
    }
  } else {
    cat("No numeric columns found\n\n")
  }

  # --- 7. Analyze categorical columns ---
  cat("7. CATEGORICAL COLUMN ANALYSIS\n")

  categorical_cols <- names(df)[sapply(df, function(x) is.character(x) || is.factor(x))]
  categorical_cols <- setdiff(categorical_cols, names(df)[date_cols])  # Exclude date columns

  if (length(categorical_cols) > 0) {
    cat("Found", length(categorical_cols), "categorical columns\n\n")

    for (col in categorical_cols) {
      values <- df[[col]]
      non_na_values <- values[!is.na(values)]

      if (length(non_na_values) == 0) {
        cat("Column:", col, "- All values are NA\n\n")
        next
      }

      cat("Column:", col, "\n")

      # Count unique values
      unique_values <- unique(non_na_values)
      cat("Unique values:", length(unique_values), "\n")

      # Show distribution for columns with few unique values
      if (length(unique_values) <= 20) {
        value_counts <- table(non_na_values)
        value_pcts <- prop.table(value_counts) * 100

        cat("Value distribution:\n")
        for (i in 1:length(value_counts)) {
          cat("  -", names(value_counts)[i], ":", value_counts[i],
              sprintf("(%.2f%%)", value_pcts[i]), "\n")
        }
      } else {
        cat("Too many unique values to display distribution\n")

        # Show most common values
        value_counts <- sort(table(non_na_values), decreasing = TRUE)
        cat("Top 5 most common values:\n")
        for (i in 1:min(5, length(value_counts))) {
          cat("  -", names(value_counts)[i], ":", value_counts[i],
              sprintf("(%.2f%%)", value_counts[i] / length(non_na_values) * 100), "\n")
        }
      }
      cat("\n")
    }
  } else {
    cat("No categorical columns found\n\n")
  }

  # --- 8. Generate recommendations ---
  cat("8. RECOMMENDATIONS FOR DATA LOADING\n")

  # Recommendation for missing values
  if (length(missing_patterns) > 0) {
    cat("- Use custom NA strings:", paste(names(missing_patterns), collapse = ", "), "\n")
  }

  # Recommendation for date parsing
  if (length(date_cols) > 0) {
    cat("- Parse date columns:", paste(names(df)[date_cols], collapse = ", "), "\n")
  }

  # Recommendation for column dropping
  if (exists("high_missing") && length(high_missing) > 0) {
    cat("- Consider dropping columns with high missingness:", paste(high_missing, collapse = ", "), "\n")
  }

  cat("\n")

  # Return the dataframe for further analysis
  return(df)
}

# --- Main Analysis Function ---
analyze_data_directory <- function(dir_path, source_name) {
  cat("\n\n===== ANALYZING", toupper(source_name), "DIRECTORY =====\n")
  cat("Directory:", dir_path, "\n\n")

  # Check if directory exists
  if (!dir.exists(dir_path)) {
    cat("ERROR: Directory does not exist\n\n")
    return(NULL)
  }

  # List CSV files in the directory
  csv_files <- list.files(dir_path, pattern = "*.csv", full.names = TRUE)

  if (length(csv_files) == 0) {
    cat("No CSV files found in directory\n\n")
    return(NULL)
  }

  cat("Found", length(csv_files), "CSV files\n\n")

  # Analyze each file
  results <- list()
  for (file_path in csv_files) {
    results[[basename(file_path)]] <- analyze_dataset(file_path, source_name)
  }

  return(results)
}

# --- Analyze Each Data Directory ---
cat("\n===== STARTING DIRECTORY ANALYSIS =====\n")

# Analyze combined data directory
combined_results <- analyze_data_directory(combined_data_dir, "Combined Data")

# Analyze EasyData directory
easydata_results <- analyze_data_directory(easydata_dir, "State Bank of Pakistan EasyData")

# Analyze FAO directory
fao_results <- analyze_data_directory(fao_dir, "Food and Agriculture Organization")

# Analyze Finance.gov.pk directory
finance_results <- analyze_data_directory(finance_dir, "Pakistan Ministry of Finance")

# Analyze FRED directory
fred_results <- analyze_data_directory(fred_dir, "Federal Reserve Economic Data")

# Analyze old data directory
old_data_results <- analyze_data_directory(old_data_dir, "Legacy Data")

# --- Generate Summary Report ---
cat("\n\n===== SUMMARY REPORT =====\n\n")

cat("1. DATASET COUNTS BY SOURCE\n")
cat("- Combined Data:", length(combined_results), "files\n")
cat("- State Bank of Pakistan EasyData:", length(easydata_results), "files\n")
cat("- Food and Agriculture Organization:", length(fao_results), "files\n")
cat("- Pakistan Ministry of Finance:", length(finance_results), "files\n")
cat("- Federal Reserve Economic Data:", length(fred_results), "files\n")
cat("- Legacy Data:", length(old_data_results), "files\n\n")

cat("2. KEY FINDINGS AND RECOMMENDATIONS\n")

cat("a) Missing Value Representations:\n")
cat("- Several datasets use dots (.) to represent missing values\n")
cat("- Some datasets use empty strings or special characters\n")
cat("- RECOMMENDATION: Use custom NA strings when loading data\n\n")

cat("b) Date Formats:\n")
cat("- State Bank of Pakistan uses DD-MMM-YYYY format (e.g., 30-Apr-2025)\n")
cat("- FRED uses YYYY-MM-DD format\n")
cat("- FAO uses YYYY-MM format\n")
cat("- Finance.gov.pk uses fiscal years (e.g., 2013-14)\n")
cat("- RECOMMENDATION: Use specialized date parsing for each source\n\n")

cat("c) Data Structure:\n")
cat("- EasyData files have consistent structure with observation_date and observation_value\n")
cat("- FAO data requires skipping metadata rows\n")
cat("- Finance.gov.pk data is in wide format with fiscal years\n")
cat("- RECOMMENDATION: Use source-specific loading functions\n\n")

cat("3. NEXT STEPS\n")
cat("- Implement robust data loading with proper missing value handling\n")
cat("- Standardize date formats across all datasets\n")
cat("- Create consistent column naming conventions\n")
cat("- Develop data quality checks for the loading process\n\n")

# Close the main output file
sink()

# --- Create a separate output file for the required .txt output ---
sink("00_dataset_analysis_summary.txt")
cat("===== PAKISTAN INFLATION FORECASTING PROJECT =====\n")
cat("===== DATASET ANALYSIS SUMMARY =====\n")
cat("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

cat("This file provides a summary of the dataset analysis performed by 00_dataset_analysis.R.\n")
cat("For detailed analysis, please refer to 00_dataset_analysis_output.txt.\n\n")

cat("===== DATASET COUNTS =====\n")
cat("Total datasets analyzed:",
    length(combined_results) + length(easydata_results) + length(fao_results) +
    length(finance_results) + length(fred_results) + length(old_data_results), "\n\n")

cat("===== KEY FINDINGS =====\n")
cat("1. Missing Value Patterns:\n")
cat("   - Various representations including dots, hashtags, empty strings\n")
cat("   - Recommendation: Use custom NA strings when loading\n\n")

cat("2. Date Formats:\n")
cat("   - Multiple formats across sources requiring specialized parsing\n")
cat("   - Recommendation: Use source-specific date parsing functions\n\n")

cat("3. Data Structure:\n")
cat("   - Varying structures from wide to long format\n")
cat("   - Recommendation: Standardize to consistent format for merging\n\n")

cat("===== NEXT STEPS =====\n")
cat("1. Implement robust data loading with proper missing value handling\n")
cat("2. Standardize date formats across all datasets\n")
cat("3. Create consistent column naming conventions\n")
cat("4. Develop data quality checks for the loading process\n\n")

cat("Analysis complete! Detailed reports saved to Analysis_Reports/ directory.\n")
sink()

# Print completion message
message("Dataset analysis complete!")
message("Output files saved: 00_dataset_analysis_output.txt, 00_dataset_analysis_summary.txt")
message("Proceed to 01_load_and_eda.R for data loading and exploratory data analysis")

# --- Generate Visualizations ---
message("Generating visualizations...")

# Function to create missing value visualization
create_missing_value_plot <- function(df, filename) {
  if (is.null(df) || ncol(df) <= 1) {
    return(NULL)
  }

  # Create missing value visualization
  plot_path <- file.path("Analysis_Plots", paste0("missing_", filename, ".png"))

  tryCatch({
    # Check if VIM package is available
    if ("VIM" %in% installed.packages()[,"Package"]) {
      png(plot_path, width = 800, height = 600)
      VIM::aggr(df, numbers = TRUE, sortVars = TRUE, cex.axis = 0.7, gap = 3,
                ylab = c("Missing data", "Pattern"))
      dev.off()
      return(plot_path)
    } else {
      # Alternative approach using base R
      png(plot_path, width = 800, height = 600)

      # Calculate missingness by column
      na_by_col <- colSums(is.na(df)) / nrow(df) * 100
      na_by_col <- sort(na_by_col, decreasing = TRUE)

      # Create barplot
      barplot(na_by_col,
              main = paste("Missing Values in", filename),
              xlab = "Columns",
              ylab = "Percent Missing",
              col = "steelblue",
              las = 2,
              cex.names = 0.7)

      dev.off()
      return(plot_path)
    }
  }, error = function(e) {
    warning("Could not create missing value plot for ", filename, ": ", e$message)
    return(NULL)
  })
}

# Function to create date coverage visualization
create_date_coverage_plot <- function(df, filename) {
  # Check if dataframe has a date column
  date_cols <- grep("date|time|month|year", names(df), ignore.case = TRUE)
  if (length(date_cols) == 0 || is.null(df)) {
    return(NULL)
  }

  # Try to convert to date if not already
  date_col <- names(df)[date_cols[1]]
  if (!inherits(df[[date_col]], "Date")) {
    # Try common formats
    formats <- c("%Y-%m-%d", "%d-%b-%Y", "%m/%d/%Y", "%Y/%m/%d", "%Y-%m")
    for (fmt in formats) {
      parsed_dates <- suppressWarnings(as.Date(df[[date_col]], format = fmt))
      if (sum(!is.na(parsed_dates)) > 0.5 * length(parsed_dates)) {
        df[[date_col]] <- parsed_dates
        break
      }
    }
  }

  # If still not a date, return NULL
  if (!inherits(df[[date_col]], "Date")) {
    return(NULL)
  }

  # Create date coverage plot
  plot_path <- file.path("Analysis_Plots", paste0("date_coverage_", filename, ".png"))

  tryCatch({
    # Create a data frame with dates and observation counts
    date_df <- data.frame(date = df[[date_col]])
    date_df$year <- year(date_df$date)
    date_df$month <- month(date_df$date)

    # Count observations by year-month
    date_counts <- date_df %>%
      group_by(year, month) %>%
      summarize(count = n(), .groups = "drop")

    # Create the plot
    p <- ggplot(date_counts, aes(x = month, y = year, fill = count)) +
      geom_tile(color = "white") +
      scale_fill_gradient(low = "lightblue", high = "darkblue") +
      labs(title = paste("Date Coverage for", filename),
           x = "Month", y = "Year", fill = "Count") +
      theme_minimal() +
      scale_x_continuous(breaks = 1:12, labels = month.abb) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))

    ggsave(plot_path, p, width = 10, height = 8)

    return(plot_path)
  }, error = function(e) {
    warning("Could not create date coverage plot for ", filename, ": ", e$message)
    return(NULL)
  })
}

# Create visualizations for each dataset
create_visualizations <- function(results_list, source_name) {
  vis_results <- list()

  for (filename in names(results_list)) {
    df <- results_list[[filename]]
    if (!is.null(df)) {
      missing_plot <- create_missing_value_plot(df, paste0(source_name, "_", filename))
      date_plot <- create_date_coverage_plot(df, paste0(source_name, "_", filename))

      vis_results[[filename]] <- list(
        missing_plot = missing_plot,
        date_plot = date_plot
      )
    }
  }

  return(vis_results)
}

# Create visualizations for each source
combined_vis <- create_visualizations(combined_results, "combined")
easydata_vis <- create_visualizations(easydata_results, "easydata")
fao_vis <- create_visualizations(fao_results, "fao")
finance_vis <- create_visualizations(finance_results, "finance")
fred_vis <- create_visualizations(fred_results, "fred")
old_data_vis <- create_visualizations(old_data_results, "old_data")

# --- Create a comprehensive dataset catalog ---
message("Creating dataset catalog...")

# Create a data frame with information about all datasets
catalog_rows <- list()

# Function to add datasets to catalog
add_to_catalog <- function(results_list, source_name) {
  for (filename in names(results_list)) {
    df <- results_list[[filename]]
    if (!is.null(df)) {
      # Get basic info
      n_rows <- nrow(df)
      n_cols <- ncol(df)

      # Get date range if available
      date_range <- "Unknown"
      date_cols <- grep("date|time|month|year", names(df), ignore.case = TRUE)
      if (length(date_cols) > 0) {
        date_col <- names(df)[date_cols[1]]
        if (inherits(df[[date_col]], "Date")) {
          date_range <- paste(format(min(df[[date_col]], na.rm = TRUE), "%Y-%m-%d"), "to",
                             format(max(df[[date_col]], na.rm = TRUE), "%Y-%m-%d"))
        }
      }

      # Get missing value percentage
      na_pct <- sum(is.na(df)) / (n_rows * n_cols) * 100

      # Add to catalog
      catalog_rows[[length(catalog_rows) + 1]] <<- data.frame(
        Filename = filename,
        Source = source_name,
        Rows = n_rows,
        Columns = n_cols,
        Date_Range = date_range,
        Missing_Pct = round(na_pct, 2),
        stringsAsFactors = FALSE
      )
    }
  }
}

# Add all datasets to catalog
add_to_catalog(combined_results, "Combined Data")
add_to_catalog(easydata_results, "State Bank of Pakistan")
add_to_catalog(fao_results, "FAO")
add_to_catalog(finance_results, "Finance.gov.pk")
add_to_catalog(fred_results, "FRED")
add_to_catalog(old_data_results, "Legacy Data")

# Create the catalog data frame
dataset_catalog <- do.call(rbind, catalog_rows)

# Save the catalog
write.csv(dataset_catalog, "Analysis_Reports/dataset_catalog.csv", row.names = FALSE)

# Add catalog to the output file
sink("00_dataset_analysis_output.txt", append = TRUE)
cat("\n\n===== DATASET CATALOG =====\n\n")
print(dataset_catalog)
sink()

message("Dataset catalog saved to Analysis_Reports/dataset_catalog.csv")

# --- End of script ---
