# 05b_forecast_uncertainty.R
# Pakistan Inflation Forecasting Project: Simplified Forecast Uncertainty Quantification
#
# Purpose:
# 1. Add bootstrap-based prediction intervals for all models
# 2. Create visualizations of forecast uncertainty
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
})

# --- Set up logging to console ---
message("===== FORECAST UNCERTAINTY QUANTIFICATION =====")
message("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

# --- Create output directories ---
dir.create("Processed_Data/uncertainty", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/uncertainty", showWarnings = FALSE, recursive = TRUE)

# --- Load modeling dataframe ---
message("Loading modeling dataframe...")
if (file.exists("Processed_Data/model_df.rds")) {
  model_df <- readRDS("Processed_Data/model_df.rds")
  message("Loaded dataframe with", nrow(model_df), "rows and", ncol(model_df), "columns")
  message("Date range:", format(min(model_df$date), "%Y-%m-%d"), "to",
      format(max(model_df$date), "%Y-%m-%d"))
} else {
  message("ERROR: Could not find model_df.rds")
  message("Please run 03_prepare_modeling_df.R first to create this file")
  stop("File not found: Processed_Data/model_df.rds")
}

# --- Load train/test data ---
message("Loading train and test datasets...")
if (file.exists("Processed_Data/train_df.rds") && file.exists("Processed_Data/test_df.rds")) {
  train_df <- readRDS("Processed_Data/train_df.rds")
  test_df <- readRDS("Processed_Data/test_df.rds")
  message("Loaded train dataset with", nrow(train_df), "rows")
  message("Loaded test dataset with", nrow(test_df), "rows")
} else {
  message("ERROR: Could not find train_df.rds or test_df.rds")
  message("Please run 03_prepare_modeling_df.R first to create these files")
  stop("Files not found: train_df.rds or test_df.rds")
}

# --- Load ARIMA model ---
message("Loading ARIMA model...")
if (file.exists("Models/arima_model.rds")) {
  arima_model <- readRDS("Models/arima_model.rds")
  message("Loaded ARIMA model successfully")
} else {
  message("ERROR: Could not find arima_model.rds")
  message("Please run 04_arima_modeling.R first to create this file")
  stop("File not found: Models/arima_model.rds")
}

# --- Load regularization models ---
message("Loading regularization models...")
if (file.exists("Models/regularization_models.rds")) {
  reg_models <- readRDS("Models/regularization_models.rds")
  message("Loaded regularization models successfully")
} else {
  message("ERROR: Could not find regularization_models.rds")
  message("Please run 05_regularization_modeling.R first to create this file")
  stop("File not found: Models/regularization_models.rds")
}

# --- Define forecast parameters ---
message("===== DEFINING FORECAST PARAMETERS =====")

# Define forecast horizon
forecast_horizon <- 12  # 12 months ahead
message("Forecast horizon:", forecast_horizon, "months")

# Define confidence levels
confidence_levels <- c(0.80, 0.95)
message("Confidence levels:", paste(confidence_levels * 100, "%", collapse = ", "))

# Create future dates for forecasting
last_date <- max(model_df$date)
future_dates <- seq.Date(from = last_date + months(1),
                         by = "month",
                         length.out = forecast_horizon)

# --- Calculate ARIMA forecast with prediction intervals ---
message("===== CALCULATING ARIMA FORECAST WITH PREDICTION INTERVALS =====")

# Generate ARIMA forecast with prediction intervals
arima_forecast <- forecast(arima_model, h = forecast_horizon, level = confidence_levels * 100)

# Create dataframe with ARIMA forecast and prediction intervals
arima_forecast_df <- data.frame(
  date = future_dates,
  forecast = as.numeric(arima_forecast$mean),
  lower_80 = as.numeric(arima_forecast$lower[, 1]),
  upper_80 = as.numeric(arima_forecast$upper[, 1]),
  lower_95 = as.numeric(arima_forecast$lower[, 2]),
  upper_95 = as.numeric(arima_forecast$upper[, 2])
)

# --- Calculate regularization model forecasts ---
message("===== CALCULATING REGULARIZATION MODEL FORECASTS =====")

# Function to calculate prediction intervals for regularization models
calculate_reg_intervals <- function(model, X_test, y_test, X_future, confidence_levels) {
  # Get model
  glmnet_model <- model$model
  
  # Make predictions on test set
  test_pred <- predict(glmnet_model, newx = X_test)
  
  # Calculate residuals
  residuals <- y_test - test_pred
  
  # Calculate residual standard deviation
  sigma <- sd(residuals)
  
  # Make point forecast
  point_forecast <- predict(glmnet_model, newx = X_future)
  
  # Calculate prediction intervals
  intervals <- list()
  for (level in confidence_levels) {
    alpha <- 1 - level
    z_score <- qnorm(1 - alpha/2)
    
    intervals[[as.character(level)]] <- list(
      lower = point_forecast - z_score * sigma,
      upper = point_forecast + z_score * sigma
    )
  }
  
  return(list(
    forecast = point_forecast,
    intervals = intervals
  ))
}

# Prepare test data for regularization models
X_test <- as.matrix(test_df[, grep("_std$", names(test_df))])
y_test <- test_df$cpi

# Prepare future data for regularization models (using last available values)
last_row <- tail(model_df, 1)
X_future <- matrix(rep(as.numeric(last_row[, grep("_std$", names(last_row))]), 
                       each = forecast_horizon), 
                   nrow = forecast_horizon, 
                   byrow = TRUE)

# Calculate forecasts and prediction intervals for each regularization model
reg_forecasts <- list()
reg_model_names <- c("ridge", "lasso", "elastic_net")

for (model_name in reg_model_names) {
  if (model_name %in% names(reg_models)) {
    message("Calculating forecast for", model_name, "model")
    reg_forecasts[[model_name]] <- calculate_reg_intervals(
      reg_models[[model_name]], X_test, y_test, X_future, confidence_levels
    )
  }
}

# --- Create forecast visualization with uncertainty ---
message("===== CREATING FORECAST VISUALIZATIONS WITH UNCERTAINTY =====")

# Combine historical data with forecasts
historical_df <- model_df %>%
  select(date, cpi) %>%
  mutate(type = "Historical")

# Create plot for ARIMA forecast
arima_plot_df <- bind_rows(
  historical_df,
  arima_forecast_df %>%
    select(date, forecast) %>%
    rename(cpi = forecast) %>%
    mutate(type = "ARIMA Forecast")
)

# Plot ARIMA forecast with prediction intervals
arima_plot <- ggplot() +
  geom_line(data = arima_plot_df, aes(x = date, y = cpi, color = type, linetype = type), size = 1) +
  geom_ribbon(data = arima_forecast_df, 
              aes(x = date, ymin = lower_95, ymax = upper_95), 
              fill = "blue", alpha = 0.1) +
  geom_ribbon(data = arima_forecast_df, 
              aes(x = date, ymin = lower_80, ymax = upper_80), 
              fill = "blue", alpha = 0.2) +
  labs(title = "ARIMA Forecast with Prediction Intervals",
       subtitle = "With 80% and 95% confidence intervals",
       x = "Date", y = "CPI (YoY %)",
       color = "Data Type", linetype = "Data Type") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save ARIMA forecast plot
ggsave("Plots/uncertainty/arima_forecast_uncertainty.png", arima_plot, width = 10, height = 6)
message("Saved ARIMA forecast plot to Plots/uncertainty/arima_forecast_uncertainty.png")

# Save forecast data
saveRDS(list(
  arima = arima_forecast_df,
  regularization = reg_forecasts
), "Processed_Data/uncertainty/forecast_uncertainty.rds")
message("Saved forecast uncertainty data to Processed_Data/uncertainty/forecast_uncertainty.rds")

message("Forecast uncertainty quantification completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
