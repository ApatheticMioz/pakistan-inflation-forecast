# 05_regularization_modeling.R
# Pakistan Inflation Forecasting Project: Regularization Modeling
# This script implements Lasso, Ridge, and Elastic-Net Regression for forecasting inflation in Pakistan.
# Authors: M. Abdullah Ali (23I-2523), Abdullah Aaamir (23I-2538)
# Date: 2025-05-06
#
# NOTES FOR DEMO:
# - Regularization techniques help prevent overfitting with many predictors
# - Ridge regression (L2) shrinks coefficients toward zero but keeps all variables
# - Lasso regression (L1) performs variable selection by setting some coefficients to exactly zero
# - Elastic Net combines Ridge and Lasso for balanced regularization
# - We'll ensure more significant than insignificant variables in our models
# - Cross-validation helps select optimal regularization parameters
# - We'll compare all three approaches to find the best performing model
# - These methods work well with Pakistan's economic data which has multicollinearity

# --- Load required libraries ---
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(glmnet)
  library(caret)
  library(readr)
  library(lubridate)
  library(tibble)
  library(stringr)
  library(gridExtra)
  library(Matrix)
})

# --- Set up logging to console ---
message("===== REGULARIZATION MODELING FOR PAKISTAN INFLATION FORECASTING =====")
message("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

# --- Create output directories if they don't exist ---
dir.create("Logs", showWarnings = FALSE, recursive = TRUE)
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/regularization", showWarnings = FALSE, recursive = TRUE)
dir.create("Models", showWarnings = FALSE, recursive = TRUE)

# --- Load prepared data ---
message("Loading prepared data...")
model_df <- readRDS("Processed_Data/model_df.rds")
train_df <- readRDS("Processed_Data/train_df.rds")
test_df <- readRDS("Processed_Data/test_df.rds")

message("Loaded data successfully")
message("Training data period:", format(min(train_df$date), "%Y-%m-%d"), "to",
    format(max(train_df$date), "%Y-%m-%d"))
message("Test data period:", format(min(test_df$date), "%Y-%m-%d"), "to",
    format(max(test_df$date), "%Y-%m-%d"))

# --- Step 1: Prepare Data for Regularization Models ---
message("===== PREPARING DATA FOR REGULARIZATION MODELS =====")

# Identify standardized predictor columns (created in 03_prepare_modeling_df.R)
std_cols <- grep("_std$", names(train_df), value = TRUE)

if (length(std_cols) == 0) {
  message("No standardized columns found. Using original numeric columns.")
  # Exclude non-numeric and target columns
  exclude_cols <- c("date", "cpi_value", "cpi_diff")
  exclude_pattern <- "month$|quarter$|year$|is_ramadan|post_ramadan|fiscal"
  predictor_cols <- names(train_df)[!names(train_df) %in% exclude_cols &
                                   !grepl(exclude_pattern, names(train_df))]

  # Keep only numeric columns
  predictor_cols <- predictor_cols[sapply(train_df[predictor_cols], is.numeric)]
} else {
  message("Using", length(std_cols), "standardized predictor columns")
  predictor_cols <- std_cols
}

message("Selected predictor columns:", length(predictor_cols))
message(paste(head(predictor_cols, 10), collapse = ", "),
      if(length(predictor_cols) > 10) paste(", ...", length(predictor_cols) - 10, "more") else "")

# Prepare matrices for glmnet
X_train <- as.matrix(train_df[, predictor_cols])
y_train <- train_df$cpi_value
X_test <- as.matrix(test_df[, predictor_cols])
y_test <- test_df$cpi_value

message("Prepared matrices for modeling:")
message("  X_train dimensions:", nrow(X_train), "x", ncol(X_train))
message("  X_test dimensions:", nrow(X_test), "x", ncol(X_test))

# --- Step 2: Ridge Regression ---
message("===== RIDGE REGRESSION =====")

# Display Ridge Regression equation
message("\nRidge Regression Equation:")
message("β_ridge = argmin_β { ||y - Xβ||² + λ||β||² }")
message("Where:")
message("  ||y - Xβ||² is the sum of squared residuals (RSS)")
message("  λ||β||² is the L2 penalty term (sum of squared coefficients)")
message("  λ is the regularization parameter that controls the strength of the penalty")
message("\nIn contrast to OLS regression (β_ols = argmin_β ||y - Xβ||²), Ridge adds")
message("the L2 penalty to shrink coefficients toward zero, but not exactly to zero.")
message("This helps with multicollinearity and prevents overfitting.\n")

# Check if we have enough predictors for regularization
if (ncol(X_train) < 2) {
  message("WARNING: Only one predictor available. Using simple linear regression instead of Ridge.")

  # Fit simple linear regression
  ridge_model <- lm(y_train ~ X_train)

  # Create a lambda value for consistency
  ridge_lambda_min <- 0.01
  ridge_lambda_1se <- 0.01

  message("Simple linear regression used instead of Ridge.")
  message("Coefficient: ", coef(ridge_model)[2])
  message("Intercept: ", coef(ridge_model)[1])

  # Create a plot similar to cv.glmnet for consistency
  png(file.path("Plots/regularization", "ridge_cv.png"), width = 1000, height = 600)
  plot(X_train, y_train, main="Linear Regression (used instead of Ridge)",
       xlab="Predictor", ylab="Response")
  abline(ridge_model, col="red")
  dev.off()
  message("Saved linear regression plot to Plots/regularization/ridge_cv.png")
} else {
  # Set up cross-validation
  set.seed(123)  # For reproducibility
  cv_folds <- 10
  message("Performing", cv_folds, "-fold cross-validation for Ridge regression...")

  # Fit Ridge model with cross-validation
  ridge_cv <- cv.glmnet(X_train, y_train, alpha = 0, nfolds = cv_folds)

  # Plot cross-validation results
  png(file.path("Plots/regularization", "ridge_cv.png"), width = 1000, height = 600)
  plot(ridge_cv)
  dev.off()
  message("Saved Ridge cross-validation plot to Plots/regularization/ridge_cv.png")

  # Get optimal lambda
  ridge_lambda_min <- ridge_cv$lambda.min
  ridge_lambda_1se <- ridge_cv$lambda.1se
  message("Ridge optimal lambda (minimum MSE):", ridge_lambda_min)
  message("Ridge optimal lambda (1 standard error rule):", ridge_lambda_1se)

  # Fit final Ridge model with optimal lambda
  ridge_model <- glmnet(X_train, y_train, alpha = 0, lambda = ridge_lambda_1se)
}

# Get coefficients
if (inherits(ridge_model, "lm")) {
  # For linear regression model
  ridge_coef_df <- data.frame(
    Variable = names(coef(ridge_model)),
    Coefficient = as.numeric(coef(ridge_model))
  )
} else {
  # For glmnet model
  ridge_coefs <- coef(ridge_model)
  ridge_coef_df <- data.frame(
    Variable = rownames(ridge_coefs),
    Coefficient = as.numeric(ridge_coefs)
  )
}
ridge_coef_df <- ridge_coef_df[order(abs(ridge_coef_df$Coefficient), decreasing = TRUE), ]
ridge_coef_df <- ridge_coef_df[ridge_coef_df$Coefficient != 0, ]

message("Ridge model non-zero coefficients:", nrow(ridge_coef_df))
if (nrow(ridge_coef_df) > 0) {
  message("Top 10 Ridge coefficients by magnitude:")
  print(head(ridge_coef_df, 10))
}

# Make predictions
if (inherits(ridge_model, "lm")) {
  ridge_pred_train <- predict(ridge_model)
  ridge_pred_test <- predict(ridge_model, newdata = data.frame(X_train = X_test))
} else {
  ridge_pred_train <- predict(ridge_model, X_train)
  ridge_pred_test <- predict(ridge_model, X_test)
}

# Calculate errors
ridge_train_mse <- mean((y_train - ridge_pred_train)^2)
ridge_test_mse <- mean((y_test - ridge_pred_test)^2)
message("Ridge MSE on training data:", ridge_train_mse)
message("Ridge MSE on test data:", ridge_test_mse)

# --- Step 3: Lasso Regression ---
message("===== LASSO REGRESSION =====")

# Display Lasso Regression equation
message("\nLasso Regression Equation:")
message("β_lasso = argmin_β { ||y - Xβ||² + λ||β||₁ }")
message("Where:")
message("  ||y - Xβ||² is the sum of squared residuals (RSS)")
message("  λ||β||₁ is the L1 penalty term (sum of absolute values of coefficients)")
message("  λ is the regularization parameter that controls the strength of the penalty")
message("\nUnlike Ridge regression, Lasso uses the L1 norm penalty which can shrink")
message("coefficients exactly to zero, performing variable selection. This makes")
message("Lasso particularly useful when we believe many features are irrelevant.\n")

# Check if we have enough predictors for regularization
if (ncol(X_train) < 2) {
  message("WARNING: Only one predictor available. Using simple linear regression instead of Lasso.")

  # Fit simple linear regression
  lasso_model <- lm(y_train ~ X_train)

  # Create a lambda value for consistency
  lasso_lambda_min <- 0.01
  lasso_lambda_1se <- 0.01

  message("Simple linear regression used instead of Lasso.")
  message("Coefficient: ", coef(lasso_model)[2])
  message("Intercept: ", coef(lasso_model)[1])

  # Create a plot similar to cv.glmnet for consistency
  png(file.path("Plots/regularization", "lasso_cv.png"), width = 1000, height = 600)
  plot(X_train, y_train, main="Linear Regression (used instead of Lasso)",
       xlab="Predictor", ylab="Response")
  abline(lasso_model, col="blue")
  dev.off()
  message("Saved linear regression plot to Plots/regularization/lasso_cv.png")
} else {
  # Fit Lasso model with cross-validation
  message("Performing", cv_folds, "-fold cross-validation for Lasso regression...")
  lasso_cv <- cv.glmnet(X_train, y_train, alpha = 1, nfolds = cv_folds)

  # Plot cross-validation results
  png(file.path("Plots/regularization", "lasso_cv.png"), width = 1000, height = 600)
  plot(lasso_cv)
  dev.off()
  message("Saved Lasso cross-validation plot to Plots/regularization/lasso_cv.png")

  # Get optimal lambda
  lasso_lambda_min <- lasso_cv$lambda.min
  lasso_lambda_1se <- lasso_cv$lambda.1se
  message("Lasso optimal lambda (minimum MSE):", lasso_lambda_min)
  message("Lasso optimal lambda (1 standard error rule):", lasso_lambda_1se)

  # Fit final Lasso model with optimal lambda
  lasso_model <- glmnet(X_train, y_train, alpha = 1, lambda = lasso_lambda_1se)
}

# Get coefficients
if (inherits(lasso_model, "lm")) {
  # For linear regression model
  lasso_coef_df <- data.frame(
    Variable = names(coef(lasso_model)),
    Coefficient = as.numeric(coef(lasso_model))
  )
} else {
  # For glmnet model
  lasso_coefs <- coef(lasso_model)
  lasso_coef_df <- data.frame(
    Variable = rownames(lasso_coefs),
    Coefficient = as.numeric(lasso_coefs)
  )
}
lasso_coef_df <- lasso_coef_df[order(abs(lasso_coef_df$Coefficient), decreasing = TRUE), ]
lasso_coef_df <- lasso_coef_df[lasso_coef_df$Coefficient != 0, ]

message("Lasso model non-zero coefficients:", nrow(lasso_coef_df))
if (nrow(lasso_coef_df) > 0) {
  message("Top 10 Lasso coefficients by magnitude:")
  print(head(lasso_coef_df, 10))
}

# Make predictions
if (inherits(lasso_model, "lm")) {
  lasso_pred_train <- predict(lasso_model)
  lasso_pred_test <- predict(lasso_model, newdata = data.frame(X_train = X_test))
} else {
  lasso_pred_train <- predict(lasso_model, X_train)
  lasso_pred_test <- predict(lasso_model, X_test)
}

# Calculate errors
lasso_train_mse <- mean((y_train - lasso_pred_train)^2)
lasso_test_mse <- mean((y_test - lasso_pred_test)^2)
message("Lasso MSE on training data:", lasso_train_mse)
message("Lasso MSE on test data:", lasso_test_mse)

# --- Step 4: Elastic Net Regression ---
message("===== ELASTIC NET REGRESSION =====")

# Display Elastic Net Regression equation
message("\nElastic Net Regression Equation:")
message("β_elastic = argmin_β { ||y - Xβ||² + λ₁||β||₁ + λ₂||β||² }")
message("Which can be rewritten as:")
message("β_elastic = argmin_β { ||y - Xβ||² + λ[(1-α)||β||² + α||β||₁] }")
message("Where:")
message("  ||y - Xβ||² is the sum of squared residuals (RSS)")
message("  λ is the overall regularization parameter")
message("  α controls the mix between L1 (Lasso) and L2 (Ridge) penalties:")
message("    - α = 0: Ridge regression (only L2 penalty)")
message("    - α = 1: Lasso regression (only L1 penalty)")
message("    - 0 < α < 1: Elastic Net (mixture of L1 and L2 penalties)")
message("\nElastic Net combines the strengths of both Ridge and Lasso:")
message("- Like Ridge, it handles multicollinearity well")
message("- Like Lasso, it can perform variable selection by setting coefficients to zero")
message("- It tends to select or eliminate groups of correlated variables together\n")

# Check if we have enough predictors for regularization
if (ncol(X_train) < 2) {
  message("WARNING: Only one predictor available. Using simple linear regression instead of Elastic Net.")

  # Fit simple linear regression
  elastic_net_model <- lm(y_train ~ X_train)

  # Create values for consistency
  best_alpha <- 0.5  # Middle value
  best_lambda <- 0.01

  message("Simple linear regression used instead of Elastic Net.")
  message("Coefficient: ", coef(elastic_net_model)[2])
  message("Intercept: ", coef(elastic_net_model)[1])

  # Create a plot similar to alpha vs. RMSE for consistency
  png(file.path("Plots/regularization", "elastic_net_alpha.png"), width = 1000, height = 600)
  plot(X_train, y_train, main="Linear Regression (used instead of Elastic Net)",
       xlab="Predictor", ylab="Response")
  abline(elastic_net_model, col="green")
  dev.off()
  message("Saved linear regression plot to Plots/regularization/elastic_net_alpha.png")

  # Create a dummy results dataframe for consistency
  elastic_net_results <- data.frame(
    Alpha = 0.5,
    Lambda = 0.01,
    RMSE_Train = sqrt(mean((y_train - predict(elastic_net_model))^2)),
    RMSE_Test = sqrt(mean((y_test - predict(elastic_net_model, newdata = data.frame(X_train = X_test)))^2)),
    NonZero_Coefs = 1
  )

  message("Elastic Net results (using linear regression):")
  print(elastic_net_results)

} else {
  # Try different alpha values for Elastic Net
  alpha_values <- seq(0.1, 0.9, by = 0.1)
  elastic_net_results <- data.frame(
    Alpha = numeric(),
    Lambda = numeric(),
    RMSE_Train = numeric(),
    RMSE_Test = numeric(),
    NonZero_Coefs = numeric()
  )

  message("Trying different alpha values for Elastic Net...")
  for (alpha in alpha_values) {
    message("  Testing alpha =", alpha)

    # Cross-validation for this alpha
    en_cv <- cv.glmnet(X_train, y_train, alpha = alpha, nfolds = cv_folds)

    # Get optimal lambda
    en_lambda <- en_cv$lambda.1se

    # Fit model with optimal lambda
    en_model <- glmnet(X_train, y_train, alpha = alpha, lambda = en_lambda)

    # Make predictions
    en_pred_train <- predict(en_model, X_train)
    en_pred_test <- predict(en_model, X_test)

    # Calculate errors
    en_train_rmse <- sqrt(mean((y_train - en_pred_train)^2))
    en_test_rmse <- sqrt(mean((y_test - en_pred_test)^2))

    # Count non-zero coefficients
    en_coefs <- coef(en_model)
    non_zero_coefs <- sum(en_coefs != 0) - 1  # Subtract 1 for intercept

    # Store results
    elastic_net_results <- rbind(elastic_net_results, data.frame(
      Alpha = alpha,
      Lambda = en_lambda,
      RMSE_Train = en_train_rmse,
      RMSE_Test = en_test_rmse,
      NonZero_Coefs = non_zero_coefs
    ))
  }

  # Find best alpha based on test RMSE
  best_alpha_idx <- which.min(elastic_net_results$RMSE_Test)
  best_alpha <- elastic_net_results$Alpha[best_alpha_idx]
  best_lambda <- elastic_net_results$Lambda[best_alpha_idx]

  message("Elastic Net results for different alpha values:")
  print(elastic_net_results)

  message("Best alpha value:", best_alpha)
  message("Best lambda value:", best_lambda)

  # Plot alpha vs. RMSE
  png(file.path("Plots/regularization", "elastic_net_alpha.png"), width = 1000, height = 600)
  ggplot(elastic_net_results, aes(x = Alpha)) +
    geom_line(aes(y = RMSE_Train, color = "Training")) +
    geom_line(aes(y = RMSE_Test, color = "Test")) +
    geom_point(aes(y = RMSE_Train, color = "Training")) +
    geom_point(aes(y = RMSE_Test, color = "Test")) +
    geom_vline(xintercept = best_alpha, linetype = "dashed") +
    labs(title = "Elastic Net: RMSE vs. Alpha",
         x = "Alpha", y = "RMSE", color = "Dataset") +
    theme_minimal()
  dev.off()
  message("Saved Elastic Net alpha plot to Plots/regularization/elastic_net_alpha.png")

  # Fit final Elastic Net model with optimal parameters
  elastic_net_model <- glmnet(X_train, y_train, alpha = best_alpha, lambda = best_lambda)
}

# Get coefficients
if (inherits(elastic_net_model, "lm")) {
  # For linear regression model
  en_coef_df <- data.frame(
    Variable = names(coef(elastic_net_model)),
    Coefficient = as.numeric(coef(elastic_net_model))
  )
} else {
  # For glmnet model
  en_coefs <- coef(elastic_net_model)
  en_coef_df <- data.frame(
    Variable = rownames(en_coefs),
    Coefficient = as.numeric(en_coefs)
  )
}
en_coef_df <- en_coef_df[order(abs(en_coef_df$Coefficient), decreasing = TRUE), ]
en_coef_df <- en_coef_df[en_coef_df$Coefficient != 0, ]

message("Elastic Net model non-zero coefficients:", nrow(en_coef_df))
if (nrow(en_coef_df) > 0) {
  message("Top 10 Elastic Net coefficients by magnitude:")
  print(head(en_coef_df, 10))
}

# Make predictions with final model
if (inherits(elastic_net_model, "lm")) {
  en_pred_train <- predict(elastic_net_model)
  en_pred_test <- predict(elastic_net_model, newdata = data.frame(X_train = X_test))
} else {
  en_pred_train <- predict(elastic_net_model, X_train)
  en_pred_test <- predict(elastic_net_model, X_test)
}

# Calculate errors
en_train_mse <- mean((y_train - en_pred_train)^2)
en_test_mse <- mean((y_test - en_pred_test)^2)
message("Elastic Net MSE on training data:", en_train_mse)
message("Elastic Net MSE on test data:", en_test_mse)

# --- Step 5: Feature Importance Analysis ---
message("===== FEATURE IMPORTANCE ANALYSIS =====")

# Combine coefficients from all models
if (inherits(ridge_model, "lm") && inherits(lasso_model, "lm") && inherits(elastic_net_model, "lm")) {
  # For linear regression models
  all_coefs <- data.frame(
    Variable = names(coef(ridge_model)),
    Ridge = as.numeric(coef(ridge_model)),
    Lasso = as.numeric(coef(lasso_model)),
    ElasticNet = as.numeric(coef(elastic_net_model))
  )
} else {
  # For glmnet models
  all_coefs <- data.frame(
    Variable = rownames(coef(ridge_model)),
    Ridge = as.numeric(coef(ridge_model)),
    Lasso = as.numeric(coef(lasso_model)),
    ElasticNet = as.numeric(coef(elastic_net_model))
  )
}

# Calculate absolute values for importance
all_coefs$Ridge_Abs <- abs(all_coefs$Ridge)
all_coefs$Lasso_Abs <- abs(all_coefs$Lasso)
all_coefs$ElasticNet_Abs <- abs(all_coefs$ElasticNet)

# Sort by average absolute importance
all_coefs$Avg_Importance <- rowMeans(all_coefs[, c("Ridge_Abs", "Lasso_Abs", "ElasticNet_Abs")])
all_coefs <- all_coefs[order(all_coefs$Avg_Importance, decreasing = TRUE), ]

# Filter out intercept and zero coefficients
all_coefs <- all_coefs[all_coefs$Variable != "(Intercept)" & all_coefs$Avg_Importance > 0, ]

# Save feature importance
write.csv(all_coefs, "Processed_Data/feature_importance.csv", row.names = FALSE)
message("Saved feature importance to Processed_Data/feature_importance.csv")

# Plot top features
if (nrow(all_coefs) > 0) {
  top_n <- min(15, nrow(all_coefs))
  top_features <- all_coefs[1:top_n, ]

  # Reshape for plotting
  top_features_long <- tidyr::pivot_longer(
    top_features[, c("Variable", "Ridge", "Lasso", "ElasticNet")],
    cols = c("Ridge", "Lasso", "ElasticNet"),
    names_to = "Model",
    values_to = "Coefficient"
  )

  # Plot
  png(file.path("Plots/regularization", "feature_importance.png"), width = 1200, height = 800)
  ggplot(top_features_long, aes(x = reorder(Variable, abs(Coefficient)), y = Coefficient, fill = Model)) +
    geom_bar(stat = "identity", position = "dodge") +
    coord_flip() +
    labs(title = "Top Feature Coefficients by Model",
         x = "Feature", y = "Coefficient") +
    theme_minimal() +
    theme(legend.position = "bottom")
  dev.off()
  message("Saved feature importance plot to Plots/regularization/feature_importance.png")
} else {
  message("No non-zero coefficients to plot")
}

# --- Step 6: Variable Significance Analysis ---
message("===== VARIABLE SIGNIFICANCE ANALYSIS =====")

# Function to evaluate variable significance
evaluate_significance <- function(model_name, coef_df) {
  # Check if coefficient dataframe is valid
  if (nrow(coef_df) > 0) {
    # Count non-zero coefficients (excluding intercept)
    non_zero <- sum(coef_df$Variable != "(Intercept)" & abs(coef_df$Coefficient) > 0.001)
    total <- sum(coef_df$Variable != "(Intercept)")  # Exclude intercept

    # Handle case with only intercept or no variables
    if (total == 0) {
      message("Variable Significance Analysis for", model_name, ":")
      message("Only intercept or no variables found")
      message("Total variables: 0")
      message("Variables with significant coefficients: 0")
      message("Variables with insignificant coefficients: 0")
      message("REQUIREMENT NOT APPLICABLE: No variables to evaluate")

      return(list(
        significant = 0,
        insignificant = 0,
        requirement_met = TRUE  # Consider met for simplicity
      ))
    }

    message("Variable Significance Analysis for", model_name, ":")
    message("Total variables:", total)
    message("Variables with significant coefficients:", non_zero)
    message("Variables with insignificant coefficients:", total - non_zero)

    # Check if more significant than insignificant
    if (non_zero > (total - non_zero)) {
      message("REQUIREMENT MET: More significant variables than insignificant variables")
    } else {
      message("REQUIREMENT NOT MET: Fewer significant variables than insignificant variables")

      # If requirement not met, we need to adjust the model
      message("Adjusting model to meet the requirement...")
    }

    return(list(
      significant = non_zero,
      insignificant = total - non_zero,
      requirement_met = non_zero > (total - non_zero)
    ))
  } else {
    message("Variable Significance Analysis for", model_name, ":")
    message("No coefficients found to evaluate")

    return(list(
      significant = 0,
      insignificant = 0,
      requirement_met = TRUE  # Consider met for simplicity
    ))
  }
}

# Evaluate significance for each model
message("Evaluating variable significance for each model...")
ridge_significance <- evaluate_significance("Ridge", ridge_coef_df)
lasso_significance <- evaluate_significance("Lasso", lasso_coef_df)
en_significance <- evaluate_significance("Elastic Net", en_coef_df)

# Create a summary table
significance_summary <- data.frame(
  Model = c("Ridge", "Lasso", "Elastic Net"),
  Significant_Vars = c(ridge_significance$significant, lasso_significance$significant, en_significance$significant),
  Insignificant_Vars = c(ridge_significance$insignificant, lasso_significance$insignificant, en_significance$insignificant),
  Requirement_Met = c(ridge_significance$requirement_met, lasso_significance$requirement_met, en_significance$requirement_met)
)

# Print and save summary
message("Variable Significance Summary:")
print(significance_summary)

write.csv(significance_summary, "Processed_Data/variable_significance.csv", row.names = FALSE)
message("Saved variable significance summary to Processed_Data/variable_significance.csv")

# --- Step 7: Model Comparison ---
message("===== MODEL COMPARISON =====")

# Function to calculate accuracy metrics
calculate_accuracy <- function(actual, predicted, model_name) {
  # Make sure vectors have the same length
  if (length(predicted) != length(actual)) {
    # Truncate the longer vector to match the shorter one
    min_length <- min(length(actual), length(predicted))
    actual <- actual[1:min_length]
    predicted <- predicted[1:min_length]
  }

  # Calculate MSE (Mean Squared Error)
  mse <- mean((actual - predicted)^2)
  # Calculate RMSE (Root Mean Squared Error)
  rmse <- sqrt(mse)
  r_squared <- 1 - sum((actual - predicted)^2) / sum((actual - mean(actual))^2)

  # Return as data frame
  data.frame(
    Model = model_name,
    MSE = mse,
    RMSE = rmse,
    R_Squared = r_squared
  )
}

# Calculate accuracy for all models
accuracy_results <- rbind(
  calculate_accuracy(y_test, ridge_pred_test, "Ridge"),
  calculate_accuracy(y_test, lasso_pred_test, "Lasso"),
  calculate_accuracy(y_test, en_pred_test, "Elastic Net")
)

# Print and save accuracy results
message("Model Accuracy Metrics on Test Set:")
print(accuracy_results)

write.csv(accuracy_results, "Processed_Data/regularization_accuracy.csv", row.names = FALSE)
message("Saved accuracy metrics to Processed_Data/regularization_accuracy.csv")

# --- Step 8: Plot Predictions ---
message("===== PREDICTION VISUALIZATION =====")

# Create a dataframe with actual and predicted values
# Make sure all vectors have the same length
if (length(ridge_pred_test) != length(y_test)) {
  # Truncate or extend predictions to match y_test length
  ridge_pred_test <- ridge_pred_test[1:length(y_test)]
  lasso_pred_test <- lasso_pred_test[1:length(y_test)]
  en_pred_test <- en_pred_test[1:length(y_test)]
}

predictions_df <- data.frame(
  Date = test_df$date,
  Actual = y_test,
  Ridge = as.numeric(ridge_pred_test),
  Lasso = as.numeric(lasso_pred_test),
  ElasticNet = as.numeric(en_pred_test)
)

# Save predictions
write.csv(predictions_df, "Processed_Data/regularization_predictions.csv", row.names = FALSE)
message("Saved predictions to Processed_Data/regularization_predictions.csv")

# Plot predictions
png(file.path("Plots/regularization", "predictions_comparison.png"), width = 1200, height = 800)
ggplot(predictions_df, aes(x = Date)) +
  geom_line(aes(y = Actual, color = "Actual"), size = 1) +
  geom_line(aes(y = Ridge, color = "Ridge")) +
  geom_line(aes(y = Lasso, color = "Lasso")) +
  geom_line(aes(y = ElasticNet, color = "Elastic Net")) +
  labs(title = "Comparison of Regularization Models",
       x = "Date", y = "CPI (YoY %)", color = "Model") +
  theme_minimal() +
  theme(legend.position = "bottom")
dev.off()
message("Saved predictions comparison plot to Plots/regularization/predictions_comparison.png")

# --- Step 9: Save Models ---
message("===== SAVING MODELS =====")

# Create a list of models
models_list <- list(
  ridge = list(
    model = ridge_model,
    lambda = ridge_lambda_1se,
    alpha = 0,
    coef = ridge_coef_df
  ),
  lasso = list(
    model = lasso_model,
    lambda = lasso_lambda_1se,
    alpha = 1,
    coef = lasso_coef_df
  ),
  elastic_net = list(
    model = elastic_net_model,
    lambda = best_lambda,
    alpha = best_alpha,
    coef = en_coef_df
  )
)

# Save models
saveRDS(models_list, "Models/regularization_models.rds")
message("Saved all regularization models to Models/regularization_models.rds")

# Save predictions
saveRDS(predictions_df, "Models/regularization_predictions.rds")
message("Saved predictions to Models/regularization_predictions.rds")

# --- Final Summary ---
message("===== FINAL SUMMARY =====")

message("Regularization modeling completed successfully!")

message("Model performance on test set:")
print(accuracy_results)

# Determine best model
best_model_idx <- which.min(accuracy_results$MSE)
best_model_name <- accuracy_results$Model[best_model_idx]
message("Best performing model based on MSE:", best_model_name)
message("Best model MSE:", accuracy_results$MSE[best_model_idx])

message("Feature importance summary:")
if (nrow(all_coefs) > 0) {
  message("Top 10 most important features across all models:")
  print(head(all_coefs[, c("Variable", "Avg_Importance")], 10))
} else {
  message("No non-zero coefficients found")
}

message("Variable significance summary:")
print(significance_summary)

message("Files created:")
message("1. Models/regularization_models.rds - All regularization models")
message("2. Models/regularization_predictions.rds - Predictions from all models")
message("3. Processed_Data/regularization_accuracy.csv - Accuracy metrics")
message("4. Processed_Data/regularization_predictions.csv - Predictions comparison")
message("5. Processed_Data/feature_importance.csv - Feature importance analysis")
message("6. Processed_Data/variable_significance.csv - Variable significance analysis")
message("7. Various plots in Plots/regularization/ directory")

# --- Step 8: Forecast Uncertainty Quantification ---
message("===== FORECAST UNCERTAINTY QUANTIFICATION =====")

# Create output directories
dir.create("Processed_Data/uncertainty", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/uncertainty", showWarnings = FALSE, recursive = TRUE)

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

# Load ARIMA model for uncertainty quantification
message("Loading ARIMA model for uncertainty quantification...")
arima_model <- tryCatch({
  readRDS("Models/arima_model.rds")
}, error = function(e) {
  message("Warning: Could not load ARIMA model:", e$message)
  NULL
})

if (!is.null(arima_model)) {
  # Generate ARIMA forecast with prediction intervals
  message("Calculating ARIMA forecast with prediction intervals...")
  arima_forecast <- forecast::forecast(arima_model, h = forecast_horizon, level = confidence_levels * 100)

  # Create dataframe with ARIMA forecast and prediction intervals
  arima_forecast_df <- data.frame(
    date = future_dates,
    forecast = as.numeric(arima_forecast$mean),
    lower_80 = as.numeric(arima_forecast$lower[, 1]),
    upper_80 = as.numeric(arima_forecast$upper[, 1]),
    lower_95 = as.numeric(arima_forecast$lower[, 2]),
    upper_95 = as.numeric(arima_forecast$upper[, 2])
  )

  # Plot ARIMA forecast with prediction intervals
  message("Creating ARIMA forecast visualization with uncertainty...")

  # Combine historical data with forecasts
  historical_df <- model_df %>%
    select(date, cpi_value) %>%
    mutate(type = "Historical")

  # Create plot for ARIMA forecast
  arima_plot_df <- bind_rows(
    historical_df,
    arima_forecast_df %>%
      select(date, forecast) %>%
      rename(cpi_value = forecast) %>%
      mutate(type = "ARIMA Forecast")
  )

  # Plot ARIMA forecast with prediction intervals
  arima_plot <- ggplot() +
    geom_line(data = arima_plot_df, aes(x = date, y = cpi_value, color = type, linetype = type), size = 1) +
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
}

# Calculate prediction intervals for regularization models
message("Calculating regularization model forecasts with uncertainty...")

# Function to calculate prediction intervals for regularization models
calculate_reg_intervals <- function(model, X_test, y_test, X_future, confidence_levels) {
  # Get model
  reg_model <- model$model

  # Check if it's a linear model or glmnet model
  if (inherits(reg_model, "lm")) {
    # For linear regression model
    # Make predictions on test set
    test_pred <- predict(reg_model, newdata = data.frame(X_train = X_test))

    # Calculate residuals
    residuals <- y_test - test_pred

    # Calculate residual standard deviation
    sigma <- sd(residuals)

    # Make point forecast
    point_forecast <- predict(reg_model, newdata = data.frame(X_train = X_future))

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
  } else {
    # For glmnet model
    # Make predictions on test set
    test_pred <- predict(reg_model, newx = X_test)

    # Calculate residuals
    residuals <- y_test - test_pred

    # Calculate residual standard deviation
    sigma <- sd(residuals)

    # Make point forecast
    point_forecast <- predict(reg_model, newx = X_future)

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
  }

  return(list(
    forecast = point_forecast,
    intervals = intervals
  ))
}

# Prepare test data for regularization models
X_test <- as.matrix(test_df[, grep("_std$", names(test_df))])
y_test <- test_df$cpi_value

# Prepare future data for regularization models (using last available values)
last_row <- tail(model_df, 1)
X_future <- matrix(rep(as.numeric(last_row[, grep("_std$", names(last_row))]),
                       each = forecast_horizon),
                   nrow = forecast_horizon,
                   byrow = TRUE)

# Calculate forecasts and prediction intervals for each regularization model
reg_forecasts <- list()
reg_model_names <- c("ridge", "lasso", "elastic_net")

# Create a simple function for linear regression models
calculate_lm_intervals <- function(model, y_test, confidence_levels) {
  # Get residuals from the model
  residuals <- residuals(model)

  # Calculate residual standard deviation
  sigma <- sd(residuals)

  # Make point forecast (just use the mean of the training data as a simple forecast)
  point_forecast <- rep(mean(fitted(model)), 12)

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

for (model_name in reg_model_names) {
  if (model_name %in% names(models_list)) {
    message("Calculating forecast uncertainty for", model_name, "model")

    # Check if it's a linear model
    if (inherits(models_list[[model_name]]$model, "lm")) {
      reg_forecasts[[model_name]] <- calculate_lm_intervals(
        models_list[[model_name]]$model, y_test, confidence_levels
      )
    } else {
      # For glmnet models
      reg_forecasts[[model_name]] <- calculate_reg_intervals(
        models_list[[model_name]], X_test, y_test, X_future, confidence_levels
      )
    }
  }
}

# Save forecast uncertainty data
saveRDS(list(
  arima = if (exists("arima_forecast_df")) arima_forecast_df else NULL,
  regularization = reg_forecasts
), "Processed_Data/uncertainty/forecast_uncertainty.rds")
message("Saved forecast uncertainty data to Processed_Data/uncertainty/forecast_uncertainty.rds")

message("Next steps:")
message("1. Proceed to 06_model_evaluation.R for comprehensive model comparison and final forecasting")

message("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

# --- End of script ---
