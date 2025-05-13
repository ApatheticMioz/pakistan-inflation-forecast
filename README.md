# Pakistan Inflation Forecasting Project

## Project Overview

This project implements a comprehensive forecasting system for Pakistan's inflation using time series and regularization models. The system analyzes historical Consumer Price Index (CPI) data along with various economic indicators to predict future inflation trends.

The project focuses on four specific modeling approaches:
1. ARIMA (AutoRegressive Integrated Moving Average)
2. Ridge Regression
3. Lasso Regression
4. Elastic Net Regression

## Project Structure

The project consists of exactly six core R scripts that form a complete forecasting pipeline:

1. **01_load_and_eda.R**: Loads raw data and performs exploratory data analysis
   - Imports multiple datasets from the Data folder
   - Performs data cleaning and validation
   - Conducts exploratory data analysis with visualizations
   - Identifies patterns and relationships in the data

2. **02_merge_datasets.R**: Merges multiple datasets into a single analysis dataset
   - Aligns datasets on common date fields
   - Handles missing values and inconsistencies
   - Creates a unified dataset for modeling
   - Saves the merged dataset as merged_df.rds

3. **03_prepare_modeling_df.R**: Prepares the modeling dataframe with feature engineering and train-test split
   - Performs feature engineering and transformation
   - Standardizes variables for regularization models
   - Creates time series objects for ARIMA modeling
   - Implements an 80-20 train-test split

4. **04_arima_modeling.R**: Implements ARIMA time series modeling
   - Tests for stationarity and applies differencing if needed
   - Uses auto.arima() to identify optimal parameters
   - Provides the complete mathematical equation for the ARIMA model
   - Evaluates model performance using MSE on the test set

5. **05_regularization_modeling.R**: Implements Ridge, Lasso, and Elastic Net regularization models
   - Provides mathematical equations for all regularization techniques
   - Uses cross-validation to select optimal hyperparameters
   - Analyzes feature importance across models
   - Includes forecast uncertainty quantification with prediction intervals

6. **06_model_evaluation.R**: Evaluates all models, selects the best one, and generates final forecasts
   - Compares all models using MSE as the primary metric
   - Creates visualizations of model performance
   - Selects the best model based on MSE and error distribution
   - Generates 12-month forecasts with prediction intervals
   - Produces a comprehensive final report

## Directory Structure

```
├── R Scripts (at root level)
├── Data/                  # Raw data files
├── Logs/                  # Log files from script execution
├── Output/                # Output files including merged datasets
├── Processed_Data/        # Processed datasets ready for modeling
│   └── uncertainty/       # Forecast uncertainty data
├── Plots/                 # Visualizations and plots
│   ├── eda/               # Exploratory data analysis plots
│   ├── model_prep/        # Model preparation plots
│   ├── arima/             # ARIMA model plots
│   ├── regularization/    # Regularization model plots
│   ├── uncertainty/       # Forecast uncertainty plots
│   └── evaluation/        # Model evaluation plots
├── Models/                # Saved model objects
├── Final_Results/         # Final forecasts and reports
└── Documentation/         # Project documentation
```

## Mathematical Models

### ARIMA Model

The ARIMA(p,d,q) model is defined as:

For non-differenced series (d=0):
```
Y_t = μ + φ₁Y_{t-1} + φ₂Y_{t-2} + ... + φ_pY_{t-p} + ε_t + θ₁ε_{t-1} + θ₂ε_{t-2} + ... + θ_qε_{t-q}
```

For first-differenced series (d=1):
```
ΔY_t = Y_t - Y_{t-1} = μ + φ₁ΔY_{t-1} + φ₂ΔY_{t-2} + ... + φ_pΔY_{t-p} + ε_t + θ₁ε_{t-1} + θ₂ε_{t-2} + ... + θ_qε_{t-q}
```

Where:
- Y_t is the value at time t
- μ is the intercept
- φ₁...φ_p are the AR coefficients
- θ₁...θ_q are the MA coefficients
- ε_t is the error term at time t

### Ridge Regression

Ridge regression minimizes:
```
β_ridge = argmin_β { ||y - Xβ||² + λ||β||² }
```

Where:
- ||y - Xβ||² is the sum of squared residuals (RSS)
- λ||β||² is the L2 penalty term (sum of squared coefficients)
- λ is the regularization parameter that controls the strength of the penalty

### Lasso Regression

Lasso regression minimizes:
```
β_lasso = argmin_β { ||y - Xβ||² + λ||β||₁ }
```

Where:
- ||y - Xβ||² is the sum of squared residuals (RSS)
- λ||β||₁ is the L1 penalty term (sum of absolute values of coefficients)
- λ is the regularization parameter that controls the strength of the penalty

### Elastic Net Regression

Elastic Net regression minimizes:
```
β_elastic = argmin_β { ||y - Xβ||² + λ[(1-α)||β||² + α||β||₁] }
```

Where:
- ||y - Xβ||² is the sum of squared residuals (RSS)
- λ is the overall regularization parameter
- α controls the mix between L1 (Lasso) and L2 (Ridge) penalties:
  - α = 0: Ridge regression (only L2 penalty)
  - α = 1: Lasso regression (only L1 penalty)
  - 0 < α < 1: Elastic Net (mixture of L1 and L2 penalties)

## Model Evaluation

All models are evaluated using Mean Squared Error (MSE) on the test set:
```
MSE = (1/n) * Σ(y_i - ŷ_i)²
```

Where:
- n is the number of observations in the test set
- y_i is the actual value
- ŷ_i is the predicted value

## Running the Project

The scripts should be run in numerical order:

```r
# Example using Rscript
Rscript 01_load_and_eda.R
Rscript 02_merge_datasets.R
Rscript 03_prepare_modeling_df.R
Rscript 04_arima_modeling.R
Rscript 05_regularization_modeling.R
Rscript 06_model_evaluation.R
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
- tseries
- zoo

## Results

The final results include:

1. Comparative analysis of different forecasting models (ARIMA, Ridge, Lasso, Elastic Net)
2. Identification of the best performing model based on MSE
3. 12-month forecast of Pakistan's inflation with prediction intervals
4. Comprehensive report with insights and recommendations
5. Visualizations of historical trends and future forecasts
6. Feature importance analysis identifying key drivers of inflation

## License

This project is provided for educational and research purposes only.
