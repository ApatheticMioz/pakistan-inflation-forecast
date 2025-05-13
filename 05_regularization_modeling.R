# 05_regularization_modeling.R
# Pakistan Inflation Forecasting Project: Regularization Modeling
# This script implements Lasso, Ridge, and Elastic-Net Regression for forecasting inflation in Pakistan.
# Author: <Your Name>
# Date: 2025-05-13

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

# --- Set up output file for logging ---
sink("05_regularization_modeling_output.txt")
cat("===== REGULARIZATION MODELING FOR PAKISTAN INFLATION FORECASTING =====\n\n")
cat("Started at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# --- Create output directories if they don't exist ---
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)
dir.create("Plots/regularization", showWarnings = FALSE, recursive = TRUE)
dir.create("Models", showWarnings = FALSE, recursive = TRUE)

# --- Load prepared data ---
cat("Loading prepared data...\n")
model_df <- readRDS("Processed_Data/model_df.rds")
train_df <- readRDS("Processed_Data/train_df.rds")
test_df <- readRDS("Processed_Data/test_df.rds")

cat("Loaded data successfully\n")
cat("Training data period:", format(min(train_df$date), "%Y-%m-%d"), "to", 
    format(max(train_df$date), "%Y-%m-%d"), "\n")
cat("Test data period:", format(min(test_df$date), "%Y-%m-%d"), "to", 
    format(max(test_df$date), "%Y-%m-%d"), "\n\n")

# --- Step 1: Prepare Data for Regularization Models ---
cat("===== PREPARING DATA FOR REGULARIZATION MODELS =====\n\n")

# Identify standardized predictor columns (created in 03_prepare_modeling_df.R)
std_cols <- grep("_std$", names(train_df), value = TRUE)

if (length(std_cols) == 0) {
  cat("No standardized columns found. Using original numeric columns.\n")
  # Exclude non-numeric and target columns
  exclude_cols <- c("date", "cpi", "cpi_diff")
  exclude_pattern <- "month$|quarter$|year$|is_ramadan|post_ramadan|fiscal"
  predictor_cols <- names(train_df)[!names(train_df) %in% exclude_cols & 
                                   !grepl(exclude_pattern, names(train_df))]
  
  # Keep only numeric columns
  predictor_cols <- predictor_cols[sapply(train_df[predictor_cols], is.numeric)]
} else {
  cat("Using", length(std_cols), "standardized predictor columns\n")
  predictor_cols <- std_cols
}

cat("Selected predictor columns:", length(predictor_cols), "\n")
cat(paste(head(predictor_cols, 10), collapse = ", "))
if (length(predictor_cols) > 10) {
  cat(", ...", length(predictor_cols) - 10, "more")
}
cat("\n\n")

# Prepare matrices for glmnet
X_train <- as.matrix(train_df[, predictor_cols])
y_train <- train_df$cpi
X_test <- as.matrix(test_df[, predictor_cols])
y_test <- test_df$cpi

cat("Prepared matrices for modeling:\n")
cat("  X_train dimensions:", nrow(X_train), "x", ncol(X_train), "\n")
cat("  X_test dimensions:", nrow(X_test), "x", ncol(X_test), "\n\n")

# --- Step 2: Ridge Regression ---
cat("===== RIDGE REGRESSION =====\n\n")

# Set up cross-validation
set.seed(123)  # For reproducibility
cv_folds <- 10
cat("Performing", cv_folds, "-fold cross-validation for Ridge regression...\n")

# Fit Ridge model with cross-validation
ridge_cv <- cv.glmnet(X_train, y_train, alpha = 0, nfolds = cv_folds)

# Plot cross-validation results
png(file.path("Plots/regularization", "ridge_cv.png"), width = 1000, height = 600)
plot(ridge_cv)
dev.off()
cat("Saved Ridge cross-validation plot to Plots/regularization/ridge_cv.png\n")

# Get optimal lambda
ridge_lambda_min <- ridge_cv$lambda.min
ridge_lambda_1se <- ridge_cv$lambda.1se
cat("Ridge optimal lambda (minimum MSE):", ridge_lambda_min, "\n")
cat("Ridge optimal lambda (1 standard error rule):", ridge_lambda_1se, "\n")

# Fit final Ridge model with optimal lambda
ridge_model <- glmnet(X_train, y_train, alpha = 0, lambda = ridge_lambda_1se)

# Get coefficients
ridge_coefs <- coef(ridge_model)
ridge_coef_df <- data.frame(
  Variable = rownames(ridge_coefs),
  Coefficient = as.numeric(ridge_coefs)
)
ridge_coef_df <- ridge_coef_df[order(abs(ridge_coef_df$Coefficient), decreasing = TRUE), ]
ridge_coef_df <- ridge_coef_df[ridge_coef_df$Coefficient != 0, ]

cat("Ridge model non-zero coefficients:", nrow(ridge_coef_df), "\n")
if (nrow(ridge_coef_df) > 0) {
  cat("Top 10 Ridge coefficients by magnitude:\n")
  print(head(ridge_coef_df, 10))
}
cat("\n")

# Make predictions
ridge_pred_train <- predict(ridge_model, X_train)
ridge_pred_test <- predict(ridge_model, X_test)

# Calculate errors
ridge_train_rmse <- sqrt(mean((y_train - ridge_pred_train)^2))
ridge_test_rmse <- sqrt(mean((y_test - ridge_pred_test)^2))
cat("Ridge RMSE on training data:", ridge_train_rmse, "\n")
cat("Ridge RMSE on test data:", ridge_test_rmse, "\n\n")

# --- Step 3: Lasso Regression ---
cat("===== LASSO REGRESSION =====\n\n")

# Fit Lasso model with cross-validation
cat("Performing", cv_folds, "-fold cross-validation for Lasso regression...\n")
lasso_cv <- cv.glmnet(X_train, y_train, alpha = 1, nfolds = cv_folds)

# Plot cross-validation results
png(file.path("Plots/regularization", "lasso_cv.png"), width = 1000, height = 600)
plot(lasso_cv)
dev.off()
cat("Saved Lasso cross-validation plot to Plots/regularization/lasso_cv.png\n")

# Get optimal lambda
lasso_lambda_min <- lasso_cv$lambda.min
lasso_lambda_1se <- lasso_cv$lambda.1se
cat("Lasso optimal lambda (minimum MSE):", lasso_lambda_min, "\n")
cat("Lasso optimal lambda (1 standard error rule):", lasso_lambda_1se, "\n")

# Fit final Lasso model with optimal lambda
lasso_model <- glmnet(X_train, y_train, alpha = 1, lambda = lasso_lambda_1se)

# Get coefficients
lasso_coefs <- coef(lasso_model)
lasso_coef_df <- data.frame(
  Variable = rownames(lasso_coefs),
  Coefficient = as.numeric(lasso_coefs)
)
lasso_coef_df <- lasso_coef_df[order(abs(lasso_coef_df$Coefficient), decreasing = TRUE), ]
lasso_coef_df <- lasso_coef_df[lasso_coef_df$Coefficient != 0, ]

cat("Lasso model non-zero coefficients:", nrow(lasso_coef_df), "\n")
if (nrow(lasso_coef_df) > 0) {
  cat("Top 10 Lasso coefficients by magnitude:\n")
  print(head(lasso_coef_df, 10))
}
cat("\n")

# Make predictions
lasso_pred_train <- predict(lasso_model, X_train)
lasso_pred_test <- predict(lasso_model, X_test)

# Calculate errors
lasso_train_rmse <- sqrt(mean((y_train - lasso_pred_train)^2))
lasso_test_rmse <- sqrt(mean((y_test - lasso_pred_test)^2))
cat("Lasso RMSE on training data:", lasso_train_rmse, "\n")
cat("Lasso RMSE on test data:", lasso_test_rmse, "\n\n")

# --- Step 4: Elastic Net Regression ---
cat("===== ELASTIC NET REGRESSION =====\n\n")

# Try different alpha values for Elastic Net
alpha_values <- seq(0.1, 0.9, by = 0.1)
elastic_net_results <- data.frame(
  Alpha = numeric(),
  Lambda = numeric(),
  RMSE_Train = numeric(),
  RMSE_Test = numeric(),
  NonZero_Coefs = numeric()
)

cat("Trying different alpha values for Elastic Net...\n")
for (alpha in alpha_values) {
  cat("  Testing alpha =", alpha, "\n")
  
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

cat("Elastic Net results for different alpha values:\n")
print(elastic_net_results)
cat("\n")
cat("Best alpha value:", best_alpha, "\n")
cat("Best lambda value:", best_lambda, "\n\n")

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
cat("Saved Elastic Net alpha plot to Plots/regularization/elastic_net_alpha.png\n")

# Fit final Elastic Net model with optimal parameters
elastic_net_model <- glmnet(X_train, y_train, alpha = best_alpha, lambda = best_lambda)

# Get coefficients
en_coefs <- coef(elastic_net_model)
en_coef_df <- data.frame(
  Variable = rownames(en_coefs),
  Coefficient = as.numeric(en_coefs)
)
en_coef_df <- en_coef_df[order(abs(en_coef_df$Coefficient), decreasing = TRUE), ]
en_coef_df <- en_coef_df[en_coef_df$Coefficient != 0, ]

cat("Elastic Net model non-zero coefficients:", nrow(en_coef_df), "\n")
if (nrow(en_coef_df) > 0) {
  cat("Top 10 Elastic Net coefficients by magnitude:\n")
  print(head(en_coef_df, 10))
}
cat("\n")

# Make predictions with final model
en_pred_train <- predict(elastic_net_model, X_train)
en_pred_test <- predict(elastic_net_model, X_test)

# Calculate errors
en_train_rmse <- sqrt(mean((y_train - en_pred_train)^2))
en_test_rmse <- sqrt(mean((y_test - en_pred_test)^2))
cat("Elastic Net RMSE on training data:", en_train_rmse, "\n")
cat("Elastic Net RMSE on test data:", en_test_rmse, "\n\n")

# --- Step 5: Feature Importance Analysis ---
cat("===== FEATURE IMPORTANCE ANALYSIS =====\n\n")

# Combine coefficients from all models
all_coefs <- data.frame(
  Variable = rownames(coef(ridge_model)),
  Ridge = as.numeric(coef(ridge_model)),
  Lasso = as.numeric(coef(lasso_model)),
  ElasticNet = as.numeric(coef(elastic_net_model))
)

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
cat("Saved feature importance to Processed_Data/feature_importance.csv\n")

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
  cat("Saved feature importance plot to Plots/regularization/feature_importance.png\n\n")
} else {
  cat("No non-zero coefficients to plot\n\n")
}

# --- Step 6: Model Comparison ---
cat("===== MODEL COMPARISON =====\n\n")

# Function to calculate accuracy metrics
calculate_accuracy <- function(actual, predicted, model_name) {
  # Calculate metrics
  mae <- mean(abs(actual - predicted))
  rmse <- sqrt(mean((actual - predicted)^2))
  mape <- mean(abs((actual - predicted) / actual)) * 100
  r_squared <- 1 - sum((actual - predicted)^2) / sum((actual - mean(actual))^2)
  
  # Return as data frame
  data.frame(
    Model = model_name,
    MAE = mae,
    RMSE = rmse,
    MAPE = mape,
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
cat("Model Accuracy Metrics on Test Set:\n")
print(accuracy_results)
cat("\n")

write.csv(accuracy_results, "Processed_Data/regularization_accuracy.csv", row.names = FALSE)
cat("Saved accuracy metrics to Processed_Data/regularization_accuracy.csv\n\n")

# --- Step 7: Plot Predictions ---
cat("===== PREDICTION VISUALIZATION =====\n\n")

# Create a dataframe with actual and predicted values
predictions_df <- data.frame(
  Date = test_df$date,
  Actual = y_test,
  Ridge = as.numeric(ridge_pred_test),
  Lasso = as.numeric(lasso_pred_test),
  ElasticNet = as.numeric(en_pred_test)
)

# Save predictions
write.csv(predictions_df, "Processed_Data/regularization_predictions.csv", row.names = FALSE)
cat("Saved predictions to Processed_Data/regularization_predictions.csv\n")

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
cat("Saved predictions comparison plot to Plots/regularization/predictions_comparison.png\n\n")

# --- Step 8: Save Models ---
cat("===== SAVING MODELS =====\n\n")

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
cat("Saved all regularization models to Models/regularization_models.rds\n")

# Save predictions
saveRDS(predictions_df, "Models/regularization_predictions.rds")
cat("Saved predictions to Models/regularization_predictions.rds\n\n")

# --- Final Summary ---
cat("===== FINAL SUMMARY =====\n\n")

cat("Regularization modeling completed successfully!\n\n")

cat("Model performance on test set:\n")
print(accuracy_results)
cat("\n")

# Determine best model
best_model_idx <- which.min(accuracy_results$RMSE)
best_model_name <- accuracy_results$Model[best_model_idx]
cat("Best performing model based on RMSE:", best_model_name, "\n")
cat("Best model RMSE:", accuracy_results$RMSE[best_model_idx], "\n\n")

cat("Feature importance summary:\n")
if (nrow(all_coefs) > 0) {
  cat("Top 10 most important features across all models:\n")
  print(head(all_coefs[, c("Variable", "Avg_Importance")], 10))
} else {
  cat("No non-zero coefficients found\n")
}
cat("\n")

cat("Files created:\n")
cat("1. Models/regularization_models.rds - All regularization models\n")
cat("2. Models/regularization_predictions.rds - Predictions from all models\n")
cat("3. Processed_Data/regularization_accuracy.csv - Accuracy metrics\n")
cat("4. Processed_Data/regularization_predictions.csv - Predictions comparison\n")
cat("5. Processed_Data/feature_importance.csv - Feature importance analysis\n")
cat("6. Various plots in Plots/regularization/ directory\n\n")

cat("Next steps:\n")
cat("1. Proceed to 06_model_evaluation.R for comprehensive model comparison and final forecasting\n\n")

cat("Completed at:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
sink()

# Print message to console
message("Regularization modeling completed successfully!")
message("Output saved to 05_regularization_modeling_output.txt")
message("Proceed to 06_model_evaluation.R for model comparison and final forecasting")

# --- End of script ---
