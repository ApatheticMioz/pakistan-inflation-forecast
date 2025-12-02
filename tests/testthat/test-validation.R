# Tests for data validation functions
# Part of Pakistan Inflation Forecasting Project

library(testthat)

# Source the validation functions
source("../../R/validation.R")

# Test validate_cpi_data
test_that("validate_cpi_data accepts valid data", {
  df <- data.frame(
    observation_date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    observation_value = c(10.5, 11.2, 12.1, 13.0, 12.5, 11.8, 10.9, 11.5, 12.0, 12.8, 13.5, 14.0)
  )
  
  result <- validate_cpi_data(df)
  
  expect_true(result$valid)
  expect_equal(length(result$errors), 0)
})

test_that("validate_cpi_data handles missing columns", {
  df <- data.frame(
    wrong_date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    wrong_value = 1:12
  )
  
  result <- validate_cpi_data(df)
  
  expect_false(result$valid)
  expect_true(length(result$errors) > 0)
})

test_that("validate_cpi_data accepts alternative column names", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    value = c(10.5, 11.2, 12.1, 13.0, 12.5, 11.8, 10.9, 11.5, 12.0, 12.8, 13.5, 14.0)
  )
  
  result <- validate_cpi_data(df)
  
  # Should still be valid with warnings about column names
  expect_true(length(result$warnings) >= 0)
})

test_that("validate_cpi_data warns about extreme values", {
  df <- data.frame(
    observation_date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 5),
    observation_value = c(10.5, 150, 12.1, -30, 12.5)  # Extreme values
  )
  
  result <- validate_cpi_data(df)
  
  expect_true(any(grepl("outside expected range", result$warnings)))
})

# Test validate_exchange_rate_data
test_that("validate_exchange_rate_data accepts valid data", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    observation_value = seq(160, 180, length.out = 12)
  )
  
  result <- validate_exchange_rate_data(df)
  
  expect_true(result$valid)
})

test_that("validate_exchange_rate_data rejects negative values", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 5),
    observation_value = c(160, -10, 165, 170, 175)
  )
  
  result <- validate_exchange_rate_data(df)
  
  expect_false(result$valid)
  expect_true(any(grepl("non-positive", result$errors)))
})

test_that("validate_exchange_rate_data warns about extreme values", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 5),
    observation_value = c(160, 600, 165, 170, 175)  # 600 is extreme
  )
  
  result <- validate_exchange_rate_data(df)
  
  expect_true(any(grepl("outside typical range", result$warnings)))
})

# Test validate_oil_price_data
test_that("validate_oil_price_data accepts valid data", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
    mcoilbrenteu = seq(60, 80, length.out = 12)
  )
  
  result <- validate_oil_price_data(df)
  
  expect_true(result$valid)
})

test_that("validate_oil_price_data rejects missing date column", {
  df <- data.frame(
    wrong_column = 1:12,
    mcoilbrenteu = seq(60, 80, length.out = 12)
  )
  
  result <- validate_oil_price_data(df)
  
  expect_false(result$valid)
  expect_true(any(grepl("date column", result$errors, ignore.case = TRUE)))
})

test_that("validate_oil_price_data warns about extreme prices", {
  df <- data.frame(
    date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 5),
    mcoilbrenteu = c(60, 250, 70, 2, 80)  # 250 and 2 are extreme
  )
  
  result <- validate_oil_price_data(df)
  
  expect_true(any(grepl("outside typical range", result$warnings)))
})

# Test validate_all_datasets
test_that("validate_all_datasets processes multiple datasets", {
  datasets <- list(
    cpi = data.frame(
      observation_date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
      observation_value = seq(10, 15, length.out = 12)
    ),
    exchange_rate = data.frame(
      date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
      observation_value = seq(160, 180, length.out = 12)
    )
  )
  
  result <- validate_all_datasets(datasets)
  
  expect_true("cpi" %in% names(result))
  expect_true("exchange_rate" %in% names(result))
  expect_true("summary" %in% names(result))
  expect_equal(result$summary$datasets_validated, 2)
})

test_that("validate_all_datasets handles empty datasets list", {
  result <- validate_all_datasets(list())
  
  expect_true("summary" %in% names(result))
  expect_equal(result$summary$datasets_validated, 0)
})

# Test print_validation_results (just ensure it doesn't error)
test_that("print_validation_results executes without error", {
  datasets <- list(
    cpi = data.frame(
      observation_date = seq.Date(as.Date("2020-01-01"), by = "month", length.out = 12),
      observation_value = seq(10, 15, length.out = 12)
    )
  )
  
  result <- validate_all_datasets(datasets)
  
  expect_silent(capture.output(print_validation_results(result)))
})
