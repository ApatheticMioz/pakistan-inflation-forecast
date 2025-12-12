# Contributing to Pakistan Inflation Forecast

Thank you for your interest in contributing to this project! This document provides guidelines and instructions for contributing.

## Project Status

**Note:** This repository is in an **archived/refactored** state. While contributions are welcome, please be aware that active development may be limited.

## How to Contribute

### Reporting Issues

1. Check existing issues to avoid duplicates
2. Use a clear and descriptive title
3. Provide detailed reproduction steps
4. Include relevant data samples (anonymized if necessary)
5. Specify your R version and operating system

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following the coding standards below
4. **Test your changes** by running all R scripts in sequence
5. **Commit with a descriptive message**:
   ```bash
   git commit -m "feat: add new forecasting method"
   ```
6. **Push to your fork** and submit a Pull Request

### Commit Message Format

Use conventional commits format:
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Formatting changes
- `refactor:` - Code restructuring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

## Coding Standards

### R Code Style

- Use consistent indentation (2 spaces)
- Follow tidyverse style guide where applicable
- Comment complex logic and non-obvious decisions
- Use meaningful variable and function names
- Prefix script names with numbers to indicate execution order

### Data Handling

- Never commit raw data containing sensitive information
- Document data sources and transformations
- Use relative paths for file references
- Include data validation checks

### Documentation

- Update README.md if adding new features
- Document new functions with roxygen2-style comments
- Include examples for new functionality

## Development Setup

1. Install R (version 4.0 or higher recommended)
2. Install required packages:
   ```r
   install.packages(c(
     "dplyr", "ggplot2", "forecast", "glmnet",
     "readr", "lubridate", "stringr", "gridExtra",
     "reshape2", "knitr", "tibble", "tseries", "zoo"
   ))
   ```
3. Run scripts in numerical order (01-06)

## Questions?

Feel free to open an issue for any questions or suggestions.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
