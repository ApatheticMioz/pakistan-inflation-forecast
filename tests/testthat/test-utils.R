# Tests for utility functions
# Part of Pakistan Inflation Forecasting Project

library(testthat)

# Source the utility functions
source("../../R/utils.R")

# Test standardize_names
test_that("standardize_names converts column names correctly", {
  df <- data.frame(
    "Column Name" = 1:3,
    "Another.Column" = 4:6,
    "Third-Col" = 7:9
  )
  
  result <- standardize_names(df)
  
  expect_equal(names(result), c("column_name", "another_column", "third_col"))
  expect_equal(nrow(result), 3)
})

test_that("standardize_names throws error for non-dataframe input", {
  expect_error(standardize_names(c(1, 2, 3)), "Input must be a data frame")
})

# Test detect_outliers
test_that("detect_outliers identifies outliers correctly", {
  # Normal values with one clear outlier
  x <- c(1, 2, 3, 4, 5, 100)
  
  result <- detect_outliers(x, multiplier = 1.5)
  
  expect_equal(length(result), length(x))
  expect_true(result[6])  # 100 should be an outlier
  expect_false(all(result[1:5]))  # 1-5 should not be outliers
})

test_that("detect_outliers handles non-numeric input", {
  x <- c("a", "b", "c")
  result <- detect_outliers(x)
  
  expect_equal(result, rep(FALSE, 3))
})

test_that("detect_outliers handles NA values", {
  x <- c(1, 2, NA, 4, 5)
  result <- detect_outliers(x)
  
  expect_equal(length(result), length(x))
})

# Test cap_outliers
test_that("cap_outliers caps values at bounds", {
  x <- c(1, 2, 3, 4, 5, 100)
  
  result <- cap_outliers(x, multiplier = 1.5)
  
  expect_true(max(result) < 100)
  expect_equal(result[1:5], x[1:5])
})

test_that("cap_outliers returns non-numeric input unchanged", {
  x <- c("a", "b", "c")
  result <- cap_outliers(x)
  
  expect_equal(result, x)
})

# Test calculate_accuracy
test_that("calculate_accuracy returns correct metrics", {
  actual <- c(1, 2, 3, 4, 5)
  predicted <- c(1.1, 2.1, 2.9, 4.1, 4.9)
  
  result <- calculate_accuracy(actual, predicted, "Test Model")
  
  expect_equal(result$Model, "Test Model")
  expect_true(result$MSE > 0)
  expect_true(result$RMSE > 0)
  expect_true(result$MAE > 0)
  expect_true(result$R_Squared <= 1)
})

test_that("calculate_accuracy handles perfect predictions", {
  actual <- c(1, 2, 3, 4, 5)
  predicted <- c(1, 2, 3, 4, 5)
  
  result <- calculate_accuracy(actual, predicted)
  
  expect_equal(result$MSE, 0)
  expect_equal(result$RMSE, 0)
  expect_equal(result$MAE, 0)
  expect_equal(result$R_Squared, 1)
})

test_that("calculate_accuracy handles different length vectors", {
  actual <- c(1, 2, 3)
  predicted <- c(1.1, 2.1, 2.9, 4.1)
  
  result <- calculate_accuracy(actual, predicted)
  
  expect_equal(result$Model, "Model")
  expect_true(!is.na(result$MSE))
})

# Test create_lag_variables
test_that("create_lag_variables creates correct lag columns", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    value = 1:12
  )
  
  result <- create_lag_variables(df, "value", lags = c(1, 3))
  
  expect_true("value_lag1" %in% names(result))
  expect_true("value_lag3" %in% names(result))
  expect_equal(result$value_lag1[2], 1)  # lag 1 of row 2 should be row 1 value
  expect_equal(result$value_lag3[4], 1)  # lag 3 of row 4 should be row 1 value
})

test_that("create_lag_variables handles missing variable", {
  df <- data.frame(x = 1:10)
  
  result <- create_lag_variables(df, "missing_var", lags = c(1))
  
  expect_equal(names(result), names(df))  # Should return unchanged
})

# Test create_ma_variables
test_that("create_ma_variables creates correct moving average columns", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    value = rep(2, 12)  # Constant values for easy verification
  )
  
  result <- create_ma_variables(df, "value", windows = c(3))
  
  expect_true("value_ma3" %in% names(result))
  expect_equal(result$value_ma3[3], 2)  # MA of constant should equal constant
})

# Test create_growth_variables
test_that("create_growth_variables creates growth rate columns", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 13),
    value = c(100, 110, rep(110, 11))  # 10% increase then constant
  )
  
  result <- create_growth_variables(df, "value")
  
  expect_true("value_mom_pct" %in% names(result))
  expect_true("value_yoy_pct" %in% names(result))
  expect_equal(round(result$value_mom_pct[2], 1), 10)  # 10% increase
  expect_equal(result$value_yoy_pct[13], 0)  # Should be 10% for position 13
})

# Test get_default_config
test_that("get_default_config returns expected structure", {
  config <- get_default_config()
  
  expect_true(is.list(config))
  expect_true("data" %in% names(config))
  expect_true("model" %in% names(config))
  expect_true("features" %in% names(config))
  expect_equal(config$model$train_ratio, 0.80)
  expect_equal(config$model$seed, 123)
})

# Test validate_data_quality
test_that("validate_data_quality detects missing columns", {
  df <- data.frame(a = 1:10, b = 11:20)
  
  result <- validate_data_quality(df, required_cols = c("a", "c"))
  
  expect_false(result$valid)
  expect_true(any(grepl("Missing required columns", result$issues)))
})

test_that("validate_data_quality handles empty data frame", {
  df <- data.frame()
  
  result <- validate_data_quality(df)
  
  expect_false(result$valid)
  expect_true(any(grepl("empty", result$issues)))
})

test_that("validate_data_quality detects duplicate dates", {
  df <- data.frame(
    date = as.Date(c("2020-01-01", "2020-01-01", "2020-01-02")),
    value = c(1, 2, 3)
  )
  
  result <- validate_data_quality(df, date_col = "date")
  
  expect_true(any(grepl("duplicate", result$issues)))
})

# Test calculate_missingness
test_that("calculate_missingness returns correct statistics", {
  df <- data.frame(
    a = c(1, NA, 3, 4, 5),
    b = c(NA, NA, 3, 4, 5),
    c = c(1, 2, 3, 4, 5)
  )
  
  result <- calculate_missingness(df)
  
  expect_equal(nrow(result), 3)
  expect_true("Variable" %in% names(result))
  expect_true("Missing_Count" %in% names(result))
  expect_true("Missing_Percent" %in% names(result))
  expect_equal(result$Missing_Count[result$Variable == "a"], 1)
  expect_equal(result$Missing_Count[result$Variable == "b"], 2)
  expect_equal(result$Missing_Count[result$Variable == "c"], 0)
})

# Test log_message
test_that("log_message produces message output", {
  expect_message(log_message("Test message", "INFO"), "\\[INFO\\] Test message")
})
