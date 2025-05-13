# Pakistan Inflation Forecasting Project

This project implements a comprehensive forecasting system for Pakistan's inflation using time series and regularization models. The system analyzes historical Consumer Price Index (CPI) data along with various economic indicators to predict future inflation trends.

## Project Structure

The project consists of six core R scripts that form a complete forecasting pipeline:

1. **01_load_and_eda.R**: Loads raw data and performs exploratory data analysis
2. **02_merge_datasets.R**: Merges multiple datasets into a single analysis dataset
3. **03_prepare_modeling_df.R**: Prepares the modeling dataframe with feature engineering and train-test split
4. **04_arima_modeling.R**: Implements ARIMA time series modeling
5. **05_regularization_modeling.R**: Implements Ridge, Lasso, and Elastic Net regularization models
6. **06_model_evaluation.R**: Evaluates all models, selects the best one, and generates final forecasts

Additional scripts provide enhanced functionality:

- **07_missing_value_handling.R**: Advanced techniques for handling missing values
- **08_train_test_split_sensitivity.R**: Sensitivity analysis for different train-test split ratios
- **09_rolling_window_validation.R**: Rolling window validation for time series models
- **10_forecast_uncertainty.R**: Quantification of forecast uncertainty
- **11_interactive_visualizations.R**: Interactive visualizations of forecasts
- **12_web_search.R**: Web search capability for retrieving external data
- **13_data_collection.R**: Additional data collection utilities

## Directory Structure

```
├── R Scripts (at root level)
├── Logs/                  # Log files from script execution
├── Output/                # Output files including merged datasets
├── Processed_Data/        # Processed datasets ready for modeling
├── Plots/                 # Visualizations and plots
│   ├── eda/               # Exploratory data analysis plots
│   ├── model_prep/        # Model preparation plots
│   ├── arima/             # ARIMA model plots
│   ├── regularization/    # Regularization model plots
│   └── evaluation/        # Model evaluation plots
├── Models/                # Saved model objects
├── Final_Results/         # Final forecasts and reports
└── Documentation/         # Project documentation
```

## Key Features

- **Comprehensive Data Analysis**: Thorough exploration of Pakistan's economic indicators
- **Multiple Modeling Approaches**: ARIMA time series and regularization techniques (Ridge, Lasso, Elastic Net)
- **Train-Test Split Sensitivity**: Analysis of different train-test split ratios to find optimal configuration
- **Feature Importance Analysis**: Identification of key drivers of inflation
- **Forecast Uncertainty Quantification**: Confidence intervals and prediction bounds
- **Detailed Reporting**: Comprehensive reports with actionable insights

## Running the Project

The scripts should be run in numerical order:

```r
# Example using Rscript
Rscript 01_load_and_eda.R
Rscript 02_merge_datasets.R
# ... and so on
```

## Requirements

The project requires the following R packages:

- dplyr
- ggplot2
- forecast
- glmnet
- readr
- lubridate
- stringr
- gridExtra
- reshape2
- knitr
- tibble

## Results

The final results include:

1. Comparative analysis of different forecasting models
2. Identification of the best performing model based on RMSE
3. 12-month forecast of Pakistan's inflation
4. Comprehensive report with insights and recommendations
5. Visualizations of historical trends and future forecasts

## License

This project is provided for educational and research purposes only.
