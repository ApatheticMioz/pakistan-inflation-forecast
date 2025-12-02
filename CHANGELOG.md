# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Project configuration file (`config.yml`) for centralized parameter management
- MIT License for open source distribution
- Comprehensive `DESCRIPTION` file for R package metadata
- `CONTRIBUTING.md` with contribution guidelines
- Docker support with `Dockerfile` and `docker-compose.yml`
- GitHub Actions CI/CD workflow (`.github/workflows/r-ci.yml`)
- Testing infrastructure with testthat (`tests/testthat/`)
- Reusable utility functions module (`R/utils.R`)
- Code linting configuration (`.lintr`)
- Data validation schemas and functions
- This `CHANGELOG.md` file

### Changed
- Updated `.gitignore` to include new project structure
- Improved code organization with extracted utility functions

### Fixed
- None

## [1.0.0] - 2025-05-06

### Added
- Initial release of Pakistan Inflation Forecasting Project
- Six R scripts forming the complete forecasting pipeline:
  - `01_load_and_eda.R` - Data loading and exploratory analysis
  - `02_merge_datasets.R` - Dataset merging and feature creation
  - `03_prepare_modeling_df.R` - Model preparation and train-test split
  - `04_arima_modeling.R` - ARIMA time series modeling
  - `05_regularization_modeling.R` - Ridge, Lasso, and Elastic Net models
  - `06_model_evaluation.R` - Model comparison and forecasting
- Data from multiple sources (SBP, FAO, FRED, Finance.gov.pk)
- Comprehensive README with model documentation
- Results visualization and reporting

### Model Performance (Initial Release)
| Model       | MSE      | RMSE     | R-Squared |
|-------------|----------|----------|-----------|
| ARIMA       | 202.13   | NA       | NA        |
| Ridge       | 1.05     | 1.02     | 0.9888    |
| Lasso       | 0.54     | 0.74     | 0.9942    |
| Elastic Net | 0.51     | 0.71     | 0.9946    |

[Unreleased]: https://github.com/ApatheticMioz/pakistan-inflation-forecast/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/ApatheticMioz/pakistan-inflation-forecast/releases/tag/v1.0.0
