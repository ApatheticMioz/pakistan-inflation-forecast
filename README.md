# Pakistan Inflation Forecast

> ⚠️ **Status:** Archived

A comprehensive forecasting system for Pakistan's inflation using time series and regularization models. The project analyzes historical Consumer Price Index (CPI) data along with various economic indicators to predict future inflation trends.

## Description

This project implements a complete inflation forecasting pipeline for Pakistan, comparing multiple modeling approaches:

- **ARIMA** (AutoRegressive Integrated Moving Average) - Captures temporal patterns and seasonality
- **Ridge Regression** - L2 regularization for handling multicollinearity
- **Lasso Regression** - L1 regularization for feature selection
- **Elastic Net** - Combined L1/L2 regularization for balanced prediction

The analysis incorporates economic indicators from the State Bank of Pakistan, FAO, FRED, and the Pakistan Ministry of Finance.

## Project Structure

```
pakistan-inflation-forecast/
├── 01_load_and_eda.R           # Data loading and exploratory analysis
├── 02_merge_datasets.R         # Dataset merging and feature engineering
├── 03_prepare_modeling_df.R    # Model preparation and train-test split
├── 04_arima_modeling.R         # ARIMA time series modeling
├── 05_regularization_modeling.R # Ridge, Lasso, Elastic Net models
├── 06_model_evaluation.R       # Model comparison and final forecasting
├── Data/
│   ├── data_combined/          # Primary economic indicator datasets
│   ├── easydata/               # State Bank of Pakistan data
│   ├── fao/                    # FAO food price indices
│   ├── fred/                   # FRED oil prices
│   ├── finanaceGovPk/          # Pakistan Ministry of Finance data
│   ├── additional_data/        # Supplementary datasets
│   ├── old_data/               # Historical/legacy datasets
│   └── web_search/             # Web-sourced data
├── LICENSE                     # MIT License
├── CONTRIBUTING.md             # Contribution guidelines
├── CHANGELOG.md                # Version history
└── README.md                   # This file
```

## Installation

### Prerequisites

- R (version 4.0 or higher recommended)
- RStudio (optional but recommended)

### Install Required Packages

```r
install.packages(c(
  "dplyr",
  "ggplot2",
  "forecast",
  "glmnet",
  "readr",
  "lubridate",
  "stringr",
  "gridExtra",
  "reshape2",
  "knitr",
  "tibble",
  "tseries",
  "zoo",
  "tidyr",
  "janitor",
  "VIM",
  "caret",
  "corrplot",
  "GGally",
  "Matrix",
  "purrr",
  "tools"
))
```

## Usage

Run the scripts in numerical order:

```bash
# Using Rscript from command line
Rscript 01_load_and_eda.R
Rscript 02_merge_datasets.R
Rscript 03_prepare_modeling_df.R
Rscript 04_arima_modeling.R
Rscript 05_regularization_modeling.R
Rscript 06_model_evaluation.R
```

Or run interactively in RStudio by opening each script and executing.

### Output

The scripts generate:
- **Plots/** - Visualizations for EDA, model diagnostics, and forecasts
- **Processed_Data/** - Cleaned and transformed datasets
- **Models/** - Saved model objects
- **Final_Results/** - Forecast outputs and comprehensive reports

## Model Performance

| Model       | MSE    | RMSE | R-Squared     |
|-------------|--------|------|---------------|
| ARIMA       | 202.13 | 14.22| Not applicable|
| Ridge       | 1.05   | 1.02 | 0.9888        |
| Lasso       | 0.54   | 0.74 | 0.9942        |
| Elastic Net | 0.51   | 0.71 | 0.9946        |

**Best Model:** Elastic Net (lowest MSE, highest R-squared)

## Data Sources

- **State Bank of Pakistan (SBP)** - CPI, exchange rates, monetary aggregates
- **Food and Agriculture Organization (FAO)** - Global food price indices
- **Federal Reserve Economic Data (FRED)** - International oil prices
- **Pakistan Ministry of Finance** - Fiscal and economic indicators

## Authors

- M. Abdullah Ali (23I-2523)
- Abdullah Aaamir (23I-2538)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.
