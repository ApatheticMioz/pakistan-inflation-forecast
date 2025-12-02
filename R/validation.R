# Data Validation Module
# Provides schema validation for input datasets

#' Validate CPI Dataset
#'
#' Validates the Consumer Price Index dataset structure and content
#'
#' @param df Data frame containing CPI data
#' @return List with validation results
#' @export
validate_cpi_data <- function(df) {
  results <- list(
    valid = TRUE,
    errors = character(),
    warnings = character()
  )
  
  # Required columns
  required_cols <- c("observation_date", "observation_value")
  missing_cols <- setdiff(required_cols, names(df))
  
  if (length(missing_cols) > 0) {
    # Try alternative column names
    alt_names <- list(
      observation_date = c("date", "Date", "DATE"),
      observation_value = c("value", "Value", "cpi", "CPI")
    )
    
    for (col in missing_cols) {
      found <- FALSE
      for (alt in alt_names[[col]]) {
        if (alt %in% names(df)) {
          results$warnings <- c(results$warnings, 
            sprintf("Column '%s' not found, using '%s' instead", col, alt))
          found <- TRUE
          break
        }
      }
      
      if (!found) {
        results$valid <- FALSE
        results$errors <- c(results$errors, 
          sprintf("Required column '%s' not found", col))
      }
    }
  }
  
  # Validate date range
  if ("observation_date" %in% names(df) || any(c("date", "Date") %in% names(df))) {
    date_col <- if ("observation_date" %in% names(df)) "observation_date" else 
                if ("date" %in% names(df)) "date" else "Date"
    
    dates <- as.Date(df[[date_col]])
    if (any(is.na(dates))) {
      na_count <- sum(is.na(dates))
      results$warnings <- c(results$warnings,
        sprintf("%d dates could not be parsed", na_count))
    }
    
    # Check for reasonable date range
    if (min(dates, na.rm = TRUE) < as.Date("1990-01-01")) {
      results$warnings <- c(results$warnings,
        "Data contains dates before 1990, which may be unreliable")
    }
    
    if (max(dates, na.rm = TRUE) > Sys.Date() + 365) {
      results$errors <- c(results$errors,
        "Data contains future dates more than 1 year ahead")
      results$valid <- FALSE
    }
  }
  
  # Validate CPI values
  value_col <- if ("observation_value" %in% names(df)) "observation_value" else
               if ("value" %in% names(df)) "value" else
               if ("cpi" %in% names(df)) "cpi" else NULL
  
  if (!is.null(value_col) && value_col %in% names(df)) {
    values <- as.numeric(df[[value_col]])
    
    # Check for NA values
    na_pct <- sum(is.na(values)) / length(values) * 100
    if (na_pct > 20) {
      results$warnings <- c(results$warnings,
        sprintf("%.1f%% of CPI values are missing", na_pct))
    }
    
    # Check for reasonable value range (inflation typically -10% to 50% for Pakistan)
    non_na_values <- values[!is.na(values)]
    if (any(non_na_values < -20 | non_na_values > 100)) {
      results$warnings <- c(results$warnings,
        "Some CPI values are outside expected range (-20% to 100%)")
    }
    
    # Check for negative values if unexpected
    if (any(non_na_values < 0)) {
      results$warnings <- c(results$warnings,
        "Data contains negative CPI values (deflation)")
    }
  }
  
  return(results)
}

#' Validate Exchange Rate Dataset
#'
#' Validates the exchange rate dataset structure and content
#'
#' @param df Data frame containing exchange rate data
#' @return List with validation results
#' @export
validate_exchange_rate_data <- function(df) {
  results <- list(
    valid = TRUE,
    errors = character(),
    warnings = character()
  )
  
  # Required columns
  required_cols <- c("date", "observation_value")
  alternative_cols <- list(
    date = c("observation_date", "Date", "DATE"),
    observation_value = c("value", "exchange_rate", "rate")
  )
  
  # Check required columns
  for (col in names(alternative_cols)) {
    if (!col %in% names(df)) {
      found <- FALSE
      for (alt in alternative_cols[[col]]) {
        if (alt %in% names(df)) {
          found <- TRUE
          results$warnings <- c(results$warnings,
            sprintf("Using '%s' as '%s' column", alt, col))
          break
        }
      }
      if (!found && col %in% required_cols) {
        results$errors <- c(results$errors,
          sprintf("Required column '%s' not found", col))
        results$valid <- FALSE
      }
    }
  }
  
  # Validate exchange rate values
  value_col <- intersect(names(df), c("observation_value", "value", "exchange_rate", "rate"))[1]
  
  if (!is.null(value_col) && value_col %in% names(df)) {
    values <- as.numeric(df[[value_col]])
    
    # Exchange rate should be positive
    if (any(values <= 0, na.rm = TRUE)) {
      results$errors <- c(results$errors,
        "Exchange rate contains non-positive values")
      results$valid <- FALSE
    }
    
    # Reasonable range for PKR/USD (historically 1-400)
    if (any(values > 500 | values < 0.5, na.rm = TRUE)) {
      results$warnings <- c(results$warnings,
        "Exchange rate values outside typical range")
    }
  }
  
  return(results)
}

#' Validate Oil Price Dataset
#'
#' Validates the oil price dataset structure and content
#'
#' @param df Data frame containing oil price data
#' @return List with validation results
#' @export
validate_oil_price_data <- function(df) {
  results <- list(
    valid = TRUE,
    errors = character(),
    warnings = character()
  )
  
  # Check for date column
  date_cols <- c("date", "observation_date", "Date")
  if (!any(date_cols %in% names(df))) {
    results$errors <- c(results$errors, "No date column found")
    results$valid <- FALSE
  }
  
  # Check for value column
  value_cols <- c("mcoilbrenteu", "observation_value", "price", "oil_price")
  value_col <- intersect(names(df), value_cols)[1]
  
  if (is.null(value_col) || is.na(value_col)) {
    results$errors <- c(results$errors, "No oil price column found")
    results$valid <- FALSE
  } else {
    values <- as.numeric(df[[value_col]])
    
    # Oil price should be positive
    if (any(values <= 0, na.rm = TRUE)) {
      results$errors <- c(results$errors,
        "Oil price contains non-positive values")
      results$valid <- FALSE
    }
    
    # Reasonable range for oil price (historically $10-$150)
    if (any(values > 200 | values < 5, na.rm = TRUE)) {
      results$warnings <- c(results$warnings,
        "Oil price values outside typical range ($5-$200)")
    }
  }
  
  return(results)
}

#' Validate All Input Datasets
#'
#' Runs validation on all standard input datasets
#'
#' @param datasets Named list of data frames
#' @return List with validation results for each dataset
#' @export
validate_all_datasets <- function(datasets) {
  results <- list()
  
  # Validate CPI if present
  if ("cpi" %in% names(datasets) && !is.null(datasets$cpi)) {
    results$cpi <- validate_cpi_data(datasets$cpi)
  }
  
  # Validate exchange rate if present
  if ("exchange_rate" %in% names(datasets) && !is.null(datasets$exchange_rate)) {
    results$exchange_rate <- validate_exchange_rate_data(datasets$exchange_rate)
  }
  
  # Validate oil prices if present
  if ("oil_prices" %in% names(datasets) && !is.null(datasets$oil_prices)) {
    results$oil_prices <- validate_oil_price_data(datasets$oil_prices)
  }
  
  # Summary
  all_valid <- all(sapply(results, function(r) r$valid))
  total_errors <- sum(sapply(results, function(r) length(r$errors)))
  total_warnings <- sum(sapply(results, function(r) length(r$warnings)))
  
  results$summary <- list(
    all_valid = all_valid,
    total_errors = total_errors,
    total_warnings = total_warnings,
    datasets_validated = length(results) - 1
  )
  
  return(results)
}

#' Print Validation Results
#'
#' Pretty prints validation results
#'
#' @param results Validation results list
#' @return NULL (prints to console)
#' @export
print_validation_results <- function(results) {
  cat("===== DATA VALIDATION RESULTS =====\n\n")
  
  for (name in names(results)) {
    if (name == "summary") next
    
    cat(sprintf("Dataset: %s\n", toupper(name)))
    cat(sprintf("  Status: %s\n", ifelse(results[[name]]$valid, "VALID", "INVALID")))
    
    if (length(results[[name]]$errors) > 0) {
      cat("  Errors:\n")
      for (err in results[[name]]$errors) {
        cat(sprintf("    - %s\n", err))
      }
    }
    
    if (length(results[[name]]$warnings) > 0) {
      cat("  Warnings:\n")
      for (warn in results[[name]]$warnings) {
        cat(sprintf("    - %s\n", warn))
      }
    }
    
    cat("\n")
  }
  
  if ("summary" %in% names(results)) {
    cat("===== SUMMARY =====\n")
    cat(sprintf("Datasets validated: %d\n", results$summary$datasets_validated))
    cat(sprintf("All valid: %s\n", ifelse(results$summary$all_valid, "YES", "NO")))
    cat(sprintf("Total errors: %d\n", results$summary$total_errors))
    cat(sprintf("Total warnings: %d\n", results$summary$total_warnings))
  }
  
  invisible(NULL)
}
