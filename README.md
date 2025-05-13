# Pakistan Inflation Forecasting Project

## Project Overview

This project implements a comprehensive forecasting system for Pakistan's inflation using time series and regularization models. The system analyzes historical Consumer Price Index (CPI) data along with various economic indicators to predict future inflation trends.

### Authors
- M. Abdullah Ali (23I-2523)
- Abdullah Aaamir (23I-2538)

### Modeling Approaches
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

## Results and Interpretation

### Model Performance

The models were evaluated using Mean Squared Error (MSE) as the primary metric:

| Model       | MSE      | R-Squared  |
|-------------|----------|------------|
| ARIMA       | 206.43   | NA         |
| Ridge       | 177.86   | -0.904     |
| Lasso       | 177.86   | -0.904     |
| Elastic Net | 177.86   | -0.904     |

**Interpretation:**
- Ridge, Lasso, and Elastic Net models all performed identically with an MSE of 177.86, outperforming the ARIMA model (MSE of 206.43).
- The negative R-squared values indicate that the models performed worse than a simple mean-based model on the test set, suggesting high volatility in the data.
- All regularization models converged to the same solution, indicating that the dataset likely has limited predictive features.

### Error Analysis

| Model       | Mean Error | Median Error | Error Variance | Error Range |
|-------------|------------|--------------|----------------|-------------|
| ARIMA       | -10.63     | -8.50        | 94.09          | 29.40       |
| Ridge       | 5.65       | 8.18         | 146.94         | 37.09       |
| Lasso       | 5.65       | 8.18         | 146.94         | 37.09       |
| Elastic Net | 5.65       | 8.18         | 146.94         | 37.09       |

**Interpretation:**
- ARIMA tends to overestimate inflation (negative mean error), while regularization models underestimate it.
- ARIMA has lower error variance, indicating more consistent predictions, despite having a higher overall MSE.
- The regularization models show identical error patterns, confirming they converged to the same solution.

### Forecasts

12-month inflation forecasts (May 2025 - April 2026):

| Date       | ARIMA | ARIMA Lower | ARIMA Upper | Ridge  |
|------------|-------|-------------|-------------|--------|
| 2025-05-01 | 29.20 | 27.75       | 30.65       | 18.09  |
| 2025-06-01 | 29.20 | 27.15       | 31.25       | 18.09  |
| 2025-07-01 | 29.20 | 26.69       | 31.71       | 18.09  |
| 2025-08-01 | 29.20 | 26.30       | 32.10       | 18.09  |
| 2025-09-01 | 29.20 | 25.96       | 32.44       | 18.09  |
| 2025-10-01 | 29.20 | 25.65       | 32.75       | 18.09  |
| 2025-11-01 | 29.20 | 25.37       | 33.03       | 18.09  |
| 2025-12-01 | 29.20 | 25.10       | 33.30       | 18.09  |
| 2026-01-01 | 29.20 | 24.86       | 33.54       | 18.09  |
| 2026-02-01 | 29.20 | 24.62       | 33.78       | 18.09  |
| 2026-03-01 | 29.20 | 24.40       | 34.00       | 18.09  |
| 2026-04-01 | 29.20 | 24.18       | 34.22       | 18.09  |

**Interpretation:**
- ARIMA forecasts consistently higher inflation (29.20%) compared to Ridge (18.09%).
- ARIMA prediction intervals widen over time, reflecting increasing uncertainty in longer-term forecasts.
- Ridge model produces a constant forecast due to limited predictors and the simplified approach used for regularization forecasts.
- The significant difference between ARIMA and Ridge forecasts highlights the uncertainty in Pakistan's inflation outlook.

### Key Findings

1. **Best Model**: Ridge regression was identified as the best model based on MSE, though all regularization models performed identically.
2. **Forecast Divergence**: The substantial difference between time series and regression forecasts suggests high uncertainty in Pakistan's economic outlook.
3. **Prediction Intervals**: ARIMA prediction intervals widen over time, indicating increasing uncertainty for longer-term forecasts.
4. **Model Limitations**: The negative R-squared values and identical regularization results suggest limitations in the available predictors.

### Recommendations

1. **Data Enhancement**: Incorporate additional economic indicators and higher frequency data to improve model performance.
2. **Model Refinement**: Explore more sophisticated time series models and feature engineering techniques.
3. **Regular Updates**: Update models as new data becomes available to maintain forecast accuracy.
4. **Ensemble Approach**: Consider combining forecasts from different models to potentially improve accuracy.

## License

This project is provided for educational and research purposes only.
