#!/usr/bin/env Rscript
# Setup Script for Pakistan Inflation Forecasting Project
# This script installs dependencies and sets up the project environment

cat("===== Pakistan Inflation Forecasting Project Setup =====\n\n")

# Check R version
r_version <- getRversion()
cat(sprintf("R version: %s\n", r_version))

if (r_version < "4.0.0") {
  warning("R version 4.0.0 or higher is recommended")
}

# List of required packages
required_packages <- c(
  # Data manipulation
  "dplyr",
  "tidyr",
  "readr",
  "tibble",
  "purrr",
  "stringr",
  "janitor",
  
  # Date/time handling
  "lubridate",
  "zoo",
  
  # Visualization
  "ggplot2",
  "GGally",
  "gridExtra",
  "corrplot",
  "reshape2",
  "VIM",
  
  # Time series
  "forecast",
  "tseries",
  
  # Machine learning
  "glmnet",
  "caret",
  "Matrix",
  
  # Statistics
  "moments",
  
  # Reporting
  "knitr",
  "rmarkdown",
  
  # Configuration
  "yaml",
  
  # Development tools
  "testthat",
  "lintr",
  "covr"
)

# Function to check if package is installed
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# Function to install package if missing
install_if_missing <- function(pkg) {
  if (!is_installed(pkg)) {
    cat(sprintf("Installing %s...\n", pkg))
    tryCatch({
      install.packages(pkg, repos = "https://cloud.r-project.org/", quiet = TRUE)
      return(TRUE)
    }, error = function(e) {
      cat(sprintf("  Error installing %s: %s\n", pkg, e$message))
      return(FALSE)
    })
  } else {
    return(TRUE)
  }
}

# Install packages
cat("\nChecking and installing required packages...\n\n")
installed_count <- 0
failed_packages <- character()

for (pkg in required_packages) {
  if (is_installed(pkg)) {
    cat(sprintf("  [OK] %s\n", pkg))
    installed_count <- installed_count + 1
  } else {
    if (install_if_missing(pkg)) {
      cat(sprintf("  [INSTALLED] %s\n", pkg))
      installed_count <- installed_count + 1
    } else {
      cat(sprintf("  [FAILED] %s\n", pkg))
      failed_packages <- c(failed_packages, pkg)
    }
  }
}

# Create output directories
cat("\nCreating output directories...\n")
dirs <- c(
  "Logs",
  "Output",
  "Processed_Data",
  "Processed_Data/uncertainty",
  "Plots",
  "Plots/eda",
  "Plots/model_prep",
  "Plots/arima",
  "Plots/regularization",
  "Plots/uncertainty",
  "Plots/evaluation",
  "Models",
  "Final_Results"
)

for (dir in dirs) {
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
    cat(sprintf("  Created: %s\n", dir))
  } else {
    cat(sprintf("  Exists: %s\n", dir))
  }
}

# Summary
cat("\n===== Setup Summary =====\n")
cat(sprintf("Packages installed: %d/%d\n", installed_count, length(required_packages)))

if (length(failed_packages) > 0) {
  cat(sprintf("\nFailed to install: %s\n", paste(failed_packages, collapse = ", ")))
  cat("You may need to install these manually.\n")
}

cat("\n===== Next Steps =====\n")
cat("1. Run the analysis pipeline:\n")
cat("   Rscript 01_load_and_eda.R\n")
cat("   Rscript 02_merge_datasets.R\n")
cat("   Rscript 03_prepare_modeling_df.R\n")
cat("   Rscript 04_arima_modeling.R\n")
cat("   Rscript 05_regularization_modeling.R\n")
cat("   Rscript 06_model_evaluation.R\n")
cat("\n2. Or use Make:\n")
cat("   make run\n")
cat("\n3. Or use Docker:\n")
cat("   docker-compose up forecast\n")

cat("\nSetup complete!\n")
