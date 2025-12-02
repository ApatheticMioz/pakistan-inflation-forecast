# Contributing to Pakistan Inflation Forecasting Project

Thank you for your interest in contributing to this project! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Contributions](#making-contributions)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)

## Code of Conduct

Please be respectful and constructive in all interactions. We welcome contributors of all backgrounds and experience levels.

## Getting Started

### Prerequisites

- R version 4.0.0 or higher
- RStudio (recommended) or another R IDE
- Git

### Installing Dependencies

```r
# Install all required packages
install.packages(c(
  "dplyr", "ggplot2", "forecast", "glmnet", "readr",
  "lubridate", "stringr", "gridExtra", "reshape2", "knitr",
  "tibble", "tseries", "zoo", "tidyr", "janitor", "VIM",
  "GGally", "caret", "corrplot", "Matrix", "purrr", "moments",
  "testthat", "lintr", "yaml"
))
```

## Development Setup

1. **Fork the repository** on GitHub

2. **Clone your fork**:
   ```bash
   git clone https://github.com/your-username/pakistan-inflation-forecast.git
   cd pakistan-inflation-forecast
   ```

3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Run the analysis pipeline** to ensure everything works:
   ```bash
   Rscript 01_load_and_eda.R
   Rscript 02_merge_datasets.R
   Rscript 03_prepare_modeling_df.R
   Rscript 04_arima_modeling.R
   Rscript 05_regularization_modeling.R
   Rscript 06_model_evaluation.R
   ```

## Making Contributions

### Types of Contributions

We welcome:
- Bug fixes
- Documentation improvements
- New features (modeling approaches, visualizations)
- Performance optimizations
- Data source additions
- Test additions

### Before Starting Work

1. Check existing [issues](https://github.com/ApatheticMioz/pakistan-inflation-forecast/issues) to avoid duplicate effort
2. For major changes, open an issue first to discuss your proposed approach
3. Ensure your contribution aligns with the project's goals

## Code Style Guidelines

### R Code Style

We follow the [tidyverse style guide](https://style.tidyverse.org/) with some modifications:

1. **Naming Conventions**:
   - Use `snake_case` for variable and function names
   - Use descriptive names that indicate purpose
   - Prefix private/internal functions with `.`

2. **Documentation**:
   - Add roxygen2 comments for all functions
   - Include examples where appropriate
   - Document parameter types and return values

3. **Code Organization**:
   - Keep functions focused and single-purpose
   - Extract reusable code to the `R/` directory
   - Use meaningful section headers in scripts

4. **Line Length**:
   - Maximum 120 characters per line
   - Break long function calls across multiple lines

### Example Function Documentation

```r
#' Calculate Moving Average
#'
#' Calculates a rolling moving average for a numeric vector.
#'
#' @param x Numeric vector of values
#' @param window Integer specifying the window size for the moving average
#' @param align Character string specifying alignment: "right", "center", or "left"
#'
#' @return Numeric vector of moving averages with NA for incomplete windows
#'
#' @examples
#' calculate_moving_average(c(1, 2, 3, 4, 5), window = 3)
#'
#' @export
calculate_moving_average <- function(x, window = 3, align = "right") {
  zoo::rollmean(x, k = window, fill = NA, align = align)
}
```

## Testing

### Running Tests

```r
# Run all tests
testthat::test_dir("tests/testthat")

# Run specific test file
testthat::test_file("tests/testthat/test-utils.R")
```

### Writing Tests

- Place test files in `tests/testthat/`
- Name test files `test-*.R`
- Use descriptive test names
- Test both expected behavior and edge cases

### Example Test

```r
test_that("calculate_moving_average returns correct values", {
  input <- c(1, 2, 3, 4, 5)
  result <- calculate_moving_average(input, window = 3)
  
  expect_equal(length(result), length(input))
  expect_true(is.na(result[1]))
  expect_true(is.na(result[2]))
  expect_equal(result[3], 2)
  expect_equal(result[4], 3)
  expect_equal(result[5], 4)
})
```

### Code Linting

Run lintr before submitting:

```r
lintr::lint_dir()
```

## Submitting Changes

### Pull Request Process

1. **Update documentation** if you've changed functionality
2. **Add or update tests** for your changes
3. **Run the full pipeline** to ensure nothing is broken
4. **Run lintr** to check code style
5. **Update the CHANGELOG** if applicable

### Pull Request Template

When creating a PR, please include:

- **Description**: What does this PR do?
- **Motivation**: Why is this change needed?
- **Testing**: How did you test your changes?
- **Screenshots**: Include if there are UI/visualization changes
- **Related Issues**: Link any related issues

### Commit Messages

Follow conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(model): add Prophet forecasting model
fix(eda): handle missing values in date column
docs(readme): update installation instructions
```

## Questions?

If you have questions, please:
1. Check the [README](README.md) first
2. Search existing [issues](https://github.com/ApatheticMioz/pakistan-inflation-forecast/issues)
3. Open a new issue with the "question" label

Thank you for contributing! 🙏
