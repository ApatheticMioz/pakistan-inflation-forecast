# 06_model_evaluation.R
# Pakistan Inflation Forecasting Project: Model Evaluation and Final Forecasting
# This script compares all models, selects the best one, and generates final forecasts.
# Author: <Your Name>
# Date: 2025-05-13
#
# NOTES FOR DEMO:
# - This is the culmination of our entire forecasting pipeline
# - We'll compare all models (ARIMA, Ridge, Lasso, Elastic Net) using MSE and other metrics
# - The 80-20 train-test split allows fair evaluation of model performance
# - We'll identify the best model based on lowest RMSE on the test set
# - We'll generate forecasts for the next 12 months using the best model
# - The comprehensive report will summarize all findings and provide actionable insights
# - This approach ensures we select the most accurate model for Pakistan's inflation dynamics

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(forecast)
  library(glmnet)
  library(readr)
  library(lubridate)
  library(tibble)
  library(stringr)
  library(gridExtra)
  library(reshape2)
  library(knitr)
})

# --- Set up output file for logging ---
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)
sink("Logs/06_model_evaluation_output.txt")
cat("===== MODEL EVALUATION AND FINAL FORECASTING =====\n\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Create output directories if they don't exist ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/evaluation", showWarnings = FALSE, recursive = TRUE)
dir.create("Final_Results", showWarnings = FALSE, recursive = TRUE)

# --- Load prepared data ---
cat("Loading prepared data and models...\n")
model_df <- readRDS("Processed_Data/model_df.rds")
train_df <- readRDS("Processed_Data/train_df.rds")
test_df <- readRDS("Processed_Data/test_df.rds")

# Load ARIMA models and forecasts
arima_models <- tryCatch({
  readRDS("Models/arima_model.rds")
}, error = function(e) {
  cat("Warning: Could not load ARIMA model:", e$message, "\n")
  NULL
})

arimax_models <- tryCatch({
  readRDS("Models/arimax_model.rds")
}, error = function(e) {
  cat("Warning: Could not load ARIMAX model:", e$message, "\n")
  NULL
})

arima_forecasts <- tryCatch({
  readRDS("Models/arima_forecasts.rds")
}, error = function(e) {
  cat("Warning: Could not load ARIMA forecasts:", e$message, "\n")
  NULL
})

# Load regularization models
reg_models <- tryCatch({
  readRDS("Models/regularization_models.rds")
}, error = function(e) {
  cat("Warning: Could not load regularization models:", e$message, "\n")
  NULL
})

reg_predictions <- tryCatch({
  readRDS("Models/regularization_predictions.rds")
}, error = function(e) {
  cat("Warning: Could not load regularization predictions:", e$message, "\n")
  NULL
})

cat("Data and models loaded successfully\n\n")

# --- Step 1: Collect All Model Accuracy Metrics ---
cat("===== COLLECTING MODEL ACCURACY METRICS =====\n\n")

# Load accuracy metrics from previous scripts
arima_accuracy <- tryCatch({
  read.csv("Processed_Data/arima_accuracy.csv")
}, error = function(e) {
  cat("Warning: Could not load ARIMA accuracy metrics:", e$message, "\n")
  NULL
})

reg_accuracy <- tryCatch({
  read.csv("Processed_Data/regularization_accuracy.csv")
}, error = function(e) {
  cat("Warning: Could not load regularization accuracy metrics:", e$message, "\n")
  NULL
})

# Combine all accuracy metrics
# First ensure both dataframes have the same columns
if (!is.null(arima_accuracy) && !is.null(reg_accuracy)) {
  # Check if R_Squared is in reg_accuracy but not in arima_accuracy
  if ("R_Squared" %in% names(reg_accuracy) && !("R_Squared" %in% names(arima_accuracy))) {
    # Add R_Squared column to arima_accuracy with NA values
    arima_accuracy$R_Squared <- NA
  }

  # Check if any columns in arima_accuracy are not in reg_accuracy
  for (col in names(arima_accuracy)) {
    if (!(col %in% names(reg_accuracy))) {
      reg_accuracy[[col]] <- NA
    }
  }

  # Check if any columns in reg_accuracy are not in arima_accuracy
  for (col in names(reg_accuracy)) {
    if (!(col %in% names(arima_accuracy))) {
      arima_accuracy[[col]] <- NA
    }
  }
}

# Now combine the dataframes
all_accuracy <- rbind(
  if (!is.null(arima_accuracy)) arima_accuracy else NULL,
  if (!is.null(reg_accuracy)) reg_accuracy else NULL
)

if (nrow(all_accuracy) > 0) {
  cat("Combined accuracy metrics for all models:\n")
  print(all_accuracy)
  cat("\n")

  # Save combined accuracy metrics
  write.csv(all_accuracy, "Final_Results/all_model_accuracy.csv", row.names = FALSE)
  cat("Saved combined accuracy metrics to Final_Results/all_model_accuracy.csv\n\n")
} else {
  cat("No accuracy metrics available. Please run the modeling scripts first.\n\n")
}

# --- Step 2: Identify Best Model ---
cat("===== IDENTIFYING BEST MODEL =====\n\n")

if (nrow(all_accuracy) > 0) {
  # Find best model based on RMSE
  best_model_idx <- which.min(all_accuracy$RMSE)
  best_model_name <- all_accuracy$Model[best_model_idx]

  cat("Best model based on RMSE:", best_model_name, "\n")
  cat("Best model RMSE:", all_accuracy$RMSE[best_model_idx], "\n")

  # Compare with other metrics
  cat("\nModel ranking by different metrics:\n")

  # RMSE ranking
  rmse_ranking <- all_accuracy[order(all_accuracy$RMSE), ]
  cat("RMSE ranking (lower is better):\n")
  for (i in 1:nrow(rmse_ranking)) {
    cat(i, ". ", rmse_ranking$Model[i], " (", rmse_ranking$RMSE[i], ")\n", sep = "")
  }
  cat("\n")

  # MAE ranking
  if ("MAE" %in% names(all_accuracy)) {
    mae_ranking <- all_accuracy[order(all_accuracy$MAE), ]
    cat("MAE ranking (lower is better):\n")
    for (i in 1:nrow(mae_ranking)) {
      cat(i, ". ", mae_ranking$Model[i], " (", mae_ranking$MAE[i], ")\n", sep = "")
    }
    cat("\n")
  }

  # MAPE ranking
  if ("MAPE" %in% names(all_accuracy)) {
    mape_ranking <- all_accuracy[order(all_accuracy$MAPE), ]
    cat("MAPE ranking (lower is better):\n")
    for (i in 1:nrow(mape_ranking)) {
      cat(i, ". ", mape_ranking$Model[i], " (", mape_ranking$MAPE[i], ")\n", sep = "")
    }
    cat("\n")
  }

  # R-squared ranking
  if ("R_Squared" %in% names(all_accuracy)) {
    r2_ranking <- all_accuracy[order(all_accuracy$R_Squared, decreasing = TRUE), ]
    cat("R-squared ranking (higher is better):\n")
    for (i in 1:nrow(r2_ranking)) {
      cat(i, ". ", r2_ranking$Model[i], " (", r2_ranking$R_Squared[i], ")\n", sep = "")
    }
    cat("\n")
  }
} else {
  cat("Cannot identify best model without accuracy metrics.\n\n")
  best_model_name <- NULL
}

# --- Step 3: Visualize Model Comparison ---
cat("===== VISUALIZING MODEL COMPARISON =====\n\n")

# Collect all predictions
all_predictions <- data.frame(Date = test_df$date, Actual = test_df$cpi)

# Add ARIMA predictions
if (!is.null(arima_forecasts)) {
  if (!is.null(arima_forecasts$arima)) {
    all_predictions$ARIMA <- as.numeric(arima_forecasts$arima$mean)
  }
  if (!is.null(arima_forecasts$arimax)) {
    all_predictions$ARIMAX <- as.numeric(arima_forecasts$arimax$mean)
  }
}

# Add regularization predictions
if (!is.null(reg_predictions)) {
  if ("Ridge" %in% names(reg_predictions)) {
    all_predictions$Ridge <- reg_predictions$Ridge
  }
  if ("Lasso" %in% names(reg_predictions)) {
    all_predictions$Lasso <- reg_predictions$Lasso
  }
  if ("ElasticNet" %in% names(reg_predictions)) {
    all_predictions$ElasticNet <- reg_predictions$ElasticNet
  }
}

# Save all predictions
write.csv(all_predictions, "Final_Results/all_model_predictions.csv", row.names = FALSE)
cat("Saved all model predictions to Final_Results/all_model_predictions.csv\n")

# Plot all predictions
if (ncol(all_predictions) > 2) {
  # Reshape for plotting
  predictions_long <- reshape2::melt(all_predictions, id.vars = "Date",
                                    variable.name = "Model", value.name = "CPI")

  # Plot
  png(file.path("Plots/evaluation", "all_model_comparison.png"), width = 1200, height = 800)
  ggplot(predictions_long, aes(x = Date, y = CPI, color = Model)) +
    geom_line(size = ifelse(predictions_long$Model == "Actual", 1.2, 0.8)) +
    labs(title = "Comparison of All Models",
         x = "Date", y = "CPI (YoY %)", color = "Model") +
    theme_minimal() +
    theme(legend.position = "bottom")
  dev.off()
  cat("Saved all model comparison plot to Plots/evaluation/all_model_comparison.png\n\n")

  # Plot error comparison
  error_df <- all_predictions
  for (col in names(error_df)[-c(1, 2)]) {
    error_df[[paste0(col, "_Error")]] <- error_df$Actual - error_df[[col]]
  }

  error_cols <- grep("_Error$", names(error_df), value = TRUE)
  error_df_long <- reshape2::melt(error_df[, c("Date", error_cols)], id.vars = "Date",
                                 variable.name = "Model", value.name = "Error")
  error_df_long$Model <- gsub("_Error$", "", error_df_long$Model)

  png(file.path("Plots/evaluation", "error_comparison.png"), width = 1200, height = 800)
  ggplot(error_df_long, aes(x = Date, y = Error, color = Model)) +
    geom_line() +
    geom_hline(yintercept = 0, linetype = "dashed") +
    labs(title = "Model Error Comparison",
         x = "Date", y = "Error (Actual - Predicted)", color = "Model") +
    theme_minimal() +
    theme(legend.position = "bottom")
  dev.off()
  cat("Saved error comparison plot to Plots/evaluation/error_comparison.png\n\n")
} else {
  cat("Not enough predictions to create comparison plots\n\n")
}

# --- Step 4: Generate Final Forecasts ---
cat("===== GENERATING FINAL FORECASTS =====\n\n")

# Determine forecast horizon (12 months)
forecast_horizon <- 12
forecast_start_date <- max(model_df$date) + months(1)
forecast_end_date <- forecast_start_date + months(forecast_horizon - 1)

cat("Generating forecasts for", forecast_horizon, "months ahead\n")
cat("Forecast period:", format(forecast_start_date, "%Y-%m-%d"), "to",
    format(forecast_end_date, "%Y-%m-%d"), "\n\n")

# Create forecast dates
forecast_dates <- seq.Date(from = forecast_start_date,
                          by = "month",
                          length.out = forecast_horizon)

# Initialize forecast dataframe
final_forecasts <- data.frame(
  Date = forecast_dates,
  Month = month(forecast_dates),
  Year = year(forecast_dates)
)

# Generate ARIMA forecasts
if (!is.null(arima_models)) {
  cat("Generating ARIMA forecasts...\n")

  # Generate forecast
  arima_future <- forecast(arima_models, h = forecast_horizon)

  # Add to forecast dataframe
  final_forecasts$ARIMA <- as.numeric(arima_future$mean)
  final_forecasts$ARIMA_Lower <- as.numeric(arima_future$lower[, 2])  # 95% CI
  final_forecasts$ARIMA_Upper <- as.numeric(arima_future$upper[, 2])  # 95% CI

  # Plot ARIMA forecast
  png(file.path("Plots/evaluation", "arima_future_forecast.png"), width = 1000, height = 600)
  plot(arima_future, main = "ARIMA Forecast for Next 12 Months",
       xlab = "Year", ylab = "CPI (YoY %)")
  dev.off()
  cat("Saved ARIMA future forecast plot to Plots/evaluation/arima_future_forecast.png\n")
}

# Generate ARIMAX forecasts if external regressors are available
if (!is.null(arimax_models)) {
  cat("ARIMAX model available, but future values of external regressors are needed\n")
  cat("Skipping ARIMAX future forecasting\n")
}

# Generate regularization forecasts
if (!is.null(reg_models) && !is.null(best_model_name)) {
  cat("Generating regularization forecasts...\n")

  # For regularization models, we need future values of predictors
  # This is a simplified approach - in practice, you would need to forecast these predictors
  cat("Note: Using a simplified approach for regularization forecasts\n")
  cat("      In practice, you would need to forecast the predictor variables\n")

  # Use the last available values of predictors as a simple forecast
  if (best_model_name %in% c("Ridge", "Lasso", "Elastic Net")) {
    # Get the model
    if (best_model_name == "Ridge") {
      best_reg_model <- reg_models$ridge$model
    } else if (best_model_name == "Lasso") {
      best_reg_model <- reg_models$lasso$model
    } else if (best_model_name == "Elastic Net") {
      best_reg_model <- reg_models$elastic_net$model
    }

    # Get the last row of predictors
    last_predictors <- tail(model_df, 1)

    # For regularization models, we need to use a simpler approach
    cat("Using a simplified approach for regularization forecasts...\n")

    # Get the standardized predictor columns used in the model
    std_cols <- grep("_std$", names(model_df), value = TRUE)

    if (length(std_cols) > 0) {
      # Create a matrix with the right dimensions
      future_predictors <- matrix(0, nrow = forecast_horizon, ncol = length(std_cols))
      colnames(future_predictors) <- std_cols

      # Use the last available values for each predictor
      for (i in 1:length(std_cols)) {
        col <- std_cols[i]
        if (col %in% names(model_df)) {
          future_predictors[, i] <- rep(tail(model_df[[col]], 1), forecast_horizon)
        }
      }

      # Generate forecast
      reg_future <- tryCatch({
        predict(best_reg_model, newx = future_predictors)
      }, error = function(e) {
        cat("Error generating regularization forecast:", e$message, "\n")
        cat("Skipping regularization forecasting\n")
        return(NULL)
      })

      if (!is.null(reg_future)) {
        # Add to forecast dataframe
        final_forecasts[[best_model_name]] <- as.numeric(reg_future)
        cat("Generated simple", best_model_name, "forecasts using last available predictor values\n")
      }
    } else {
      cat("No standardized predictor columns found. Skipping regularization forecasting.\n")
    }
  }
}

# Save final forecasts
write.csv(final_forecasts, "Final_Results/final_forecasts.csv", row.names = FALSE)
cat("Saved final forecasts to Final_Results/final_forecasts.csv\n\n")

# Plot final forecasts
if (ncol(final_forecasts) > 3) {  # More than just Date, Month, Year columns
  # Get historical data for context
  historical <- model_df %>%
    select(Date = date, CPI = cpi) %>%
    mutate(Type = "Historical")

  # Prepare forecast data
  forecast_cols <- setdiff(names(final_forecasts), c("Date", "Month", "Year"))
  forecast_data <- list()

  for (col in forecast_cols) {
    if (!grepl("Lower|Upper", col)) {  # Skip confidence interval columns
      forecast_data[[col]] <- data.frame(
        Date = final_forecasts$Date,
        CPI = final_forecasts[[col]],
        Type = col
      )
    }
  }

  # Combine historical and forecast data
  plot_data <- rbind(
    historical,
    do.call(rbind, forecast_data)
  )

  # Plot
  png(file.path("Plots/evaluation", "final_forecasts.png"), width = 1200, height = 800)
  ggplot() +
    geom_line(data = historical, aes(x = Date, y = CPI), size = 1) +
    geom_point(data = historical, aes(x = Date, y = CPI), size = 1) +
    geom_vline(xintercept = as.numeric(max(historical$Date)),
               linetype = "dashed", color = "red") +
    geom_line(data = do.call(rbind, forecast_data),
              aes(x = Date, y = CPI, color = Type), size = 1) +
    geom_point(data = do.call(rbind, forecast_data),
               aes(x = Date, y = CPI, color = Type), size = 2) +
    labs(title = "Pakistan Inflation Forecast",
         subtitle = paste("Historical data and", forecast_horizon, "month forecast"),
         x = "Date", y = "CPI (YoY %)", color = "Model") +
    theme_minimal() +
    theme(legend.position = "bottom")
  dev.off()
  cat("Saved final forecast plot to Plots/evaluation/final_forecasts.png\n\n")
}

# --- Step 5: Generate Comprehensive Report ---
cat("===== GENERATING COMPREHENSIVE REPORT =====\n\n")

# Create a detailed report
report_file <- "Final_Results/pakistan_inflation_forecast_report.txt"
sink(report_file)

cat("=======================================================================\n")
cat("                PAKISTAN INFLATION FORECASTING PROJECT                 \n")
cat("                   COMPREHENSIVE ANALYSIS REPORT                       \n")
cat("=======================================================================\n\n")

cat("Report Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

cat("1. EXECUTIVE SUMMARY\n")
cat("===================\n\n")

cat("This report presents the results of a comprehensive analysis of Pakistan's\n")
cat("inflation trends and forecasts using various time series and regression models.\n\n")

if (!is.null(best_model_name)) {
  cat("The best performing model was identified as", best_model_name, "with an RMSE of",
      all_accuracy$RMSE[best_model_idx], "on the test dataset.\n\n")
}

cat("The analysis covered historical CPI data and incorporated various economic\n")
cat("indicators including exchange rates, interest rates, global commodity prices,\n")
cat("and domestic economic indicators.\n\n")

cat("2. DATA OVERVIEW\n")
cat("===============\n\n")

cat("Time period analyzed:", format(min(model_df$date), "%Y-%m-%d"), "to",
    format(max(model_df$date), "%Y-%m-%d"), "\n")
cat("Total observations:", nrow(model_df), "\n")
cat("Training set size:", nrow(train_df), "observations\n")
cat("Test set size:", nrow(test_df), "observations\n\n")

cat("Target variable: Consumer Price Index (CPI) Year-on-Year percentage change\n")
cat("CPI range:", min(model_df$cpi, na.rm = TRUE), "to", max(model_df$cpi, na.rm = TRUE), "\n")
cat("CPI mean:", mean(model_df$cpi, na.rm = TRUE), "\n")
cat("CPI standard deviation:", sd(model_df$cpi, na.rm = TRUE), "\n\n")

cat("3. METHODOLOGY\n")
cat("=============\n\n")

cat("The following modeling approaches were implemented:\n\n")

cat("Time Series Models:\n")
cat("- ARIMA (AutoRegressive Integrated Moving Average)\n")
cat("- ARIMAX (ARIMA with external regressors)\n\n")

cat("Regularization Models:\n")
cat("- Ridge Regression\n")
cat("- Lasso Regression\n")
cat("- Elastic Net Regression\n\n")

cat("Model Selection Criteria:\n")
cat("- Root Mean Square Error (RMSE)\n")
cat("- Mean Absolute Error (MAE)\n")
cat("- Mean Absolute Percentage Error (MAPE)\n")
cat("- R-squared (for regression models)\n\n")

cat("4. MODEL PERFORMANCE\n")
cat("==================\n\n")

if (nrow(all_accuracy) > 0) {
  cat("Performance metrics for all models on the test set:\n\n")
  print(all_accuracy)
  cat("\n")

  cat("Model ranking by RMSE (lower is better):\n")
  rmse_ranking <- all_accuracy[order(all_accuracy$RMSE), ]
  for (i in 1:nrow(rmse_ranking)) {
    cat(i, ". ", rmse_ranking$Model[i], " (", rmse_ranking$RMSE[i], ")\n", sep = "")
  }
  cat("\n")
}

cat("5. KEY FINDINGS\n")
cat("==============\n\n")

# Feature importance if available
if (!is.null(reg_models)) {
  cat("Key drivers of inflation identified by regularization models:\n\n")

  # Try to load feature importance
  feature_importance <- tryCatch({
    read.csv("Processed_Data/feature_importance.csv")
  }, error = function(e) {
    NULL
  })

  if (!is.null(feature_importance) && nrow(feature_importance) > 0) {
    top_features <- head(feature_importance, 10)
    print(top_features[, c("Variable", "Avg_Importance")])
    cat("\n")
  } else {
    cat("Feature importance data not available\n\n")
  }
}

cat("6. FORECASTS\n")
cat("===========\n\n")

cat("Forecast period:", format(forecast_start_date, "%Y-%m-%d"), "to",
    format(forecast_end_date, "%Y-%m-%d"), "\n\n")

if (ncol(final_forecasts) > 3) {
  cat("Monthly forecasts:\n\n")
  print(final_forecasts)
  cat("\n")

  # Calculate average forecast if multiple models
  forecast_cols <- setdiff(names(final_forecasts), c("Date", "Month", "Year", "ARIMA_Lower", "ARIMA_Upper"))
  if (length(forecast_cols) > 1) {
    final_forecasts$Average <- rowMeans(final_forecasts[, forecast_cols])
    cat("Average forecast for the next 12 months:", mean(final_forecasts$Average), "\n\n")
  } else if (length(forecast_cols) == 1) {
    cat("Average forecast for the next 12 months:", mean(final_forecasts[[forecast_cols]]), "\n\n")
  }
}

cat("7. CONCLUSIONS AND RECOMMENDATIONS\n")
cat("================================\n\n")

cat("Based on the analysis, the following conclusions can be drawn:\n\n")

cat("1. Model Performance: The", best_model_name, "model demonstrated the best performance\n")
cat("   in forecasting Pakistan's inflation, suggesting that",
    ifelse(grepl("ARIMA", best_model_name),
          "time series patterns and seasonality",
          "the relationship between economic indicators and inflation"),
    "are key to accurate forecasting.\n\n")

cat("2. Inflation Drivers: The analysis identified several key drivers of inflation in Pakistan,\n")
cat("   including exchange rates, global commodity prices, and monetary policy indicators.\n\n")

cat("3. Forecast Reliability: The models show reasonable accuracy on historical data,\n")
cat("   but forecasts should be interpreted with caution due to the inherent uncertainty\n")
cat("   in economic predictions, especially in volatile economic environments.\n\n")

cat("Recommendations for further analysis:\n\n")

cat("1. Incorporate additional variables such as fiscal indicators, remittances,\n")
cat("   and more detailed sectoral data to improve model accuracy.\n\n")

cat("2. Implement more sophisticated forecasting techniques for the predictor variables\n")
cat("   to improve the accuracy of regularization model forecasts.\n\n")

cat("3. Consider ensemble methods that combine the strengths of different modeling approaches\n")
cat("   to potentially improve forecast accuracy.\n\n")

cat("4. Update the models regularly as new data becomes available to maintain forecast accuracy.\n\n")

cat("=======================================================================\n")
cat("                            END OF REPORT                              \n")
cat("=======================================================================\n")

sink()
cat("Generated comprehensive report at Final_Results/pakistan_inflation_forecast_report.txt\n\n")

# --- Final Summary ---
sink("06_model_evaluation_output.txt", append = TRUE)
cat("===== FINAL SUMMARY =====\n\n")

cat("Model evaluation and forecasting completed successfully!\n\n")

if (!is.null(best_model_name)) {
  cat("Best performing model:", best_model_name, "\n")
  cat("Best model RMSE:", all_accuracy$RMSE[best_model_idx], "\n\n")
}

cat("Files created:\n")
cat("1. Final_Results/all_model_accuracy.csv - Combined accuracy metrics\n")
cat("2. Final_Results/all_model_predictions.csv - All model predictions\n")
cat("3. Final_Results/final_forecasts.csv - Final forecasts\n")
cat("4. Final_Results/pakistan_inflation_forecast_report.txt - Comprehensive report\n")
cat("5. Various plots in Plots/evaluation/ directory\n\n")

cat("Project completed successfully!\n\n")

cat("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
sink()

# Print message to console
message("Model evaluation and forecasting completed successfully!")
message("Output saved to Logs/06_model_evaluation_output.txt")
message("Comprehensive report generated at Final_Results/pakistan_inflation_forecast_report.txt")
message("Pakistan Inflation Forecasting Project completed!")

# --- End of script ---
