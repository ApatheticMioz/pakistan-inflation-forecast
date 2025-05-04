# --- Load Necessary Libraries ---
# install.packages(c("glmnet", "dplyr", "ggplot2", "tidyr", "lubridate", "reshape2")) # Keep commented unless needed
library(glmnet)
library(dplyr)
library(ggplot2)
library(tidyr)     # For pivot_wider, pivot_longer, unnest
library(lubridate)
# library(reshape2) # Not strictly needed if using tidyr::pivot_longer

cat("Current Date/Time:", format(Sys.time()), "\n") # For reference

# --- 1. Load Data ---
# !! IMPORTANT: Replace this with the actual path to your CSV file !!
file_path <- "D:/work/Semester4/AdvStats/pakistan-inflation-forecast/Data/inflation_base_2015.csv"
# Example: file_path <- "D:/data/inflation_base_2015.csv"

# Load the data
tryCatch({
  raw_data <- read.csv(file_path, stringsAsFactors = FALSE, na.strings = c(
    "", " ", "-", ".", "..", "...", "NA", "#N/A", "N/A", "n/a",
    "NULL", "null", "NaN", "nan", "Missing", "missing",
    "No data", "no data", "?", "<NA>",
    "###", "####", "#####", "######", "#######", "########"
  ))
  cat("Data loaded successfully. Rows:", nrow(raw_data), "\n")
}, error = function(e) {
  stop(paste("Error loading file:", file_path, "\nOriginal error message:", e$message))
})

# --- 2. Prepare Data Frame ---
# Select necessary columns and rename for clarity
required_cols <- c("Observation.Date", "Series.Display.Name", "Observation.Value")
if (!all(required_cols %in% names(raw_data))) {
  stop(paste("One or more required columns not found in CSV. Check names like:",
             paste(required_cols[!required_cols %in% names(raw_data)], collapse=", ")))
}

long_data <- raw_data %>%
  select(
    Date_Str = Observation.Date,
    Series_Name = Series.Display.Name,
    Value = Observation.Value
  )

# Convert Value column to numeric, coercing errors to NA
long_data$Value <- suppressWarnings(as.numeric(as.character(long_data$Value)))
na_value_initial_count <- sum(is.na(long_data$Value))
cat("Values initially non-numeric or NA:", na_value_initial_count, "\n")

# Convert Date column - Robust parsing
long_data$Date <- parse_date_time(long_data$Date_Str, orders = c("d-b-Y", "Ymd", "dmY", "mdY", "Y-m-d", "m/d/Y"), quiet = TRUE)
na_date_count <- sum(is.na(long_data$Date))
if(na_date_count > 0) {
  warning(paste(na_date_count, "dates could not be parsed. Rows with NA dates will be removed."))
  long_data <- long_data %>% filter(!is.na(Date))
}

# Remove rows where numeric conversion failed AFTER date filtering
long_data <- long_data %>% filter(!is.na(Value))
na_value_after_date_filter <- sum(is.na(long_data$Value)) # Should be 0 now
if(nrow(long_data) == 0) {
  stop("No valid data rows remaining after date parsing and NA value filtering. Check date formats and value column.")
}
cat("Rows remaining after date/value cleaning:", nrow(long_data), "\n")


# --- Filter for Required CPI Series ---
# !! IMPORTANT: Verify these filter strings EXACTLY match the values
# !! in your 'Series.Display.Name' column.
# !! CHOOSE YOUR FIFTH INDEPENDENT VARIABLE and replace the placeholder.
# !! Example assumes Urban Non-Food is added and asks user for the 5th.

dependent_series_name <- ". CPI-YoY-National"
independent_series_names <- c(
  ". NFNE-YoY-Urban",                 # Core NFNE CPI
  ". Trimmed-YoY-Urban",              # Core Trimmed CPI
  "................... Food",       # Urban Food CPI
  "................... Non-Food",   # Urban Non-Food CPI (ADDED)
  "PLACEHOLDER_FOR_FIFTH_VARIABLE"    # !! REPLACE THIS !! e.g., "............. Rural" or an Energy series name
  # Example if using Rural Non-Food: "................... Non-Food" # (Need to distinguish from Urban if name identical)
  # If names are identical, you might need to filter based on another column like "Series Key" if available
)

# *** ACTION REQUIRED: Replace the placeholder above ***
if ("PLACEHOLDER_FOR_FIFTH_VARIABLE" %in% independent_series_names) {
  warning("PLACEHOLDER_FOR_FIFTH_VARIABLE needs to be replaced with an actual series name from your data in the 'independent_series_names' list.")
  # Optional: Stop execution if placeholder isn't replaced
  # stop("Please replace PLACEHOLDER_FOR_FIFTH_VARIABLE in the script.")
  # For now, we'll proceed but the model will likely have fewer than 5 predictors
}

series_filters <- c(dependent_series_name, independent_series_names)

filtered_data <- long_data %>%
  filter(Series_Name %in% series_filters)

# Check if all expected series were found
found_series <- unique(filtered_data$Series_Name)
expected_series <- series_filters[series_filters != "PLACEHOLDER_FOR_FIFTH_VARIABLE"] # Don't count placeholder if not replaced
missing_series <- setdiff(expected_series, found_series)

if(length(missing_series) > 0) {
  warning(paste("Could not find data for the following expected series names:",
                paste(missing_series, collapse="; "),
                "- Please check the 'independent_series_names' list and your CSV data.",
                "The analysis will proceed without these series."))
}
if (!dependent_series_name %in% found_series) {
  stop(paste("Dependent variable series '", dependent_series_name, "' not found in the data. Cannot proceed."))
}
if (length(intersect(independent_series_names, found_series)) == 0) {
  stop("None of the specified independent variable series were found. Cannot proceed.")
}

cat("Found", length(found_series), "unique series matching filters.\n")
cat("Filtered data rows:", nrow(filtered_data), "\n")

# --- Handle Potential Duplicates and Pivot Data to Wide Format ---

# Create clean names MAP for pivoting - MAKE SURE THIS MATCHES YOUR SERIES LIST
# !! ADJUST NAMES and MAPPINGS if you change independent_series_names !!
series_to_clean_name <- function(series_name) {
  case_when(
    series_name == ". CPI-YoY-National" ~ "Headline_CPI",
    series_name == ". NFNE-YoY-Urban" ~ "Core_NFNE_CPI",
    series_name == ". Trimmed-YoY-Urban" ~ "Core_Trimmed_CPI",
    series_name == "................... Food" ~ "Urban_Food_CPI",    # Renamed for clarity
    series_name == "................... Non-Food" ~ "Urban_NonFood_CPI", # Added
    # Add your FIFTH variable's mapping here:
    series_name == "PLACEHOLDER_FOR_FIFTH_VARIABLE" ~ "Fifth_Var_CPI", # Replace Fifth_Var_CPI too
    # Example: series_name == "............. Rural" ~ "Rural_CPI",
    TRUE ~ NA_character_ # Catch unexpected series
  )
}

# Add CPI_Type column
filtered_data <- filtered_data %>%
  mutate(CPI_Type = series_to_clean_name(Series_Name)) %>%
  filter(!is.na(CPI_Type)) # Remove rows that didn't match expected types

# *FIX*: Ensure one value per Date/CPI_Type before pivoting
# Group by Date and the clean CPI_Type, calculate mean value (or first/last)
# This resolves the list-column issue.
summarized_data <- filtered_data %>%
  group_by(Date, CPI_Type) %>%
  summarise(Value = mean(Value, na.rm = TRUE), .groups = 'drop') # Use mean to average potential duplicates

# Check if averaging occurred (optional but informative)
duplicates_info <- filtered_data %>%
  group_by(Date, CPI_Type) %>%
  filter(n() > 1) %>%
  summarise(N = n(), .groups = 'drop')
if(nrow(duplicates_info) > 0) {
  warning(paste("Found", nrow(duplicates_info), "instances of duplicate Date/CPI_Type combinations.",
                "Averaged values were used. Check raw data if unexpected. First few duplicates:\n",
                paste(capture.output(head(duplicates_info)), collapse = "\n")))
}

# Pivot to wide format using the summarized data
inflation_data_wide <- summarized_data %>%
  pivot_wider(names_from = CPI_Type, values_from = Value)

cat("Data pivoted to wide format. Dimensions:", paste(dim(inflation_data_wide), collapse=" x "), "\n")

# Define target column names based on the mapping function
target_dependent_col <- series_to_clean_name(dependent_series_name)
target_independent_cols <- sapply(independent_series_names[independent_series_names != "PLACEHOLDER_FOR_FIFTH_VARIABLE"], series_to_clean_name)
target_independent_cols <- target_independent_cols[!is.na(target_independent_cols)] # Remove NA if placeholder wasn't mapped

# Check for required columns after pivoting
required_wide_cols <- c(target_dependent_col, target_independent_cols)
missing_wide_cols <- setdiff(required_wide_cols, names(inflation_data_wide))

if (length(missing_wide_cols) > 0) {
  stop(paste("Could not create wide data with all required columns after pivoting. Missing:",
             paste(missing_wide_cols, collapse=", "),
             "\nCheck filters, mapping, and original data."))
}
cat("All required columns found in wide data.\n")


# Handle Missing Values AFTER pivoting
numeric_cols_wide <- setdiff(names(inflation_data_wide), "Date") # All columns except Date
na_counts_before_impute <- colSums(is.na(inflation_data_wide[, numeric_cols_wide, drop = FALSE]))
print("Missing value counts before imputation (Wide Format):")
print(na_counts_before_impute)

# Impute NAs in numeric columns using the median
# This loop should now work correctly on numeric columns
for(col in numeric_cols_wide){
  if(any(is.na(inflation_data_wide[[col]]))){
    median_val <- median(inflation_data_wide[[col]], na.rm = TRUE)
    if (is.na(median_val)) {
      warning(paste("Cannot compute median for column:", col, "- it might contain only NAs. Imputation skipped for this column."))
    } else {
      inflation_data_wide[[col]][is.na(inflation_data_wide[[col]])] <- median_val
      cat(paste("Imputed NAs in", col, "using median (", round(median_val, 3), ").\n"))
    }
  }
}

# Verify no NAs remaining in numeric columns used for model
print("Missing value counts after imputation (Wide Format):")
na_counts_after_impute <- colSums(is.na(inflation_data_wide[, numeric_cols_wide, drop=FALSE]))
print(na_counts_after_impute)
if(any(na_counts_after_impute[required_wide_cols] > 0)) {
  warning("NAs still present in required columns after imputation. Check median calculation or data.")
  print(inflation_data_wide[!complete.cases(inflation_data_wide[, required_wide_cols]), required_wide_cols])
}


# Sort data by date
inflation_data_wide <- inflation_data_wide %>% arrange(Date)

# Add a time index column
inflation_data_wide$Index <- 1:nrow(inflation_data_wide)

cat("\nWide data frame created and prepared.\n")
print(head(inflation_data_wide))
print(str(inflation_data_wide)) # Check column types are numeric


# --- 3. List Independent Variables ---
dependent_var <- target_dependent_col
# Use the independent columns that *actually exist* in the wide data
independent_vars <- intersect(target_independent_cols, names(inflation_data_wide))

cat("\nDependent Variable (Y):", dependent_var, "\n")
cat("Independent Variables (X) found for modeling:\n")
print(independent_vars)
if (length(independent_vars) < 5 && !"PLACEHOLDER_FOR_FIFTH_VARIABLE" %in% independent_series_names) {
  warning(paste("Only", length(independent_vars), "independent variables are available for modeling, less than the target of 5."))
} else if (length(independent_vars) < length(target_independent_cols)) {
  warning(paste("Only", length(independent_vars), "out of", length(target_independent_cols), "targeted independent variables are available for modeling."))
}


# --- 4. Normalize and Standardize Data ---
# Make sure the columns exist before trying to scale/normalize
cols_to_scale <- c(dependent_var, independent_vars)
cols_exist_check <- all(cols_to_scale %in% names(inflation_data_wide))
if (!cols_exist_check) {
  stop("One or more variables listed for scaling do not exist in the wide data frame.")
}
# Check if columns are numeric before scaling
col_types <- sapply(inflation_data_wide[, cols_to_scale, drop=FALSE], class)
if(any(col_types != "numeric")) {
  stop(paste("Cannot scale non-numeric columns:", paste(names(col_types[col_types != "numeric"]), collapse=", ")))
}

# Standardization (Mean = 0, SD = 1)
standardized_data <- inflation_data_wide
# Use tryCatch for robustness if scaling somehow fails
tryCatch({
  standardized_data[cols_to_scale] <- scale(standardized_data[cols_to_scale])
  cat("\nData standardized.\n")
  # print(head(standardized_data))
  # Check for NAs introduced by scaling (e.g., if SD was zero)
  if (any(is.na(standardized_data[cols_to_scale]))) {
    warning("NAs detected after standardization. Check for columns with zero variance.")
    print(colSums(is.na(standardized_data[cols_to_scale])))
    # Consider removing constant columns or handling NAs again if necessary
    # standardized_data <- standardized_data[complete.cases(standardized_data[cols_to_scale]), ] # Option: remove rows with NAs
  }
}, error = function(e) {
  stop(paste("Error during standardization:", e$message))
})


# Normalization (Min-Max Scaling to 0-1)
normalize <- function(x) {
  if(is.numeric(x)) {
    range_x <- range(x, na.rm = TRUE)
    if (diff(range_x) == 0) return(rep(0, length(x))) # Handle constant columns
    return ((x - range_x[1]) / (range_x[2] - range_x[1]))
  } else {
    warning("Non-numeric column passed to normalize function.")
    return(x) # Return unchanged
  }
}
normalized_data <- inflation_data_wide
# Use lapply safely
normalized_data[cols_to_scale] <- lapply(normalized_data[cols_to_scale], normalize)
cat("\nData normalized.\n")
# print(head(normalized_data))


# --- 5. Scatter Plot of Original Data ---
cat("\nGenerating scatter plot matrix for original data (wide format)...\n")
plot_cols_original <- c(dependent_var, independent_vars)
if (length(plot_cols_original) > 1) {
  # Ensure data is purely numeric for pairs plot
  plot_data_original <- inflation_data_wide[, plot_cols_original, drop = FALSE]
  if (all(sapply(plot_data_original, is.numeric))) {
    pairs(plot_data_original, main = "Scatter Plot Matrix (Original Data)", pch = '.')
  } else {
    warning("Could not create pairs plot because some columns are not numeric.")
  }
} else {
  warning("Not enough numeric columns available for pairs plot of original data.")
}


# --- 6. Ridge Regression Model ---
cat("\nFitting Ridge Regression model...\n")

# Prepare matrices for glmnet using STANDARDIZED data
# Ensure columns exist and are numeric
if (!all(independent_vars %in% names(standardized_data)) || !dependent_var %in% names(standardized_data)) {
  stop("Independent or dependent variable columns not found in standardized_data.")
}
x_vars_check <- standardized_data[, independent_vars, drop = FALSE]
y_var_check <- standardized_data[[dependent_var]]

if (!is.matrix(x_vars_check)) x_vars_check <- as.matrix(x_vars_check)
if (!is.numeric(y_var_check)) stop("Dependent variable is not numeric.")
if (any(!sapply(x_vars_check, is.numeric))) stop ("Independent variables matrix is not numeric.")

# Final check for NAs before glmnet
if (any(is.na(x_vars_check)) || any(is.na(y_var_check))) {
  stop("NAs detected in data immediately before passing to glmnet. Check imputation and standardization steps.")
}
x_vars <- x_vars_check
y_var <- y_var_check
cat("Dimensions of matrix X for glmnet:", paste(dim(x_vars), collapse=" x "), "\n")
cat("Length of vector Y for glmnet:", length(y_var), "\n")


# Find the best lambda using cross-validation
set.seed(123) # for reproducibility
tryCatch({
  cv_ridge <- cv.glmnet(x_vars, y_var, alpha = 0, nfolds = 10) # alpha = 0 for Ridge
  best_lambda <- cv_ridge$lambda.min
  cat("\nBest Lambda found via cross-validation:", best_lambda, "\n")
  
  # Plot cross-validation results
  plot(cv_ridge)
  title("Ridge Regression Cross-Validation", line = 2.5)
  
  # Fit the final Ridge model using the best lambda
  ridge_model <- glmnet(x_vars, y_var, alpha = 0, lambda = best_lambda)
  cat("\nRidge Model Coefficients (for standardized data):\n")
  print(coef(ridge_model))
  
}, error = function(e) {
  stop(paste("Error during glmnet cross-validation or fitting:", e$message))
})


# --- 7. Generate Predictions & Scatter Plot ---
cat("\nGenerating predictions...\n")

# Check if ridge_model exists
if (!exists("ridge_model")) {
  stop("Ridge model object ('ridge_model') not found. Fitting likely failed.")
}
# Check dimensions for prediction
if (ncol(x_vars) != nrow(coef(ridge_model)) - 1) { # -1 for intercept
  stop(paste("Mismatch between number of variables in x_vars (", ncol(x_vars),
             ") and model coefficients (", nrow(coef(ridge_model)) - 1, ")."))
}


predictions_standardized <- predict(ridge_model, s = best_lambda, newx = x_vars)

# Un-standardize predictions
# Calculate mean/sd from the ORIGINAL data BEFORE standardization
mean_y_original <- mean(inflation_data_wide[[dependent_var]], na.rm = TRUE)
sd_y_original <- sd(inflation_data_wide[[dependent_var]], na.rm = TRUE)

# Check if mean/sd are valid
if (is.na(mean_y_original) || is.na(sd_y_original) || sd_y_original == 0) {
  warning("Could not calculate valid mean/SD of original dependent variable. Predictions cannot be rescaled.")
  predictions_original_scale <- rep(NA, nrow(predictions_standardized)) # Assign NAs
} else {
  predictions_original_scale <- predictions_standardized * sd_y_original + mean_y_original
}


# Add predictions to the original wide dataframe
# Check length compatibility
if (nrow(inflation_data_wide) != length(predictions_original_scale)) {
  stop(paste("Prediction length (", length(predictions_original_scale),
             ") does not match data frame rows (", nrow(inflation_data_wide), ")."))
}
inflation_data_wide$Predicted_Headline_CPI <- as.vector(predictions_original_scale) # Use the correct name

cat("\nGenerating scatter plot of Predicted vs Actual values (Original Scale)...\n")
# Only plot if predictions are not all NA
if (!all(is.na(inflation_data_wide$Predicted_Headline_CPI))) {
  print( # Ensure ggplot object is printed
    ggplot(inflation_data_wide, aes(x = .data[[dependent_var]], y = Predicted_Headline_CPI)) + # Use .data[[]]
      geom_point(alpha = 0.7) +
      geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
      labs(
        title = "Predicted vs Actual Headline CPI (Original Scale)",
        x = paste("Actual", dependent_var),
        y = paste("Predicted", dependent_var)
      ) +
      theme_minimal() +
      coord_equal() # Use coord_equal for 1:1 comparison
  )
} else {
  warning("Skipping Predicted vs Actual plot because predictions could not be generated or rescaled.")
}

# --- 8. R-squared ---
# Calculated on STANDARDARDIZED values, consistent with model fit
actual_y_standardized <- y_var # Already have this from model fitting
# Check if predictions are valid
if (exists("predictions_standardized") && length(actual_y_standardized) == length(predictions_standardized)) {
  tss <- sum((actual_y_standardized - mean(actual_y_standardized))^2)
  rss <- sum((actual_y_standardized - predictions_standardized)^2)
  if (tss > 0) {
    r_squared_ridge <- 1 - (rss / tss)
    cat("\nVariance Explained (Pseudo R-squared) by Ridge Model (on standardized data):", round(r_squared_ridge, 4), "\n")
  } else {
    cat("\nCannot calculate R-squared (Total Sum of Squares is zero).\n")
  }
} else {
  cat("\nCannot calculate R-squared because standardized predictions or actual values are missing/mismatched.\n")
}


# OLS Comparison (on standardized data)
ols_formula <- as.formula(paste(dependent_var, "~", paste(independent_vars, collapse = "+")))
tryCatch({
  ols_model <- lm(ols_formula, data = standardized_data)
  ols_summary <- summary(ols_model)
  cat("For comparison, OLS Model R-squared (on standardized data):", round(ols_summary$r.squared, 4), "\n")
  cat("OLS Model Adjusted R-squared (on standardized data):", round(ols_summary$adj.r.squared, 4), "\n")
}, error = function(e){
  cat("Could not fit OLS model for comparison:", e$message, "\n")
})


# --- 9. Correlation and Covariance ---
# Uses the STANDARDIZED predictors matrix (x_vars)
if (ncol(x_vars) > 1) {
  cat("\nCalculating Correlation Matrix (Standardized Predictors)...\n")
  correlation_matrix <- cor(x_vars)
  print(round(correlation_matrix, 3))
  
  cat("\nCalculating Covariance Matrix (Standardized Predictors)...\n")
  # Covariance of standardized variables should be same as correlation
  covariance_matrix <- cov(x_vars)
  print(round(covariance_matrix, 3))
} else {
  cat("\nSkipping Correlation/Covariance matrix (only one predictor).\n")
}


# --- 10. Plot Predicted vs Actual Over Time ---
cat("\nGenerating plot of Predicted vs Actual over Time (Original Scale)...\n")
# Check if predictions column exists and is not all NA
if ("Predicted_Headline_CPI" %in% names(inflation_data_wide) && !all(is.na(inflation_data_wide$Predicted_Headline_CPI))) {
  print( # Ensure ggplot object is printed
    ggplot(inflation_data_wide, aes(x = Date)) +
      geom_line(aes(y = .data[[dependent_var]], color = "Actual")) +
      geom_line(aes(y = Predicted_Headline_CPI, color = "Predicted"), linetype = "dashed") +
      labs(
        title = "Actual vs Predicted Headline CPI Over Time",
        x = "Date",
        y = dependent_var, # Use variable name
        color = "Legend"
      ) +
      theme_minimal() +
      scale_color_manual(values = c("Actual" = "blue", "Predicted" = "red"))
  )
} else {
  warning("Skipping time series plot because Predicted_Headline_CPI column is missing or empty.")
}

# --- 11. Table of Original and Forecasted Values ---
cat("\nTable: Original vs Forecasted (Predicted) Values (First 20 rows)...\n")
if ("Predicted_Headline_CPI" %in% names(inflation_data_wide)) {
  forecast_table <- inflation_data_wide %>%
    select(Date, Actual = all_of(dependent_var), Forecasted = Predicted_Headline_CPI) # Use actual names
  print(head(forecast_table, 20), digits=3)
  # print(forecast_table) # Uncomment for full table
} else {
  cat("Forecast table cannot be generated.\n")
}


# --- 12. Scatter Plot of Normalized Variables (Colored) ---
cat("\nGenerating scatter plot of Normalized Variables over Time Index...\n")

# Use the NORMLIZED data
plot_cols_normalized <- c("Index", dependent_var, independent_vars)
plot_cols_normalized_exist <- intersect(plot_cols_normalized, names(normalized_data))

if (length(plot_cols_normalized_exist) > 1) { # Need Index + at least one CPI
  # Use pivot_longer (replaces melt)
  normalized_data_long <- normalized_data %>%
    select(all_of(plot_cols_normalized_exist)) %>%
    pivot_longer(cols = -Index, names_to = "CPI_Type", values_to = "Normalized_Value")
  
  print( # Ensure ggplot object is printed
    ggplot(normalized_data_long, aes(x = Index, y = Normalized_Value, color = CPI_Type)) +
      geom_line(alpha = 0.8) + # Use lines instead of points for time series view
      # geom_point(alpha = 0.7, size = 1.5) + # Optional: add points
      labs(
        title = "Normalized CPI Variables Over Time Index",
        x = "Time Index (sorted by Date)",
        y = "Normalized Value (0 to 1)",
        color = "CPI Variable"
      ) +
      theme_minimal()
  )
} else {
  warning("Not enough columns available for normalized variables plot.")
}

cat("\n--- Analysis Finished --- \n")

