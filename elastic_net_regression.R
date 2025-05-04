# --- Elastic Net Regression Modeling, Forecasting & Evaluation (v5 - lambda.1se, Console Output) ---
# --- Assumes prepare_predictors.R (verified v3, full predictors) has been run ---

# --- Load Necessary Libraries ---
library(glmnet)
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(Metrics)
library(caret) # Not used directly for CV here, but keep if useful

cat("Current Date/Time:", format(Sys.time()), "\n")

# --- 0. Setup ----
base_dir <- "D:/work/Semester4/AdvStats/pakistan-inflation-forecast"
output_folder <- file.path(base_dir, "Processed_Data")
results_folder <- file.path(base_dir, "Model_Results/ElasticNet_v5_1se") # Updated folder
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

# --- 2. Define Variables ---
target_col_final <- names(final_data_scaled)[grepl("^Headline_CPI", names(final_data_scaled)) & !grepl("_L\\d+$", names(final_data_scaled))][1]
predictor_cols_final <- setdiff(names(final_data_scaled), c("Date", target_col_final))
cat("\nDependent Variable (Y):", target_col_final, "\n")
cat("Predictor Variables (X) being used (", length(predictor_cols_final), "total).\n")

# --- 3. Train/Test Split ---
cat("\n--- Splitting Data ---\n")
split_ratio <- 0.80; split_index <- floor(nrow(final_data_scaled) * split_ratio)
train_data_scaled <- final_data_scaled[1:split_index, ]; test_data_scaled <- final_data_scaled[(split_index + 1):nrow(final_data_scaled), ]
train_data_unscaled <- final_data_unscaled[1:split_index, ]; test_data_unscaled <- final_data_unscaled[(split_index + 1):nrow(final_data_unscaled), ]
cat("Training set:", nrow(train_data_scaled), "rows; Test set:", nrow(test_data_scaled), "rows\n")
x_train <- as.matrix(train_data_scaled[, predictor_cols_final, drop = FALSE]); y_train <- train_data_scaled[[target_col_final]]
x_test <- as.matrix(test_data_scaled[, predictor_cols_final, drop = FALSE]); y_test_scaled <- test_data_scaled[[target_col_final]]; y_test_unscaled <- test_data_unscaled[[target_col_final]]
if (any(is.na(x_train)) || any(is.na(y_train)) || any(is.na(x_test))) {stop("NAs detected.")}

# --- 4. Elastic Net Regression Model Training (Tune alpha, lambda.1se) ---
cat("\n--- Training Elastic Net Model (Tuning alpha, using lambda.1se) ---\n")
set.seed(123)
best_alpha <- NA; best_lambda_enet <- NA; min_cv_mse_1se <- Inf; results_list <- list()
alpha_values <- seq(0, 1, by = 0.1)

cat("Performing grid search with CV (k=10) for alpha, selecting lambda.1se...\n")
for (a in alpha_values) {
  cat("  Tuning lambda for alpha =", a, "...\n")
  cv_result <- tryCatch({ cv.glmnet(x_train, y_train, alpha = a, nfolds = min(10, nrow(x_train))) },
                        error = function(e) {warning(paste("CV failed for alpha =", a)); NULL})
  if (!is.null(cv_result)) {
    lambda_1se_loop <- cv_result$lambda.1se # --- USE lambda.1se ---
    if (!is.null(lambda_1se_loop) && any(cv_result$lambda == lambda_1se_loop)) {
      mse_1se_loop <- cv_result$cvm[which(cv_result$lambda == lambda_1se_loop)]
      results_list[[paste("alpha",a,sep="_")]] <- list(alpha=a, lambda_1se=lambda_1se_loop, mse_at_1se=mse_1se_loop, lambda_min=cv_result$lambda.min, mse_at_min=cv_result$cvm[which(cv_result$lambda == cv_result$lambda.min)])
      # --- Select alpha based on MSE at lambda.1se ---
      if (!is.na(mse_1se_loop) && mse_1se_loop < min_cv_mse_1se) {
        min_cv_mse_1se <- mse_1se_loop
        best_alpha <- a
        best_lambda_enet <- lambda_1se_loop
      }
    } else { results_list[[paste("alpha",a,sep="_")]] <- list(alpha=a, lambda_1se=NA, mse_at_1se=NA, lambda_min=NA, mse_at_min=NA) }
  } else { results_list[[paste("alpha",a,sep="_")]] <- list(alpha=a, lambda_1se=NA, mse_at_1se=NA, lambda_min=NA, mse_at_min=NA) }
}

cat("\nCV Results Summary (Alpha vs MSE at Lambda.1se):\n")
cv_summary_df <- do.call(rbind, lapply(results_list, data.frame)); cv_summary_df <- cv_summary_df[!is.na(cv_summary_df$mse_at_1se), ]
if(nrow(cv_summary_df)>0) {print(cv_summary_df[order(cv_summary_df$mse_at_1se), ])} else {warning("No successful CV results.")}

if(is.na(best_alpha) || is.na(best_lambda_enet)) { stop("Could not determine best alpha/lambda.1se.") }
cat("\nBest Combination Found via CV (using lambda.1se):\n"); cat("  Best Alpha:", best_alpha, "\n"); cat("  Best Lambda (1se):", best_lambda_enet, "\n"); cat("  Minimum CV MSE at lambda.1se:", min_cv_mse_1se, "\n")

elastic_net_model <- glmnet(x_train, y_train, alpha = best_alpha, lambda = best_lambda_enet)
cat("\nFinal Elastic Net Model Coefficients (lambda.1se):\n")
elastic_net_coeffs <- coef(elastic_net_model); print(elastic_net_coeffs)
selected_vars_enet <- rownames(elastic_net_coeffs)[which(elastic_net_coeffs != 0)]; selected_vars_enet <- selected_vars_enet[selected_vars_enet != "(Intercept)"]
cat("\nVariables selected by Elastic Net (non-zero coefficients):\n"); print(selected_vars_enet)

# --- 5. Prediction on Test Set ---
cat("\n--- Generating Predictions on Test Set ---\n")
if (ncol(x_train) > 0) { predictions_test_scaled <- predict(elastic_net_model, s = best_lambda_enet, newx = x_test)
} else { predictions_test_scaled <- rep(elastic_net_model$intercept, nrow(x_test)) }
predictions_test_scaled <- as.vector(predictions_test_scaled)
# Unscaling (same logic/caveats as before)
mean_y_original <- mean(final_data_unscaled[[target_col_final]], na.rm = TRUE); sd_y_original <- sd(final_data_unscaled[[target_col_final]], na.rm = TRUE)
if (!is.na(mean_y_original) && !is.na(sd_y_original) && sd_y_original != 0) { predictions_test_unscaled <- predictions_test_scaled * sd_y_original + mean_y_original; cat("Attempting to unscale predictions.\n")
} else { predictions_test_unscaled <- rep(NA, length(predictions_test_scaled)); warning("Cannot unscale predictions.") }

# --- 6. Performance Evaluation on Test Set ---
cat("\n--- Evaluating Model Performance on Test Set ---\n")
# (Same metric calculation logic)
# ... [Insert metric calculation code here] ...
# --- START Copied Metrics ---
rmse_scaled <- Metrics::rmse(actual = y_test_scaled, predicted = predictions_test_scaled); mae_scaled <- Metrics::mae(actual = y_test_scaled, predicted = predictions_test_scaled)
cat("Performance Metrics (Standardized Scale - Target vs. Prediction):\n"); cat("  RMSE:", round(rmse_scaled, 4), "\n"); cat("  MAE:", round(mae_scaled, 4), "\n")
rmse_unscaled <- Metrics::rmse(actual = y_test_unscaled, predicted = predictions_test_unscaled); mae_unscaled <- Metrics::mae(actual = y_test_unscaled, predicted = predictions_test_unscaled)
cat("\nPerformance Metrics (Original Scale - Target vs. Prediction):\n"); cat("  NOTE: Unscaled metrics assume target variable was scaled during training, which may not be the case.\n")
cat("  RMSE:", round(rmse_unscaled, 4), "\n"); cat("  MAE:", round(mae_unscaled, 4), "\n")
if (any(y_test_unscaled == 0)) { cat("  MAPE: Cannot calculate due to zero values.\n"); mape_unscaled <- NA
} else { mape_unscaled <- Metrics::mape(actual = y_test_unscaled, predicted = predictions_test_unscaled); cat("  MAPE:", round(mape_unscaled * 100, 2), "%\n") }
# In-Sample R-squared
if (ncol(x_train) > 0) { predictions_train_scaled <- predict(elastic_net_model, s = best_lambda_enet, newx = x_train)
} else { predictions_train_scaled <- rep(elastic_net_model$intercept, nrow(x_train)) }
tss_train <- sum((y_train - mean(y_train))^2); rss_train <- sum((y_train - predictions_train_scaled)^2)
if (tss_train > 0) { r_squared_train <- 1 - (rss_train / tss_train); cat("\nIn-Sample R-squared (Training Data, Standardized):", round(r_squared_train, 4), "\n")
} else { cat("\nCannot calculate In-Sample R-squared.\n"); r_squared_train <- NA }
evaluation_metrics <- data.frame( Metric = c("Best_Alpha", "Best_Lambda_1se", "RMSE_scaled", "MAE_scaled", "RMSE_unscaled", "MAE_unscaled", "MAPE_unscaled", "R_squared_train"),
                                  Value = c(best_alpha, best_lambda_enet, rmse_scaled, mae_scaled, rmse_unscaled, mae_unscaled, mape_unscaled, r_squared_train) )
cat("\n--- Evaluation Metrics Summary ---\n"); print(evaluation_metrics, row.names = FALSE, digits=4)
# --- END Copied Metrics ---

# --- 7. Generate Plots for Test Set ---
cat("\n--- Generating Test Set Plots ---\n")
# (Same plotting logic, update titles)
# ... [Insert plotting code here] ...
# --- START Copied Plots ---
test_data_unscaled$Predicted_Unscaled <- predictions_test_unscaled; test_data_scaled$Predicted_Scaled <- predictions_test_scaled
print( ggplot(test_data_unscaled, aes(x = .data[[target_col_final]], y = Predicted_Unscaled)) + geom_point(alpha = 0.7) + geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
         labs(title = "Elastic Net (lambda.1se): Predicted vs Actual CPI (Test Set - Original Scale)", subtitle = "Note: Unscaling might be inaccurate", x = paste("Actual", target_col_final), y = paste("Predicted", target_col_final)) + theme_minimal() + coord_equal() )
plot_data_ts <- bind_rows( train_data_unscaled %>% select(Date, Value = all_of(target_col_final)) %>% mutate(Type = "Train Actual"),
                           test_data_unscaled %>% select(Date, Value = all_of(target_col_final)) %>% mutate(Type = "Test Actual"),
                           test_data_unscaled %>% filter(!is.na(Predicted_Unscaled)) %>% select(Date, Value = Predicted_Unscaled) %>% mutate(Type = "Test Predicted") )
print( ggplot(plot_data_ts, aes(x = Date, y = Value, color = Type)) + geom_line(data = filter(plot_data_ts, Type %in% c("Train Actual", "Test Actual")), alpha = 0.8) +
         geom_line(data = filter(plot_data_ts, Type == "Test Predicted"), linetype = "dashed", alpha = 0.8) + labs(title = "Elastic Net (lambda.1se): Headline CPI Forecast vs Actuals (Original Scale)", x = "Date", y = target_col_final, color = "Data Type") +
         scale_color_manual(values = c("Train Actual" = "grey50", "Test Actual" = "blue", "Test Predicted" = "red")) + theme_minimal() + geom_vline(xintercept = train_data_unscaled$Date[nrow(train_data_unscaled)], linetype="dotted", color = "black") +
         annotate("text", x = train_data_unscaled$Date[nrow(train_data_unscaled)], y = max(plot_data_ts$Value, na.rm=T), label = "Train/Test Split", hjust = -0.1, vjust=1, size=3) )
cat("Test set plots generated.\n")
# --- END Copied Plots ---

# --- 8. Print Predictions Table ---
cat("\n--- Test Set Predictions (First 20 Rows) ---\n")
# (Same prediction printing logic)
# ... [Insert prediction printing code here] ...
# --- START Copied Predictions Print ---
predictions_df <- data.frame( Date = test_data_unscaled$Date, Actual_Original = y_test_unscaled, Predicted_Original = predictions_test_unscaled,
                              Actual_Scaled = y_test_scaled, Predicted_Scaled = predictions_test_scaled )
print(head(predictions_df, 20), digits=4)
# --- END Copied Predictions Print ---

cat("\n--- Elastic Net Regression Analysis Finished (v5 - lambda.1se, Console Output) --- \n")