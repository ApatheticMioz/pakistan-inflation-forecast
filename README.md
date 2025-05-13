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

| Model       | MSE      | RMSE     | R-Squared |
|-------------|----------|----------|-----------|
| ARIMA       | 202.13   | NA       | NA        |
| Ridge       | 1.05     | 1.02     | 0.9888    |
| Lasso       | 0.54     | 0.74     | 0.9942    |
| Elastic Net | 0.51     | 0.71     | 0.9946    |

**Interpretation:**
- Elastic Net performed the best with the lowest MSE (0.51) and highest R-squared (0.9946), followed closely by Lasso.
- Ridge regression performed well but had approximately twice the MSE of Elastic Net.
- ARIMA performed significantly worse than the regularization models, with an MSE of 202.13.
- The high R-squared values for regularization models indicate they explain over 98% of the variance in the test set.
- Elastic Net's superior performance suggests it found the optimal balance between Ridge and Lasso penalties.

### Error Analysis

| Model       | Mean Error | Median Error | Error Variance | Error Range |
|-------------|------------|--------------|----------------|-------------|
| ARIMA       | -10.41     | -8.50        | 94.44          | 29.40       |
| Ridge       | -0.25      | -0.15        | 0.99           | 5.79        |
| Lasso       | -0.19      | 0.06         | 0.51           | 4.43        |
| Elastic Net | -0.21      | 0.03         | 0.47           | 4.62        |

**Interpretation:**
- ARIMA consistently overestimates inflation (negative mean error of -10.41).
- Regularization models have much smaller mean errors, with Lasso and Elastic Net being closest to zero.
- Elastic Net has the lowest error variance (0.47), indicating more consistent predictions.
- The error range for regularization models is significantly smaller than for ARIMA, showing more stable predictions.
- Lasso and Elastic Net have slightly positive median errors, suggesting they slightly underestimate inflation about half the time.

### Feature Importance

| Variable                | Avg. Importance |
|-------------------------|----------------|
| cpi_value_ma3_std       | 6.09           |
| cpi_value_lag1_std      | 1.37           |
| cpi_value_ma6_std       | 0.90           |
| oil_prices_oil_price_std| 0.08           |

**Interpretation:**
- The 3-month moving average of CPI (cpi_value_ma3_std) is by far the most important predictor.
- The 1-month lag of CPI (cpi_value_lag1_std) is the second most important feature.
- The 6-month moving average of CPI (cpi_value_ma6_std) also contributes significantly.
- Oil prices have a small but measurable impact on inflation predictions.
- The importance of lagged and moving average CPI values suggests strong autocorrelation in the inflation time series.

### Forecasts

12-month inflation forecasts (May 2025 - April 2026):

| Date       | ARIMA | ARIMA Lower | ARIMA Upper | Elastic Net |
|------------|-------|-------------|-------------|-------------|
| 2025-05-01 | 29.20 | 27.73       | 30.67       | 1.20        |
| 2025-06-01 | 29.20 | 27.13       | 31.27       | 1.20        |
| 2025-07-01 | 29.20 | 26.66       | 31.74       | 1.20        |
| 2025-08-01 | 29.20 | 26.27       | 32.13       | 1.20        |
| 2025-09-01 | 29.20 | 25.92       | 32.48       | 1.20        |
| 2025-10-01 | 29.20 | 25.61       | 32.79       | 1.20        |
| 2025-11-01 | 29.20 | 25.32       | 33.08       | 1.20        |
| 2025-12-01 | 29.20 | 25.06       | 33.34       | 1.20        |
| 2026-01-01 | 29.20 | 24.80       | 33.60       | 1.20        |
| 2026-02-01 | 29.20 | 24.57       | 33.83       | 1.20        |
| 2026-03-01 | 29.20 | 24.34       | 34.06       | 1.20        |
| 2026-04-01 | 29.20 | 24.12       | 34.28       | 1.20        |

**Interpretation:**
- There is a dramatic difference between ARIMA forecasts (29.20%) and Elastic Net forecasts (1.20%).
- ARIMA predicts consistently high inflation, while Elastic Net predicts very low inflation.
- ARIMA prediction intervals widen over time, reflecting increasing uncertainty in longer-term forecasts.
- The Elastic Net model produces a constant forecast due to the simplified approach used for regularization forecasts.
- The large discrepancy between models highlights the uncertainty in Pakistan's inflation outlook and the limitations of the current forecasting approach.

### Key Findings

1. **Best Model**: Elastic Net regression was identified as the best model based on MSE (0.51) and R-squared (0.9946).
2. **Feature Importance**: Previous inflation values (moving averages and lags) are the strongest predictors of future inflation.
3. **Forecast Divergence**: The substantial difference between ARIMA and Elastic Net forecasts suggests high uncertainty in Pakistan's economic outlook.
4. **Model Stability**: Regularization models, especially Elastic Net, show more stable error patterns compared to ARIMA.
5. **Prediction Intervals**: ARIMA prediction intervals widen over time, indicating increasing uncertainty for longer-term forecasts.

### Detailed Interpretation of Results

### Coefficient Interpretation

Since the variables are standardized, the coefficients represent the effect of a one standard deviation change in the predictor on the target variable (CPI). Converting to the original scale:

For the Elastic Net model (best performer):
- **3-month moving average of CPI**: A 1 percentage point increase is associated with a 7.07 percentage point increase in current CPI, indicating strong momentum effects in inflation.
- **Previous month's CPI**: A 1 percentage point increase is associated with a 1.40 percentage point increase in current CPI, showing the importance of recent inflation trends.
- **6-month moving average of CPI**: A 1 percentage point increase is associated with a 0.04 percentage point increase in current CPI, suggesting longer-term trends have a smaller but still positive effect.
- **Oil prices**: While included in the Ridge model, this variable has a relatively small effect, with a coefficient of 0.23 in standardized units.

### Model Performance Analysis

- **Elastic Net vs. Lasso**: Elastic Net slightly outperformed Lasso, suggesting that a combination of L1 and L2 penalties provides the optimal balance for this dataset.
- **Ridge vs. Lasso/Elastic Net**: Ridge performed well but not as well as the other regularization models, indicating that some feature selection (setting coefficients to zero) improves model performance.
- **ARIMA Performance**: The poor performance of ARIMA (MSE of 202.13) compared to regularization models (MSE < 1.05) is likely due to:
  1. Different evaluation approaches (raw vs. standardized data)
  2. ARIMA's inability to incorporate external economic indicators
  3. The simplicity of the selected ARIMA model

### Forecast Divergence

The large difference in forecasts between ARIMA (29.20%) and Elastic Net (1.20%) highlights:
1. The uncertainty in long-term forecasting
2. Different assumptions about inflation persistence
3. The value of incorporating multiple predictors in the regularization models

## Recommendations

1. **Improve ARIMA Modeling**: Consider transforming the data or trying more complex ARIMA models to improve performance and enable fairer comparison with regularization models.

2. **Data Enhancement**: Incorporate additional economic indicators such as fiscal indicators, remittances, and more detailed sectoral data to improve model accuracy.

3. **Predictor Forecasting**: Implement more sophisticated forecasting techniques for the predictor variables to improve the accuracy of regularization model forecasts.

4. **Ensemble Methods**: Consider combining forecasts from different models to potentially improve forecast accuracy, especially given the large divergence between model forecasts.

5. **Regular Updates**: Update the models regularly as new data becomes available to maintain forecast accuracy.

6. **Alternative Models**: Explore additional modeling approaches such as VAR (Vector Autoregression) or machine learning methods for comparison.

## License

This project is provided for educational and research purposes only.
