# Test runner for testthat
# This file sets up the testing environment

library(testthat)

# Source the utility functions
source("R/utils.R")

# Run all tests
test_dir("tests/testthat", reporter = "summary")
