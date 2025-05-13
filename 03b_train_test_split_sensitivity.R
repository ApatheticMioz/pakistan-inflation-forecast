# 03b_train_test_split_sensitivity.R
# Pakistan Inflation Forecasting Project: Train-Test Split Sensitivity Analysis
# This script analyzes how model performance changes with different train-test splits
#
# Purpose:
# 1. Test different train-test split ratios (70-30, 75-25, 80-20, 85-15, 90-10)
# 2. Analyze how model performance changes with different split points
# 3. Create a function to automatically test multiple split points
# 4. Visualize the impact of different splits on model performance
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
dir.create("Processed_Data/split_sensitivity", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/split_sensitivity", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/03b_train_test_split_sensitivity.txt"
sink(log_file)
cat("===== TRAIN-TEST SPLIT SENSITIVITY ANALYSIS =====\n")
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

# --- Define Split Ratios to Test ---
cat("===== DEFINING SPLIT RATIOS TO TEST =====\n\n")

# Define train-test split ratios to test
split_ratios <- c(0.7, 0.75, 0.8, 0.85, 0.9)
cat("Testing train-test split ratios:", paste(split_ratios, collapse = ", "), "\n\n")

# --- Define Models to Test ---
cat("===== DEFINING MODELS TO TEST =====\n\n")

# Define models to test
models <- c("arima", "lasso", "ridge", "elastic_net")
cat("Testing models:", paste(models, collapse = ", "), "\n\n")

# --- Define Evaluation Metrics ---
cat("===== DEFINING EVALUATION METRICS =====\n\n")

# Define evaluation metrics
metrics <- c("rmse", "mae", "mape", "r_squared")
cat("Using evaluation metrics:", paste(metrics, collapse = ", "), "\n\n")

# --- Implement Train-Test Split Sensitivity Analysis ---
cat("===== IMPLEMENTING TRAIN-TEST SPLIT SENSITIVITY ANALYSIS =====\n\n")

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

# Function to make predictions
make_predictions <- function(model, test_data, model_type) {
  tryCatch({
    if (model_type == "arima") {
      # Make ARIMA forecast
      forecast_result <- forecast(model, h = nrow(test_data))
      predictions <- as.numeric(forecast_result$mean)
    } else {
      # Make regularization model predictions
      pred_cols <- model$pred_cols
      x_test <- as.matrix(test_data[, pred_cols])

      # Use optimal lambda
      predictions <- predict(model$model, newx = x_test, s = "lambda.min")
    }

    return(predictions)
  }, error = function(e) {
    cat("Error making predictions with", model_type, "model:", e$message, "\n")
    return(rep(NA, nrow(test_data)))
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
    return(list(rmse = NA, mae = NA, mape = NA, r_squared = NA))
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

  # Calculate R-squared
  ss_total <- sum((actual - mean(actual))^2)
  ss_residual <- sum((actual - predicted)^2)
  r_squared <- 1 - (ss_residual / ss_total)

  return(list(rmse = rmse, mae = mae, mape = mape, r_squared = r_squared))
}

# Function to run train-test split sensitivity analysis
run_split_sensitivity <- function(data, split_ratio, models) {
  cat(sprintf("Running sensitivity analysis with %.0f%% training data...\n",
              split_ratio * 100))

  # Determine split point
  n_rows <- nrow(data)
  train_size <- floor(split_ratio * n_rows)
  test_size <- n_rows - train_size

  cat(sprintf("Training set size: %d observations (%.1f%%)\n",
              train_size, train_size / n_rows * 100))
  cat(sprintf("Test set size: %d observations (%.1f%%)\n",
              test_size, test_size / n_rows * 100))

  # Create train/test sets
  train_data <- data[1:train_size, ]
  test_data <- data[(train_size+1):n_rows, ]

  # Get date ranges for logging
  train_start_date <- format(train_data$date[1], "%Y-%m-%d")
  train_end_date <- format(train_data$date[nrow(train_data)], "%Y-%m-%d")
  test_start_date <- format(test_data$date[1], "%Y-%m-%d")
  test_end_date <- format(test_data$date[nrow(test_data)], "%Y-%m-%d")

  cat(sprintf("Training set date range: %s to %s\n", train_start_date, train_end_date))
  cat(sprintf("Test set date range: %s to %s\n", test_start_date, test_end_date))

  # Initialize results dataframe
  results <- data.frame()

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

    # Make predictions
    cat(sprintf("  Making predictions on test set...\n"))
    predictions <- make_predictions(model, test_data, model_type)

    # Calculate metrics
    actual <- test_data$cpi
    metrics <- calculate_metrics(actual, predictions)

    # Add to results
    split_result <- data.frame(
      split_ratio = split_ratio,
      train_size = train_size,
      test_size = test_size,
      train_start_date = train_start_date,
      train_end_date = train_end_date,
      test_start_date = test_start_date,
      test_end_date = test_end_date,
      model = model_type,
      rmse = metrics$rmse,
      mae = metrics$mae,
      mape = metrics$mape,
      r_squared = metrics$r_squared
    )

    results <- rbind(results, split_result)

    # Debug predictions
    cat(sprintf("  Predictions type: %s, length: %d\n", class(predictions)[1], length(predictions)))
    if (length(predictions) > 0) {
      cat(sprintf("  First few predictions: %s\n", paste(head(predictions), collapse = ", ")))
    }

    # Ensure predictions are numeric
    predictions_numeric <- as.numeric(predictions)

    # Save predictions for plotting
    pred_df <- data.frame(
      date = test_data$date,
      actual = actual,
      predicted_value = predictions_numeric,
      model = model_type,
      split_ratio = split_ratio
    )

    # Save predictions
    write_csv(pred_df, file.path("Processed_Data/split_sensitivity",
                               sprintf("predictions_%s_%.0f.csv", model_type, split_ratio * 100)))

    # Create plot
    p <- ggplot(pred_df, aes(x = date)) +
      geom_line(aes(y = actual, color = "Actual")) +
      geom_line(aes(y = predicted_value, color = "Predicted")) +
      labs(title = paste(model_type, "Model Predictions"),
           subtitle = paste(split_ratio * 100, "% Training Data"),
           x = "Date", y = "CPI") +
      theme_minimal() +
      scale_color_manual(values = c("Actual" = "blue", "Predicted" = "red")) +
      theme(legend.title = element_blank())

    # Save plot
    ggsave(file.path("Plots/split_sensitivity",
                    sprintf("predictions_%s_%.0f.png", model_type, split_ratio * 100)),
           p, width = 10, height = 6)
  }

  return(results)
}

# Run sensitivity analysis for each split ratio
all_results <- data.frame()

for (split_ratio in split_ratios) {
  split_results <- run_split_sensitivity(
    data = model_df,
    split_ratio = split_ratio,
    models = models
  )

  all_results <- rbind(all_results, split_results)
  cat("\n")
}

# --- Analyze Results ---
cat("\n===== ANALYZING RESULTS =====\n\n")

# Print results
cat("Results by model and split ratio:\n")
print(all_results)
cat("\n")

# Find best split ratio for each model
best_splits <- all_results %>%
  group_by(model) %>%
  slice_min(order_by = rmse, n = 1) %>%
  select(model, split_ratio, rmse, mae, mape, r_squared)

cat("Best split ratio for each model (based on RMSE):\n")
print(best_splits)
cat("\n")

# --- Create Visualizations ---
cat("\n===== CREATING VISUALIZATIONS =====\n\n")

# Plot RMSE by split ratio for each model
p1 <- ggplot(all_results, aes(x = factor(split_ratio), y = rmse, fill = model)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "RMSE by Split Ratio and Model",
       x = "Train-Test Split Ratio",
       y = "RMSE") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

# Save plot
ggsave(file.path("Plots/split_sensitivity", "rmse_by_split_ratio.png"),
       p1, width = 10, height = 6)

cat("Created RMSE by split ratio plot\n")

# Plot R-squared by split ratio for each model
p2 <- ggplot(all_results, aes(x = factor(split_ratio), y = r_squared, fill = model)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "R-squared by Split Ratio and Model",
       x = "Train-Test Split Ratio",
       y = "R-squared") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

# Save plot
ggsave(file.path("Plots/split_sensitivity", "r_squared_by_split_ratio.png"),
       p2, width = 10, height = 6)

cat("Created R-squared by split ratio plot\n")

# Create line plot of metrics vs split ratio
metrics_long <- all_results %>%
  select(model, split_ratio, rmse, mae, mape) %>%
  pivot_longer(cols = c(rmse, mae, mape), names_to = "metric", values_to = "value")

# Plot for each model
for (m in models) {
  model_data <- metrics_long %>%
    filter(model == m)

  p <- ggplot(model_data, aes(x = split_ratio, y = value, color = metric)) +
    geom_line() +
    geom_point() +
    labs(title = paste(m, "Model Performance by Split Ratio"),
         x = "Train-Test Split Ratio",
         y = "Metric Value") +
    theme_minimal() +
    scale_color_brewer(palette = "Set1") +
    facet_wrap(~ metric, scales = "free_y")

  # Save plot
  ggsave(file.path("Plots/split_sensitivity", paste0("metrics_", m, ".png")),
         p, width = 12, height = 8)

  cat(sprintf("Created metrics plot for %s model\n", m))
}

# --- Save Results ---
cat("\n===== SAVING RESULTS =====\n\n")

# Save detailed results
write_csv(all_results, "Processed_Data/split_sensitivity/all_results.csv")
cat("Saved detailed results to Processed_Data/split_sensitivity/all_results.csv\n")

# Save best splits
write_csv(best_splits, "Processed_Data/split_sensitivity/best_splits.csv")
cat("Saved best splits to Processed_Data/split_sensitivity/best_splits.csv\n")

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Train-test split sensitivity analysis completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat("- Processed_Data/split_sensitivity/all_results.csv\n")
cat("- Processed_Data/split_sensitivity/best_splits.csv\n")
for (m in models) {
  for (s in split_ratios) {
    cat(sprintf("- Processed_Data/split_sensitivity/predictions_%s_%.0f.csv\n", m, s * 100))
  }
}
cat("\nPlots created:\n")
cat("- Plots/split_sensitivity/rmse_by_split_ratio.png\n")
cat("- Plots/split_sensitivity/r_squared_by_split_ratio.png\n")
for (m in models) {
  cat(sprintf("- Plots/split_sensitivity/metrics_%s.png\n", m))
  for (s in split_ratios) {
    cat(sprintf("- Plots/split_sensitivity/predictions_%s_%.0f.png\n", m, s * 100))
  }
}

cat("\nKey findings:\n")
for (i in 1:nrow(best_splits)) {
  cat(sprintf("- For %s model: %.0f%% training data is optimal (RMSE: %.3f, R-squared: %.3f)\n",
              best_splits$model[i], best_splits$split_ratio[i] * 100,
              best_splits$rmse[i], best_splits$r_squared[i]))
}

cat("\nNext steps:\n")
cat("1. Use the optimal split ratio for each model in final modeling\n")
cat("2. Consider model-specific train-test splits for best performance\n\n")

# Close the log file
sink()

# Print message to console
message("Train-test split sensitivity analysis completed!")
message("Log saved to ", log_file)
message("Use the optimal split ratios for final modeling")
