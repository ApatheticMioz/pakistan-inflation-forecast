# --- Ridge Regression Modeling, Forecasting & Evaluation (v5 - lambda.1se, Console Output) ---
# --- Assumes prepare_predictors.R (verified v3, full predictors) has been run ---

# --- Load Necessary Libraries ---
library(glmnet)
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(Metrics)

cat("Current Date/Time:", format(Sys.time()), "\n")

# --- 0. Setup ----
base_dir <- "D:/work/Semester4/AdvStats/pakistan-inflation-forecast"
output_folder <- file.path(base_dir, "Processed_Data")
results_folder <- file.path(base_dir, "Model_Results/Ridge_v5_1se") # Updated folder
if (!dir.exists(results_folder)) {dir.create(results_folder, recursive = TRUE)}

# --- 1. Load Processed Data (Full Predictor Set) ---
cat("\n--- Loading Processed Data (Full Predictor Set) ---\n")
scaled_rds_path <- file.path(output_folder, "final_data_scaled_monthly_v3_verified.rds") # Using v3 output
unscaled_rds_path <- file.path(output_folder, "final_data_unscaled_monthly_v3_verified.rds") # Using v3 output

if (!file.exists(scaled_rds_path) || !file.exists(unscaled_rds_path)) {
  stop("Processed data files (v3_verified .rds) not found. Please run the correct 'prepare_predictors.R' script first.")
}

final_data_scaled <- readRDS(scaled_rds_path)
final_data_unscaled <- readRDS(unscaled_rds_path)

cat("Scaled and unscaled data loaded successfully.\n")
cat("Dimensions:", paste(dim(final_data_scaled), collapse=" x "), "\n")
cat("Date range:", format(min(final_data_scaled$Date)), "to", format(max(final_data_scaled$Date)), "\n")

# --- 2. Define Variables ---
target_col_final <- names(final_data_scaled)[grepl("^Headline_CPI", names(final_data_scaled)) & !grepl("_L\\d+$", names(final_data_scaled))][1]
predictor_cols_final <- setdiff(names(final_data_scaled), c("Date", target_col_final))

cat("\nDependent Variable (Y):", target_col_final, "\n")
cat("Predictor Variables (X) being used (", length(predictor_cols_final), "total).\n")

if (length(predictor_cols_final) == 0) {stop("No predictor columns found.")}
if (!target_col_final %in% names(final_data_scaled)) {stop("Target column not found.")}

# --- 3. Train/Test Split ---
cat("\n--- Splitting Data into Training and Test Sets ---\n")
split_ratio <- 0.80
split_index <- floor(nrow(final_data_scaled) * split_ratio)
train_data_scaled <- final_data_scaled[1:split_index, ]; test_data_scaled <- final_data_scaled[(split_index + 1):nrow(final_data_scaled), ]
train_data_unscaled <- final_data_unscaled[1:split_index, ]; test_data_unscaled <- final_data_unscaled[(split_index + 1):nrow(final_data_unscaled), ]
cat("Training set size:", nrow(train_data_scaled), "rows\n")
cat("Test set size:", nrow(test_data_scaled), "rows\n")
x_train <- as.matrix(train_data_scaled[, predictor_cols_final, drop = FALSE]); y_train <- train_data_scaled[[target_col_final]]
x_test <- as.matrix(test_data_scaled[, predictor_cols_final, drop = FALSE]); y_test_scaled <- test_data_scaled[[target_col_final]]; y_test_unscaled <- test_data_unscaled[[target_col_final]]
if (any(is.na(x_train)) || any(is.na(y_train)) || any(is.na(x_test))) {stop("NAs detected in train/test matrices.")}

# --- 4. Ridge Regression Model Training (alpha=0, lambda.1se) ---
cat("\n--- Training Ridge Regression Model (alpha=0, lambda.1se) ---\n")
set.seed(123)
cv_ridge <- cv.glmnet(x_train, y_train, alpha = 0, nfolds = min(10, nrow(x_train))) # nfolds safe for small N
# --- Use lambda.1se ---
best_lambda_ridge <- cv_ridge$lambda.1se
cat("Best Lambda (lambda.1se) found via CV on training data:", best_lambda_ridge, "\n")
cat("Lambda Min was:", cv_ridge$lambda.min, "\n")

plot(cv_ridge)
title("Ridge Regression Cross-Validation (Training Data)", line = 2.5)
abline(v=log(cv_ridge$lambda.1se), lty=2, col="blue") # Add line for lambda.1se
legend("topright", legend=c("lambda.min", "lambda.1se"), lty=2, col=c("red", "blue"))
cat("CV plot generated.\n")

ridge_model <- glmnet(x_train, y_train, alpha = 0, lambda = best_lambda_ridge)
cat("\nFinal Ridge Model Coefficients (lambda.1se):\n")
ridge_coeffs <- coef(ridge_model)
print(ridge_coeffs)

# --- 5. Prediction on Test Set ---
cat("\n--- Generating Predictions on Test Set ---\n")
predictions_test_scaled <- predict(ridge_model, s = best_lambda_ridge, newx = x_test)
predictions_test_scaled <- as.vector(predictions_test_scaled)
# Unscaling
mean_y_original <- mean(final_data_unscaled[[target_col_final]], na.rm = TRUE); sd_y_original <- sd(final_data_unscaled[[target_col_final]], na.rm = TRUE)
if (!is.na(mean_y_original) && !is.na(sd_y_original) && sd_y_original != 0) { predictions_test_unscaled <- predictions_test_scaled * sd_y_original + mean_y_original; cat("Attempting to unscale predictions.\n")
} else { predictions_test_unscaled <- rep(NA, length(predictions_test_scaled)); warning("Cannot unscale predictions.") }

# --- 6. Performance Evaluation on Test Set ---
cat("\n--- Evaluating Model Performance on Test Set ---\n")
rmse_scaled <- Metrics::rmse(actual = y_test_scaled, predicted = predictions_test_scaled); mae_scaled <- Metrics::mae(actual = y_test_scaled, predicted = predictions_test_scaled)
cat("Performance Metrics (Standardized Scale - Target vs. Prediction):\n"); cat("  RMSE:", round(rmse_scaled, 4), "\n"); cat("  MAE:", round(mae_scaled, 4), "\n")
rmse_unscaled <- Metrics::rmse(actual = y_test_unscaled, predicted = predictions_test_unscaled); mae_unscaled <- Metrics::mae(actual = y_test_unscaled, predicted = predictions_test_unscaled)
cat("\nPerformance Metrics (Original Scale - Target vs. Prediction):\n"); cat("  NOTE: Unscaled metrics assume target variable was scaled during training, which may not be the case.\n")
cat("  RMSE:", round(rmse_unscaled, 4), "\n"); cat("  MAE:", round(mae_unscaled, 4), "\n")
if (any(y_test_unscaled == 0)) { cat("  MAPE: Cannot calculate due to zero values.\n"); mape_unscaled <- NA
} else { mape_unscaled <- Metrics::mape(actual = y_test_unscaled, predicted = predictions_test_unscaled); cat("  MAPE:", round(mape_unscaled * 100, 2), "%\n") }
# In-Sample R-squared
predictions_train_scaled <- predict(ridge_model, s = best_lambda_ridge, newx = x_train)
tss_train <- sum((y_train - mean(y_train))^2); rss_train <- sum((y_train - predictions_train_scaled)^2)
if (tss_train > 0) { r_squared_train <- 1 - (rss_train / tss_train); cat("\nIn-Sample R-squared (Training Data, Standardized):", round(r_squared_train, 4), "\n")
} else { cat("\nCannot calculate In-Sample R-squared.\n"); r_squared_train <- NA }
evaluation_metrics <- data.frame( Metric = c("Lambda_1se", "RMSE_scaled", "MAE_scaled", "RMSE_unscaled", "MAE_unscaled", "MAPE_unscaled", "R_squared_train"),
                                  Value = c(best_lambda_ridge, rmse_scaled, mae_scaled, rmse_unscaled, mae_unscaled, mape_unscaled, r_squared_train) )
cat("\n--- Evaluation Metrics Summary ---\n"); print(evaluation_metrics, row.names = FALSE, digits=4)

# --- 7. Generate Plots for Test Set ---
cat("\n--- Generating Test Set Plots ---\n")
test_data_unscaled$Predicted_Unscaled <- predictions_test_unscaled; test_data_scaled$Predicted_Scaled <- predictions_test_scaled
print( ggplot(test_data_unscaled, aes(x = .data[[target_col_final]], y = Predicted_Unscaled)) + geom_point(alpha = 0.7) + geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
         labs(title = "Ridge (lambda.1se): Predicted vs Actual CPI (Test Set - Original Scale)", subtitle = "Note: Unscaling might be inaccurate", x = paste("Actual", target_col_final), y = paste("Predicted", target_col_final)) + theme_minimal() + coord_equal() )
plot_data_ts <- bind_rows( train_data_unscaled %>% select(Date, Value = all_of(target_col_final)) %>% mutate(Type = "Train Actual"),
                           test_data_unscaled %>% select(Date, Value = all_of(target_col_final)) %>% mutate(Type = "Test Actual"),
                           test_data_unscaled %>% filter(!is.na(Predicted_Unscaled)) %>% select(Date, Value = Predicted_Unscaled) %>% mutate(Type = "Test Predicted") )
print( ggplot(plot_data_ts, aes(x = Date, y = Value, color = Type)) + geom_line(data = filter(plot_data_ts, Type %in% c("Train Actual", "Test Actual")), alpha = 0.8) +
         geom_line(data = filter(plot_data_ts, Type == "Test Predicted"), linetype = "dashed", alpha = 0.8) + labs(title = "Ridge (lambda.1se): Headline CPI Forecast vs Actuals (Original Scale)", x = "Date", y = target_col_final, color = "Data Type") +
         scale_color_manual(values = c("Train Actual" = "grey50", "Test Actual" = "blue", "Test Predicted" = "red")) + theme_minimal() + geom_vline(xintercept = train_data_unscaled$Date[nrow(train_data_unscaled)], linetype="dotted", color = "black") +
         annotate("text", x = train_data_unscaled$Date[nrow(train_data_unscaled)], y = max(plot_data_ts$Value, na.rm=T), label = "Train/Test Split", hjust = -0.1, vjust=1, size=3) )
cat("Test set plots generated.\n")

# --- 8. Print Predictions Table ---
cat("\n--- Test Set Predictions (First 20 Rows) ---\n")
predictions_df <- data.frame( Date = test_data_unscaled$Date, Actual_Original = y_test_unscaled, Predicted_Original = predictions_test_unscaled,
                              Actual_Scaled = y_test_scaled, Predicted_Scaled = predictions_test_scaled )
print(head(predictions_df, 20), digits=4)

cat("\n--- Ridge Regression Analysis Finished (v5 - lambda.1se, Console Output) --- \n")