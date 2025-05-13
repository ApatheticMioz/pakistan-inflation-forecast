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

# --- Set up logging to console ---
message("===== ARIMA MODELING FOR PAKISTAN INFLATION FORECASTING =====")
message("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

# --- Create output directories if they don't exist ---
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/arima", showWarnings = FALSE, recursive = TRUE)
dir.create("Models", showWarnings = FALSE, recursive = TRUE)

# --- Load prepared data ---
message("Loading prepared data...")
model_df <- readRDS("Processed_Data/model_df.rds")
train_df <- readRDS("Processed_Data/train_df.rds")
test_df <- readRDS("Processed_Data/test_df.rds")
ts_objects <- readRDS("Processed_Data/ts_objects.rds")

# Extract time series objects
cpi_ts <- ts_objects$full
train_cpi_ts <- ts_objects$train
test_cpi_ts <- ts_objects$test

message("Loaded data successfully")
message("Training data period:", format(min(train_df$date), "%Y-%m-%d"), "to",
    format(max(train_df$date), "%Y-%m-%d"))
message("Test data period:", format(min(test_df$date), "%Y-%m-%d"), "to",
    format(max(test_df$date), "%Y-%m-%d"))

# --- Step 1: Exploratory Analysis of Time Series ---
message("===== EXPLORATORY ANALYSIS OF TIME SERIES =====")

# Plot the time series
png(file.path("Plots/arima", "cpi_time_series.png"), width = 1000, height = 600)
plot(cpi_ts, main = "Pakistan CPI (Year-on-Year % Change)",
     xlab = "Year", ylab = "CPI (YoY %)")
abline(v = time(train_cpi_ts)[length(train_cpi_ts)], col = "red", lty = 2)
legend("topleft", legend = c("Training Data", "Test Data"),
       col = c("black", "black"), lty = c(1, 1), bty = "n")
dev.off()
message("Saved time series plot to Plots/arima/cpi_time_series.png")

# Decompose the time series
message("Decomposing time series to identify trend, seasonality, and residuals...")
ts_decomp <- decompose(cpi_ts)
png(file.path("Plots/arima", "cpi_decomposition.png"), width = 1000, height = 800)
plot(ts_decomp)
dev.off()
message("Saved time series decomposition plot to Plots/arima/cpi_decomposition.png")

# ACF and PACF plots
png(file.path("Plots/arima", "acf_pacf.png"), width = 1000, height = 600)
par(mfrow = c(2, 1))
acf(train_cpi_ts, main = "ACF of CPI")
pacf(train_cpi_ts, main = "PACF of CPI")
dev.off()
message("Saved ACF and PACF plots to Plots/arima/acf_pacf.png")

# --- Step 2: Check for Stationarity ---
message("===== STATIONARITY TESTING =====")

# Augmented Dickey-Fuller test
adf_test <- adf.test(train_cpi_ts, alternative = "stationary")
message("Augmented Dickey-Fuller Test for Stationarity:")
message("  Test statistic:", adf_test$statistic)
message("  p-value:", adf_test$p.value)
message("  Interpretation:", ifelse(adf_test$p.value < 0.05,
                              "Series is stationary",
                              "Series is non-stationary"))

# If non-stationary, difference the series
if (adf_test$p.value >= 0.05) {
  message("Series is non-stationary. Differencing the series...")
  diff_cpi_ts <- diff(train_cpi_ts)

  # Plot differenced series
  png(file.path("Plots/arima", "differenced_series.png"), width = 1000, height = 600)
  plot(diff_cpi_ts, main = "Differenced CPI Series",
       xlab = "Year", ylab = "Differenced CPI")
  dev.off()
  message("Saved differenced series plot to Plots/arima/differenced_series.png")

  # Check stationarity of differenced series
  adf_diff_test <- adf.test(diff_cpi_ts, alternative = "stationary")
  message("Augmented Dickey-Fuller Test for Differenced Series:")
  message("  Test statistic:", adf_diff_test$statistic)
  message("  p-value:", adf_diff_test$p.value)
  message("  Interpretation:", ifelse(adf_diff_test$p.value < 0.05,
                                "Differenced series is stationary",
                                "Differenced series is non-stationary"))

  # ACF and PACF of differenced series
  png(file.path("Plots/arima", "acf_pacf_diff.png"), width = 1000, height = 600)
  par(mfrow = c(2, 1))
  acf(diff_cpi_ts, main = "ACF of Differenced CPI")
  pacf(diff_cpi_ts, main = "PACF of Differenced CPI")
  dev.off()
  message("Saved ACF and PACF plots of differenced series to Plots/arima/acf_pacf_diff.png")
} else {
  message("Series is already stationary. No differencing needed.")
  diff_cpi_ts <- train_cpi_ts
}

# --- Step 3: ARIMA Model Selection ---
message("===== ARIMA MODEL SELECTION =====")

# Auto ARIMA to find the best model
message("Running auto.arima to find the best ARIMA model...")
auto_arima_model <- auto.arima(train_cpi_ts, seasonal = TRUE,
                              stepwise = TRUE, approximation = FALSE)

# Print model summary
message("Best ARIMA Model:")
print(auto_arima_model)

# Save model information
arima_order <- arimaorder(auto_arima_model)
message("ARIMA Order: (", arima_order[1], ",", arima_order[2], ",", arima_order[3], ")")
if (is.null(auto_arima_model$coef)) {
  message("No coefficients in the model")
} else {
  message("Coefficients:")
  print(auto_arima_model$coef)
}
message("AIC:", auto_arima_model$aic)
message("BIC:", auto_arima_model$bic)
message("Log Likelihood:", auto_arima_model$loglik)

# --- Step 4: ARIMA Model Diagnostics ---
message("===== ARIMA MODEL DIAGNOSTICS =====")

# Residual analysis
png(file.path("Plots/arima", "residual_diagnostics.png"), width = 1000, height = 800)
checkresiduals(auto_arima_model)
dev.off()
message("Saved residual diagnostics plot to Plots/arima/residual_diagnostics.png")

# Ljung-Box test for residual autocorrelation
lb_test <- Box.test(residuals(auto_arima_model), lag = 20, type = "Ljung-Box")
message("Ljung-Box Test for Residual Autocorrelation:")
message("  Test statistic:", lb_test$statistic)
message("  p-value:", lb_test$p.value)
message("  Interpretation:", ifelse(lb_test$p.value >= 0.05,
                              "Residuals are white noise (good)",
                              "Residuals show autocorrelation (problematic)"))

# --- Step 5: ARIMA Forecasting ---
message("===== ARIMA FORECASTING =====")

# Forecast horizon (length of test set)
h <- length(test_cpi_ts)
message("Forecast horizon:", h, "periods")

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
message("Saved ARIMA forecast plot to Plots/arima/arima_forecast.png")

# --- Note on ARIMAX Modeling ---
message("===== NOTE ON ARIMAX MODELING =====")
message("As per project requirements, ARIMAX modeling has been excluded from this analysis.")
message("The project focuses only on ARIMA, Ridge, Lasso, and Elastic Net models.")

# Create a placeholder for ARIMAX results to maintain compatibility with later scripts
arimax_model <- NULL
arimax_forecast <- NULL

# --- Step 7: Model Evaluation ---
message("===== MODEL EVALUATION =====")

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
message("Model Accuracy Metrics:")
print(accuracy_df)

# Save accuracy results
write.csv(accuracy_df, "Processed_Data/arima_accuracy.csv", row.names = FALSE)
message("Saved accuracy metrics to Processed_Data/arima_accuracy.csv")

# --- Step 8: Compare Forecasts ---
message("===== FORECAST COMPARISON =====")

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
message("Saved forecast comparison to Processed_Data/arima_forecast_comparison.csv")

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
message("Saved forecast comparison plot to Plots/arima/forecast_comparison.png")

# --- Step 9: Save Models ---
message("===== SAVING MODELS =====")

# Save ARIMA model
saveRDS(auto_arima_model, "Models/arima_model.rds")
message("Saved ARIMA model to Models/arima_model.rds")

# Save ARIMAX model if available
if (exists("arimax_model")) {
  saveRDS(arimax_model, "Models/arimax_model.rds")
  message("Saved ARIMAX model to Models/arimax_model.rds")
}

# Save forecasts
saveRDS(list(
  arima = arima_forecast,
  arimax = if (exists("arimax_forecast")) arimax_forecast else NULL
), "Models/arima_forecasts.rds")
message("Saved forecasts to Models/arima_forecasts.rds")

# --- Final Summary ---
message("===== FINAL SUMMARY =====")

message("ARIMA modeling completed successfully!")

message("Best ARIMA model: ARIMA", paste0(arimaorder(auto_arima_model), collapse = ","))
if (exists("arimax_model") && !is.null(arimax_model)) {
  tryCatch({
    message("Best ARIMAX model: ARIMA", paste0(arimaorder(arimax_model), collapse = ","))
  }, error = function(e) {
    message("ARIMAX model information not available")
  })
}

message("Model performance on test set:")
print(accuracy_df)

message("Files created:")
message("1. Models/arima_model.rds - ARIMA model")
if (exists("arimax_model")) {
  message("2. Models/arimax_model.rds - ARIMAX model")
}
message("3. Models/arima_forecasts.rds - Forecasts from all models")
message("4. Processed_Data/arima_accuracy.csv - Accuracy metrics")
message("5. Processed_Data/arima_forecast_comparison.csv - Forecast comparison")
message("6. Various plots in Plots/arima/ directory")

message("Next steps:")
message("1. Proceed to 05_regularization_modeling.R for Lasso, Ridge, and Elastic-Net Regression")
message("2. Proceed to 06_model_evaluation.R for model comparison and final forecasting")

message("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

# --- End of script ---
