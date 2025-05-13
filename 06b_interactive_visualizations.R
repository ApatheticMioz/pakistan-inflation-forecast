# 06b_interactive_visualizations.R
# Pakistan Inflation Forecasting Project: Interactive Visualizations
# This script creates interactive visualizations for better stakeholder engagement
#
# Purpose:
# 1. Create interactive visualizations using plotly
# 2. Develop a dashboard with key metrics and forecasts
# 3. Add interactive time series exploration tools
# 4. Create comparative visualizations of model performance
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
  library(ggplot2)
  library(plotly)
  library(htmlwidgets)
  library(DT)
  library(stringr)
  library(htmltools)
})

# --- Create output directories ---
dir.create("Interactive_Visualizations", showWarnings = FALSE, recursive = TRUE)
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)

# --- Set up logging ---
log_file <- "Logs/06b_interactive_visualizations.txt"
sink(log_file)
cat("===== INTERACTIVE VISUALIZATIONS =====\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Load required data ---
cat("Loading required data...\n")

# Load modeling dataframe
if (file.exists("Processed_Data/model_df.rds")) {
  model_df <- readRDS("Processed_Data/model_df.rds")
  cat("Loaded modeling dataframe with", nrow(model_df), "rows and", ncol(model_df), "columns\n")
} else {
  cat("ERROR: Could not find model_df.rds\n")
  cat("Please run 03_prepare_modeling_df.R first to create this file\n\n")
  stop("File not found: Processed_Data/model_df.rds")
}

# Load train-test split
if (file.exists("Processed_Data/train_test_split.rds")) {
  train_test_split <- readRDS("Processed_Data/train_test_split.rds")
  train_data <- train_test_split$train
  test_data <- train_test_split$test
  cat("Loaded train-test split\n")
} else {
  cat("WARNING: Could not find train_test_split.rds\n")
  cat("Will proceed without train-test split information\n\n")
  train_data <- NULL
  test_data <- NULL
}

# Load model predictions
if (file.exists("Processed_Data/model_predictions.rds")) {
  model_predictions <- readRDS("Processed_Data/model_predictions.rds")
  cat("Loaded model predictions\n")
} else {
  cat("WARNING: Could not find model_predictions.rds\n")
  cat("Will proceed without model predictions\n\n")
  model_predictions <- NULL
}

# Load model evaluation results
if (file.exists("Processed_Data/model_evaluation.rds")) {
  model_evaluation <- readRDS("Processed_Data/model_evaluation.rds")
  cat("Loaded model evaluation results\n")
} else {
  cat("WARNING: Could not find model_evaluation.rds\n")
  cat("Will proceed without model evaluation results\n\n")
  model_evaluation <- NULL
}

# Load forecast uncertainty results
if (file.exists("Processed_Data/uncertainty/bootstrap_prediction_intervals.rds")) {
  bootstrap_intervals <- readRDS("Processed_Data/uncertainty/bootstrap_prediction_intervals.rds")
  cat("Loaded bootstrap prediction intervals\n")
} else {
  cat("WARNING: Could not find bootstrap_prediction_intervals.rds\n")
  cat("Will proceed without bootstrap prediction intervals\n\n")
  bootstrap_intervals <- NULL
}

# --- Create Interactive Time Series Plot ---
cat("\n===== CREATING INTERACTIVE TIME SERIES PLOT =====\n\n")

# Create interactive time series plot of CPI
create_interactive_ts_plot <- function(data) {
  cat("Creating interactive time series plot of CPI...\n")

  # Create plotly plot
  p <- plot_ly(data = data, x = ~date, y = ~cpi, type = "scatter", mode = "lines",
               name = "CPI", line = list(color = "blue", width = 2)) %>%
    layout(title = "Pakistan Consumer Price Index (CPI) Over Time",
           xaxis = list(title = "Date"),
           yaxis = list(title = "CPI"),
           hovermode = "x unified")

  # Add range slider
  p <- p %>% layout(
    xaxis = list(
      rangeslider = list(visible = TRUE),
      rangeselector = list(
        buttons = list(
          list(count = 6, label = "6m", step = "month", stepmode = "backward"),
          list(count = 1, label = "1y", step = "year", stepmode = "backward"),
          list(count = 2, label = "2y", step = "year", stepmode = "backward"),
          list(count = 5, label = "5y", step = "year", stepmode = "backward"),
          list(step = "all")
        )
      )
    )
  )

  # Save as HTML widget
  saveWidget(p, "Interactive_Visualizations/cpi_time_series.html", selfcontained = TRUE)
  cat("Interactive time series plot saved to Interactive_Visualizations/cpi_time_series.html\n")

  return(p)
}

# Create the interactive time series plot
cpi_plot <- create_interactive_ts_plot(model_df)

# --- Create Interactive Correlation Heatmap ---
cat("\n===== CREATING INTERACTIVE CORRELATION HEATMAP =====\n\n")

create_correlation_heatmap <- function(data) {
  cat("Creating interactive correlation heatmap...\n")

  # Select numeric columns
  numeric_cols <- sapply(data, is.numeric)
  numeric_data <- data[, numeric_cols]

  # Remove date column if present
  if ("date" %in% names(numeric_data)) {
    numeric_data <- numeric_data[, names(numeric_data) != "date"]
  }

  # Calculate correlation matrix
  cor_matrix <- cor(numeric_data, use = "pairwise.complete.obs")

  # Convert to long format for plotting
  cor_data <- as.data.frame(as.table(cor_matrix))
  names(cor_data) <- c("Var1", "Var2", "Correlation")

  # Create plotly heatmap
  p <- plot_ly(
    z = cor_matrix,
    x = colnames(cor_matrix),
    y = rownames(cor_matrix),
    type = "heatmap",
    colorscale = "RdBu",
    zmin = -1,
    zmax = 1
  ) %>%
    layout(
      title = "Correlation Heatmap of Economic Indicators",
      xaxis = list(title = ""),
      yaxis = list(title = "")
    )

  # Save as HTML widget
  saveWidget(p, "Interactive_Visualizations/correlation_heatmap.html", selfcontained = TRUE)
  cat("Interactive correlation heatmap saved to Interactive_Visualizations/correlation_heatmap.html\n")

  return(p)
}

# Create the interactive correlation heatmap
cor_heatmap <- create_correlation_heatmap(model_df)

# --- Create Interactive Model Comparison Plot ---
cat("\n===== CREATING INTERACTIVE MODEL COMPARISON PLOT =====\n\n")

create_model_comparison_plot <- function(model_evaluation) {
  cat("Creating interactive model comparison plot...\n")

  if (is.null(model_evaluation)) {
    cat("WARNING: No model evaluation data available\n")
    return(NULL)
  }

  # Extract metrics
  metrics_data <- model_evaluation$metrics

  # Create plotly bar chart
  p <- plot_ly() %>%
    add_trace(
      x = metrics_data$model,
      y = metrics_data$rmse,
      type = "bar",
      name = "RMSE",
      marker = list(color = "red")
    ) %>%
    add_trace(
      x = metrics_data$model,
      y = metrics_data$mae,
      type = "bar",
      name = "MAE",
      marker = list(color = "blue")
    ) %>%
    layout(
      title = "Model Performance Comparison",
      xaxis = list(title = "Model"),
      yaxis = list(title = "Error Metric"),
      barmode = "group"
    )

  # Save as HTML widget
  saveWidget(p, "Interactive_Visualizations/model_comparison.html", selfcontained = TRUE)
  cat("Interactive model comparison plot saved to Interactive_Visualizations/model_comparison.html\n")

  return(p)
}

# Create the interactive model comparison plot
model_comparison <- create_model_comparison_plot(model_evaluation)

# --- Create Interactive Forecast Plot with Uncertainty ---
cat("\n===== CREATING INTERACTIVE FORECAST PLOT WITH UNCERTAINTY =====\n\n")

create_forecast_plot <- function(data, model_predictions, bootstrap_intervals) {
  cat("Creating interactive forecast plot with uncertainty...\n")

  if (is.null(model_predictions) || is.null(bootstrap_intervals)) {
    cat("WARNING: No model predictions or bootstrap intervals available\n")
    return(NULL)
  }

  # Get the last date in the data
  last_date <- max(data$date)

  # Create future dates for the forecast horizon
  forecast_horizon <- length(bootstrap_intervals$lasso$point_forecast)
  future_dates <- seq.Date(from = last_date + months(1),
                           by = "month",
                           length.out = forecast_horizon)

  # Create dataframe for historical data
  historical_df <- data.frame(
    date = data$date,
    cpi = data$cpi,
    type = "Historical"
  )

  # Create dataframes for forecasts
  forecast_dfs <- list()
  for (model_name in names(bootstrap_intervals)) {
    forecast_df <- data.frame(
      date = future_dates,
      cpi = bootstrap_intervals[[model_name]]$point_forecast,
      type = paste(model_name, "Forecast"),
      model = model_name
    )
    forecast_dfs[[model_name]] <- forecast_df
  }

  # Combine all forecast dataframes
  all_forecasts <- do.call(rbind, forecast_dfs)

  # Create dataframes for prediction intervals
  interval_dfs <- list()
  for (model_name in names(bootstrap_intervals)) {
    for (level_name in names(bootstrap_intervals[[model_name]]$intervals)) {
      level <- as.numeric(level_name)
      level_df <- data.frame(
        date = future_dates,
        lower = bootstrap_intervals[[model_name]]$intervals[[level_name]]$lower,
        upper = bootstrap_intervals[[model_name]]$intervals[[level_name]]$upper,
        level = level,
        model = model_name
      )
      interval_dfs[[paste(model_name, level_name, sep = "_")]] <- level_df
    }
  }

  # Create plotly plot
  p <- plot_ly()

  # Add historical data
  p <- p %>% add_trace(
    data = historical_df,
    x = ~date,
    y = ~cpi,
    type = "scatter",
    mode = "lines",
    name = "Historical CPI",
    line = list(color = "black", width = 2)
  )

  # Add forecasts for each model
  colors <- c("lasso" = "red", "ridge" = "blue", "elastic_net" = "green", "arima" = "purple")
  for (model_name in names(bootstrap_intervals)) {
    model_forecast <- all_forecasts[all_forecasts$model == model_name, ]
    p <- p %>% add_trace(
      x = model_forecast$date,
      y = model_forecast$cpi,
      type = "scatter",
      mode = "lines",
      name = paste(model_name, "Forecast"),
      line = list(color = colors[[model_name]], width = 2)
    )

    # Add prediction intervals for this model
    for (level_name in names(bootstrap_intervals[[model_name]]$intervals)) {
      interval_key <- paste(model_name, level_name, sep = "_")
      interval_data <- interval_dfs[[interval_key]]

      p <- p %>% add_trace(
        x = c(interval_data$date, rev(interval_data$date)),
        y = c(interval_data$lower, rev(interval_data$upper)),
        fill = "toself",
        fillcolor = paste0(colors[[model_name]], "20"),
        line = list(color = "transparent"),
        name = paste(model_name, "Interval", level_name),
        showlegend = FALSE,
        hoverinfo = "none"
      )
    }
  }

  # Customize layout
  p <- p %>% layout(
    title = "Pakistan CPI Forecast with Uncertainty",
    xaxis = list(title = "Date"),
    yaxis = list(title = "CPI"),
    hovermode = "x unified",
    legend = list(x = 0.01, y = 0.99)
  )

  # Add range slider
  p <- p %>% layout(
    xaxis = list(
      rangeslider = list(visible = TRUE),
      rangeselector = list(
        buttons = list(
          list(count = 6, label = "6m", step = "month", stepmode = "backward"),
          list(count = 1, label = "1y", step = "year", stepmode = "backward"),
          list(count = 2, label = "2y", step = "year", stepmode = "backward"),
          list(step = "all")
        )
      )
    )
  )

  # Save as HTML widget
  saveWidget(p, "Interactive_Visualizations/forecast_with_uncertainty.html", selfcontained = TRUE)
  cat("Interactive forecast plot saved to Interactive_Visualizations/forecast_with_uncertainty.html\n")

  return(p)
}

# Create the interactive forecast plot
forecast_plot <- create_forecast_plot(model_df, model_predictions, bootstrap_intervals)

# --- Create Interactive Variable Importance Plot ---
cat("\n===== CREATING INTERACTIVE VARIABLE IMPORTANCE PLOT =====\n\n")

create_variable_importance_plot <- function(model_evaluation) {
  cat("Creating interactive variable importance plot...\n")

  if (is.null(model_evaluation) || is.null(model_evaluation$variable_importance)) {
    cat("WARNING: No variable importance data available\n")
    return(NULL)
  }

  # Extract variable importance
  var_imp <- model_evaluation$variable_importance

  # Create plotly plot for each model
  plots <- list()

  for (model_name in names(var_imp)) {
    if (model_name == "arima") next  # Skip ARIMA as it doesn't have variable importance

    model_var_imp <- var_imp[[model_name]]

    # Sort by importance
    model_var_imp <- model_var_imp[order(model_var_imp$importance), ]

    # Take top 15 variables
    if (nrow(model_var_imp) > 15) {
      model_var_imp <- tail(model_var_imp, 15)
    }

    # Create plot
    p <- plot_ly(
      x = model_var_imp$importance,
      y = model_var_imp$variable,
      type = "bar",
      orientation = "h",
      marker = list(color = "steelblue")
    ) %>%
      layout(
        title = paste(model_name, "Variable Importance"),
        xaxis = list(title = "Importance"),
        yaxis = list(title = "")
      )

    # Save as HTML widget
    saveWidget(p, paste0("Interactive_Visualizations/variable_importance_", model_name, ".html"),
               selfcontained = TRUE)
    cat("Interactive variable importance plot saved to Interactive_Visualizations/variable_importance_",
        model_name, ".html\n", sep = "")

    plots[[model_name]] <- p
  }

  return(plots)
}

# Create the interactive variable importance plots
var_imp_plots <- create_variable_importance_plot(model_evaluation)

# --- Create Interactive Dashboard ---
cat("\n===== CREATING INTERACTIVE DASHBOARD =====\n\n")

create_dashboard <- function() {
  cat("Creating interactive dashboard...\n")

  # Create HTML for dashboard
  current_date <- format(Sys.time(), "%Y-%m-%d")
  html <- paste0('
  <!DOCTYPE html>
  <html>
  <head>
    <title>Pakistan Inflation Forecasting Dashboard</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
      .header {
        background-color: #4CAF50;
        color: white;
        padding: 20px;
        text-align: center;
      }
      .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        padding: 20px;
      }
      .chart {
        width: 100%;
        margin-bottom: 20px;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        transition: 0.3s;
        border-radius: 5px;
        overflow: hidden;
      }
      .chart:hover {
        box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
      }
      .chart-header {
        background-color: #f1f1f1;
        padding: 10px;
        font-weight: bold;
      }
      .chart-content {
        padding: 10px;
        height: 500px;
      }
      iframe {
        width: 100%;
        height: 100%;
        border: none;
      }
      @media (min-width: 768px) {
        .chart {
          width: 48%;
        }
      }
      @media (min-width: 1200px) {
        .chart {
          width: 32%;
        }
      }
    </style>
  </head>
  <body>
    <div class="header">
      <h1>Pakistan Inflation Forecasting Dashboard</h1>
      <p>Interactive visualizations for inflation forecasting analysis</p>
    </div>

    <div class="container">
      <div class="chart">
        <div class="chart-header">CPI Time Series</div>
        <div class="chart-content">
          <iframe src="cpi_time_series.html"></iframe>
        </div>
      </div>

      <div class="chart">
        <div class="chart-header">Forecast with Uncertainty</div>
        <div class="chart-content">
          <iframe src="forecast_with_uncertainty.html"></iframe>
        </div>
      </div>

      <div class="chart">
        <div class="chart-header">Model Comparison</div>
        <div class="chart-content">
          <iframe src="model_comparison.html"></iframe>
        </div>
      </div>

      <div class="chart">
        <div class="chart-header">Correlation Heatmap</div>
        <div class="chart-content">
          <iframe src="correlation_heatmap.html"></iframe>
        </div>
      </div>

      <div class="chart">
        <div class="chart-header">Lasso Variable Importance</div>
        <div class="chart-content">
          <iframe src="variable_importance_lasso.html"></iframe>
        </div>
      </div>

      <div class="chart">
        <div class="chart-header">Ridge Variable Importance</div>
        <div class="chart-content">
          <iframe src="variable_importance_ridge.html"></iframe>
        </div>
      </div>
    </div>

    <div class="header" style="font-size: 0.8em; padding: 10px;">
      <p>Pakistan Inflation Forecasting Project | Created on ', current_date, '</p>
    </div>
  </body>
  </html>
  ')

  # Write HTML to file
  writeLines(html, "Interactive_Visualizations/dashboard.html")
  cat("Interactive dashboard saved to Interactive_Visualizations/dashboard.html\n")
}

# Create the dashboard
create_dashboard()

# --- Create README file ---
cat("\n===== CREATING README FILE =====\n\n")

create_readme <- function() {
  cat("Creating README file for interactive visualizations...\n")

  current_date <- format(Sys.time(), "%Y-%m-%d")
  readme <- paste0('# Pakistan Inflation Forecasting Project: Interactive Visualizations

This directory contains interactive visualizations for the Pakistan Inflation Forecasting Project.

## Contents

1. **dashboard.html** - Main dashboard with all visualizations
2. **cpi_time_series.html** - Interactive time series plot of Pakistan CPI
3. **correlation_heatmap.html** - Interactive correlation heatmap of economic indicators
4. **model_comparison.html** - Interactive comparison of model performance
5. **forecast_with_uncertainty.html** - Interactive forecast plot with uncertainty intervals
6. **variable_importance_*.html** - Interactive variable importance plots for each model

## How to Use

1. Open the dashboard.html file in a web browser to view all visualizations in one place
2. Individual visualization files can be opened separately for a more detailed view
3. Use the interactive features:
   - Hover over data points to see details
   - Zoom in/out using the tools in the top right
   - Pan by clicking and dragging
   - Use range sliders to focus on specific time periods
   - Toggle visibility of series by clicking on legend items

## Notes

- These visualizations are HTML files that can be viewed in any modern web browser
- No internet connection is required as all files are self-contained
- For best performance, use Chrome, Firefox, or Edge browsers

Created on ', current_date)

  # Write README to file
  writeLines(readme, "Interactive_Visualizations/README.md")
  cat("README file saved to Interactive_Visualizations/README.md\n")
}

# Create the README file
create_readme()

# --- Summary ---
cat("\n===== SUMMARY =====\n\n")
cat("Interactive visualizations created at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("Files created:\n")
cat("- Interactive_Visualizations/dashboard.html\n")
cat("- Interactive_Visualizations/cpi_time_series.html\n")
cat("- Interactive_Visualizations/correlation_heatmap.html\n")
if (!is.null(model_comparison)) {
  cat("- Interactive_Visualizations/model_comparison.html\n")
}
if (!is.null(forecast_plot)) {
  cat("- Interactive_Visualizations/forecast_with_uncertainty.html\n")
}
if (!is.null(var_imp_plots)) {
  for (model_name in names(var_imp_plots)) {
    cat(sprintf("- Interactive_Visualizations/variable_importance_%s.html\n", model_name))
  }
}
cat("- Interactive_Visualizations/README.md\n")

cat("\nNext steps:\n")
cat("1. Open the dashboard.html file in a web browser to explore the visualizations\n")
cat("2. Share the visualizations with stakeholders for better engagement\n")
cat("3. Update the visualizations as new data becomes available\n\n")

# Close the log file
sink()

# Print message to console
message("Interactive visualizations created!")
message("Log saved to ", log_file)
message("Open Interactive_Visualizations/dashboard.html in a web browser to explore the visualizations")
