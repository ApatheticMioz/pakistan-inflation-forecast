# 04_arima_modeling.R
# Pakistan Inflation Forecasting Project: ARIMA Modeling
# This script implements ARIMA models for forecasting inflation in Pakistan.
# Author: <Your Name>
# Date: 2025-05-13
#
# NOTES FOR DEMO:
# - ARIMA is a powerful time series forecasting method that captures temporal patterns
# - We're focusing on ARIMA only (not ARIMAX) as per project requirements
# - The model selection process is automated using auto.arima() for optimal parameters
# - We'll evaluate stationarity using ADF tests and transform data if needed
# - Model diagnostics include residual analysis to ensure model validity
# - We'll use an 80-20 train-test split to evaluate model performance with MSE
# - This approach allows us to capture inflation dynamics without external variables

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(forecast)
  library(tseries)
  library(lubridate)
  library(readr)
  library(zoo)
  library(tibble)
  library(stringr)
  library(gridExtra)
})

# --- Set up output file for logging ---
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)
sink("Logs/04_arima_modeling_output.txt")
cat("===== ARIMA MODELING FOR PAKISTAN INFLATION FORECASTING =====\n\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Create output directories if they don't exist ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/arima", showWarnings = FALSE, recursive = TRUE)
dir.create("Models", showWarnings = FALSE, recursive = TRUE)

# --- Load prepared data ---
cat("Loading prepared data...\n")
model_df <- readRDS("Processed_Data/model_df.rds")
train_df <- readRDS("Processed_Data/train_df.rds")
test_df <- readRDS("Processed_Data/test_df.rds")
ts_objects <- readRDS("Processed_Data/ts_objects.rds")

# Extract time series objects
cpi_ts <- ts_objects$full
train_cpi_ts <- ts_objects$train
test_cpi_ts <- ts_objects$test

cat("Loaded data successfully\n")
cat("Training data period:", format(min(train_df$date), "%Y-%m-%d"), "to",
    format(max(train_df$date), "%Y-%m-%d"), "\n")
cat("Test data period:", format(min(test_df$date), "%Y-%m-%d"), "to",
    format(max(test_df$date), "%Y-%m-%d"), "\n\n")

# --- Step 1: Exploratory Analysis of Time Series ---
cat("===== EXPLORATORY ANALYSIS OF TIME SERIES =====\n\n")

# Plot the time series
png(file.path("Plots/arima", "cpi_time_series.png"), width = 1000, height = 600)
plot(cpi_ts, main = "Pakistan CPI (Year-on-Year % Change)",
     xlab = "Year", ylab = "CPI (YoY %)")
abline(v = time(train_cpi_ts)[length(train_cpi_ts)], col = "red", lty = 2)
legend("topleft", legend = c("Training Data", "Test Data"),
       col = c("black", "black"), lty = c(1, 1), bty = "n")
dev.off()
cat("Saved time series plot to Plots/arima/cpi_time_series.png\n")

# Decompose the time series
cat("Decomposing time series to identify trend, seasonality, and residuals...\n")
ts_decomp <- decompose(cpi_ts)
png(file.path("Plots/arima", "cpi_decomposition.png"), width = 1000, height = 800)
plot(ts_decomp)
dev.off()
cat("Saved time series decomposition plot to Plots/arima/cpi_decomposition.png\n")

# ACF and PACF plots
png(file.path("Plots/arima", "acf_pacf.png"), width = 1000, height = 600)
par(mfrow = c(2, 1))
acf(train_cpi_ts, main = "ACF of CPI")
pacf(train_cpi_ts, main = "PACF of CPI")
dev.off()
cat("Saved ACF and PACF plots to Plots/arima/acf_pacf.png\n\n")

# --- Step 2: Check for Stationarity ---
cat("===== STATIONARITY TESTING =====\n\n")

# Augmented Dickey-Fuller test
adf_test <- adf.test(train_cpi_ts, alternative = "stationary")
cat("Augmented Dickey-Fuller Test for Stationarity:\n")
cat("  Test statistic:", adf_test$statistic, "\n")
cat("  p-value:", adf_test$p.value, "\n")
cat("  Interpretation:", ifelse(adf_test$p.value < 0.05,
                              "Series is stationary",
                              "Series is non-stationary"), "\n\n")

# If non-stationary, difference the series
if (adf_test$p.value >= 0.05) {
  cat("Series is non-stationary. Differencing the series...\n")
  diff_cpi_ts <- diff(train_cpi_ts)

  # Plot differenced series
  png(file.path("Plots/arima", "differenced_series.png"), width = 1000, height = 600)
  plot(diff_cpi_ts, main = "Differenced CPI Series",
       xlab = "Year", ylab = "Differenced CPI")
  dev.off()
  cat("Saved differenced series plot to Plots/arima/differenced_series.png\n")

  # Check stationarity of differenced series
  adf_diff_test <- adf.test(diff_cpi_ts, alternative = "stationary")
  cat("Augmented Dickey-Fuller Test for Differenced Series:\n")
  cat("  Test statistic:", adf_diff_test$statistic, "\n")
  cat("  p-value:", adf_diff_test$p.value, "\n")
  cat("  Interpretation:", ifelse(adf_diff_test$p.value < 0.05,
                                "Differenced series is stationary",
                                "Differenced series is non-stationary"), "\n\n")

  # ACF and PACF of differenced series
  png(file.path("Plots/arima", "acf_pacf_diff.png"), width = 1000, height = 600)
  par(mfrow = c(2, 1))
  acf(diff_cpi_ts, main = "ACF of Differenced CPI")
  pacf(diff_cpi_ts, main = "PACF of Differenced CPI")
  dev.off()
  cat("Saved ACF and PACF plots of differenced series to Plots/arima/acf_pacf_diff.png\n\n")
} else {
  cat("Series is already stationary. No differencing needed.\n\n")
  diff_cpi_ts <- train_cpi_ts
}

# --- Step 3: ARIMA Model Selection ---
cat("===== ARIMA MODEL SELECTION =====\n\n")

# Auto ARIMA to find the best model
cat("Running auto.arima to find the best ARIMA model...\n")
auto_arima_model <- auto.arima(train_cpi_ts, seasonal = TRUE,
                              stepwise = TRUE, approximation = FALSE)

# Print model summary
cat("Best ARIMA Model:\n")
print(auto_arima_model)
cat("\n")

# Save model information
arima_order <- arimaorder(auto_arima_model)
cat("ARIMA Order: (", arima_order[1], ",", arima_order[2], ",", arima_order[3], ")\n")
if (is.null(auto_arima_model$coef)) {
  cat("No coefficients in the model\n")
} else {
  cat("Coefficients:\n")
  print(auto_arima_model$coef)
}
cat("AIC:", auto_arima_model$aic, "\n")
cat("BIC:", auto_arima_model$bic, "\n")
cat("Log Likelihood:", auto_arima_model$loglik, "\n\n")

# --- Step 4: ARIMA Model Diagnostics ---
cat("===== ARIMA MODEL DIAGNOSTICS =====\n\n")

# Residual analysis
png(file.path("Plots/arima", "residual_diagnostics.png"), width = 1000, height = 800)
checkresiduals(auto_arima_model)
dev.off()
cat("Saved residual diagnostics plot to Plots/arima/residual_diagnostics.png\n")

# Ljung-Box test for residual autocorrelation
lb_test <- Box.test(residuals(auto_arima_model), lag = 20, type = "Ljung-Box")
cat("Ljung-Box Test for Residual Autocorrelation:\n")
cat("  Test statistic:", lb_test$statistic, "\n")
cat("  p-value:", lb_test$p.value, "\n")
cat("  Interpretation:", ifelse(lb_test$p.value >= 0.05,
                              "Residuals are white noise (good)",
                              "Residuals show autocorrelation (problematic)"), "\n\n")

# --- Step 5: ARIMA Forecasting ---
cat("===== ARIMA FORECASTING =====\n\n")

# Forecast horizon (length of test set)
h <- length(test_cpi_ts)
cat("Forecast horizon:", h, "periods\n")

# Generate forecasts
arima_forecast <- forecast(auto_arima_model, h = h)

# Plot forecasts
png(file.path("Plots/arima", "arima_forecast.png"), width = 1000, height = 600)
plot(arima_forecast, main = "ARIMA Forecast of Pakistan CPI",
     xlab = "Year", ylab = "CPI (YoY %)")
lines(test_cpi_ts, col = "red")
legend("topleft", legend = c("Actual", "Forecast", "95% Prediction Interval"),
       col = c("red", "blue", "gray"), lty = c(1, 1, 1), bty = "n")
dev.off()
cat("Saved ARIMA forecast plot to Plots/arima/arima_forecast.png\n")

# --- Note on ARIMAX Modeling ---
cat("===== NOTE ON ARIMAX MODELING =====\n\n")
cat("As per project requirements, ARIMAX modeling has been excluded from this analysis.\n")
cat("The project focuses only on ARIMA, Ridge, Lasso, and Elastic Net models.\n\n")

# Create a placeholder for ARIMAX results to maintain compatibility with later scripts
arimax_model <- NULL
arimax_forecast <- NULL

# --- Step 7: Model Evaluation ---
cat("===== MODEL EVALUATION =====\n\n")

# Function to calculate accuracy metrics
calculate_accuracy <- function(actual, predicted, model_name) {
  # Calculate metrics
  mae <- mean(abs(actual - predicted))
  rmse <- sqrt(mean((actual - predicted)^2))
  mape <- mean(abs((actual - predicted) / actual)) * 100

  # Return as data frame
  data.frame(
    Model = model_name,
    MAE = mae,
    RMSE = rmse,
    MAPE = mape
  )
}

# Create a list to store accuracy results
accuracy_results <- list()

# Evaluate ARIMA model
arima_predictions <- as.numeric(arima_forecast$mean)
accuracy_results$arima <- calculate_accuracy(
  actual = as.numeric(test_cpi_ts),
  predicted = arima_predictions,
  model_name = "ARIMA"
)

# Evaluate ARIMAX model if available
if (exists("arimax_forecast")) {
  arimax_predictions <- as.numeric(arimax_forecast$mean)
  accuracy_results$arimax <- calculate_accuracy(
    actual = as.numeric(test_cpi_ts),
    predicted = arimax_predictions,
    model_name = "ARIMAX"
  )
}

# Combine results
accuracy_df <- do.call(rbind, accuracy_results)
cat("Model Accuracy Metrics:\n")
print(accuracy_df)
cat("\n")

# Save accuracy results
write.csv(accuracy_df, "Processed_Data/arima_accuracy.csv", row.names = FALSE)
cat("Saved accuracy metrics to Processed_Data/arima_accuracy.csv\n\n")

# --- Step 8: Compare Forecasts ---
cat("===== FORECAST COMPARISON =====\n\n")

# Create a dataframe with actual and predicted values
forecast_comparison <- data.frame(
  Date = test_df$date,
  Actual = as.numeric(test_cpi_ts),
  ARIMA = arima_predictions
)

# Add ARIMAX predictions if available and not empty
if (exists("arimax_predictions") && length(arimax_predictions) > 0) {
  forecast_comparison$ARIMAX <- arimax_predictions
}

# Save comparison data
write.csv(forecast_comparison, "Processed_Data/arima_forecast_comparison.csv", row.names = FALSE)
cat("Saved forecast comparison to Processed_Data/arima_forecast_comparison.csv\n")

# Plot comparison
png(file.path("Plots/arima", "forecast_comparison.png"), width = 1000, height = 600)
plot(forecast_comparison$Date, forecast_comparison$Actual, type = "l", col = "black",
     main = "Comparison of ARIMA Forecasts", xlab = "Date", ylab = "CPI (YoY %)",
     ylim = range(forecast_comparison[, -1], na.rm = TRUE))
lines(forecast_comparison$Date, forecast_comparison$ARIMA, col = "blue")
if ("ARIMAX" %in% names(forecast_comparison)) {
  lines(forecast_comparison$Date, forecast_comparison$ARIMAX, col = "green")
  legend("topleft", legend = c("Actual", "ARIMA", "ARIMAX"),
         col = c("black", "blue", "green"), lty = 1, bty = "n")
} else {
  legend("topleft", legend = c("Actual", "ARIMA"),
         col = c("black", "blue"), lty = 1, bty = "n")
}
dev.off()
cat("Saved forecast comparison plot to Plots/arima/forecast_comparison.png\n\n")

# --- Step 9: Save Models ---
cat("===== SAVING MODELS =====\n\n")

# Save ARIMA model
saveRDS(auto_arima_model, "Models/arima_model.rds")
cat("Saved ARIMA model to Models/arima_model.rds\n")

# Save ARIMAX model if available
if (exists("arimax_model")) {
  saveRDS(arimax_model, "Models/arimax_model.rds")
  cat("Saved ARIMAX model to Models/arimax_model.rds\n")
}

# Save forecasts
saveRDS(list(
  arima = arima_forecast,
  arimax = if (exists("arimax_forecast")) arimax_forecast else NULL
), "Models/arima_forecasts.rds")
cat("Saved forecasts to Models/arima_forecasts.rds\n\n")

# --- Final Summary ---
cat("===== FINAL SUMMARY =====\n\n")

cat("ARIMA modeling completed successfully!\n\n")

cat("Best ARIMA model: ARIMA", paste0(arimaorder(auto_arima_model), collapse = ","), "\n")
if (exists("arimax_model") && !is.null(arimax_model)) {
  tryCatch({
    cat("Best ARIMAX model: ARIMA", paste0(arimaorder(arimax_model), collapse = ","), "\n")
  }, error = function(e) {
    cat("ARIMAX model information not available\n")
  })
}
cat("\n")

cat("Model performance on test set:\n")
print(accuracy_df)
cat("\n")

cat("Files created:\n")
cat("1. Models/arima_model.rds - ARIMA model\n")
if (exists("arimax_model")) {
  cat("2. Models/arimax_model.rds - ARIMAX model\n")
}
cat("3. Models/arima_forecasts.rds - Forecasts from all models\n")
cat("4. Processed_Data/arima_accuracy.csv - Accuracy metrics\n")
cat("5. Processed_Data/arima_forecast_comparison.csv - Forecast comparison\n")
cat("6. Various plots in Plots/arima/ directory\n\n")

cat("Next steps:\n")
cat("1. Proceed to 05_regularization_modeling.R for Lasso, Ridge, and Elastic-Net Regression\n")
cat("2. Proceed to 06_model_evaluation.R for model comparison and final forecasting\n\n")

cat("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
sink()

# Print message to console
message("ARIMA modeling completed successfully!")
message("Output saved to Logs/04_arima_modeling_output.txt")
message("Proceed to 05_regularization_modeling.R for regularization techniques")

# --- End of script ---
