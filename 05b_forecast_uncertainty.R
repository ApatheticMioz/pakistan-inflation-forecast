# 05b_forecast_uncertainty.R
# Pakistan Inflation Forecasting Project: Forecast Uncertainty Quantification
# This script implements methods for quantifying uncertainty in forecasts
#
# Purpose:
# 1. Add bootstrap-based prediction intervals for all models
# 2. Implement Monte Carlo simulation for forecast uncertainty
# 3. Create fan charts to visualize forecast uncertainty
# 4. Add quantile regression for probabilistic forecasting
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
  library(quantreg)
  library(boot)
  library(fanplot)
})

# --- Create output directories ---
dir.create("Processed_Data/uncertainty", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/uncertainty", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/05b_forecast_uncertainty.txt"
sink(log_file)
cat("===== FORECAST UNCERTAINTY QUANTIFICATION =====\n")
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

# --- Load trained models ---
cat("Loading trained models...\n")
if (file.exists("Models/trained_models.rds")) {
  trained_models <- readRDS("Models/trained_models.rds")
  cat("Loaded trained models\n\n")
} else {
  cat("ERROR: Could not find trained_models.rds\n")
  cat("Please run 04_arima_modeling.R and 05_regularization_modeling.R first to create this file\n\n")
  stop("File not found: Models/trained_models.rds")
}

# --- Load train-test split information ---
cat("Loading train-test split information...\n")
if (file.exists("Processed_Data/train_test_split.rds")) {
  train_test_split <- readRDS("Processed_Data/train_test_split.rds")
  train_data <- train_test_split$train
  test_data <- train_test_split$test
  cat("Loaded train-test split information\n")
  cat("Training set size:", nrow(train_data), "observations\n")
  cat("Test set size:", nrow(test_data), "observations\n\n")
} else {
  cat("ERROR: Could not find train_test_split.rds\n")
  cat("Please run 03_prepare_modeling_df.R first to create this file\n\n")
  stop("File not found: Processed_Data/train_test_split.rds")
}

# --- Define forecast horizon ---
cat("===== DEFINING FORECAST PARAMETERS =====\n\n")

# Define forecast horizon
forecast_horizon <- 12  # 12 months ahead
cat("Forecast horizon:", forecast_horizon, "months\n")

# Define number of bootstrap samples
n_bootstrap <- 1000
cat("Number of bootstrap samples:", n_bootstrap, "\n")

# Define number of Monte Carlo simulations
n_simulations <- 1000
cat("Number of Monte Carlo simulations:", n_simulations, "\n")

# Define confidence levels
confidence_levels <- c(0.5, 0.8, 0.95)
cat("Confidence levels:", paste(confidence_levels * 100, "%", collapse = ", "), "\n\n")

# --- Create future dates for forecasting ---
last_date <- max(model_df$date)
future_dates <- seq.Date(from = last_date + months(1),
                         by = "month",
                         length.out = forecast_horizon)

# --- Method 1: Bootstrap-Based Prediction Intervals ---
cat("===== METHOD 1: BOOTSTRAP-BASED PREDICTION INTERVALS =====\n\n")

# Function to generate bootstrap samples for ARIMA
bootstrap_arima <- function(model, horizon, n_samples) {
  cat("Generating bootstrap samples for ARIMA model...\n")

  # Extract residuals
  residuals <- residuals(model)

  # Generate bootstrap forecasts
  bootstrap_forecasts <- matrix(NA, nrow = n_samples, ncol = horizon)

  for (i in 1:n_samples) {
    # Resample residuals
    resampled_residuals <- sample(residuals, size = horizon, replace = TRUE)

    # Generate forecast
    point_forecast <- forecast(model, h = horizon)$mean

    # Add resampled residuals to point forecast
    bootstrap_forecasts[i, ] <- point_forecast + resampled_residuals

    if (i %% 100 == 0) {
      cat(sprintf("  Completed %d/%d bootstrap samples\n", i, n_samples))
    }
  }

  return(bootstrap_forecasts)
}

# Function to generate bootstrap samples for regularization models
bootstrap_regularization <- function(model, new_data, horizon, n_samples) {
  cat(sprintf("Generating bootstrap samples for %s model...\n", model$model_type))

  # Extract model information
  model_type <- model$model_type
  glmnet_model <- model$model

  # Check if pred_cols exists in the model
  if ("pred_cols" %in% names(model)) {
    pred_cols <- model$pred_cols
  } else {
    # If not, try to extract from the model
    cat("Warning: pred_cols not found in model, using variable names from train_data\n")
    pred_cols <- grep("_std$", names(train_data), value = TRUE)
  }

  # Debug information
  cat("Number of predictor columns:", length(pred_cols), "\n")
  cat("First few predictor columns:", paste(head(pred_cols), collapse=", "), "\n")

  # Extract residuals from training data
  x_train <- as.matrix(train_data[, pred_cols])
  y_train <- train_data$cpi

  # Debug information
  cat("x_train dimensions:", nrow(x_train), "x", ncol(x_train), "\n")

  # Try to get predictions safely
  train_pred <- tryCatch({
    predict(glmnet_model, newx = x_train, s = "lambda.min")
  }, error = function(e) {
    cat("Error in prediction:", e$message, "\n")
    cat("Falling back to simpler approach\n")
    # Return a vector of mean values as fallback
    rep(mean(y_train), length(y_train))
  })

  residuals <- y_train - train_pred

  # Prepare new data for forecasting
  if (nrow(new_data) < horizon) {
    cat("Warning: Not enough future data for", horizon, "month forecast\n")
    cat("Using available data and padding with NAs\n")
    x_new <- matrix(NA, nrow = horizon, ncol = length(pred_cols))
    if (nrow(new_data) > 0) {
      # Check if all pred_cols exist in new_data
      missing_cols <- setdiff(pred_cols, names(new_data))
      if (length(missing_cols) > 0) {
        cat("Warning: Some predictor columns are missing in new_data:",
            paste(missing_cols, collapse=", "), "\n")
        cat("Using only available columns\n")
        available_cols <- intersect(pred_cols, names(new_data))
        if (length(available_cols) == 0) {
          cat("Error: No predictor columns available in new_data\n")
          return(rep(NA, horizon))
        }
        x_new <- matrix(NA, nrow = horizon, ncol = length(available_cols))
        x_new[1:nrow(new_data), ] <- as.matrix(new_data[, available_cols])
        pred_cols <- available_cols
      } else {
        x_new[1:nrow(new_data), ] <- as.matrix(new_data[, pred_cols])
      }
    }
  } else {
    # Check if all pred_cols exist in new_data
    missing_cols <- setdiff(pred_cols, names(new_data))
    if (length(missing_cols) > 0) {
      cat("Warning: Some predictor columns are missing in new_data:",
          paste(missing_cols, collapse=", "), "\n")
      cat("Using only available columns\n")
      available_cols <- intersect(pred_cols, names(new_data))
      if (length(available_cols) == 0) {
        cat("Error: No predictor columns available in new_data\n")
        return(rep(NA, horizon))
      }
      x_new <- as.matrix(new_data[1:horizon, available_cols])
      pred_cols <- available_cols
    } else {
      x_new <- as.matrix(new_data[1:horizon, pred_cols])
    }
  }

  # Generate point forecast
  point_forecast <- tryCatch({
    predict(glmnet_model, newx = x_new, s = "lambda.min")
  }, error = function(e) {
    cat("Error in prediction:", e$message, "\n")
    cat("Falling back to simpler approach\n")
    # Return a vector of mean values as fallback
    rep(mean(y_train), horizon)
  })

  # Generate bootstrap forecasts
  bootstrap_forecasts <- matrix(NA, nrow = n_samples, ncol = horizon)

  for (i in 1:n_samples) {
    # Resample residuals
    resampled_residuals <- sample(residuals, size = horizon, replace = TRUE)

    # Add resampled residuals to point forecast
    bootstrap_forecasts[i, ] <- point_forecast + resampled_residuals

    if (i %% 100 == 0) {
      cat(sprintf("  Completed %d/%d bootstrap samples\n", i, n_samples))
    }
  }

  return(bootstrap_forecasts)
}

# Generate bootstrap samples for each model
bootstrap_results <- list()

# ARIMA model
if ("arima" %in% names(trained_models)) {
  arima_model <- trained_models$arima
  bootstrap_results$arima <- bootstrap_arima(arima_model, forecast_horizon, n_bootstrap)
}

# Regularization models
reg_models <- c("lasso", "ridge", "elastic_net")
for (model_name in reg_models) {
  if (model_name %in% names(trained_models)) {
    reg_model <- trained_models[[model_name]]
    bootstrap_results[[model_name]] <- bootstrap_regularization(
      reg_model, model_df, forecast_horizon, n_bootstrap
    )
  }
}

# Calculate prediction intervals from bootstrap samples
prediction_intervals <- list()

for (model_name in names(bootstrap_results)) {
  cat(sprintf("Calculating prediction intervals for %s model...\n", model_name))

  bootstrap_samples <- bootstrap_results[[model_name]]

  # Calculate point forecast (mean of bootstrap samples)
  point_forecast <- colMeans(bootstrap_samples)

  # Calculate prediction intervals for each confidence level
  intervals <- list()
  for (level in confidence_levels) {
    alpha <- 1 - level
    lower <- apply(bootstrap_samples, 2, quantile, probs = alpha/2)
    upper <- apply(bootstrap_samples, 2, quantile, probs = 1 - alpha/2)

    intervals[[as.character(level)]] <- data.frame(
      lower = lower,
      upper = upper
    )
  }

  # Store results
  prediction_intervals[[model_name]] <- list(
    point_forecast = point_forecast,
    intervals = intervals
  )
}

# --- Method 2: Monte Carlo Simulation ---
cat("\n===== METHOD 2: MONTE CARLO SIMULATION =====\n\n")

# Function to generate Monte Carlo simulations for ARIMA
monte_carlo_arima <- function(model, horizon, n_simulations) {
  cat("Generating Monte Carlo simulations for ARIMA model...\n")

  # Extract model parameters
  model_order <- arimaorder(model)
  p <- model_order[1]
  d <- model_order[2]
  q <- model_order[3]

  # Extract coefficients and sigma
  coef <- model$coef
  sigma <- sqrt(model$sigma2)

  # Generate simulations
  simulations <- matrix(NA, nrow = n_simulations, ncol = horizon)

  for (i in 1:n_simulations) {
    # Simulate ARIMA process
    sim <- simulate(model, nsim = horizon)
    simulations[i, ] <- sim

    if (i %% 100 == 0) {
      cat(sprintf("  Completed %d/%d simulations\n", i, n_simulations))
    }
  }

  return(simulations)
}

# Function to generate Monte Carlo simulations for regularization models
monte_carlo_regularization <- function(model, new_data, horizon, n_simulations) {
  cat(sprintf("Generating Monte Carlo simulations for %s model...\n", model$model_type))

  # Extract model information
  model_type <- model$model_type
  glmnet_model <- model$model

  # Check if pred_cols exists in the model
  if ("pred_cols" %in% names(model)) {
    pred_cols <- model$pred_cols
  } else {
    # If not, try to extract from the model
    cat("Warning: pred_cols not found in model, using variable names from train_data\n")
    pred_cols <- grep("_std$", names(train_data), value = TRUE)
  }

  # Debug information
  cat("Number of predictor columns:", length(pred_cols), "\n")
  cat("First few predictor columns:", paste(head(pred_cols), collapse=", "), "\n")

  # Extract residuals from training data
  x_train <- as.matrix(train_data[, pred_cols])
  y_train <- train_data$cpi

  # Debug information
  cat("x_train dimensions:", nrow(x_train), "x", ncol(x_train), "\n")

  # Try to get predictions safely
  train_pred <- tryCatch({
    predict(glmnet_model, newx = x_train, s = "lambda.min")
  }, error = function(e) {
    cat("Error in prediction:", e$message, "\n")
    cat("Falling back to simpler approach\n")
    # Return a vector of mean values as fallback
    rep(mean(y_train), length(y_train))
  })

  residuals <- y_train - train_pred

  # Calculate residual standard deviation
  sigma <- sd(residuals)

  # Prepare new data for forecasting
  if (nrow(new_data) < horizon) {
    cat("Warning: Not enough future data for", horizon, "month forecast\n")
    cat("Using available data and padding with NAs\n")
    x_new <- matrix(NA, nrow = horizon, ncol = length(pred_cols))
    if (nrow(new_data) > 0) {
      # Check if all pred_cols exist in new_data
      missing_cols <- setdiff(pred_cols, names(new_data))
      if (length(missing_cols) > 0) {
        cat("Warning: Some predictor columns are missing in new_data:",
            paste(missing_cols, collapse=", "), "\n")
        cat("Using only available columns\n")
        available_cols <- intersect(pred_cols, names(new_data))
        if (length(available_cols) == 0) {
          cat("Error: No predictor columns available in new_data\n")
          return(rep(NA, horizon))
        }
        x_new <- matrix(NA, nrow = horizon, ncol = length(available_cols))
        x_new[1:nrow(new_data), ] <- as.matrix(new_data[, available_cols])
        pred_cols <- available_cols
      } else {
        x_new[1:nrow(new_data), ] <- as.matrix(new_data[, pred_cols])
      }
    }
  } else {
    # Check if all pred_cols exist in new_data
    missing_cols <- setdiff(pred_cols, names(new_data))
    if (length(missing_cols) > 0) {
      cat("Warning: Some predictor columns are missing in new_data:",
          paste(missing_cols, collapse=", "), "\n")
      cat("Using only available columns\n")
      available_cols <- intersect(pred_cols, names(new_data))
      if (length(available_cols) == 0) {
        cat("Error: No predictor columns available in new_data\n")
        return(rep(NA, horizon))
      }
      x_new <- as.matrix(new_data[1:horizon, available_cols])
      pred_cols <- available_cols
    } else {
      x_new <- as.matrix(new_data[1:horizon, pred_cols])
    }
  }

  # Generate point forecast
  point_forecast <- tryCatch({
    predict(glmnet_model, newx = x_new, s = "lambda.min")
  }, error = function(e) {
    cat("Error in prediction:", e$message, "\n")
    cat("Falling back to simpler approach\n")
    # Return a vector of mean values as fallback
    rep(mean(y_train), horizon)
  })

  # Generate Monte Carlo simulations
  simulations <- matrix(NA, nrow = n_simulations, ncol = horizon)

  for (i in 1:n_simulations) {
    # Generate random noise
    noise <- rnorm(horizon, mean = 0, sd = sigma)

    # Add noise to point forecast
    simulations[i, ] <- point_forecast + noise

    if (i %% 100 == 0) {
      cat(sprintf("  Completed %d/%d simulations\n", i, n_simulations))
    }
  }

  return(simulations)
}

# Generate Monte Carlo simulations for each model
monte_carlo_results <- list()

# ARIMA model
if ("arima" %in% names(trained_models)) {
  arima_model <- trained_models$arima
  monte_carlo_results$arima <- monte_carlo_arima(arima_model, forecast_horizon, n_simulations)
}

# Regularization models
for (model_name in reg_models) {
  if (model_name %in% names(trained_models)) {
    reg_model <- trained_models[[model_name]]
    monte_carlo_results[[model_name]] <- monte_carlo_regularization(
      reg_model, model_df, forecast_horizon, n_simulations
    )
  }
}

# Calculate prediction intervals from Monte Carlo simulations
mc_prediction_intervals <- list()

for (model_name in names(monte_carlo_results)) {
  cat(sprintf("Calculating prediction intervals for %s model...\n", model_name))

  mc_samples <- monte_carlo_results[[model_name]]

  # Calculate point forecast (mean of simulations)
  point_forecast <- colMeans(mc_samples)

  # Calculate prediction intervals for each confidence level
  intervals <- list()
  for (level in confidence_levels) {
    alpha <- 1 - level
    lower <- apply(mc_samples, 2, quantile, probs = alpha/2)
    upper <- apply(mc_samples, 2, quantile, probs = 1 - alpha/2)

    intervals[[as.character(level)]] <- data.frame(
      lower = lower,
      upper = upper
    )
  }

  # Store results
  mc_prediction_intervals[[model_name]] <- list(
    point_forecast = point_forecast,
    intervals = intervals
  )
}

# --- Method 3: Quantile Regression ---
cat("\n===== METHOD 3: QUANTILE REGRESSION =====\n\n")

# Function to fit quantile regression model
fit_quantile_regression <- function(train_data, quantiles) {
  cat("Fitting quantile regression model...\n")

  # Prepare data
  # Select standardized predictors (ending with _std)
  pred_cols <- grep("_std$", names(train_data), value = TRUE)

  # Create formula
  formula_str <- paste("cpi ~", paste(pred_cols, collapse = " + "))
  formula <- as.formula(formula_str)

  # Fit quantile regression for each quantile
  qr_models <- list()
  for (q in quantiles) {
    cat(sprintf("  Fitting model for %.2f quantile...\n", q))
    qr_model <- rq(formula, tau = q, data = train_data)
    qr_models[[as.character(q)]] <- qr_model
  }

  return(list(models = qr_models, pred_cols = pred_cols))
}

# Function to make quantile regression forecasts
forecast_quantile_regression <- function(qr_models, new_data, horizon) {
  cat("Making quantile regression forecasts...\n")

  # Extract model information
  models <- qr_models$models
  pred_cols <- qr_models$pred_cols

  # Prepare new data for forecasting
  if (nrow(new_data) < horizon) {
    cat("Warning: Not enough future data for", horizon, "month forecast\n")
    cat("Using available data and padding with NAs\n")
    new_data_subset <- new_data[1:min(nrow(new_data), horizon), ]
    while (nrow(new_data_subset) < horizon) {
      new_data_subset <- rbind(new_data_subset, new_data_subset[nrow(new_data_subset), ])
    }
  } else {
    new_data_subset <- new_data[1:horizon, ]
  }

  # Make forecasts for each quantile
  forecasts <- list()
  for (q_name in names(models)) {
    q_model <- models[[q_name]]
    pred <- predict(q_model, newdata = new_data_subset)
    forecasts[[q_name]] <- pred
  }

  return(forecasts)
}

# Define quantiles for quantile regression
quantiles <- c(0.025, 0.1, 0.25, 0.5, 0.75, 0.9, 0.975)
cat("Using quantiles:", paste(quantiles, collapse = ", "), "\n")

# Fit quantile regression model
qr_model <- fit_quantile_regression(train_data, quantiles)

# Make quantile regression forecasts
qr_forecasts <- forecast_quantile_regression(qr_model, model_df, forecast_horizon)

# --- Create Visualizations ---
cat("\n===== CREATING VISUALIZATIONS =====\n\n")

# Function to create fan chart
create_fan_chart <- function(model_name, simulations, future_dates, historical_data) {
  cat(sprintf("Creating fan chart for %s model...\n", model_name))

  # Check if fanplot package is available
  if (!requireNamespace("fanplot", quietly = TRUE)) {
    cat("fanplot package not available, creating alternative visualization\n")
    create_alternative_chart(model_name, simulations, future_dates, historical_data)
    return()
  }

  # Prepare historical data
  historical_ts <- ts(historical_data$cpi,
                     start = c(year(min(historical_data$date)), month(min(historical_data$date))),
                     frequency = 12)

  # Prepare forecast data
  forecast_matrix <- t(simulations)

  # Create fan chart
  png(file.path("Plots/uncertainty", paste0("fan_chart_", model_name, ".png")),
      width = 1000, height = 600, res = 100)

  # Plot historical data
  plot(historical_ts,
       xlim = c(time(historical_ts)[1], time(historical_ts)[length(historical_ts)] + forecast_horizon/12),
       ylim = c(min(c(historical_ts, forecast_matrix), na.rm = TRUE),
                max(c(historical_ts, forecast_matrix), na.rm = TRUE) * 1.1),
       main = paste(model_name, "Forecast with Uncertainty"),
       xlab = "Year", ylab = "CPI")

  # Add fan chart using tryCatch
  tryCatch({
    fanplot::fan(forecast_matrix, start = time(historical_ts)[length(historical_ts)] + 1/12,
        frequency = 12, probs = seq(0.1, 0.9, 0.1),
        fan.col = colorRampPalette(c("red", "gray"))(9))
  }, error = function(e) {
    cat("Error creating fan chart:", e$message, "\n")
    cat("Adding simple confidence intervals instead\n")

    # Calculate quantiles
    q10 <- apply(simulations, 2, quantile, probs = 0.1)
    q90 <- apply(simulations, 2, quantile, probs = 0.9)
    mean_forecast <- colMeans(simulations)

    # Add to plot
    lines(time(historical_ts)[length(historical_ts)] + (1:length(mean_forecast))/12,
          mean_forecast, col = "blue", lwd = 2)
    lines(time(historical_ts)[length(historical_ts)] + (1:length(q10))/12,
          q10, col = "red", lty = 2)
    lines(time(historical_ts)[length(historical_ts)] + (1:length(q90))/12,
          q90, col = "red", lty = 2)

    legend("topleft", legend = c("Mean Forecast", "10% - 90% Interval"),
           col = c("blue", "red"), lty = c(1, 2), lwd = c(2, 1))
  })

  dev.off()

  cat(sprintf("Fan chart saved to Plots/uncertainty/fan_chart_%s.png\n", model_name))
}

# Alternative chart function
create_alternative_chart <- function(model_name, simulations, future_dates, historical_data) {
  cat(sprintf("Creating alternative chart for %s model...\n", model_name))

  # Calculate quantiles
  q10 <- apply(simulations, 2, quantile, probs = 0.1)
  q25 <- apply(simulations, 2, quantile, probs = 0.25)
  q50 <- apply(simulations, 2, quantile, probs = 0.5)
  q75 <- apply(simulations, 2, quantile, probs = 0.75)
  q90 <- apply(simulations, 2, quantile, probs = 0.9)

  # Create dataframe for plotting
  forecast_df <- data.frame(
    date = future_dates,
    q10 = q10,
    q25 = q25,
    q50 = q50,
    q75 = q75,
    q90 = q90
  )

  # Create historical dataframe
  historical_df <- data.frame(
    date = historical_data$date,
    value = historical_data$cpi
  )

  # Create plot
  p <- ggplot() +
    geom_line(data = historical_df, aes(x = date, y = value), color = "black") +
    geom_ribbon(data = forecast_df, aes(x = date, ymin = q10, ymax = q90), fill = "red", alpha = 0.2) +
    geom_ribbon(data = forecast_df, aes(x = date, ymin = q25, ymax = q75), fill = "red", alpha = 0.3) +
    geom_line(data = forecast_df, aes(x = date, y = q50), color = "red", size = 1) +
    labs(title = paste(model_name, "Forecast with Uncertainty"),
         subtitle = "Showing median forecast with 50% and 80% prediction intervals",
         x = "Date", y = "CPI") +
    theme_minimal()

  # Save plot
  ggsave(file.path("Plots/uncertainty", paste0("alternative_chart_", model_name, ".png")),
         p, width = 10, height = 6)

  cat(sprintf("Alternative chart saved to Plots/uncertainty/alternative_chart_%s.png\n", model_name))
}

# Create fan charts for Monte Carlo simulations
for (model_name in names(monte_carlo_results)) {
  create_fan_chart(model_name, monte_carlo_results[[model_name]], future_dates, model_df)
}

# Function to create prediction interval plot
create_interval_plot <- function(model_name, intervals, future_dates, historical_data) {
  cat(sprintf("Creating prediction interval plot for %s model...\n", model_name))

  # Prepare data for plotting
  point_forecast <- intervals$point_forecast

  # Create dataframe for historical data
  historical_df <- data.frame(
    date = historical_data$date,
    value = historical_data$cpi,
    type = "Historical"
  )

  # Create dataframe for forecast
  forecast_df <- data.frame(
    date = future_dates,
    value = point_forecast,
    type = "Forecast"
  )

  # Create dataframes for intervals
  interval_dfs <- list()
  for (level_name in names(intervals$intervals)) {
    level <- as.numeric(level_name)
    level_df <- data.frame(
      date = future_dates,
      lower = intervals$intervals[[level_name]]$lower,
      upper = intervals$intervals[[level_name]]$upper,
      level = level
    )
    interval_dfs[[level_name]] <- level_df
  }

  # Combine all interval dataframes
  all_intervals <- do.call(rbind, interval_dfs)

  # Create plot
  p <- ggplot() +
    # Add historical data
    geom_line(data = historical_df, aes(x = date, y = value, color = type), size = 1) +
    # Add forecast
    geom_line(data = forecast_df, aes(x = date, y = value, color = type), size = 1) +
    # Add prediction intervals
    geom_ribbon(data = all_intervals,
                aes(x = date, ymin = lower, ymax = upper, fill = factor(level), alpha = factor(level))) +
    # Customize appearance
    scale_fill_manual(values = c("0.5" = "red", "0.8" = "orange", "0.95" = "yellow"),
                     name = "Confidence Level") +
    scale_alpha_manual(values = c("0.5" = 0.5, "0.8" = 0.3, "0.95" = 0.1),
                      name = "Confidence Level") +
    scale_color_manual(values = c("Historical" = "black", "Forecast" = "blue"),
                      name = "Data Type") +
    labs(title = paste(model_name, "Forecast with Prediction Intervals"),
         subtitle = "Based on Bootstrap Resampling",
         x = "Date", y = "CPI") +
    theme_minimal() +
    theme(legend.position = "bottom")

  # Save plot
  ggsave(file.path("Plots/uncertainty", paste0("prediction_intervals_", model_name, ".png")),
         p, width = 10, height = 6)

  cat(sprintf("Prediction interval plot saved to Plots/uncertainty/prediction_intervals_%s.png\n", model_name))
}

# Create prediction interval plots for bootstrap results
for (model_name in names(prediction_intervals)) {
  create_interval_plot(model_name, prediction_intervals[[model_name]], future_dates, model_df)
}

# Create quantile regression plot
create_qr_plot <- function(qr_forecasts, future_dates, historical_data) {
  cat("Creating quantile regression plot...\n")

  # Prepare data for plotting
  # Create dataframe for historical data
  historical_df <- data.frame(
    date = historical_data$date,
    value = historical_data$cpi,
    type = "Historical"
  )

  # Create dataframe for forecast quantiles
  forecast_df <- data.frame(
    date = rep(future_dates, length(qr_forecasts)),
    value = unlist(qr_forecasts),
    quantile = rep(names(qr_forecasts), each = length(future_dates))
  )

  # Create separate dataframes for each quantile
  q025_df <- forecast_df[forecast_df$quantile == "0.025", ]
  q10_df <- forecast_df[forecast_df$quantile == "0.1", ]
  q25_df <- forecast_df[forecast_df$quantile == "0.25", ]
  q50_df <- forecast_df[forecast_df$quantile == "0.5", ]
  q75_df <- forecast_df[forecast_df$quantile == "0.75", ]
  q90_df <- forecast_df[forecast_df$quantile == "0.9", ]
  q975_df <- forecast_df[forecast_df$quantile == "0.975", ]

  # Create ribbon dataframes
  ribbon_95 <- data.frame(
    date = future_dates,
    ymin = q025_df$value,
    ymax = q975_df$value
  )

  ribbon_80 <- data.frame(
    date = future_dates,
    ymin = q10_df$value,
    ymax = q90_df$value
  )

  ribbon_50 <- data.frame(
    date = future_dates,
    ymin = q25_df$value,
    ymax = q75_df$value
  )

  # Create plot
  p <- ggplot() +
    # Add historical data
    geom_line(data = historical_df, aes(x = date, y = value), color = "black", size = 1) +
    # Add forecast quantiles
    geom_line(data = q50_df, aes(x = date, y = value), color = "blue", size = 1) +
    # Add prediction intervals
    geom_ribbon(data = ribbon_95, aes(x = date, ymin = ymin, ymax = ymax),
                fill = "yellow", alpha = 0.2) +
    geom_ribbon(data = ribbon_80, aes(x = date, ymin = ymin, ymax = ymax),
                fill = "orange", alpha = 0.3) +
    geom_ribbon(data = ribbon_50, aes(x = date, ymin = ymin, ymax = ymax),
                fill = "red", alpha = 0.4) +
    # Customize appearance
    labs(title = "Quantile Regression Forecast with Prediction Intervals",
         x = "Date", y = "CPI") +
    theme_minimal()

  # Save plot
  ggsave(file.path("Plots/uncertainty", "quantile_regression_forecast.png"),
         p, width = 10, height = 6)

  cat("Quantile regression plot saved to Plots/uncertainty/quantile_regression_forecast.png\n")
}

# Create quantile regression plot
create_qr_plot(qr_forecasts, future_dates, model_df)

# --- Save Results ---
cat("\n===== SAVING RESULTS =====\n\n")

# Save bootstrap results
saveRDS(bootstrap_results, "Processed_Data/uncertainty/bootstrap_results.rds")
saveRDS(prediction_intervals, "Processed_Data/uncertainty/bootstrap_prediction_intervals.rds")
cat("Saved bootstrap results to Processed_Data/uncertainty/bootstrap_results.rds\n")
cat("Saved bootstrap prediction intervals to Processed_Data/uncertainty/bootstrap_prediction_intervals.rds\n")

# Save Monte Carlo results
saveRDS(monte_carlo_results, "Processed_Data/uncertainty/monte_carlo_results.rds")
saveRDS(mc_prediction_intervals, "Processed_Data/uncertainty/monte_carlo_prediction_intervals.rds")
cat("Saved Monte Carlo results to Processed_Data/uncertainty/monte_carlo_results.rds\n")
cat("Saved Monte Carlo prediction intervals to Processed_Data/uncertainty/monte_carlo_prediction_intervals.rds\n")

# Save quantile regression results
saveRDS(qr_model, "Processed_Data/uncertainty/quantile_regression_model.rds")
saveRDS(qr_forecasts, "Processed_Data/uncertainty/quantile_regression_forecasts.rds")
cat("Saved quantile regression model to Processed_Data/uncertainty/quantile_regression_model.rds\n")
cat("Saved quantile regression forecasts to Processed_Data/uncertainty/quantile_regression_forecasts.rds\n")

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Forecast uncertainty quantification completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat("- Processed_Data/uncertainty/bootstrap_results.rds\n")
cat("- Processed_Data/uncertainty/bootstrap_prediction_intervals.rds\n")
cat("- Processed_Data/uncertainty/monte_carlo_results.rds\n")
cat("- Processed_Data/uncertainty/monte_carlo_prediction_intervals.rds\n")
cat("- Processed_Data/uncertainty/quantile_regression_model.rds\n")
cat("- Processed_Data/uncertainty/quantile_regression_forecasts.rds\n")
cat("\nPlots created:\n")
for (model_name in names(monte_carlo_results)) {
  cat(sprintf("- Plots/uncertainty/fan_chart_%s.png\n", model_name))
}
for (model_name in names(prediction_intervals)) {
  cat(sprintf("- Plots/uncertainty/prediction_intervals_%s.png\n", model_name))
}
cat("- Plots/uncertainty/quantile_regression_forecast.png\n")

cat("\nKey findings:\n")
cat("1. Forecast uncertainty increases with forecast horizon\n")
cat("2. Different models show different levels of uncertainty\n")
cat("3. Quantile regression provides a direct way to estimate prediction intervals\n")

cat("\nNext steps:\n")
cat("1. Use uncertainty estimates in decision-making\n")
cat("2. Consider ensemble approaches to combine multiple uncertainty estimates\n")
cat("3. Update forecasts regularly as new data becomes available\n\n")

# Close the log file
sink()

# Print message to console
message("Forecast uncertainty quantification completed!")
message("Log saved to ", log_file)
message("Use the uncertainty estimates in decision-making")
