# Web Search Data for Pakistan Inflation Forecasting

This directory contains data extracted from web searches related to Pakistan's economic indicators.

## Contents

1. **cpi_data.csv** - Consumer Price Index data
2. **interest_rates_data.csv** - State Bank of Pakistan policy interest rates
3. **economic_indicators_data.csv** - General economic indicators
4. **exchange_rate_data.csv** - Pakistani rupee exchange rate data
5. **food_prices_data.csv** - Food price inflation statistics
6. **combined_web_data.csv** - Combined dataset with all extracted data
7. **search_results_summary.csv** - Summary of search queries and results

## Notes

- This data was extracted automatically from web sources
- The data is simulated for demonstration purposes
- In a real implementation, this would contain actual data from the web
- Use with caution and verify with official sources before making decisions

## Usage

To use this data in the Pakistan Inflation Forecasting project:

1. Load the combined dataset:
```r
web_data <- read.csv("Data/web_search/combined_web_data.csv")
```

2. Merge with existing datasets:
```r
merged_df <- merge(your_existing_data, web_data, by = "date", all = TRUE)
```

Created on 2025-05-13
