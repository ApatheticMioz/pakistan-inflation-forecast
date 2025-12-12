# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - Initial Archival Release

### Added
- Complete inflation forecasting pipeline with 6 R scripts
- ARIMA time series modeling (`04_arima_modeling.R`)
- Regularization models: Ridge, Lasso, Elastic Net (`05_regularization_modeling.R`)
- Comprehensive data loading and EDA (`01_load_and_eda.R`)
- Dataset merging and feature engineering (`02_merge_datasets.R`)
- Model preparation and train-test split (`03_prepare_modeling_df.R`)
- Model evaluation and comparison (`06_model_evaluation.R`)
- Economic indicator datasets from multiple sources (SBP, FAO, FRED)
- Detailed documentation and README
- MIT License
- Contributing guidelines
- Editor configuration for consistent code style

### Data Sources
- State Bank of Pakistan (SBP) EasyData portal
- Food and Agriculture Organization (FAO)
- Federal Reserve Economic Data (FRED)
- Pakistan Ministry of Finance

### Models Implemented
- ARIMA (AutoRegressive Integrated Moving Average)
- Ridge Regression
- Lasso Regression
- Elastic Net Regression

### Project Status
- Repository standardized for public archival
- All scripts tested and documented
