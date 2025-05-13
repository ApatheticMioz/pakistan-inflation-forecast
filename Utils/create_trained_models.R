# Create trained_models.rds file
# This script combines the ARIMA and regularization models into a single RDS file

# Load required libraries
suppressPackageStartupMessages({
  library(dplyr)
})

# Create Models directory if it doesn't exist
dir.create("Models", showWarnings = FALSE, recursive = TRUE)

# Load ARIMA model
if (file.exists("Models/arima_model.rds")) {
  arima_model <- readRDS("Models/arima_model.rds")
  message("Loaded ARIMA model")
} else {
  message("ARIMA model file not found")
  arima_model <- NULL
}

# Load regularization models
if (file.exists("Models/regularization_models.rds")) {
  reg_models <- readRDS("Models/regularization_models.rds")
  message("Loaded regularization models")
} else {
  message("Regularization models file not found")
  reg_models <- NULL
}

# Combine models
trained_models <- list()

# Add ARIMA model
if (!is.null(arima_model)) {
  trained_models$arima <- arima_model
}

# Add regularization models
if (!is.null(reg_models)) {
  if ("lasso" %in% names(reg_models)) {
    trained_models$lasso <- reg_models$lasso
  }
  if ("ridge" %in% names(reg_models)) {
    trained_models$ridge <- reg_models$ridge
  }
  if ("elastic_net" %in% names(reg_models)) {
    trained_models$elastic_net <- reg_models$elastic_net
  }
}

# Save combined models
saveRDS(trained_models, "Models/trained_models.rds")
message("Saved trained models to Models/trained_models.rds")

# Print summary
message("Models included:")
for (model_name in names(trained_models)) {
  message("- ", model_name)
}
