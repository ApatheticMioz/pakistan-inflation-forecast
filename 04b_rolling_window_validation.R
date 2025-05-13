# 04b_rolling_window_validation.R
# Pakistan Inflation Forecasting Project: Rolling Window Validation
# This script implements rolling-window validation for time series forecasting
#
# Purpose:
# 1. Implement rolling-window forecasting
# 2. Evaluate models using multiple forecast origins
# 3. Compare performance across different window sizes
# 4. Visualize rolling window validation results
#
# Author: <Your Name>
# Date: 2025-05-13

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(lubridate)
  library(zoo)
  library(forecast)
  library(ggplot2)
  library(gridExtra)
  library(stringr)
  library(glmnet)
  library(tseries)
})

# --- Create output directories ---
dir.create("Processed_Data/rolling_window", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/rolling_window", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/04b_rolling_window_validation.txt"
sink(log_file)
cat("===== ROLLING WINDOW VALIDATION =====\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Load modeling dataframe ---
cat("Loading modeling dataframe...\n")
if (file.exists("Processed_Data/model_df.rds")) {
  model_df <- readRDS("Processed_Data/model_df.rds")
  cat("Loaded dataframe with", nrow(model_df), "rows and", ncol(model_df), "columns\n")
  cat("Date range:", format(min(model_df$date), "%Y-%m-%d"), "to",
      format(max(model_df$date), "%Y-%m-%d"), "\n\n")
} else {
  cat("ERROR: Could not find model_df.rds\n")
  cat("Please run 03_prepare_modeling_df.R first to create this file\n\n")
  stop("File not found: Processed_Data/model_df.rds")
}

# --- Load time series objects ---
cat("Loading time series objects...\n")
if (file.exists("Processed_Data/ts_objects.rds")) {
  ts_objects <- readRDS("Processed_Data/ts_objects.rds")
  cat("Loaded time series objects\n\n")
} else {
  cat("ERROR: Could not find ts_objects.rds\n")
  cat("Please run 03_prepare_modeling_df.R first to create this file\n\n")
  stop("File not found: Processed_Data/ts_objects.rds")
}

# --- Define Rolling Window Parameters ---
cat("===== DEFINING ROLLING WINDOW PARAMETERS =====\n\n")

# Define window sizes to test
window_sizes <- c(24, 36, 48, 60)  # 2, 3, 4, and 5 years
cat("Testing window sizes:", paste(window_sizes, collapse = ", "), "months\n")

# Define forecast horizons
forecast_horizons <- c(1, 3, 6, 12)  # 1, 3, 6, and 12 months ahead
cat("Testing forecast horizons:", paste(forecast_horizons, collapse = ", "), "months\n")

# Define step size (how often to refit the model)
step_size <- 1  # Refit every month
cat("Step size:", step_size, "month(s)\n\n")

# --- Define Models to Test ---
cat("===== DEFINING MODELS TO TEST =====\n\n")

# Define models to test
models <- c("arima", "lasso", "ridge", "elastic_net")
cat("Testing models:", paste(models, collapse = ", "), "\n\n")

# --- Define Evaluation Metrics ---
cat("===== DEFINING EVALUATION METRICS =====\n\n")

# Define evaluation metrics
metrics <- c("rmse", "mae", "mape")
cat("Using evaluation metrics:", paste(metrics, collapse = ", "), "\n\n")

# --- Implement Rolling Window Validation ---
cat("===== IMPLEMENTING ROLLING WINDOW VALIDATION =====\n\n")

# Function to fit ARIMA model
fit_arima <- function(train_data) {
  tryCatch({
    # Convert to time series
    train_ts <- ts(train_data$cpi, frequency = 12)
    
    # Fit auto.arima model
    model <- auto.arima(train_ts, seasonal = TRUE, stepwise = TRUE, approximation = TRUE)
    
    return(model)
  }, error = function(e) {
    cat("Error fitting ARIMA model:", e$message, "\n")
    return(NULL)
  })
}

# Function to fit regularization models
fit_regularization <- function(train_data, model_type = "lasso") {
  tryCatch({
    # Prepare data
    # Select standardized predictors (ending with _std)
    pred_cols <- grep("_std$", names(train_data), value = TRUE)
    
    # Create model matrix
    x <- as.matrix(train_data[, pred_cols])
    y <- train_data$cpi
    
    # Set alpha based on model type
    alpha <- switch(model_type,
                   "lasso" = 1,
                   "ridge" = 0,
                   "elastic_net" = 0.5)
    
    # Fit model with cross-validation
    model <- cv.glmnet(x, y, alpha = alpha)
    
    return(list(model = model, pred_cols = pred_cols))
  }, error = function(e) {
    cat("Error fitting", model_type, "model:", e$message, "\n")
    return(NULL)
  })
}

# Function to make forecasts
make_forecast <- function(model, test_data, model_type, horizon) {
  tryCatch({
    if (model_type == "arima") {
      # Make ARIMA forecast
      forecast_result <- forecast(model, h = horizon)
      predictions <- as.numeric(forecast_result$mean)
    } else {
      # Make regularization model forecast
      pred_cols <- model$pred_cols
      x_test <- as.matrix(test_data[1:horizon, pred_cols])
      
      # Use optimal lambda
      predictions <- predict(model$model, newx = x_test, s = "lambda.min")
    }
    
    return(predictions)
  }, error = function(e) {
    cat("Error making forecast with", model_type, "model:", e$message, "\n")
    return(rep(NA, horizon))
  })
}

# Function to calculate evaluation metrics
calculate_metrics <- function(actual, predicted) {
  # Remove any NA values
  valid_idx <- !is.na(actual) & !is.na(predicted)
  actual <- actual[valid_idx]
  predicted <- predicted[valid_idx]
  
  # If no valid data, return NA for all metrics
  if (length(actual) == 0) {
    return(list(rmse = NA, mae = NA, mape = NA))
  }
  
  # Calculate metrics
  rmse <- sqrt(mean((actual - predicted)^2))
  mae <- mean(abs(actual - predicted))
  
  # Handle zero or near-zero values for MAPE
  if (any(abs(actual) < 0.01)) {
    mape <- NA
  } else {
    mape <- mean(abs((actual - predicted) / actual)) * 100
  }
  
  return(list(rmse = rmse, mae = mae, mape = mape))
}

# Function to run rolling window validation for a specific window size
run_rolling_window <- function(data, window_size, horizons, models, step_size) {
  cat(sprintf("Running rolling window validation with window size %d months...\n", window_size))
  
  # Determine number of windows
  n_rows <- nrow(data)
  max_start <- n_rows - window_size - max(horizons)
  window_starts <- seq(1, max_start, by = step_size)
  
  cat(sprintf("Number of windows: %d\n", length(window_starts)))
  
  # Initialize results dataframe
  results <- data.frame()
  
  # Loop through each window
  for (i in seq_along(window_starts)) {
    start_idx <- window_starts[i]
    end_idx <- start_idx + window_size - 1
    
    # Extract training data
    train_data <- data[start_idx:end_idx, ]
    
    # Get window date range for logging
    window_start_date <- format(train_data$date[1], "%Y-%m-%d")
    window_end_date <- format(train_data$date[nrow(train_data)], "%Y-%m-%d")
    
    cat(sprintf("Window %d/%d: %s to %s\n", 
                i, length(window_starts), window_start_date, window_end_date))
    
    # Loop through each model
    for (model_type in models) {
      cat(sprintf("  Fitting %s model...\n", model_type))
      
      # Fit model
      if (model_type == "arima") {
        model <- fit_arima(train_data)
      } else {
        model <- fit_regularization(train_data, model_type)
      }
      
      # Skip if model fitting failed
      if (is.null(model)) {
        cat(sprintf("  Failed to fit %s model, skipping\n", model_type))
        next
      }
      
      # Loop through each forecast horizon
      for (h in horizons) {
        cat(sprintf("    Making %d-month forecast...\n", h))
        
        # Extract test data
        test_idx <- (end_idx + 1):(end_idx + h)
        if (max(test_idx) > n_rows) {
          cat(sprintf("    Not enough data for %d-month forecast, skipping\n", h))
          next
        }
        
        test_data <- data[test_idx, ]
        
        # Make forecast
        predictions <- make_forecast(model, test_data, model_type, h)
        
        # Calculate metrics
        actual <- test_data$cpi
        metrics <- calculate_metrics(actual, predictions)
        
        # Add to results
        window_result <- data.frame(
          window_id = i,
          window_size = window_size,
          window_start_date = window_start_date,
          window_end_date = window_end_date,
          forecast_date = format(test_data$date[1], "%Y-%m-%d"),
          model = model_type,
          horizon = h,
          rmse = metrics$rmse,
          mae = metrics$mae,
          mape = metrics$mape
        )
        
        results <- rbind(results, window_result)
      }
    }
  }
  
  return(results)
}

# Run rolling window validation for each window size
all_results <- data.frame()

for (window_size in window_sizes) {
  window_results <- run_rolling_window(
    data = model_df,
    window_size = window_size,
    horizons = forecast_horizons,
    models = models,
    step_size = step_size
  )
  
  all_results <- rbind(all_results, window_results)
}

# --- Analyze Results ---
cat("\n===== ANALYZING RESULTS =====\n\n")

# Calculate average metrics by model, window size, and horizon
avg_results <- all_results %>%
  group_by(model, window_size, horizon) %>%
  summarize(
    avg_rmse = mean(rmse, na.rm = TRUE),
    avg_mae = mean(mae, na.rm = TRUE),
    avg_mape = mean(mape, na.rm = TRUE),
    n_windows = n()
  ) %>%
  arrange(horizon, window_size, avg_rmse)

# Print average results
cat("Average RMSE by model, window size, and horizon:\n")
print(avg_results)
cat("\n")

# Find best model for each horizon
best_models <- avg_results %>%
  group_by(horizon) %>%
  slice_min(order_by = avg_rmse, n = 1)

cat("Best models by forecast horizon (based on RMSE):\n")
print(best_models)
cat("\n")

# --- Create Visualizations ---
cat("\n===== CREATING VISUALIZATIONS =====\n\n")

# Plot RMSE by window size for each model and horizon
for (h in forecast_horizons) {
  # Filter data for this horizon
  horizon_data <- avg_results %>%
    filter(horizon == h)
  
  # Create plot
  p <- ggplot(horizon_data, aes(x = factor(window_size), y = avg_rmse, fill = model)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = paste(h, "Month Forecast Horizon"),
         subtitle = "Average RMSE by Model and Window Size",
         x = "Window Size (months)",
         y = "Average RMSE") +
    theme_minimal() +
    scale_fill_brewer(palette = "Set1")
  
  # Save plot
  ggsave(file.path("Plots/rolling_window", paste0("rmse_by_window_h", h, ".png")),
         p, width = 10, height = 6)
  
  cat(sprintf("Created RMSE by window size plot for %d-month horizon\n", h))
}

# Plot RMSE by horizon for each model and window size
for (ws in window_sizes) {
  # Filter data for this window size
  window_data <- avg_results %>%
    filter(window_size == ws)
  
  # Create plot
  p <- ggplot(window_data, aes(x = factor(horizon), y = avg_rmse, fill = model)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = paste(ws, "Month Window Size"),
         subtitle = "Average RMSE by Model and Forecast Horizon",
         x = "Forecast Horizon (months)",
         y = "Average RMSE") +
    theme_minimal() +
    scale_fill_brewer(palette = "Set1")
  
  # Save plot
  ggsave(file.path("Plots/rolling_window", paste0("rmse_by_horizon_w", ws, ".png")),
         p, width = 10, height = 6)
  
  cat(sprintf("Created RMSE by horizon plot for %d-month window size\n", ws))
}

# Plot RMSE over time for best model configuration
best_config <- best_models[1, ]
best_model <- best_config$model
best_window <- best_config$window_size
best_horizon <- best_config$horizon

cat(sprintf("Creating time series plot for best configuration: %s model, %d-month window, %d-month horizon\n",
            best_model, best_window, best_horizon))

# Filter results for best configuration
best_results <- all_results %>%
  filter(model == best_model, window_size == best_window, horizon == best_horizon) %>%
  arrange(forecast_date)

# Convert forecast_date to Date
best_results$forecast_date <- as.Date(best_results$forecast_date)

# Create plot
p <- ggplot(best_results, aes(x = forecast_date, y = rmse)) +
  geom_line() +
  geom_point() +
  labs(title = paste("RMSE Over Time for Best Configuration"),
       subtitle = paste(best_model, "model,", best_window, "month window,", best_horizon, "month horizon"),
       x = "Forecast Date",
       y = "RMSE") +
  theme_minimal()

# Save plot
ggsave(file.path("Plots/rolling_window", "rmse_over_time_best_config.png"),
       p, width = 10, height = 6)

# --- Save Results ---
cat("\n===== SAVING RESULTS =====\n\n")

# Save detailed results
write_csv(all_results, "Processed_Data/rolling_window/all_results.csv")
cat("Saved detailed results to Processed_Data/rolling_window/all_results.csv\n")

# Save average results
write_csv(avg_results, "Processed_Data/rolling_window/avg_results.csv")
cat("Saved average results to Processed_Data/rolling_window/avg_results.csv\n")

# Save best models
write_csv(best_models, "Processed_Data/rolling_window/best_models.csv")
cat("Saved best models to Processed_Data/rolling_window/best_models.csv\n")

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Rolling window validation completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat("- Processed_Data/rolling_window/all_results.csv\n")
cat("- Processed_Data/rolling_window/avg_results.csv\n")
cat("- Processed_Data/rolling_window/best_models.csv\n")
cat("\nPlots created:\n")
for (h in forecast_horizons) {
  cat(sprintf("- Plots/rolling_window/rmse_by_window_h%d.png\n", h))
}
for (ws in window_sizes) {
  cat(sprintf("- Plots/rolling_window/rmse_by_horizon_w%d.png\n", ws))
}
cat("- Plots/rolling_window/rmse_over_time_best_config.png\n")

cat("\nKey findings:\n")
for (i in 1:nrow(best_models)) {
  cat(sprintf("- For %d-month horizon: %s model with %d-month window is best (RMSE: %.3f)\n",
              best_models$horizon[i], best_models$model[i], best_models$window_size[i], best_models$avg_rmse[i]))
}

cat("\nNext steps:\n")
cat("1. Use the best model configurations for final forecasting\n")
cat("2. Consider ensemble approaches combining multiple models\n\n")

# Close the log file
sink()

# Print message to console
message("Rolling window validation completed!")
message("Log saved to ", log_file)
message("Use the best model configurations for final forecasting")
