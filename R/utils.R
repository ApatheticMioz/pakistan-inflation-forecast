# Utils: Reusable utility functions for Pakistan Inflation Forecasting Project
# This module contains common functions used across the analysis pipeline

#' Load Configuration
#'
#' Loads configuration from config.yml file
#'
#' @param config_path Path to the configuration file
#' @return List containing configuration values
#' @export
load_config <- function(config_path = "config.yml") {
  if (!file.exists(config_path)) {
    warning(paste("Configuration file not found:", config_path))
    return(get_default_config())
  }
  
  tryCatch({
    config <- yaml::read_yaml(config_path)
    return(config)
  }, error = function(e) {
    warning(paste("Error reading config file:", e$message))
    return(get_default_config())
  })
}

#' Get Default Configuration
#'
#' Returns default configuration values when config.yml is not available
#'
#' @return List containing default configuration values
#' @export
get_default_config <- function() {
  list(
    data = list(
      main_data_dir = "Data",
      combined_data_dir = "Data/data_combined",
      output_dir = "Output",
      processed_data_dir = "Processed_Data",
      plots_dir = "Plots",
      logs_dir = "Logs",
      models_dir = "Models",
      final_results_dir = "Final_Results",
      na_strings = c("NA", "N/A", "n/a", "#", ".", "-", "", "NULL", "null", "MISSING", "missing")
    ),
    model = list(
      train_ratio = 0.80,
      cv_folds = 10,
      seed = 123,
      forecast_horizon = 12,
      confidence_levels = c(0.80, 0.95)
    ),
    features = list(
      lag_periods = c(1, 3, 6, 12),
      ma_windows = c(3, 6, 12),
      correlation_threshold = 0.3,
      outlier_iqr_multiplier = 3.0,
      max_missingness_threshold = 0.30
    )
  )
}

#' Create Output Directories
#'
#' Creates all necessary output directories for the analysis
#'
#' @param config Configuration list containing directory paths
#' @return NULL (side effect: creates directories)
#' @export
create_output_directories <- function(config = NULL) {
  if (is.null(config)) {
    config <- get_default_config()
  }
  
  dirs <- c(
    config$data$output_dir,
    config$data$processed_data_dir,
    config$data$plots_dir,
    config$data$logs_dir,
    config$data$models_dir,
    config$data$final_results_dir,
    file.path(config$data$plots_dir, "eda"),
    file.path(config$data$plots_dir, "model_prep"),
    file.path(config$data$plots_dir, "arima"),
    file.path(config$data$plots_dir, "regularization"),
    file.path(config$data$plots_dir, "uncertainty"),
    file.path(config$data$plots_dir, "evaluation"),
    file.path(config$data$processed_data_dir, "uncertainty")
  )
  
  for (dir in dirs) {
    dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  }
  
  invisible(NULL)
}

#' Standardize Column Names
#'
#' Converts column names to lowercase with underscores
#'
#' @param df Data frame to process
#' @return Data frame with standardized column names
#' @export
standardize_names <- function(df) {
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }
  names(df) <- tolower(gsub("[ .-]", "_", names(df)))
  return(df)
}

#' Convert Columns to Numeric
#'
#' Converts specified columns (or all non-excluded) to numeric
#'
#' @param df Data frame to process
#' @param exclude_cols Character vector of column names to exclude
#' @return Data frame with numeric conversions applied
#' @export
convert_to_numeric <- function(df, exclude_cols = c()) {
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }
  
  for (col in setdiff(names(df), exclude_cols)) {
    if (!is.numeric(df[[col]])) {
      df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
    }
  }
  return(df)
}

#' Detect Outliers
#'
#' Detects outliers using the IQR method
#'
#' @param x Numeric vector
#' @param multiplier IQR multiplier for outlier detection (default: 3)
#' @return Logical vector indicating outlier positions
#' @export
detect_outliers <- function(x, multiplier = 3) {
  if (!is.numeric(x)) {
    return(rep(FALSE, length(x)))
  }
  
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - multiplier * iqr
  upper_bound <- q3 + multiplier * iqr
  
  return(x < lower_bound | x > upper_bound)
}

#' Cap Outliers
#'
#' Caps outliers at specified bounds using IQR method
#'
#' @param x Numeric vector
#' @param multiplier IQR multiplier for bound calculation (default: 3)
#' @return Numeric vector with outliers capped
#' @export
cap_outliers <- function(x, multiplier = 3) {
  if (!is.numeric(x)) {
    return(x)
  }
  
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - multiplier * iqr
  upper_bound <- q3 + multiplier * iqr
  
  x[x < lower_bound] <- lower_bound
  x[x > upper_bound] <- upper_bound
  
  return(x)
}

#' Create Lag Variables
#'
#' Creates lagged versions of a variable
#'
#' @param df Data frame containing the variable
#' @param var_name Name of the variable to lag
#' @param lags Vector of lag periods (default: c(1, 3, 6, 12))
#' @return Data frame with lag variables added
#' @export
create_lag_variables <- function(df, var_name, lags = c(1, 3, 6, 12)) {
  if (!var_name %in% names(df)) {
    return(df)
  }
  
  for (lag in lags) {
    lag_name <- paste0(var_name, "_lag", lag)
    df[[lag_name]] <- dplyr::lag(df[[var_name]], lag)
  }
  
  return(df)
}

#' Create Moving Average Variables
#'
#' Creates rolling moving average versions of a variable
#'
#' @param df Data frame containing the variable
#' @param var_name Name of the variable
#' @param windows Vector of window sizes (default: c(3, 6, 12))
#' @return Data frame with moving average variables added
#' @export
create_ma_variables <- function(df, var_name, windows = c(3, 6, 12)) {
  if (!var_name %in% names(df)) {
    return(df)
  }
  
  for (window in windows) {
    ma_name <- paste0(var_name, "_ma", window)
    df[[ma_name]] <- zoo::rollmean(df[[var_name]], k = window, fill = NA, align = "right")
  }
  
  return(df)
}

#' Create Growth Rate Variables
#'
#' Creates month-over-month and year-over-year growth rates
#'
#' @param df Data frame containing the variable
#' @param var_name Name of the variable
#' @return Data frame with growth rate variables added
#' @export
create_growth_variables <- function(df, var_name) {
  if (!var_name %in% names(df)) {
    return(df)
  }
  
  # Month-over-month percent change
  mom_name <- paste0(var_name, "_mom_pct")
  df[[mom_name]] <- (df[[var_name]] / dplyr::lag(df[[var_name]], 1) - 1) * 100
  
  # Year-over-year percent change
  yoy_name <- paste0(var_name, "_yoy_pct")
  df[[yoy_name]] <- (df[[var_name]] / dplyr::lag(df[[var_name]], 12) - 1) * 100
  
  return(df)
}

#' Calculate Model Accuracy Metrics
#'
#' Calculates MSE, RMSE, MAE, and R-squared
#'
#' @param actual Numeric vector of actual values
#' @param predicted Numeric vector of predicted values
#' @param model_name Name of the model for labeling
#' @return Data frame with accuracy metrics
#' @export
calculate_accuracy <- function(actual, predicted, model_name = "Model") {
  # Ensure vectors have same length
  if (length(predicted) != length(actual)) {
    min_length <- min(length(actual), length(predicted))
    actual <- actual[1:min_length]
    predicted <- predicted[1:min_length]
  }
  
  # Remove NA values
  valid_idx <- !is.na(actual) & !is.na(predicted)
  actual <- actual[valid_idx]
  predicted <- predicted[valid_idx]
  
  if (length(actual) == 0) {
    return(data.frame(
      Model = model_name,
      MSE = NA,
      RMSE = NA,
      MAE = NA,
      R_Squared = NA
    ))
  }
  
  # Calculate metrics
  errors <- actual - predicted
  mse <- mean(errors^2)
  rmse <- sqrt(mse)
  mae <- mean(abs(errors))
  
  ss_res <- sum(errors^2)
  ss_tot <- sum((actual - mean(actual))^2)
  r_squared <- ifelse(ss_tot == 0, NA, 1 - ss_res / ss_tot)
  
  return(data.frame(
    Model = model_name,
    MSE = mse,
    RMSE = rmse,
    MAE = mae,
    R_Squared = r_squared
  ))
}

#' Safe File Read
#'
#' Safely reads a file with error handling
#'
#' @param file_path Path to the file
#' @param reader_func Function to read the file (e.g., readr::read_csv)
#' @param description Description of the file for logging
#' @param ... Additional arguments to pass to reader function
#' @return Data frame or NULL if reading fails
#' @export
safe_read <- function(file_path, reader_func = readr::read_csv, description = "", ...) {
  if (!file.exists(file_path)) {
    message(paste("File not found:", file_path, "-", description))
    return(NULL)
  }
  
  tryCatch({
    result <- reader_func(file_path, ...)
    message(paste("Successfully loaded:", basename(file_path), "-", description))
    return(result)
  }, error = function(e) {
    message(paste("Error loading:", basename(file_path), "-", e$message))
    return(NULL)
  })
}

#' Log Message
#'
#' Logs a message with timestamp
#'
#' @param message Message to log
#' @param level Log level (INFO, WARNING, ERROR, DEBUG)
#' @return NULL (side effect: prints message)
#' @export
log_message <- function(msg, level = "INFO") {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  formatted_msg <- paste0("[", timestamp, "] [", level, "] ", msg)
  message(formatted_msg)
  invisible(NULL)
}

#' Validate Data Quality
#'
#' Performs basic data quality checks
#'
#' @param df Data frame to validate
#' @param required_cols Character vector of required column names
#' @param date_col Name of the date column (if applicable)
#' @return List with validation results
#' @export
validate_data_quality <- function(df, required_cols = NULL, date_col = "date") {
  results <- list(
    valid = TRUE,
    issues = character(),
    row_count = nrow(df),
    col_count = ncol(df)
  )
  
  # Check for empty data frame
  if (nrow(df) == 0) {
    results$valid <- FALSE
    results$issues <- c(results$issues, "Data frame is empty")
    return(results)
  }
  
  # Check required columns
  if (!is.null(required_cols)) {
    missing_cols <- setdiff(required_cols, names(df))
    if (length(missing_cols) > 0) {
      results$valid <- FALSE
      results$issues <- c(results$issues, 
                          paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
    }
  }
  
  # Check date column
  if (date_col %in% names(df)) {
    if (!inherits(df[[date_col]], "Date")) {
      results$issues <- c(results$issues, "Date column is not of Date type")
    }
    
    # Check for duplicate dates
    dup_dates <- sum(duplicated(df[[date_col]]))
    if (dup_dates > 0) {
      results$issues <- c(results$issues, 
                          paste("Found", dup_dates, "duplicate dates"))
    }
  }
  
  # Check for infinite values
  inf_counts <- colSums(sapply(df, function(x) is.infinite(as.numeric(x))), na.rm = TRUE)
  if (any(inf_counts > 0)) {
    inf_cols <- names(inf_counts[inf_counts > 0])
    results$issues <- c(results$issues,
                        paste("Infinite values in:", paste(inf_cols, collapse = ", ")))
  }
  
  return(results)
}

#' Calculate Missingness Summary
#'
#' Calculates missingness statistics for each column
#'
#' @param df Data frame to analyze
#' @return Data frame with missingness statistics
#' @export
calculate_missingness <- function(df) {
  missing_counts <- colSums(is.na(df))
  missing_pcts <- (missing_counts / nrow(df)) * 100
  
  data.frame(
    Variable = names(missing_counts),
    Missing_Count = missing_counts,
    Missing_Percent = round(missing_pcts, 2),
    stringsAsFactors = FALSE,
    row.names = NULL
  ) %>%
    dplyr::arrange(dplyr::desc(Missing_Percent))
}
