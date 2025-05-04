# Data Summary Report (v5 - Shape-Based Rotation)
Generated on: 2025-05-04 21:34:47 

---

## Overview
This report summarizes CSV datasets found in the directory: `D:\work\Semester4\AdvStats\pakistan-inflation-forecast\Data`.
**Processing Approach:** The script reads each CSV.
  * **If columns > rows:** The file is treated as **Wide**. It's **transposed**, using the first original column as the new index (containing series names), and the original column headers (likely time periods) become the new row index.
  * **If rows >= columns:** The file is treated as **Tall** and analyzed in its original format.
Type conversion (to numeric/datetime) is attempted after determining the format.
**Content:** Includes processing notes (indicating format handling: Tall or Wide/Transposed), original column names, basic info, memory usage, missing values, unique values, value counts, distribution stats, date analysis (if applicable), correlation summary, and a **detailed summary table for the columns being analyzed**.

---


## Analysis for: `CMO_historical_data_indices.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (787, 17) (rows, columns)
* **Format:** Detected **Tall** (Rows=787 >= Cols=17). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Unnamed: 1`: object -> float64, `Unnamed: 2`: object -> float64, `Unnamed: 3`: object -> float64, `Unnamed: 4`: object -> float64, `Unnamed: 5`: object -> float64, `Unnamed: 6`: object -> float64, `Unnamed: 7`: object -> float64, `Unnamed: 8`: object -> float64, `Unnamed: 9`: object -> float64, `Unnamed: 10`: object -> float64, `Unnamed: 11`: object -> float64, `Unnamed: 12`: object -> float64, `Unnamed: 13`: object -> float64, `Unnamed: 14`: object -> float64, `Unnamed: 15`: object -> float64, `Unnamed: 16`: object -> float64
* **Shape Analyzed:** (787, 17) (rows, columns)

* **Original Column Names (17):**
  ```
  ['World Bank Commodity Price Data (The Pink Sheet)', 'Unnamed: 1', 'Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4', 'Unnamed: 5', 'Unnamed: 6', 'Unnamed: 7', 'Unnamed: 8', 'Unnamed: 9', 'Unnamed: 10', 'Unnamed: 11', 'Unnamed: 12', 'Unnamed: 13', 'Unnamed: 14', 'Unnamed: 15', 'Unnamed: 16']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 13,379
* **Data Types Summary:** {dtype('float64'): 16, dtype('O'): 1}

### Memory Usage (Bytes)

* **Total:** 151,146 Bytes
* **Per Analyzed Column + Index:**
```
Index                                                6296
World Bank Commodity Price Data (The Pink Sheet)    44114
Unnamed: 1                                           6296
Unnamed: 2                                           6296
Unnamed: 3                                           6296
Unnamed: 4                                           6296
Unnamed: 5                                           6296
Unnamed: 6                                           6296
Unnamed: 7                                           6296
Unnamed: 8                                           6296
Unnamed: 9                                           6296
Unnamed: 10                                          6296
Unnamed: 11                                          6296
Unnamed: 12                                          6296
Unnamed: 13                                          6296
Unnamed: 14                                          6296
Unnamed: 15                                          6296
Unnamed: 16                                          6296
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 787 entries, 0 to 787
Data columns (total 17 columns):
 #   Column                                            Non-Null Count  Dtype  
---  ------                                            --------------  -----  
 0   World Bank Commodity Price Data (The Pink Sheet)  783 non-null    object 
 1   Unnamed: 1                                        780 non-null    float64
 2   Unnamed: 2                                        780 non-null    float64
 3   Unnamed: 3                                        780 non-null    float64
 4   Unnamed: 4                                        780 non-null    float64
 5   Unnamed: 5                                        780 non-null    float64
 6   Unnamed: 6                                        780 non-null    float64
 7   Unnamed: 7                                        780 non-null    float64
 8   Unnamed: 8                                        780 non-null    float64
 9   Unnamed: 9                                        780 non-null    float64
 10  Unnamed: 10                                       780 non-null    float64
 11  Unnamed: 11                                       780 non-null    float64
 12  Unnamed: 12                                       780 non-null    float64
 13  Unnamed: 13                                       780 non-null    float64
 14  Unnamed: 14                                       780 non-null    float64
 15  Unnamed: 15                                       780 non-null    float64
 16  Unnamed: 16                                       780 non-null    float64
dtypes: float64(16), object(1)
memory usage: 110.7+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 116 (0.87%)
Columns (17 of 17) with missing values (Sorted):
```
Unnamed: 8                                          7
Unnamed: 9                                          7
Unnamed: 15                                         7
Unnamed: 14                                         7
Unnamed: 13                                         7
Unnamed: 12                                         7
Unnamed: 11                                         7
Unnamed: 10                                         7
Unnamed: 16                                         7
Unnamed: 1                                          7
Unnamed: 7                                          7
Unnamed: 6                                          7
Unnamed: 5                                          7
Unnamed: 4                                          7
Unnamed: 3                                          7
Unnamed: 2                                          7
World Bank Commodity Price Data (The Pink Sheet)    4
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 17):
```
World Bank Commodity Price Data (The Pink Sheet)    783
Unnamed: 1                                          699
Unnamed: 2                                          578
Unnamed: 3                                          708
Unnamed: 4                                          711
Unnamed: 5                                          729
Unnamed: 6                                          738
Unnamed: 7                                          733
Unnamed: 8                                          725
Unnamed: 9                                          748
Unnamed: 10                                         705
Unnamed: 11                                         637
Unnamed: 12                                         725
Unnamed: 13                                         585
Unnamed: 14                                         728
Unnamed: 15                                         729
Unnamed: 16                                         665
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `World Bank Commodity Price Data (The Pink Sheet)`** (Top 20 of 783 unique values)
```
World Bank Commodity Price Data (The Pink Sheet)
monthly indices based on nominal US dollars, 2010=100, 1960 to present    1
2004M08                                                                   1
2002M10                                                                   1
2002M11                                                                   1
2002M12                                                                   1
2003M01                                                                   1
2003M02                                                                   1
2003M03                                                                   1
2003M04                                                                   1
2003M05                                                                   1
2003M06                                                                   1
2003M07                                                                   1
2003M08                                                                   1
2003M09                                                                   1
2003M10                                                                   1
2003M11                                                                   1
2003M12                                                                   1
2004M01                                                                   1
2004M02                                                                   1
2004M03                                                                   1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                                                  | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean   | StdDev   | Min    | 25%    | 50%    | 75%    | Max     | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                                                           | LastNonNull   |
|:-------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|:-------|:---------|:-------|:-------|:-------|:-------|:--------|:-----------|:-----------|:----------|:----------|:-----------------------------------------------------------------------|:--------------|
| World Bank Commodity Price Data (The Pink Sheet) | object     |            783 |           4 | 0.51%     |           783 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A     | N/A        | N/A        | NaT       | NaT       | monthly indices based on nominal US dollars, 2010=100, 1960 to present | 2024M12       |
| Unnamed: 1                                       | float64    |            780 |           7 | 0.89%     |           699 | 48.802 | 36.866   | 7.330  | 24.467 | 37.275 | 72.530 | 157.980 | 0.942      | -0.009     | NaT       | NaT       | 7.64                                                                   | 103.02        |
| Unnamed: 2                                       | float64    |            780 |           7 | 0.89%     |           578 | 44.633 | 41.284   | 1.810  | 15.230 | 29.800 | 70.002 | 173.480 | 1.055      | 0.240      | NaT       | NaT       | 2.13                                                                   | 96.5          |
| Unnamed: 3                                       | float64    |            780 |           7 | 0.89%     |           708 | 57.260 | 29.239   | 17.860 | 41.020 | 50.165 | 79.913 | 138.670 | 0.625      | -0.457     | NaT       | NaT       | 18.82                                                                  | 116.24        |
| Unnamed: 4                                       | float64    |            780 |           7 | 0.89%     |           711 | 61.624 | 28.100   | 20.770 | 46.995 | 57.105 | 82.750 | 130.370 | 0.418      | -0.548     | NaT       | NaT       | 22.03                                                                  | 121.08        |
| Unnamed: 5                                       | float64    |            780 |           7 | 0.89%     |           729 | 64.712 | 31.716   | 20.640 | 38.733 | 64.890 | 86.005 | 231.800 | 0.797      | 1.609      | NaT       | NaT       | 25.44                                                                  | 231.8         |
| Unnamed: 6                                       | float64    |            780 |           7 | 0.89%     |           738 | 63.474 | 30.653   | 19.790 | 46.105 | 57.045 | 85.347 | 153.070 | 0.638      | -0.301     | NaT       | NaT       | 21.19                                                                  | 115.05        |
| Unnamed: 7                                       | float64    |            780 |           7 | 0.89%     |           733 | 61.939 | 31.083   | 20.510 | 41.763 | 55.635 | 78.608 | 172.760 | 0.841      | 0.132      | NaT       | NaT       | 23.17                                                                  | 108.49        |
| Unnamed: 8                                       | float64    |            780 |           7 | 0.89%     |           725 | 67.269 | 32.577   | 22.380 | 46.965 | 60.645 | 84.547 | 169.040 | 0.853      | 0.233      | NaT       | NaT       | 23.58                                                                  | 109.65        |
| Unnamed: 9                                       | float64    |            780 |           7 | 0.89%     |           748 | 62.057 | 30.936   | 15.330 | 40.930 | 58.795 | 88.243 | 136.480 | 0.337      | -0.761     | NaT       | NaT       | 16.44                                                                  | 128.57        |
| Unnamed: 10                                      | float64    |            780 |           7 | 0.89%     |           705 | 55.559 | 25.801   | 18.670 | 36.008 | 55.045 | 78.067 | 134.560 | 0.202      | -0.695     | NaT       | NaT       | 22.33                                                                  | 79.41         |
| Unnamed: 11                                      | float64    |            780 |           7 | 0.89%     |           637 | 59.838 | 30.782   | 15.270 | 31.320 | 62.295 | 87.230 | 125.140 | 0.009      | -1.306     | NaT       | NaT       | 16.24                                                                  | 78.66         |
| Unnamed: 12                                      | float64    |            780 |           7 | 0.89%     |           725 | 50.879 | 22.458   | 18.770 | 37.115 | 48.605 | 64.763 | 159.290 | 0.927      | 1.872      | NaT       | NaT       | 29.0                                                                   | 80.24         |
| Unnamed: 13                                      | float64    |            780 |           7 | 0.89%     |           585 | 55.769 | 48.089   | 8.330  | 29.282 | 36.990 | 75.120 | 293.730 | 1.888      | 4.061      | NaT       | NaT       | 12.86                                                                  | 119.61        |
| Unnamed: 14                                      | float64    |            780 |           7 | 0.89%     |           728 | 48.480 | 31.565   | 12.150 | 26.170 | 36.850 | 72.165 | 141.280 | 0.900      | -0.345     | NaT       | NaT       | 12.9                                                                   | 105.95        |
| Unnamed: 15                                      | float64    |            780 |           7 | 0.89%     |           729 | 52.054 | 32.206   | 13.220 | 28.858 | 40.750 | 78.132 | 149.890 | 0.826      | -0.433     | NaT       | NaT       | 14.07                                                                  | 114.29        |
| Unnamed: 16                                      | float64    |            780 |           7 | 0.89%     |           665 | 46.935 | 45.441   | 3.270  | 14.315 | 29.415 | 74.620 | 203.360 | 1.198      | 0.393      | NaT       | NaT       | 3.27                                                                   | 199.01        |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 99 pairs with absolute correlation > 0.8 (showing top 50):*
```
Unnamed: 14  Unnamed: 15    0.996716
Unnamed: 1   Unnamed: 2     0.995924
Unnamed: 3   Unnamed: 4     0.990441
Unnamed: 4   Unnamed: 6     0.989511
Unnamed: 3   Unnamed: 6     0.985609
Unnamed: 6   Unnamed: 7     0.984769
             Unnamed: 8     0.979595
Unnamed: 10  Unnamed: 11    0.975229
Unnamed: 4   Unnamed: 7     0.970951
Unnamed: 3   Unnamed: 14    0.968544
             Unnamed: 7     0.967426
Unnamed: 1   Unnamed: 3     0.965988
Unnamed: 3   Unnamed: 15    0.963838
Unnamed: 7   Unnamed: 8     0.963406
Unnamed: 4   Unnamed: 9     0.959712
             Unnamed: 8     0.959599
Unnamed: 3   Unnamed: 9     0.956614
Unnamed: 6   Unnamed: 9     0.955865
Unnamed: 3   Unnamed: 8     0.954675
Unnamed: 1   Unnamed: 14    0.948766
             Unnamed: 6     0.948547
             Unnamed: 4     0.945806
Unnamed: 4   Unnamed: 12    0.943817
Unnamed: 10  Unnamed: 12    0.943438
Unnamed: 2   Unnamed: 3     0.938729
Unnamed: 1   Unnamed: 15    0.938700
Unnamed: 3   Unnamed: 12    0.937368
Unnamed: 1   Unnamed: 7     0.932882
Unnamed: 3   Unnamed: 16    0.929576
Unnamed: 1   Unnamed: 8     0.926918
Unnamed: 2   Unnamed: 14    0.926724
Unnamed: 4   Unnamed: 14    0.926620
Unnamed: 6   Unnamed: 14    0.926209
Unnamed: 9   Unnamed: 16    0.925840
Unnamed: 4   Unnamed: 10    0.924947
Unnamed: 6   Unnamed: 16    0.923367
Unnamed: 4   Unnamed: 15    0.921822
Unnamed: 2   Unnamed: 6     0.920515
Unnamed: 4   Unnamed: 16    0.920303
Unnamed: 6   Unnamed: 15    0.919282
Unnamed: 3   Unnamed: 10    0.917979
Unnamed: 2   Unnamed: 4     0.915182
             Unnamed: 15    0.914956
Unnamed: 6   Unnamed: 12    0.911390
Unnamed: 9   Unnamed: 15    0.911010
Unnamed: 1   Unnamed: 9     0.910448
Unnamed: 9   Unnamed: 14    0.908401
Unnamed: 8   Unnamed: 13    0.908289
Unnamed: 7   Unnamed: 14    0.907619
Unnamed: 2   Unnamed: 7     0.905970
```


---


## Analysis for: `CMO_historical_data_monthly.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (785, 72) (rows, columns)
* **Format:** Detected **Tall** (Rows=785 >= Cols=72). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Unnamed: 1`: object -> float64, `Unnamed: 2`: object -> float64, `Unnamed: 3`: object -> float64, `Unnamed: 4`: object -> float64, `Unnamed: 5`: object -> float64, `Unnamed: 6`: object -> float64, `Unnamed: 7`: object -> float64, `Unnamed: 8`: object -> float64, `Unnamed: 9`: object -> float64, `Unnamed: 10`: object -> float64, `Unnamed: 11`: object -> float64, `Unnamed: 12`: object -> float64, `Unnamed: 13`: object -> float64, `Unnamed: 14`: object -> float64, `Unnamed: 15`: object -> float64, `Unnamed: 16`: object -> float64, `Unnamed: 17`: object -> float64, `Unnamed: 18`: object -> float64, `Unnamed: 19`: object -> float64, `Unnamed: 20`: object -> float64, `Unnamed: 21`: object -> float64, `Unnamed: 22`: object -> float64, `Unnamed: 24`: object -> float64, `Unnamed: 25`: object -> float64, `Unnamed: 26`: object -> float64, `Unnamed: 29`: object -> float64, `Unnamed: 30`: object -> float64, `Unnamed: 31`: object -> float64, `Unnamed: 32`: object -> float64, `Unnamed: 33`: object -> float64, `Unnamed: 34`: object -> float64, `Unnamed: 36`: object -> float64, `Unnamed: 37`: object -> float64, `Unnamed: 39`: object -> float64, `Unnamed: 40`: object -> float64, `Unnamed: 41`: object -> float64, `Unnamed: 42`: object -> float64, `Unnamed: 43`: object -> float64, `Unnamed: 44`: object -> float64, `Unnamed: 45`: object -> float64, `Unnamed: 46`: object -> float64, `Unnamed: 47`: object -> float64, `Unnamed: 48`: object -> float64, `Unnamed: 49`: object -> float64, `Unnamed: 50`: object -> float64, `Unnamed: 51`: object -> float64, `Unnamed: 52`: object -> float64, `Unnamed: 53`: object -> float64, `Unnamed: 54`: object -> float64, `Unnamed: 56`: object -> float64, `Unnamed: 57`: object -> float64, `Unnamed: 58`: object -> float64, `Unnamed: 59`: object -> float64, `Unnamed: 60`: object -> float64, `Unnamed: 61`: object -> float64, `Unnamed: 62`: object -> float64, `Unnamed: 63`: object -> float64, `Unnamed: 64`: object -> float64, `Unnamed: 65`: object -> float64, `Unnamed: 66`: object -> float64, `Unnamed: 67`: object -> float64, `Unnamed: 68`: object -> float64, `Unnamed: 69`: object -> float64, `Unnamed: 70`: object -> float64, `Unnamed: 71`: object -> float64
* **Shape Analyzed:** (785, 72) (rows, columns)

* **Original Column Names (72):**
  ```
  ['World Bank Commodity Price Data (The Pink Sheet)', 'Unnamed: 1', 'Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4', 'Unnamed: 5', 'Unnamed: 6', 'Unnamed: 7', 'Unnamed: 8', 'Unnamed: 9', 'Unnamed: 10', 'Unnamed: 11', 'Unnamed: 12', 'Unnamed: 13', 'Unnamed: 14', 'Unnamed: 15', 'Unnamed: 16', 'Unnamed: 17', 'Unnamed: 18', 'Unnamed: 19', 'Unnamed: 20', 'Unnamed: 21', 'Unnamed: 22', 'Unnamed: 23', 'Unnamed: 24', 'Unnamed: 25', 'Unnamed: 26', 'Unnamed: 27', 'Unnamed: 28', 'Unnamed: 29', 'Unnamed: 30', 'Unnamed: 31', 'Unnamed: 32', 'Unnamed: 33', 'Unnamed: 34', 'Unnamed: 35', 'Unnamed: 36', 'Unnamed: 37', 'Unnamed: 38', 'Unnamed: 39', 'Unnamed: 40', 'Unnamed: 41', 'Unnamed: 42', 'Unnamed: 43', 'Unnamed: 44', 'Unnamed: 45', 'Unnamed: 46', 'Unnamed: 47', 'Unnamed: 48', 'Unnamed: 49', 'Unnamed: 50', 'Unnamed: 51', 'Unnamed: 52', 'Unnamed: 53', 'Unnamed: 54', 'Unnamed: 55', 'Unnamed: 56', 'Unnamed: 57', 'Unnamed: 58', 'Unnamed: 59', 'Unnamed: 60', 'Unnamed: 61', 'Unnamed: 62', 'Unnamed: 63', 'Unnamed: 64', 'Unnamed: 65', 'Unnamed: 66', 'Unnamed: 67', 'Unnamed: 68', 'Unnamed: 69', 'Unnamed: 70', 'Unnamed: 71']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 56,520
* **Data Types Summary:** {dtype('float64'): 65, dtype('O'): 7}

### Memory Usage (Bytes)

* **Total:** 747,727 Bytes
* **Per Analyzed Column + Index:**
```
Index                                                 132
World Bank Commodity Price Data (The Pink Sheet)    44028
Unnamed: 1                                           6280
Unnamed: 2                                           6280
Unnamed: 3                                           6280
Unnamed: 4                                           6280
Unnamed: 5                                           6280
Unnamed: 6                                           6280
Unnamed: 7                                           6280
Unnamed: 8                                           6280
Unnamed: 9                                           6280
Unnamed: 10                                          6280
Unnamed: 11                                          6280
Unnamed: 12                                          6280
Unnamed: 13                                          6280
Unnamed: 14                                          6280
Unnamed: 15                                          6280
Unnamed: 16                                          6280
Unnamed: 17                                          6280
Unnamed: 18                                          6280
Unnamed: 19                                          6280
Unnamed: 20                                          6280
Unnamed: 21                                          6280
Unnamed: 22                                          6280
Unnamed: 23                                         48849
Unnamed: 24                                          6280
Unnamed: 25                                          6280
Unnamed: 26                                          6280
Unnamed: 27                                         49778
Unnamed: 28                                         49836
Unnamed: 29                                          6280
Unnamed: 30                                          6280
Unnamed: 31                                          6280
Unnamed: 32                                          6280
Unnamed: 33                                          6280
Unnamed: 34                                          6280
Unnamed: 35                                         50114
Unnamed: 36                                          6280
Unnamed: 37                                          6280
Unnamed: 38                                         48214
Unnamed: 39                                          6280
Unnamed: 40                                          6280
Unnamed: 41                                          6280
Unnamed: 42                                          6280
Unnamed: 43                                          6280
Unnamed: 44                                          6280
Unnamed: 45                                          6280
Unnamed: 46                                          6280
Unnamed: 47                                          6280
Unnamed: 48                                          6280
Unnamed: 49                                          6280
Unnamed: 50                                          6280
Unnamed: 51                                          6280
Unnamed: 52                                          6280
Unnamed: 53                                          6280
Unnamed: 54                                          6280
Unnamed: 55                                         48576
Unnamed: 56                                          6280
Unnamed: 57                                          6280
Unnamed: 58                                          6280
Unnamed: 59                                          6280
Unnamed: 60                                          6280
Unnamed: 61                                          6280
Unnamed: 62                                          6280
Unnamed: 63                                          6280
Unnamed: 64                                          6280
Unnamed: 65                                          6280
Unnamed: 66                                          6280
Unnamed: 67                                          6280
Unnamed: 68                                          6280
Unnamed: 69                                          6280
Unnamed: 70                                          6280
Unnamed: 71                                          6280
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 785 entries, 0 to 784
Data columns (total 72 columns):
 #   Column                                            Non-Null Count  Dtype  
---  ------                                            --------------  -----  
 0   World Bank Commodity Price Data (The Pink Sheet)  783 non-null    object 
 1   Unnamed: 1                                        780 non-null    float64
 2   Unnamed: 2                                        780 non-null    float64
 3   Unnamed: 3                                        780 non-null    float64
 4   Unnamed: 4                                        516 non-null    float64
 5   Unnamed: 5                                        660 non-null    float64
 6   Unnamed: 6                                        492 non-null    float64
 7   Unnamed: 7                                        780 non-null    float64
 8   Unnamed: 8                                        780 non-null    float64
 9   Unnamed: 9                                        576 non-null    float64
 10  Unnamed: 10                                       576 non-null    float64
 11  Unnamed: 11                                       780 non-null    float64
 12  Unnamed: 12                                       780 non-null    float64
 13  Unnamed: 13                                       780 non-null    float64
 14  Unnamed: 14                                       780 non-null    float64
 15  Unnamed: 15                                       780 non-null    float64
 16  Unnamed: 16                                       780 non-null    float64
 17  Unnamed: 17                                       780 non-null    float64
 18  Unnamed: 18                                       780 non-null    float64
 19  Unnamed: 19                                       540 non-null    float64
 20  Unnamed: 20                                       552 non-null    float64
 21  Unnamed: 21                                       780 non-null    float64
 22  Unnamed: 22                                       780 non-null    float64
 23  Unnamed: 23                                       782 non-null    object 
 24  Unnamed: 24                                       780 non-null    float64
 25  Unnamed: 25                                       780 non-null    float64
 26  Unnamed: 26                                       780 non-null    float64
 27  Unnamed: 27                                       782 non-null    object 
 28  Unnamed: 28                                       782 non-null    object 
 29  Unnamed: 29                                       728 non-null    float64
 30  Unnamed: 30                                       780 non-null    float64
 31  Unnamed: 31                                       728 non-null    float64
 32  Unnamed: 32                                       780 non-null    float64
 33  Unnamed: 33                                       460 non-null    float64
 34  Unnamed: 34                                       468 non-null    float64
 35  Unnamed: 35                                       782 non-null    object 
 36  Unnamed: 36                                       545 non-null    float64
 37  Unnamed: 37                                       780 non-null    float64
 38  Unnamed: 38                                       782 non-null    object 
 39  Unnamed: 39                                       780 non-null    float64
 40  Unnamed: 40                                       780 non-null    float64
 41  Unnamed: 41                                       780 non-null    float64
 42  Unnamed: 42                                       780 non-null    float64
 43  Unnamed: 43                                       648 non-null    float64
 44  Unnamed: 44                                       766 non-null    float64
 45  Unnamed: 45                                       780 non-null    float64
 46  Unnamed: 46                                       780 non-null    float64
 47  Unnamed: 47                                       780 non-null    float64
 48  Unnamed: 48                                       780 non-null    float64
 49  Unnamed: 49                                       660 non-null    float64
 50  Unnamed: 50                                       780 non-null    float64
 51  Unnamed: 51                                       408 non-null    float64
 52  Unnamed: 52                                       780 non-null    float64
 53  Unnamed: 53                                       552 non-null    float64
 54  Unnamed: 54                                       780 non-null    float64
 55  Unnamed: 55                                       782 non-null    object 
 56  Unnamed: 56                                       780 non-null    float64
 57  Unnamed: 57                                       779 non-null    float64
 58  Unnamed: 58                                       696 non-null    float64
 59  Unnamed: 59                                       780 non-null    float64
 60  Unnamed: 60                                       780 non-null    float64
 61  Unnamed: 61                                       780 non-null    float64
 62  Unnamed: 62                                       780 non-null    float64
 63  Unnamed: 63                                       780 non-null    float64
 64  Unnamed: 64                                       780 non-null    float64
 65  Unnamed: 65                                       780 non-null    float64
 66  Unnamed: 66                                       780 non-null    float64
 67  Unnamed: 67                                       780 non-null    float64
 68  Unnamed: 68                                       780 non-null    float64
 69  Unnamed: 69                                       780 non-null    float64
 70  Unnamed: 70                                       780 non-null    float64
 71  Unnamed: 71                                       780 non-null    float64
dtypes: float64(65), object(7)
memory usage: 441.7+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 3,815 (6.75%)
Columns (72 of 72) with missing values (Sorted):
```
Unnamed: 51                                         377
Unnamed: 33                                         325
Unnamed: 34                                         317
Unnamed: 6                                          293
Unnamed: 4                                          269
Unnamed: 19                                         245
Unnamed: 36                                         240
Unnamed: 53                                         233
Unnamed: 20                                         233
Unnamed: 9                                          209
Unnamed: 10                                         209
Unnamed: 43                                         137
Unnamed: 5                                          125
Unnamed: 49                                         125
Unnamed: 58                                          89
Unnamed: 31                                          57
Unnamed: 29                                          57
Unnamed: 44                                          19
Unnamed: 57                                           6
Unnamed: 45                                           5
Unnamed: 46                                           5
Unnamed: 47                                           5
Unnamed: 70                                           5
Unnamed: 48                                           5
Unnamed: 50                                           5
Unnamed: 69                                           5
Unnamed: 68                                           5
Unnamed: 52                                           5
Unnamed: 54                                           5
Unnamed: 56                                           5
Unnamed: 41                                           5
Unnamed: 67                                           5
Unnamed: 59                                           5
Unnamed: 60                                           5
Unnamed: 61                                           5
Unnamed: 62                                           5
Unnamed: 63                                           5
Unnamed: 64                                           5
Unnamed: 65                                           5
Unnamed: 66                                           5
Unnamed: 42                                           5
Unnamed: 71                                           5
Unnamed: 40                                           5
Unnamed: 39                                           5
Unnamed: 2                                            5
Unnamed: 3                                            5
Unnamed: 7                                            5
Unnamed: 8                                            5
Unnamed: 11                                           5
Unnamed: 12                                           5
Unnamed: 13                                           5
Unnamed: 14                                           5
Unnamed: 15                                           5
Unnamed: 16                                           5
Unnamed: 17                                           5
Unnamed: 18                                           5
Unnamed: 21                                           5
Unnamed: 22                                           5
Unnamed: 24                                           5
Unnamed: 25                                           5
Unnamed: 26                                           5
Unnamed: 30                                           5
Unnamed: 32                                           5
Unnamed: 1                                            5
Unnamed: 37                                           5
Unnamed: 23                                           3
Unnamed: 55                                           3
Unnamed: 27                                           3
Unnamed: 28                                           3
Unnamed: 35                                           3
Unnamed: 38                                           3
World Bank Commodity Price Data (The Pink Sheet)      2
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 72):
```
World Bank Commodity Price Data (The Pink Sheet)    783
Unnamed: 1                                          563
Unnamed: 2                                          539
Unnamed: 3                                          538
Unnamed: 4                                          480
Unnamed: 5                                          360
Unnamed: 6                                          361
Unnamed: 7                                          348
Unnamed: 8                                          342
Unnamed: 9                                          331

...

Unnamed: 62    631
Unnamed: 63    266
Unnamed: 64    757
Unnamed: 65    751
Unnamed: 66    759
Unnamed: 67    570
Unnamed: 68    743
Unnamed: 69    687
Unnamed: 70    618
Unnamed: 71    545
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `World Bank Commodity Price Data (The Pink Sheet)`** (Top 20 of 783 unique values)
```
World Bank Commodity Price Data (The Pink Sheet)
monthly prices in nominal US dollars, 1960 to present    1
2004M08                                                  1
2002M10                                                  1
2002M11                                                  1
2002M12                                                  1
2003M01                                                  1
2003M02                                                  1
2003M03                                                  1
2003M04                                                  1
2003M05                                                  1
2003M06                                                  1
2003M07                                                  1
2003M08                                                  1
2003M09                                                  1
2003M10                                                  1
2003M11                                                  1
2003M12                                                  1
2004M01                                                  1
2004M02                                                  1
2004M03                                                  1
```
**Column: `Unnamed: 23`** (Top 20 of 344 unique values)
```
Unnamed: 23
…                  432
556.00               3
590.00               3
755.00               2
776.00               2
693.00               2
Palm kernel oil      1
914.43               1
895.63               1
849.55               1
788.75               1
857.73               1
799.66               1
735.48               1
869.13               1
979.75               1
962.06               1
1020.80              1
1052.37              1
1010.48              1
```
**Column: `Unnamed: 27`** (Top 20 of 277 unique values)
```
Unnamed: 27
…               505
838.02            2
Rapeseed oil      1
847.32            1
875.36            1
905.99            1
847.47            1
842.05            1
839.33            1
874.38            1
897.25            1
890.82            1
930.43            1
918.26            1
914.14            1
849.65            1
817.52            1
872.87            1
901.97            1
962.98            1
```
**Column: `Unnamed: 28`** (Top 20 of 253 unique values)
```
Unnamed: 28
…          510
776.00       5
873.00       5
595.00       4
666.00       3
695.00       2
1114.00      2
713.00       2
730.00       2
632.00       2
700.00       2
578.00       2
800.76       1
815.74       1
822.24       1
794.36       1
804.82       1
809.86       1
795.00       1
797.67       1
```
**Column: `Unnamed: 35`** (Top 20 of 243 unique values)
```
Unnamed: 35
…                       538
371.00                    2
478.57                    2
Rice, Viet Namese 5%      1
413.43                    1
401.56                    1
440.65                    1
443.10                    1
419.00                    1
409.92                    1
389.80                    1
395.43                    1
380.94                    1
383.24                    1
379.01                    1
376.19                    1
384.65                    1
399.52                    1
395.73                    1
390.37                    1
```
**Column: `Unnamed: 38`** (Top 20 of 78 unique values)
```
Unnamed: 38
…       444
0.86     15
0.94     15
0.97     15
0.91     15
0.89     14
1.07     12
1.10     12
0.90     11
1.08     11
0.93     10
1.05     10
1.11     10
0.92      9
0.96      9
0.95      9
0.85      8
1.00      7
0.99      7
1.12      7
```
**Column: `Unnamed: 55`** (Top 20 of 178 unique values)
```
Unnamed: 55
…       468
0.60      7
1.46      6
1.36      5
1.63      5
1.53      5
1.21      5
1.50      4
1.41      4
1.32      4
1.24      4
1.27      4
1.65      4
1.30      4
1.44      4
1.56      4
0.51      4
1.93      4
1.22      3
1.34      3
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                                                  | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev   | Min      | 25%      | 50%      | 75%       | Max       | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                                          | LastNonNull   |
|:-------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:---------|:---------|:---------|:---------|:----------|:----------|:-----------|:-----------|:----------|:----------|:------------------------------------------------------|:--------------|
| World Bank Commodity Price Data (The Pink Sheet) | object     |            783 |           2 | 0.25%     |           783 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | monthly prices in nominal US dollars, 1960 to present | 2024M12       |
| Unnamed: 1                                       | float64    |            780 |           5 | 0.64%     |           563 | 33.413    | 31.358   | 1.210    | 11.510   | 22.140   | 52.860    | 132.830   | 1.038      | 0.095      | NaT       | NaT       | 1.63                                                  | 72.31         |
| Unnamed: 2                                       | float64    |            780 |           5 | 0.64%     |           539 | 34.231    | 32.523   | 1.210    | 11.510   | 22.565   | 54.127    | 133.870   | 1.069      | 0.176      | NaT       | NaT       | 1.63                                                  | 73.83         |
| Unnamed: 3                                       | float64    |            780 |           5 | 0.64%     |           538 | 32.764    | 31.653   | 1.210    | 10.600   | 20.835   | 51.480    | 131.220   | 1.092      | 0.175      | NaT       | NaT       | 1.63                                                  | 73.31         |
| Unnamed: 4                                       | float64    |            516 |         269 | 34.27%    |           480 | 45.981    | 28.603   | 11.310   | 20.655   | 33.075   | 69.567    | 133.930   | 0.761      | -0.568     | NaT       | NaT       | 35.3                                                  | 69.79         |
| Unnamed: 5                                       | float64    |            660 |         125 | 15.92%    |           360 | 57.748    | 55.007   | 7.800    | 29.250   | 38.375   | 68.968    | 430.810   | 3.493      | 16.508     | NaT       | NaT       | 7.8                                                   | 129.81        |
| Unnamed: 6                                       | float64    |            492 |         293 | 37.32%    |           361 | 60.479    | 43.593   | 21.250   | 30.385   | 43.955   | 82.915    | 302.000   | 2.376      | 8.216      | NaT       | NaT       | 29.34                                                 | 105.47        |
| Unnamed: 7                                       | float64    |            780 |           5 | 0.64%     |           348 | 2.400     | 2.176    | 0.140    | 0.548    | 2.100    | 3.022     | 13.520    | 1.580      | 3.537      | NaT       | NaT       | 0.14                                                  | 3.02          |
| Unnamed: 8                                       | float64    |            780 |           5 | 0.64%     |           342 | 4.782     | 6.192    | 0.380    | 1.740    | 3.020    | 5.860     | 70.040    | 4.723      | 33.442     | NaT       | NaT       | 0.4                                                   | 13.86         |
| Unnamed: 9                                       | float64    |            576 |         209 | 26.62%    |           331 | 7.190     | 4.421    | 2.720    | 3.640    | 5.550    | 10.012    | 23.730    | 1.144      | 0.359      | NaT       | NaT       | 2.77                                                  | 12.76         |
| Unnamed: 10                                      | float64    |            576 |         209 | 26.62%    |           539 | 73.060    | 49.907   | 18.530   | 40.032   | 54.430   | 95.330    | 454.040   | 2.619      | 11.365     | NaT       | NaT       | 18.53                                                 | 111.23        |
| Unnamed: 11                                      | float64    |            780 |           5 | 0.64%     |           283 | 1.840     | 1.140    | 0.260    | 1.060    | 1.640    | 2.382     | 10.320    | 2.188      | 10.574     | NaT       | NaT       | 0.63                                                  | 10.32         |
| Unnamed: 12                                      | float64    |            780 |           5 | 0.64%     |           351 | 2.654     | 1.399    | 0.780    | 1.377    | 2.740    | 3.420     | 7.570     | 0.588      | -0.144     | NaT       | NaT       | 0.94                                                  | 7.57          |
| Unnamed: 13                                      | float64    |            780 |           5 | 0.64%     |           289 | 1.783     | 0.993    | 0.490    | 0.930    | 1.675    | 2.310     | 6.880     | 1.187      | 2.180      | NaT       | NaT       | 0.7                                                   | 5.22          |
| Unnamed: 14                                      | float64    |            780 |           5 | 0.64%     |           222 | 1.807     | 0.731    | 0.710    | 1.218    | 1.670    | 2.493     | 3.370     | 0.334      | -1.011     | NaT       | NaT       | 1.03                                                  | 2.96          |
| Unnamed: 15                                      | float64    |            780 |           5 | 0.64%     |           274 | 1.842     | 1.057    | 0.430    | 0.890    | 1.540    | 2.855     | 4.490     | 0.699      | -0.784     | NaT       | NaT       | 0.93                                                  | 4.11          |
| Unnamed: 16                                      | float64    |            780 |           5 | 0.64%     |           239 | 1.893     | 0.707    | 0.660    | 1.340    | 1.855    | 2.410     | 4.070     | 0.259      | -0.580     | NaT       | NaT       | 1.12                                                  | 2.56          |
| Unnamed: 17                                      | float64    |            780 |           5 | 0.64%     |           197 | 1.688     | 0.614    | 0.720    | 1.210    | 1.610    | 2.110     | 3.390     | 0.466      | -0.548     | NaT       | NaT       | 1.04                                                  | 2.19          |
| Unnamed: 18                                      | float64    |            780 |           5 | 0.64%     |           645 | 708.386   | 414.368  | 200.000  | 388.000  | 595.000  | 907.750   | 2256.000  | 1.220      | 1.029      | NaT       | NaT       | 390.0                                                 | 1973.24       |
| Unnamed: 19                                      | float64    |            540 |         245 | 31.21%    |           392 | 1186.689  | 420.089  | 585.000  | 868.795  | 1050.000 | 1426.760  | 2528.430  | 1.135      | 0.875      | NaT       | NaT       | 869.0                                                 | 1515.41       |
| Unnamed: 20                                      | float64    |            552 |         233 | 29.68%    |           474 | 871.615   | 510.545  | 254.000  | 432.577  | 638.875  | 1410.205  | 1926.470  | 0.535      | -1.345     | NaT       | NaT       | 381.0                                                 | 1597.92       |
| Unnamed: 21                                      | float64    |            780 |           5 | 0.64%     |           656 | 988.059   | 545.195  | 248.020  | 557.750  | 913.500  | 1359.375  | 2502.250  | 0.709      | -0.119     | NaT       | NaT       | 334.0                                                 | 1687.54       |
| Unnamed: 22                                      | float64    |            780 |           5 | 0.64%     |           659 | 536.930   | 281.118  | 141.730  | 305.283  | 490.760  | 685.808   | 1776.960  | 1.034      | 1.147      | NaT       | NaT       | 233.0                                                 | 1189.73       |
| Unnamed: 23                                      | object     |            782 |           3 | 0.38%     |           344 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Palm kernel oil                                       | 2098.85       |
| Unnamed: 24                                      | float64    |            780 |           5 | 0.64%     |           478 | 290.101   | 142.998  | 88.000   | 204.750  | 260.000  | 372.645   | 737.060   | 0.817      | 0.171      | NaT       | NaT       | 94.0                                                  | 409.27        |
| Unnamed: 25                                      | float64    |            780 |           5 | 0.64%     |           618 | 606.147   | 329.002  | 157.000  | 358.892  | 544.000  | 770.350   | 1962.880  | 1.128      | 1.272      | NaT       | NaT       | 204.0                                                 | 1063.63       |
| Unnamed: 26                                      | float64    |            780 |           5 | 0.64%     |           527 | 254.397   | 133.916  | 68.600   | 165.225  | 216.500  | 342.640   | 651.350   | 0.832      | -0.116     | NaT       | NaT       | 91.9                                                  | 376.39        |
| Unnamed: 27                                      | object     |            782 |           3 | 0.38%     |           277 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Rapeseed oil                                          | 1180.82       |
| Unnamed: 28                                      | object     |            782 |           3 | 0.38%     |           253 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Sunflower oil                                         | 1222.50       |
| Unnamed: 29                                      | float64    |            728 |          57 | 7.26%     |           610 | 83.374    | 51.350   | 19.200   | 48.765   | 74.870   | 104.287   | 265.690   | 1.177      | 1.429      | NaT       | NaT       | 20.36                                                 | 80.38         |
| Unnamed: 30                                      | float64    |            780 |           5 | 0.64%     |           653 | 126.479   | 65.852   | 38.000   | 86.430   | 111.000  | 158.012   | 348.170   | 1.234      | 1.323      | NaT       | NaT       | 45.0                                                  | 202.6         |
| Unnamed: 31                                      | float64    |            728 |          57 | 7.26%     |           601 | 113.317   | 55.193   | 35.000   | 78.468   | 105.015  | 139.848   | 302.530   | 1.100      | 1.214      | NaT       | NaT       | 39.0                                                  | 189.49        |
| Unnamed: 32                                      | float64    |            780 |           5 | 0.64%     |           669 | 306.652   | 142.898  | 95.670   | 191.120  | 278.520  | 406.500   | 907.000   | 0.682      | 0.081      | NaT       | NaT       | 104.45                                                | 527.0         |
| Unnamed: 33                                      | float64    |            460 |         325 | 41.40%    |           355 | 326.416   | 127.580  | 83.260   | 230.000  | 285.800  | 421.000   | 700.000   | 0.410      | -0.727     | NaT       | NaT       | 83.26                                                 | 500.0         |
| Unnamed: 34                                      | float64    |            468 |         317 | 40.38%    |           410 | 297.652   | 139.145  | 97.000   | 177.312  | 238.800  | 407.590   | 762.670   | 0.584      | -0.650     | NaT       | NaT       | 98.0                                                  | 501.94        |
| Unnamed: 35                                      | object     |            782 |           3 | 0.38%     |           243 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Rice, Viet Namese 5%                                  | 495.67        |
| Unnamed: 36                                      | float64    |            545 |         240 | 30.57%    |           520 | 176.707   | 64.085   | 85.300   | 131.650  | 157.380  | 207.380   | 446.660   | 1.232      | 1.521      | NaT       | NaT       | 140.36                                                | 230.28        |
| Unnamed: 37                                      | float64    |            780 |           5 | 0.64%     |           536 | 163.378   | 84.389   | 52.180   | 109.093  | 151.100  | 195.300   | 522.290   | 1.068      | 1.232      | NaT       | NaT       | 59.89                                                 | 252.17        |
| Unnamed: 38                                      | object     |            782 |           3 | 0.38%     |            78 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Banana, Europe                                        | 1.04          |
| Unnamed: 39                                      | float64    |            780 |           5 | 0.64%     |           129 | 0.544     | 0.375    | 0.110    | 0.240    | 0.430    | 0.830     | 1.680     | 0.961      | 0.202      | NaT       | NaT       | 0.14                                                  | 0.83          |
| Unnamed: 40                                      | float64    |            780 |           5 | 0.64%     |           137 | 0.527     | 0.389    | 0.070    | 0.220    | 0.450    | 0.730     | 2.700     | 1.915      | 6.223      | NaT       | NaT       | 0.12                                                  | 2.7           |
| Unnamed: 41                                      | float64    |            780 |           5 | 0.64%     |           352 | 2.554     | 1.332    | 0.560    | 1.620    | 2.380    | 2.947     | 6.340     | 0.811      | 0.015      | NaT       | NaT       | 0.71                                                  | 6.23          |
| Unnamed: 42                                      | float64    |            780 |           5 | 0.64%     |           200 | 1.153     | 0.606    | 0.300    | 0.600    | 1.115    | 1.620     | 2.720     | 0.262      | -1.025     | NaT       | NaT       | 0.3                                                   | 1.42          |
| Unnamed: 43                                      | float64    |            648 |         137 | 17.45%    |           391 | 4.008     | 2.431    | 0.750    | 2.270    | 2.970    | 5.445     | 10.280    | 0.877      | -0.491     | NaT       | NaT       | 0.8                                                   | 5.84          |
| Unnamed: 44                                      | float64    |            766 |          19 | 2.42%     |           329 | 9.566     | 4.314    | 1.430    | 6.292    | 10.620   | 12.490    | 19.250    | -0.564     | -0.731     | NaT       | NaT       | 1.43                                                  | 8.6           |
| Unnamed: 45                                      | float64    |            780 |           5 | 0.64%     |            57 | 0.403     | 0.185    | 0.110    | 0.300    | 0.400    | 0.560     | 0.780     | -0.148     | -1.000     | NaT       | NaT       | 0.12                                                  | 0.34          |
| Unnamed: 46                                      | float64    |            780 |           5 | 0.64%     |            82 | 0.446     | 0.201    | 0.120    | 0.318    | 0.470    | 0.520     | 1.260     | 0.217      | 0.040      | NaT       | NaT       | 0.12                                                  | 0.81          |
| Unnamed: 47                                      | float64    |            780 |           5 | 0.64%     |            71 | 0.248     | 0.156    | 0.030    | 0.140    | 0.220    | 0.320     | 1.240     | 1.326      | 3.409      | NaT       | NaT       | 0.07                                                  | 0.44          |
| Unnamed: 48                                      | float64    |            780 |           5 | 0.64%     |           689 | 2910.279  | 1216.095 | 1001.250 | 2109.373 | 2746.295 | 3742.773  | 6166.260  | 0.283      | -0.784     | NaT       | NaT       | 1736.87                                               | 5091.46       |
| Unnamed: 49                                      | float64    |            660 |         125 | 15.92%    |           586 | 292.312   | 116.297  | 42.990   | 206.335  | 295.605  | 382.150   | 562.840   | -0.244     | -0.529     | NaT       | NaT       | 42.99                                                 | 366.49        |
| Unnamed: 50                                      | float64    |            780 |           5 | 0.64%     |           648 | 176.755   | 99.104   | 28.890   | 90.900   | 187.345  | 258.503   | 520.810   | 0.152      | -0.510     | NaT       | NaT       | 31.94                                                 | 193.31        |
| Unnamed: 51                                      | float64    |            408 |         377 | 48.03%    |           361 | 604.777   | 154.637  | 175.000  | 523.662  | 605.050  | 717.455   | 1087.540  | -0.178     | 1.176      | NaT       | NaT       | 175.0                                                 | 605.94        |
| Unnamed: 52                                      | float64    |            780 |           5 | 0.64%     |           609 | 498.689   | 253.260  | 141.310  | 262.410  | 516.285  | 719.375   | 973.600   | 0.034      | -1.402     | NaT       | NaT       | 149.17                                                | 689.21        |
| Unnamed: 53                                      | float64    |            552 |         233 | 29.68%    |           535 | 444.379   | 126.442  | 196.800  | 362.582  | 455.280  | 530.940   | 751.810   | -0.157     | -0.751     | NaT       | NaT       | 270.0                                                 | 354.58        |
| Unnamed: 54                                      | float64    |            780 |           5 | 0.64%     |           179 | 1.473     | 0.586    | 0.600    | 1.090    | 1.520    | 1.823     | 5.060     | 1.058      | 4.446      | NaT       | NaT       | 0.65                                                  | 1.76          |
| Unnamed: 55                                      | object     |            782 |           3 | 0.38%     |           178 | N/A       | N/A      | N/A      | N/A      | N/A      | N/A       | N/A       | N/A        | N/A        | NaT       | NaT       | Rubber, TSR20 **                                      | 1.99          |
| Unnamed: 56                                      | float64    |            780 |           5 | 0.64%     |           244 | 1.250     | 0.870    | 0.290    | 0.650    | 0.940    | 1.603     | 6.260     | 2.001      | 5.483      | NaT       | NaT       | 0.82                                                  | 2.38          |
| Unnamed: 57                                      | float64    |            779 |           6 | 0.76%     |           149 | 63.024    | 70.631   | 11.000   | 31.440   | 36.000   | 75.000    | 450.000   | 2.838      | 9.628      | NaT       | NaT       | 13.0                                                  | 152.5         |
| Unnamed: 58                                      | float64    |            696 |          89 | 11.34%    |           488 | 253.782   | 177.368  | 54.000   | 145.188  | 185.125  | 334.543   | 1075.750  | 1.698      | 3.310      | NaT       | NaT       | 68.5                                                  | 568.33        |
| Unnamed: 59                                      | float64    |            780 |           5 | 0.64%     |           380 | 205.934   | 172.131  | 36.000   | 105.400  | 145.750  | 281.000   | 1131.500  | 2.019      | 5.468      | NaT       | NaT       | 53.0                                                  | 477.5         |
| Unnamed: 60                                      | float64    |            780 |           5 | 0.64%     |           408 | 169.729   | 139.820  | 16.000   | 75.597   | 127.815  | 235.000   | 925.000   | 2.033      | 5.963      | NaT       | NaT       | 42.25                                                 | 352.0         |
| Unnamed: 61                                      | float64    |            780 |           5 | 0.64%     |           188 | 159.185   | 165.689  | 22.000   | 56.000   | 112.500  | 206.500   | 1202.000  | 2.473      | 8.162      | NaT       | NaT       | 28.5                                                  | 292.5         |
| Unnamed: 62                                      | float64    |            780 |           5 | 0.64%     |           631 | 1439.891  | 656.932  | 496.040  | 903.890  | 1455.580 | 1860.980  | 3577.860  | 0.294      | -0.520     | NaT       | NaT       | 511.47                                                | 2541.02       |
| Unnamed: 63                                      | float64    |            780 |           5 | 0.64%     |           266 | 48.292    | 45.715   | 8.770    | 21.450   | 29.000   | 65.838    | 214.430   | 1.528      | 1.466      | NaT       | NaT       | 11.42                                                 | 102.21        |
| Unnamed: 64                                      | float64    |            780 |           5 | 0.64%     |           757 | 3297.591  | 2664.798 | 606.710  | 1404.605 | 1960.790 | 5492.453  | 10230.890 | 1.060      | -0.318     | NaT       | NaT       | 715.4                                                 | 8916.32       |
| Unnamed: 65                                      | float64    |            780 |           5 | 0.64%     |           751 | 955.640   | 765.543  | 140.700  | 400.375  | 601.150  | 1721.457  | 3719.720  | 0.964      | -0.420     | NaT       | NaT       | 206.1                                                 | 1990.43       |
| Unnamed: 66                                      | float64    |            780 |           5 | 0.64%     |           759 | 10858.891 | 8062.513 | 2162.700 | 4934.998 | 7227.600 | 15913.535 | 43983.350 | 1.235      | 1.251      | NaT       | NaT       | 2180.4                                                | 28864.99      |
| Unnamed: 67                                      | float64    |            780 |           5 | 0.64%     |           570 | 9268.946  | 7607.418 | 1631.000 | 4070.075 | 6618.100 | 13558.695 | 52179.050 | 1.676      | 3.857      | NaT       | NaT       | 1631.0                                                | 15444.89      |
| Unnamed: 68                                      | float64    |            780 |           5 | 0.64%     |           743 | 1271.751  | 908.270  | 176.600  | 685.825  | 1000.900 | 1869.628  | 4405.400  | 0.964      | 0.186      | NaT       | NaT       | 260.8                                                 | 3034.16       |
| Unnamed: 69                                      | float64    |            780 |           5 | 0.64%     |           687 | 581.010   | 586.327  | 34.940   | 149.980  | 373.980  | 889.750   | 2690.080  | 1.269      | 0.655      | NaT       | NaT       | 35.27                                                 | 2648.01       |
| Unnamed: 70                                      | float64    |            780 |           5 | 0.64%     |           618 | 585.119   | 457.985  | 78.500   | 163.420  | 429.770  | 908.675   | 2052.450  | 0.953      | 0.139      | NaT       | NaT       | 83.5                                                  | 937.88        |
| Unnamed: 71                                      | float64    |            780 |           5 | 0.64%     |           545 | 9.408     | 8.479    | 0.910    | 4.088    | 5.470    | 14.895    | 42.700    | 1.308      | 1.071      | NaT       | NaT       | 0.91                                                  | 30.76         |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 582 pairs with absolute correlation > 0.8 (showing top 50):*
```
Unnamed: 1   Unnamed: 2     0.999471
Unnamed: 2   Unnamed: 3     0.999040
Unnamed: 1   Unnamed: 3     0.998828
             Unnamed: 4     0.996197
Unnamed: 2   Unnamed: 4     0.992670
Unnamed: 3   Unnamed: 4     0.990690
Unnamed: 58  Unnamed: 59    0.988297
Unnamed: 32  Unnamed: 33    0.983295
Unnamed: 30  Unnamed: 31    0.978927
Unnamed: 24  Unnamed: 26    0.966739
Unnamed: 36  Unnamed: 37    0.966299
Unnamed: 22  Unnamed: 25    0.964895
Unnamed: 33  Unnamed: 34    0.962395
Unnamed: 5   Unnamed: 6     0.956734
Unnamed: 24  Unnamed: 30    0.954259
Unnamed: 14  Unnamed: 15    0.949394
Unnamed: 24  Unnamed: 25    0.947260
Unnamed: 30  Unnamed: 37    0.945757
Unnamed: 64  Unnamed: 65    0.943005
Unnamed: 24  Unnamed: 31    0.941518
Unnamed: 50  Unnamed: 52    0.941233
Unnamed: 24  Unnamed: 37    0.940568
Unnamed: 25  Unnamed: 30    0.938687
Unnamed: 41  Unnamed: 69    0.937961
Unnamed: 31  Unnamed: 37    0.935672
Unnamed: 49  Unnamed: 51    0.935267
Unnamed: 1   Unnamed: 70    0.934387
Unnamed: 2   Unnamed: 70    0.933089
Unnamed: 21  Unnamed: 24    0.932977
             Unnamed: 25    0.931903
Unnamed: 32  Unnamed: 34    0.931008
Unnamed: 58  Unnamed: 60    0.929658
Unnamed: 3   Unnamed: 70    0.928617
Unnamed: 29  Unnamed: 30    0.928608
Unnamed: 49  Unnamed: 52    0.928247
Unnamed: 14  Unnamed: 17    0.927898
Unnamed: 59  Unnamed: 60    0.927775
Unnamed: 63  Unnamed: 64    0.926008
Unnamed: 25  Unnamed: 37    0.925802
Unnamed: 14  Unnamed: 48    0.925232
Unnamed: 39  Unnamed: 69    0.924874
Unnamed: 29  Unnamed: 37    0.923171
             Unnamed: 31    0.920853
Unnamed: 64  Unnamed: 69    0.920697
Unnamed: 42  Unnamed: 52    0.920360
Unnamed: 69  Unnamed: 71    0.920012
Unnamed: 15  Unnamed: 48    0.919007
Unnamed: 3   Unnamed: 9     0.916878
Unnamed: 5   Unnamed: 8     0.916098
Unnamed: 3   Unnamed: 64    0.916083
```


---


## Analysis for: `LSM_QIM_2005.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (1500, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=1500 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (1500, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 13,500
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 807,216 Bytes
* **Per Analyzed Column + Index:**
```
Index                     132
Dataset Name           192000
Observation Date        12000
Series Key             110040
Series Display Name    197280
Observation Value       12000
Unit                    81000
Observation Status      82500
Sequence No.            12000
Series name            108264
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 1500 entries, 0 to 1499
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         1500 non-null   object        
 1   Observation Date     1500 non-null   datetime64[ns]
 2   Series Key           1500 non-null   object        
 3   Series Display Name  1500 non-null   object        
 4   Observation Value    1500 non-null   float64       
 5   Unit                 1500 non-null   object        
 6   Observation Status   1500 non-null   object        
 7   Sequence No.         1500 non-null   int64         
 8   Series name          1500 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 105.6+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2007-07-31 00:00:00
* **Max Date:** 2022-06-30 00:00:00
* **Number of Unique Dates:** 180
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 1320 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date        180
Series Key               11
Series Display Name      11
Observation Value      1436
Unit                      1
Observation Status        1
Sequence No.             11
Series name              11
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Quantum Index Series of Selected Large-scale Manufacturing Items (base 2005-06)    1500
```
**Column: `Series Key`** (Top 11 of 11 unique values)
```
Series Key
TS_GP_RL_LSM_M.LSM000160000    180
TS_GP_RL_LSM_M.LSM000020       132
TS_GP_RL_LSM_M.LSM000030       132
TS_GP_RL_LSM_M.LSM000040       132
TS_GP_RL_LSM_M.LSM000050       132
TS_GP_RL_LSM_M.LSM000060       132
TS_GP_RL_LSM_M.LSM000070       132
TS_GP_RL_LSM_M.LSM000080       132
TS_GP_RL_LSM_M.LSM000090       132
TS_GP_RL_LSM_M.LSM000100       132
TS_GP_RL_LSM_M.LSM000110       132
```
**Column: `Series Display Name`** (Top 11 of 11 unique values)
```
Series Display Name
. 1. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Overall           180
. 2. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Vegetable Ghee    132
. 3. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Tea Blended       132
. 4. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Cigarettes        132
. 5. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Cotton Yarn       132
. 6. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Cotton Cloth      132
. 7. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Jute Goods        132
. 8. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Paper & Board     132
. 9. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Cement            132
. 10. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Automobile       132
. 11. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Fertilizers      132
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Index    1500
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    1500
```
**Column: `Series name`** (Top 11 of 11 unique values)
```
Series name
Quantum Index - Overall          180
Quantum Index - Ghee             132
Quantum Index - Tea              132
Quantum Index - Cigarettes       132
Quantum Index - Yarn             132
Quantum Index - Cloth            132
Quantum Index - Jute             132
Quantum Index - Paper & Board    132
Quantum Index - Cement           132
Quantum Index - Auto-mobiles     132
Quantum Index - Fertilizers      132
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%     | 50%     | 75%     | Max     | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                                    | LastNonNull                                                                     |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:--------|:--------|:--------|:--------|:-----------|:-----------|:--------------------|:--------------------|:--------------------------------------------------------------------------------|:--------------------------------------------------------------------------------|
| Dataset Name        | object         |           1500 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Quantum Index Series of Selected Large-scale Manufacturing Items (base 2005-06) | Quantum Index Series of Selected Large-scale Manufacturing Items (base 2005-06) |
| Observation Date    | datetime64[ns] |           1500 |           0 | 0.00%     |           180 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | 2007-07-31 00:00:00 | 2022-06-30 00:00:00 | 2022-06-30 00:00:00                                                             | 2007-07-31 00:00:00                                                             |
| Series Key          | object         |           1500 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | TS_GP_RL_LSM_M.LSM000160000                                                     | TS_GP_RL_LSM_M.LSM000160000                                                     |
| Series Display Name | object         |           1500 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | . 1. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Overall | . 1. Quantum Index of Large-scale Manufacturing (Base Period 2005-06) - Overall |
| Observation Value   | float64        |           1500 |           0 | 0.00%     |          1436 | 130.707 | 45.947   | 4.465  | 105.137 | 122.283 | 147.630 | 376.094 | 1.022      | 2.022      | NaT                 | NaT                 | 165.6372011                                                                     | 98.0236121                                                                      |
| Unit                | object         |           1500 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Index                                                                           | Index                                                                           |
| Observation Status  | object         |           1500 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                          | Normal                                                                          |
| Sequence No.        | int64          |           1500 |           0 | 0.00%     |            11 | 58.400  | 32.344   | 10.000 | 30.000  | 60.000  | 90.000  | 110.000 | 0.030      | -1.249     | NaT                 | NaT                 | 10                                                                              | 10                                                                              |
| Series name         | object         |           1500 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Quantum Index - Overall                                                         | Quantum Index - Overall                                                         |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `LSM_QIM_2015.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (1144, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=1144 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (1144, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 10,296
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 624,132 Bytes
* **Per Analyzed Column + Index:**
```
Index                     132
Dataset Name           146432
Observation Date         9152
Series Key              88400
Series Display Name    150592
Observation Value        9152
Unit                    61776
Observation Status      62920
Sequence No.             9152
Series name             86424
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 1144 entries, 0 to 1143
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         1144 non-null   object        
 1   Observation Date     1144 non-null   datetime64[ns]
 2   Series Key           1144 non-null   object        
 3   Series Display Name  1144 non-null   object        
 4   Observation Value    1144 non-null   float64       
 5   Unit                 1144 non-null   object        
 6   Observation Status   1144 non-null   object        
 7   Sequence No.         1144 non-null   int64         
 8   Series name          1144 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 80.6+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2016-07-31 00:00:00
* **Max Date:** 2025-02-28 00:00:00
* **Number of Unique Dates:** 104
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 1040 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date        104
Series Key               11
Series Display Name      11
Observation Value      1110
Unit                      1
Observation Status        1
Sequence No.             11
Series name              11
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Quantum Index Series of Selected Large-scale Manufacturing Items (base 2015-16)    1144
```
**Column: `Series Key`** (Top 11 of 11 unique values)
```
Series Key
TS_GP_RL_LSM1516_M.LSM000160000    104
TS_GP_RL_LSM1516_M.LSM000020       104
TS_GP_RL_LSM1516_M.LSM000030       104
TS_GP_RL_LSM1516_M.LSM000040       104
TS_GP_RL_LSM1516_M.LSM000050       104
TS_GP_RL_LSM1516_M.LSM000060       104
TS_GP_RL_LSM1516_M.LSM000070       104
TS_GP_RL_LSM1516_M.LSM000080       104
TS_GP_RL_LSM1516_M.LSM000090       104
TS_GP_RL_LSM1516_M.LSM000100       104
TS_GP_RL_LSM1516_M.LSM000110       104
```
**Column: `Series Display Name`** (Top 11 of 11 unique values)
```
Series Display Name
. 1. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Overall           104
. 2. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Vegetable Ghee    104
. 3. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Tea Blended       104
. 4. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Cigarettes        104
. 5. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Cotton Yarn       104
. 6. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Cotton Cloth      104
. 7. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Jute Goods        104
. 8. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Paper & Board     104
. 9. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Cement            104
. 10. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Automobile       104
. 11. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Fertilizers      104
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Index    1144
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    1144
```
**Column: `Series name`** (Top 11 of 11 unique values)
```
Series name
Quantum Index - Overall           104
Quantum Index - Vegetable Ghee    104
Quantum Index - Tea Blended       104
Quantum Index - Cigarettes        104
Quantum Index - Cotton Yarn       104
Quantum Index - Cotton Cloth      104
Quantum Index - Jute Goods        104
Quantum Index - Paper & Board     104
Quantum Index - Cement            104
Quantum Index - Automobiles       104
Quantum Index - Fertilizers       104
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%    | 50%     | 75%     | Max     | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                                    | LastNonNull                                                                          |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:-------|:--------|:--------|:--------|:-----------|:-----------|:--------------------|:--------------------|:--------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------|
| Dataset Name        | object         |           1144 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Quantum Index Series of Selected Large-scale Manufacturing Items (base 2015-16) | Quantum Index Series of Selected Large-scale Manufacturing Items (base 2015-16)      |
| Observation Date    | datetime64[ns] |           1144 |           0 | 0.00%     |           104 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | 2016-07-31 00:00:00 | 2025-02-28 00:00:00 | 2025-02-28 00:00:00                                                             | 2016-07-31 00:00:00                                                                  |
| Series Key          | object         |           1144 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | TS_GP_RL_LSM1516_M.LSM000160000                                                 | TS_GP_RL_LSM1516_M.LSM000110                                                         |
| Series Display Name | object         |           1144 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | . 1. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Overall | . 11. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Fertilizers |
| Observation Value   | float64        |           1144 |           0 | 0.00%     |          1110 | 105.043 | 23.103   | 0.104  | 96.174 | 105.941 | 118.706 | 223.696 | -0.464     | 1.709      | NaT                 | NaT                 | 122.5624747                                                                     | 103.9527058                                                                          |
| Unit                | object         |           1144 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Index                                                                           | Index                                                                                |
| Observation Status  | object         |           1144 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                          | Normal                                                                               |
| Sequence No.        | int64          |           1144 |           0 | 0.00%     |            11 | 60.000  | 31.637   | 10.000 | 30.000 | 60.000  | 90.000  | 110.000 | 0.000      | -1.220     | NaT                 | NaT                 | 10                                                                              | 110                                                                                  |
| Series name         | object         |           1144 |           0 | 0.00%     |            11 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Quantum Index - Overall                                                         | Quantum Index - Fertilizers                                                          |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `REER.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (1512, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=1512 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (1512, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 13,608
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 772,764 Bytes
* **Per Analyzed Column + Index:**
```
Index                     132
Dataset Name           190512
Observation Date        12096
Series Key             114912
Series Display Name    119070
Observation Value       12096
Unit                    83160
Observation Status      83160
Sequence No.            12096
Series name            145530
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 1512 entries, 0 to 1511
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         1512 non-null   object        
 1   Observation Date     1512 non-null   datetime64[ns]
 2   Series Key           1512 non-null   object        
 3   Series Display Name  1512 non-null   object        
 4   Observation Value    1512 non-null   float64       
 5   Unit                 1512 non-null   object        
 6   Observation Status   1512 non-null   object        
 7   Sequence No.         1512 non-null   int64         
 8   Series name          1512 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 106.4+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 1970-01-31 00:00:00
* **Max Date:** 2001-06-30 00:00:00
* **Number of Unique Dates:** 378
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 1134 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date        378
Series Key                4
Series Display Name       4
Observation Value      1492
Unit                      2
Observation Status        1
Sequence No.              4
Series name               4
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Nominal/Real Effective Exchange Rates Indices of Pak Rupees (Base Year: 2000)    1512
```
**Column: `Series Key`** (Top 4 of 4 unique values)
```
Series Key
TS_GP_ER_REERNEERO_M.N00010    378
TS_GP_ER_REERNEERO_M.R00010    378
TS_GP_ER_REERNEERO_M.N00020    378
TS_GP_ER_REERNEERO_M.R00020    378
```
**Column: `Series Display Name`** (Top 4 of 4 unique values)
```
Series Display Name
a. NEER (Base 2000=100)                  378
b. REER (Base 2000=100)                  378
c. NEER (Base 2000=100):  MOM Changes    378
d. REER (Base 2000=100): MOM Changes     378
```
**Column: `Unit`** (Top 2 of 2 unique values)
```
Unit
Index      756
Percent    756
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    1512
```
**Column: `Series name`** (Top 4 of 4 unique values)
```
Series name
Nominal Effective Exchange Rate (Base Year: 2000)    378
Real Effective Exchange Rate (Base Year: 2000)       378
NEER : Percentage Change over last Year / Month      378
REER : Percentage Change over last Year / Month      378
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min     | 25%    | 50%    | 75%     | Max     | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                                  | LastNonNull                                                                   |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:--------|:-------|:-------|:--------|:--------|:-----------|:-----------|:--------------------|:--------------------|:------------------------------------------------------------------------------|:------------------------------------------------------------------------------|
| Dataset Name        | object         |           1512 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Nominal/Real Effective Exchange Rates Indices of Pak Rupees (Base Year: 2000) | Nominal/Real Effective Exchange Rates Indices of Pak Rupees (Base Year: 2000) |
| Observation Date    | datetime64[ns] |           1512 |           0 | 0.00%     |           378 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | 1970-01-31 00:00:00 | 2001-06-30 00:00:00 | 2001-06-30 00:00:00                                                           | 1970-01-31 00:00:00                                                           |
| Series Key          | object         |           1512 |           0 | 0.00%     |             4 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | TS_GP_ER_REERNEERO_M.N00010                                                   | TS_GP_ER_REERNEERO_M.R00020                                                   |
| Series Display Name | object         |           1512 |           0 | 0.00%     |             4 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | a. NEER (Base 2000=100)                                                       | d. REER (Base 2000=100): MOM Changes                                          |
| Observation Value   | float64        |           1512 |           0 | 0.00%     |          1492 | 113.316 | 154.785  | -57.311 | -0.133 | 49.381 | 190.885 | 839.990 | 2.055      | 6.058      | NaT                 | NaT                 | 89.4                                                                          | 0.0                                                                           |
| Unit                | object         |           1512 |           0 | 0.00%     |             2 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Index                                                                         | Percent                                                                       |
| Observation Status  | object         |           1512 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                        | Normal                                                                        |
| Sequence No.        | int64          |           1512 |           0 | 0.00%     |             4 | 25.000  | 11.184   | 10.000  | 17.500 | 25.000 | 32.500  | 40.000  | 0.000      | -1.361     | NaT                 | NaT                 | 10                                                                            | 40                                                                            |
| Series name         | object         |           1512 |           0 | 0.00%     |             4 | N/A     | N/A      | N/A     | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Nominal Effective Exchange Rate (Base Year: 2000)                             | REER : Percentage Change over last Year / Month                               |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `agriculture.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (158, 56) (rows, columns)
* **Format:** Detected **Tall** (Rows=158 >= Cols=56). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (158, 56) (rows, columns)

* **Original Column Names (56):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 8,848
* **Data Types Summary:** {dtype('float64'): 54, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 85,156 Bytes
* **Per Analyzed Column + Index:**
```
Index                  132
Sectors               6916
Sub-Sectors-Level1    9852
1970-71               1264
1971-72               1264
1972-73               1264
1973-74               1264
1974-75               1264
1975-76               1264
1976-77               1264
1977-78               1264
1978-79               1264
1979-80               1264
1980-81               1264
1981-82               1264
1982-83               1264
1983-84               1264
1984-85               1264
1985-86               1264
1986-87               1264
1987-88               1264
1988-89               1264
1989-90               1264
1990-91               1264
1991-92               1264
1992-93               1264
1993-94               1264
1994-95               1264
1995-96               1264
1996-97               1264
1997-98               1264
1998-99               1264
1999-00               1264
2000-01               1264
2001-02               1264
2002-03               1264
2003-04               1264
2004-05               1264
2005-06               1264
2006-07               1264
2007-08               1264
2008-09               1264
2009-10               1264
2010-11               1264
2011-12               1264
2012-13               1264
2013-14               1264
2014-15               1264
2015-16               1264
2016-17               1264
2017-18               1264
2018-19               1264
2019-20               1264
2020-21               1264
2021-22               1264
2022-23               1264
2023-24               1264
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 158 entries, 0 to 157
Data columns (total 56 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             38 non-null     object 
 1   Sub-Sectors-Level1  120 non-null    object 
 2   1970-71             93 non-null     float64
 3   1971-72             109 non-null    float64
 4   1972-73             106 non-null    float64
 5   1973-74             113 non-null    float64
 6   1974-75             114 non-null    float64
 7   1975-76             120 non-null    float64
 8   1976-77             121 non-null    float64
 9   1977-78             121 non-null    float64
 10  1978-79             121 non-null    float64
 11  1979-80             121 non-null    float64
 12  1980-81             120 non-null    float64
 13  1981-82             121 non-null    float64
 14  1982-83             123 non-null    float64
 15  1983-84             123 non-null    float64
 16  1984-85             123 non-null    float64
 17  1985-86             123 non-null    float64
 18  1986-87             123 non-null    float64
 19  1987-88             123 non-null    float64
 20  1988-89             123 non-null    float64
 21  1989-90             123 non-null    float64
 22  1990-91             124 non-null    float64
 23  1991-92             125 non-null    float64
 24  1992-93             125 non-null    float64
 25  1993-94             125 non-null    float64
 26  1994-95             125 non-null    float64
 27  1995-96             124 non-null    float64
 28  1996-97             122 non-null    float64
 29  1997-98             121 non-null    float64
 30  1998-99             122 non-null    float64
 31  1999-00             122 non-null    float64
 32  2000-01             123 non-null    float64
 33  2001-02             118 non-null    float64
 34  2002-03             114 non-null    float64
 35  2003-04             114 non-null    float64
 36  2004-05             131 non-null    float64
 37  2005-06             135 non-null    float64
 38  2006-07             133 non-null    float64
 39  2007-08             132 non-null    float64
 40  2008-09             137 non-null    float64
 41  2009-10             134 non-null    float64
 42  2010-11             131 non-null    float64
 43  2011-12             131 non-null    float64
 44  2012-13             131 non-null    float64
 45  2013-14             131 non-null    float64
 46  2014-15             132 non-null    float64
 47  2015-16             132 non-null    float64
 48  2016-17             131 non-null    float64
 49  2017-18             131 non-null    float64
 50  2018-19             131 non-null    float64
 51  2019-20             132 non-null    float64
 52  2020-21             132 non-null    float64
 53  2021-22             133 non-null    float64
 54  2022-23             132 non-null    float64
 55  2023-24             114 non-null    float64
dtypes: float64(54), object(2)
memory usage: 69.3+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 1,996 (22.56%)
Columns (56 of 56) with missing values (Sorted):
```
Sectors               120
1970-71                65
1972-73                52
1971-72                49
1973-74                45
2002-03                44
2003-04                44
2023-24                44
1974-75                44
2001-02                40
Sub-Sectors-Level1     38
1980-81                38
1975-76                38
1976-77                37
1978-79                37
1979-80                37
1981-82                37
1977-78                37
1997-98                37
1999-00                36
1998-99                36
1996-97                36
2000-01                35
1986-87                35
1982-83                35
1983-84                35
1984-85                35
1985-86                35
1989-90                35
1988-89                35
1987-88                35
1990-91                34
1995-96                34
1993-94                33
1992-93                33
1991-92                33
1994-95                33
2011-12                27
2018-19                27
2017-18                27
2016-17                27
2013-14                27
2012-13                27
2010-11                27
2004-05                27
2014-15                26
2015-16                26
2019-20                26
2020-21                26
2022-23                26
2007-08                26
2006-07                25
2021-22                25
2009-10                24
2005-06                23
2008-09                21
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 56):
```
Sectors                38
Sub-Sectors-Level1    119
1970-71                90
1971-72               104
1972-73               100
1973-74               106
1974-75               107
1975-76               114
1976-77               116
1977-78               115

...

2014-15    122
2015-16    120
2016-17    123
2017-18    123
2018-19    124
2019-20    123
2020-21    121
2021-22    122
2022-23    121
2023-24    105
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 38 unique values)
```
Sectors
Agricultural Production Index                                1
Procurement/Support Prices of Wheat (Rs per 40 Kg)           1
Crop Wise Composition - Fibre Crop (% Share)                 1
Credit Disbursed by Agencies                                 1
Fertilizer Offtake                                           1
Import of Fertilizers (000 N/Tonnes)                         1
Import of Insecticides                                       1
Average Retail Sale Prices of Fertilizers                    1
Area Irrigated by                                            1
Procurement/Support Prices of Rice                           1
Production of Tractors (Nos)                                 1
Procurement/Support Prices of Paddy                          1
Procurement/Support Prices of Sugarcane (at factory gate)    1
Procurement/Support Prices of Seed Cotton (Phutti)           1
Procurement (000 tonnes)                                     1
Releases (May-April) (000 tonnes)                            1
Stocks as on 1st May (000 tonnes)                            1
Livestock population                                         1
Crop Wise Composition - Cash Crop (% Share)                  1
Crop Wise Composition - Food Crops (% Share)                 1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 119 unique values)
```
Sub-Sectors-Level1
Basmati 385 (Rs per 40 Kg)            2
Food crop Wheat Index                 1
Urea (Rs per bag of 50 Kgs)           1
Others (million hectares)             1
Canal Tubewells (million hectares)    1
Tubewells (million hectares)          1
Canal Wells (million hectares)        1
Wells (million hectares)              1
Canals (million hectares)             1
SOP (Rs per bag of 50 Kgs)            1
DAP (Rs per bag of 50 Kgs)            1
SSP(G) (Rs per bag of 50 Kgs)         1
NP (Rs per bag of 50 Kgs)             1
AS (Rs per bag of 50 Kgs)             1
AN/CAN (Rs per bag of 50 Kgs)         1
Value (Mln Rs.)                       1
Quantity (Tonnes)                     1
Total (000 N/Tonnes)                  1
Potash (000 N/Tonnes)                 1
Phosphorus (000 N/Tonnes)             1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev     | Min   | 25%    | 50%     | 75%      | Max         | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                  | LastNonNull        |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:-----------|:------|:-------|:--------|:---------|:------------|:-----------|:-----------|:----------|:----------|:------------------------------|:-------------------|
| Sectors            | object     |             38 |         120 | 75.95%    |            38 | N/A       | N/A        | N/A   | N/A    | N/A     | N/A      | N/A         | N/A        | N/A        | NaT       | NaT       | Agricultural Production Index | Livestock products |
| Sub-Sectors-Level1 | object     |            120 |          38 | 24.05%    |           119 | N/A       | N/A        | N/A   | N/A    | N/A     | N/A      | N/A         | N/A        | N/A        | NaT       | NaT       | Food crop Wheat Index         | Skins (Mln.Nos.)   |
| 1970-71            | float64    |             93 |          65 | 41.14%    |            90 | 2375.770  | 11031.577  | 0.100 | 14.440 | 79.610  | 558.000  | 97636.000   | 7.555      | 62.617     | NaT       | NaT       | 3879.0                        | 0.1                |
| 1971-72            | float64    |            109 |          49 | 31.01%    |           104 | 1286.505  | 4296.683   | 0.100 | 15.000 | 53.490  | 552.000  | 36165.000   | 6.065      | 43.401     | NaT       | NaT       | 4224.0                        | 16.4               |
| 1972-73            | float64    |            106 |          52 | 32.91%    |           100 | 2618.872  | 12387.845  | 0.100 | 15.527 | 94.850  | 582.250  | 119285.000  | 8.370      | 76.935     | NaT       | NaT       | 1847.0                        | 17.5               |
| 1973-74            | float64    |            113 |          45 | 28.48%    |           106 | 2570.249  | 12983.133  | 0.100 | 18.280 | 105.000 | 633.000  | 130795.000  | 8.968      | 87.081     | NaT       | NaT       | 5216.0                        | 19.4               |
| 1974-75            | float64    |            114 |          44 | 27.85%    |           107 | 2693.380  | 14878.494  | 0.100 | 19.663 | 92.235  | 629.000  | 154290.000  | 9.611      | 97.655     | NaT       | NaT       | 7190.0                        | 21.0               |
| 1975-76            | float64    |            120 |          38 | 24.05%    |           114 | 2831.816  | 15283.259  | 0.100 | 21.925 | 94.140  | 621.000  | 160955.000  | 9.588      | 98.448     | NaT       | NaT       | 10809.0                       | 22.8               |
| 1976-77            | float64    |            121 |          37 | 23.42%    |           116 | 3009.910  | 15879.163  | 0.100 | 22.000 | 100.000 | 649.000  | 167234.000  | 9.508      | 97.421     | NaT       | NaT       | 15554.0                       | 23.6               |
| 1977-78            | float64    |            121 |          37 | 23.42%    |           115 | 2999.455  | 16269.981  | 0.100 | 20.920 | 108.800 | 656.000  | 172361.000  | 9.674      | 100.014    | NaT       | NaT       | 11902.0                       | 24.4               |
| 1978-79            | float64    |            121 |          37 | 23.42%    |           112 | 3053.255  | 16779.082  | 0.100 | 20.700 | 124.000 | 752.000  | 178483.000  | 9.780      | 101.786    | NaT       | NaT       | 15178.0                       | 25.2               |
| 1979-80            | float64    |            121 |          37 | 23.42%    |           116 | 3233.751  | 17751.637  | 0.100 | 21.400 | 117.890 | 805.990  | 188897.000  | 9.788      | 101.927    | NaT       | NaT       | 19313.0                       | 26.1               |
| 1980-81            | float64    |            120 |          38 | 24.05%    |           115 | 3447.891  | 18826.269  | 0.100 | 21.950 | 127.500 | 873.500  | 199658.000  | 9.767      | 101.367    | NaT       | NaT       | 16137.0                       | 26.9               |
| 1981-82            | float64    |            121 |          37 | 23.42%    |           117 | 3561.483  | 19446.939  | 0.100 | 23.000 | 132.800 | 930.000  | 207079.000  | 9.805      | 102.178    | NaT       | NaT       | 16476.0                       | 27.9               |
| 1982-83            | float64    |            123 |          35 | 22.15%    |           120 | 3634.400  | 19775.041  | 0.070 | 24.450 | 134.000 | 978.830  | 213226.000  | 9.988      | 105.681    | NaT       | NaT       | 21089.0                       | 28.8               |
| 1983-84            | float64    |            123 |          35 | 22.15%    |           119 | 3938.381  | 21425.843  | 0.080 | 24.850 | 135.000 | 1012.000 | 230536.000  | 9.931      | 104.755    | NaT       | NaT       | 31622.0                       | 29.8               |
| 1984-85            | float64    |            123 |          35 | 22.15%    |           119 | 4197.181  | 22993.269  | 0.080 | 26.000 | 137.000 | 1137.810 | 248878.000  | 10.090     | 107.399    | NaT       | NaT       | 31246.0                       | 30.8               |
| 1985-86            | float64    |            123 |          35 | 22.15%    |           118 | 4312.956  | 23679.846  | 0.080 | 28.800 | 140.000 | 1203.500 | 257309.000  | 10.196     | 109.154    | NaT       | NaT       | 24815.0                       | 28.6               |
| 1986-87            | float64    |            123 |          35 | 22.15%    |           118 | 4589.692  | 24726.981  | 0.070 | 29.300 | 182.000 | 1320.750 | 268453.000  | 10.162     | 108.617    | NaT       | NaT       | 22241.0                       | 29.6               |
| 1987-88            | float64    |            123 |          35 | 22.15%    |           119 | 4745.772  | 26478.537  | 0.070 | 27.250 | 154.000 | 1384.000 | 288453.000  | 10.279     | 110.441    | NaT       | NaT       | 20819.0                       | 30.6               |
| 1988-89            | float64    |            123 |          35 | 22.15%    |           118 | 4944.024  | 28038.094  | 0.080 | 25.050 | 172.000 | 1386.950 | 305231.000  | 10.270     | 110.250    | NaT       | NaT       | 24639.0                       | 31.7               |
| 1989-90            | float64    |            123 |          35 | 22.15%    |           120 | 5051.504  | 29752.439  | 0.080 | 32.950 | 185.000 | 1308.135 | 325179.000  | 10.403     | 112.355    | NaT       | NaT       | 19939.0                       | 32.9               |
| 1990-91            | float64    |            124 |          34 | 21.52%    |           119 | 5003.725  | 30907.559  | 0.080 | 25.810 | 154.000 | 1239.000 | 339840.000  | 10.527     | 114.536    | NaT       | NaT       | 13841.0                       | 32.7               |
| 1991-92            | float64    |            125 |          33 | 20.89%    |           121 | 5156.623  | 32250.573  | 0.100 | 24.480 | 150.000 | 1000.000 | 355840.000  | 10.560     | 115.287    | NaT       | NaT       | 9817.0                        | 33.9               |
| 1992-93            | float64    |            125 |          33 | 20.89%    |           119 | 5372.644  | 33863.959  | 0.100 | 24.350 | 182.600 | 1179.000 | 374099.000  | 10.598     | 115.924    | NaT       | NaT       | 17127.0                       | 36.0               |
| 1993-94            | float64    |            125 |          33 | 20.89%    |           118 | 6422.766  | 41872.369  | 0.100 | 24.440 | 228.000 | 1256.000 | 463463.000  | 10.672     | 117.086    | NaT       | NaT       | 14144.0                       | 39.3               |
| 1994-95            | float64    |            125 |          33 | 20.89%    |           120 | 6733.469  | 43804.516  | 0.100 | 24.000 | 222.000 | 1487.000 | 485050.000  | 10.682     | 117.270    | NaT       | NaT       | 16903.0                       | 32.7               |
| 1995-96            | float64    |            124 |          34 | 21.52%    |           117 | 6875.746  | 45766.624  | 0.100 | 24.500 | 229.500 | 1516.750 | 505804.000  | 10.714     | 117.503    | NaT       | NaT       | 10417.0                       | 34.5               |
| 1996-97            | float64    |            122 |          36 | 22.78%    |           117 | 7609.020  | 48604.460  | 0.100 | 33.950 | 245.810 | 1550.750 | 531259.000  | 10.520     | 113.945    | NaT       | NaT       | 14144.0                       | 35.3               |
| 1997-98            | float64    |            121 |          37 | 23.42%    |           116 | 8133.119  | 50872.312  | 0.090 | 32.100 | 240.000 | 1665.000 | 553226.000  | 10.437     | 112.413    | NaT       | NaT       | 26885.0                       | 36.3               |
| 1998-99            | float64    |            122 |          36 | 22.78%    |           116 | 8516.819  | 55631.274  | 0.090 | 32.750 | 286.000 | 1701.500 | 609775.000  | 10.614     | 115.430    | NaT       | NaT       | 35038.0                       | 37.2               |
| 1999-00            | float64    |            122 |          36 | 22.78%    |           116 | 8913.782  | 60044.785  | 0.100 | 33.500 | 266.000 | 1804.000 | 659278.000  | 10.681     | 116.458    | NaT       | NaT       | 32553.0                       | 38.2               |
| 2000-01            | float64    |            123 |          35 | 22.15%    |           118 | 9299.059  | 63791.014  | 0.160 | 32.165 | 290.000 | 1786.500 | 703093.000  | 10.725     | 117.401    | NaT       | NaT       | 24311.0                       | 39.2               |
| 2001-02            | float64    |            118 |          40 | 25.32%    |           110 | 10258.585 | 70604.548  | 0.170 | 40.725 | 326.500 | 1737.000 | 762902.000  | 10.536     | 113.101    | NaT       | NaT       | 27101.0                       | 40.3               |
| 2002-03            | float64    |            114 |          44 | 27.85%    |           110 | 12688.448 | 88574.511  | 0.150 | 40.525 | 355.000 | 1994.750 | 941752.000  | 10.398     | 109.883    | NaT       | NaT       | 36059.0                       | 42.4               |
| 2003-04            | float64    |            114 |          44 | 27.85%    |           110 | 13441.354 | 90069.162  | 0.190 | 40.650 | 365.500 | 2495.750 | 954842.000  | 10.295     | 108.304    | NaT       | NaT       | 44095.0                       | 42.6               |
| 2004-05            | float64    |            131 |          27 | 17.09%    |           124 | 5707.980  | 16591.720  | 0.150 | 31.500 | 343.000 | 2133.000 | 108733.000  | 4.445      | 22.662     | NaT       | NaT       | 44095.0                       | 42.6               |
| 2005-06            | float64    |            135 |          23 | 14.56%    |           124 | 6220.946  | 19698.110  | 0.200 | 37.115 | 300.000 | 2111.700 | 137474.000  | 5.054      | 29.185     | NaT       | NaT       | 100.0                         | 43.3               |
| 2006-07            | float64    |            133 |          25 | 15.82%    |           126 | 7167.748  | 23782.755  | 0.200 | 40.600 | 306.000 | 2107.000 | 168830.000  | 5.323      | 32.050     | NaT       | NaT       | 110.0                         | 44.3               |
| 2007-08            | float64    |            132 |          26 | 16.46%    |           125 | 8265.165  | 29092.317  | 0.170 | 32.700 | 293.000 | 2232.500 | 211561.000  | 5.682      | 36.028     | NaT       | NaT       | 99.0                          | 45.3               |
| 2008-09            | float64    |            137 |          21 | 13.29%    |           129 | 8634.086  | 31246.854  | 0.200 | 41.500 | 469.000 | 2346.000 | 233010.000  | 5.935      | 38.957     | NaT       | NaT       | 113.0                         | 46.3               |
| 2009-10            | float64    |            134 |          24 | 15.19%    |           126 | 9427.116  | 33726.919  | 0.200 | 35.760 | 361.000 | 2382.750 | 248120.000  | 5.830      | 37.588     | NaT       | NaT       | 110.0                         | 47.4               |
| 2010-11            | float64    |            131 |          27 | 17.09%    |           120 | 10057.108 | 36215.017  | 0.200 | 34.000 | 346.000 | 2748.000 | 263022.000  | 5.794      | 36.809     | NaT       | NaT       | 119.0                         | 48.5               |
| 2011-12            | float64    |            131 |          27 | 17.09%    |           123 | 10683.945 | 39617.486  | 0.190 | 35.000 | 284.000 | 3021.000 | 293850.000  | 6.082      | 40.181     | NaT       | NaT       | 110.0                         | 49.6               |
| 2012-13            | float64    |            131 |          27 | 17.09%    |           121 | 11643.955 | 45174.983  | 0.190 | 36.000 | 327.080 | 2824.500 | 336247.000  | 6.200      | 41.256     | NaT       | NaT       | 114.0                         | 50.7               |
| 2013-14            | float64    |            131 |          27 | 17.09%    |           121 | 13101.967 | 52202.510  | 0.170 | 37.500 | 359.180 | 3004.500 | 391353.000  | 6.320      | 42.608     | NaT       | NaT       | 122.0                         | 51.9               |
| 2014-15            | float64    |            132 |          26 | 16.46%    |           122 | 15906.298 | 68165.983  | 0.170 | 37.973 | 390.500 | 3326.750 | 515875.000  | 6.515      | 44.610     | NaT       | NaT       | 118.0                         | 53.1               |
| 2015-16            | float64    |            132 |          26 | 16.46%    |           120 | 17691.154 | 78941.540  | 0.200 | 41.500 | 302.000 | 3085.750 | 598287.000  | 6.587      | 45.262     | NaT       | NaT       | 100.0                         | 54.3               |
| 2016-17            | float64    |            131 |          27 | 17.09%    |           123 | 20501.975 | 92522.049  | 0.100 | 42.500 | 330.000 | 3351.500 | 704488.000  | 6.658      | 46.257     | NaT       | NaT       | 104.0                         | 55.5               |
| 2017-18            | float64    |            131 |          27 | 17.09%    |           123 | 26873.178 | 128718.659 | 0.200 | 43.705 | 331.000 | 3168.000 | 972606.000  | 6.659      | 45.694     | NaT       | NaT       | 98.0                          | 56.8               |
| 2018-19            | float64    |            131 |          27 | 17.09%    |           124 | 31369.526 | 155745.475 | 0.160 | 44.045 | 447.000 | 3463.000 | 1173990.000 | 6.677      | 45.674     | NaT       | NaT       | 95.0                          | 58.1               |
| 2019-20            | float64    |            132 |          26 | 16.46%    |           123 | 32261.868 | 161485.781 | 0.200 | 47.825 | 510.000 | 3129.250 | 1214684.000 | 6.664      | 45.344     | NaT       | NaT       | 99.0                          | 59.5               |
| 2020-21            | float64    |            132 |          26 | 16.46%    |           121 | 36183.565 | 181868.211 | 0.200 | 43.605 | 304.800 | 4028.500 | 1365870.000 | 6.649      | 45.130     | NaT       | NaT       | 107.0                         | 60.8               |
| 2021-22            | float64    |            133 |          25 | 15.82%    |           122 | 37572.659 | 186530.495 | 0.200 | 44.000 | 367.000 | 5001.000 | 1418906.000 | 6.721      | 46.479     | NaT       | NaT       | 102.0                         | 62.3               |
| 2022-23            | float64    |            132 |          26 | 16.46%    |           121 | 45875.235 | 234733.516 | 0.200 | 43.910 | 361.250 | 4366.000 | 1775956.000 | 6.709      | 46.115     | NaT       | NaT       | 110.0                         | 63.7               |
| 2023-24            | float64    |            114 |          44 | 27.85%    |           105 | 49629.888 | 231504.941 | 0.200 | 91.000 | 812.000 | 6450.500 | 1635218.000 | 6.212      | 39.510     | NaT       | NaT       | 123.0                         | 65.2               |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 744 pairs with absolute correlation > 0.8 (showing top 50):*
```
1990-91  1992-93    0.999936
2019-20  2020-21    0.999836
1990-91  1991-92    0.999834
2000-01  2001-02    0.999826
1994-95  1995-96    0.999781
1998-99  1999-00    0.999764
1980-81  1981-82    0.999764
1999-00  2001-02    0.999756
2018-19  2019-20    0.999750
1993-94  1996-97    0.999735
1999-00  2000-01    0.999728
1989-90  1992-93    0.999725
         1990-91    0.999721
1978-79  1980-81    0.999717
1991-92  1992-93    0.999693
2001-02  2002-03    0.999684
1987-88  1988-89    0.999674
1993-94  1994-95    0.999673
1975-76  1977-78    0.999673
1988-89  1989-90    0.999651
2000-01  2002-03    0.999648
1985-86  1986-87    0.999634
2021-22  2022-23    0.999608
1992-93  1993-94    0.999596
1978-79  1979-80    0.999573
2018-19  2021-22    0.999563
1996-97  1997-98    0.999534
1986-87  1987-88    0.999534
1979-80  1980-81    0.999519
1990-91  1993-94    0.999514
1998-99  2000-01    0.999499
1975-76  1976-77    0.999467
1987-88  1989-90    0.999460
1993-94  1995-96    0.999439
2022-23  2023-24    0.999434
2018-19  2020-21    0.999414
1994-95  1996-97    0.999407
1976-77  1977-78    0.999404
2018-19  2022-23    0.999395
1991-92  1993-94    0.999387
1985-86  1987-88    0.999382
2017-18  2018-19    0.999360
1999-00  2002-03    0.999357
1997-98  1998-99    0.999336
1998-99  2001-02    0.999332
1995-96  1996-97    0.999327
2019-20  2022-23    0.999326
1992-93  1994-95    0.999318
1980-81  1982-83    0.999289
2019-20  2021-22    0.999277
```


---


## Analysis for: `borrow_loans.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (8680, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=8680 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (8680, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 78,120
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 4,567,632 Bytes
* **Per Analyzed Column + Index:**
```
Index                     132
Dataset Name           755160
Observation Date        69440
Series Key             703080
Series Display Name    925610
Observation Value       69440
Unit                   520800
Observation Status     477400
Sequence No.            69440
Series name            977130
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 8680 entries, 0 to 8679
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         8680 non-null   object        
 1   Observation Date     8680 non-null   datetime64[ns]
 2   Series Key           8680 non-null   object        
 3   Series Display Name  8680 non-null   object        
 4   Observation Value    8680 non-null   float64       
 5   Unit                 8680 non-null   object        
 6   Observation Status   8680 non-null   object        
 7   Sequence No.         8680 non-null   int64         
 8   Series name          8680 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 610.4+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2019-06-30 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 70
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 8610 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date         70
Series Key              124
Series Display Name     124
Observation Value      8653
Unit                      1
Observation Status        1
Sequence No.            124
Series name             124
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Credit / Loans Classified by Borrowers    8680
```
**Column: `Series Key`** (Top 20 of 124 unique values)
```
Series Key
TS_GP_BAM_CRLONBOR_M.CLB00011000    70
TS_GP_BAM_CRLONBOR_M.CLB00089000    70
TS_GP_BAM_CRLONBOR_M.CLB00102000    70
TS_GP_BAM_CRLONBOR_M.CLB00101000    70
TS_GP_BAM_CRLONBOR_M.CLB00100000    70
TS_GP_BAM_CRLONBOR_M.CLB00099000    70
TS_GP_BAM_CRLONBOR_M.CLB00098000    70
TS_GP_BAM_CRLONBOR_M.CLB00097000    70
TS_GP_BAM_CRLONBOR_M.CLB00096000    70
TS_GP_BAM_CRLONBOR_M.CLB00095000    70
TS_GP_BAM_CRLONBOR_M.CLB00094000    70
TS_GP_BAM_CRLONBOR_M.CLB00093000    70
TS_GP_BAM_CRLONBOR_M.CLB00092000    70
TS_GP_BAM_CRLONBOR_M.CLB00091000    70
TS_GP_BAM_CRLONBOR_M.CLB00090000    70
TS_GP_BAM_CRLONBOR_M.CLB00088000    70
TS_GP_BAM_CRLONBOR_M.CLB00012000    70
TS_GP_BAM_CRLONBOR_M.CLB00087000    70
TS_GP_BAM_CRLONBOR_M.CLB00086000    70
TS_GP_BAM_CRLONBOR_M.CLB00085000    70
```
**Column: `Series Display Name`** (Top 20 of 124 unique values)
```
Series Display Name
1 Credit to Government sector (A+B)                                                                                                 70
..................56- Food and beverage service activities                                                                          70
..................72- Scientific research and development                                                                           70
..................71- Architectural and engineering activities; technical testing and analysis                                      70
..................70- Activities of head offices; management consultancy activities                                                 70
..................69- Legal and accounting activities                                                                               70
............L. Professional, scientific and technical activities                                                                    70
............K. Real estate activities                                                                                               70
..................63- Information service activities                                                                                70
..................62- Computer programming, consultancy and related activities                                                      70
..................61- Telecommunications                                                                                            70
..................60- Programming and broadcasting activities                                                                       70
..................59- Motion picture, video and television programme production, sound recording and music publishing activities    70
..................58- Publishing activities                                                                                         70
............J. Information and communication                                                                                        70
..................55- Accommodation                                                                                                 70
......A. SBP Credit to Government sector (Net)                                                                                      70
............I. Accommodation and food service activities                                                                            70
..................53- Courier activities other than national post activities                                                        70
..................52- Warehousing and support activities for transportation                                                         70
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million PKR    8680
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    8680
```
**Column: `Series name`** (Top 20 of 124 unique values)
```
Series name
SBP & Scheduled Banks Credit to Government sector                                                                                      70
Scheduled Banks Loans to Food and beverage service activities                                                                          70
Scheduled Banks Loans to Scientific research and development                                                                           70
Scheduled Banks Loans to Architectural and engineering activities; technical testing and analysis                                      70
Scheduled Banks Loans to Activities of head offices; management consultancy activities                                                 70
Scheduled Banks Loans to Legal and accounting activities                                                                               70
Scheduled Banks Loans to Professional, scientific and technical activities sector                                                      70
Scheduled Banks Loans to Real estate activities sector                                                                                 70
Scheduled Banks Loans to Information service activities                                                                                70
Scheduled Banks Loans to Computer programming, consultancy and related activities                                                      70
Scheduled Banks Loans to Telecommunications                                                                                            70
Scheduled Banks Loans to Programming and broadcasting activities                                                                       70
Scheduled Banks Loans to Motion picture, video and television programme production, sound recording and music publishing activities    70
Scheduled Banks Loans to Publishing activities                                                                                         70
Scheduled Banks Loans to Information and Communication sector                                                                          70
Scheduled Banks Loans to Accommodation sector                                                                                          70
SBP Credit to Government Sector                                                                                                        70
Scheduled Banks Loans to Accommodation and food service activities sector                                                              70
Scheduled Banks Loans to Courier activities other than national post activities                                                        70
Scheduled Banks Loans to Warehousing and support activities for transportation                                                         70
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev      | Min    | 25%      | 50%       | 75%        | Max          | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                      | LastNonNull                            |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:------------|:------------|:-------|:---------|:----------|:-----------|:-------------|:-----------|:-----------|:--------------------|:--------------------|:--------------------------------------------------|:---------------------------------------|
| Dataset Name        | object         |           8680 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | Credit / Loans Classified by Borrowers            | Credit / Loans Classified by Borrowers |
| Observation Date    | datetime64[ns] |           8680 |           0 | 0.00%     |            70 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | 2019-06-30 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                               | 2019-06-30 00:00:00                    |
| Series Key          | object         |           8680 |           0 | 0.00%     |           124 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | TS_GP_BAM_CRLONBOR_M.CLB00011000                  | TS_GP_BAM_CRLONBOR_M.CLB00134000       |
| Series Display Name | object         |           8680 |           0 | 0.00%     |           124 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | 1 Credit to Government sector (A+B)               | . Total Credit                         |
| Observation Value   | float64        |           8680 |           0 | 0.00%     |          8653 | 1066618.486 | 4000599.027 | 0.000  | 3103.233 | 35385.812 | 194342.187 | 46223137.580 | 5.982      | 42.843     | NaT                 | NaT                 | 33173299.55                                       | 20215538.92                            |
| Unit                | object         |           8680 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | Million PKR                                       | Million PKR                            |
| Observation Status  | object         |           8680 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | Normal                                            | Normal                                 |
| Sequence No.        | int64          |           8680 |           0 | 0.00%     |           124 | 625.000     | 357.966     | 10.000 | 317.500  | 625.000   | 932.500    | 1240.000     | 0.000      | -1.200     | NaT                 | NaT                 | 10                                                | 1240                                   |
| Series name         | object         |           8680 |           0 | 0.00%     |           124 | N/A         | N/A         | N/A    | N/A      | N/A       | N/A        | N/A          | N/A        | N/A        | NaT                 | NaT                 | SBP & Scheduled Banks Credit to Government sector | Total Credit                           |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `capital_markets_and_corporate_sector.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (33, 36) (rows, columns)
* **Format:** Detected **Wide** (Cols=36 > Rows=33). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Could not reliably convert transposed index to numeric/datetime. Kept as: object
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (35, 33) (rows, columns)

* **Original Column Names (36):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

* **Analyzed Column Names (33):**
  ```
  ['National Savings Schemes (Net Investment)', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'Loans Disbursed by DFIs & Other Financial Institutions', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'KSE-100 Index (End June)', 'Market Capitalization Rs billion (End June)']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 1,155
* **Data Types Summary:** {dtype('float64'): 33}

### Memory Usage (Bytes)

* **Total:** 11,211 Bytes
* **Per Analyzed Column + Index:**
```
Index                                                     1971
National Savings Schemes (Net Investment)                  280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
Loans Disbursed by DFIs & Other Financial Institutions     280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
NaN                                                        280
KSE-100 Index (End June)                                   280
Market Capitalization Rs billion (End June)                280
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 35 entries, Sub-Sectors-Level1 to 2023-24
Data columns (total 33 columns):
 #   Column                                                  Non-Null Count  Dtype  
---  ------                                                  --------------  -----  
 0   National Savings Schemes (Net Investment)               0 non-null      float64
 1   nan                                                     34 non-null     float64
 2   nan                                                     32 non-null     float64
 3   nan                                                     34 non-null     float64
 4   nan                                                     34 non-null     float64
 5   nan                                                     28 non-null     float64
 6   nan                                                     34 non-null     float64
 7   nan                                                     21 non-null     float64
 8   nan                                                     22 non-null     float64
 9   nan                                                     34 non-null     float64
 10  nan                                                     34 non-null     float64
 11  nan                                                     34 non-null     float64
 12  nan                                                     34 non-null     float64
 13  nan                                                     20 non-null     float64
 14  nan                                                     4 non-null      float64
 15  nan                                                     12 non-null     float64
 16  nan                                                     8 non-null      float64
 17  nan                                                     6 non-null      float64
 18  nan                                                     2 non-null      float64
 19  nan                                                     34 non-null     float64
 20  Loans Disbursed by DFIs & Other Financial Institutions  0 non-null      float64
 21  nan                                                     5 non-null      float64
 22  nan                                                     5 non-null      float64
 23  nan                                                     5 non-null      float64
 24  nan                                                     7 non-null      float64
 25  nan                                                     15 non-null     float64
 26  nan                                                     21 non-null     float64
 27  nan                                                     21 non-null     float64
 28  nan                                                     22 non-null     float64
 29  nan                                                     11 non-null     float64
 30  nan                                                     7 non-null      float64
 31  KSE-100 Index (End June)                                33 non-null     float64
 32  Market Capitalization Rs billion (End June)             33 non-null     float64
dtypes: float64(33)
memory usage: 9.3+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 509 (44.07%)
Columns (33 of 33) with missing values (Sorted):
```
Sectors
National Savings Schemes (Net Investment)                 35
Loans Disbursed by DFIs & Other Financial Institutions    35
NaN                                                       33
NaN                                                       31
NaN                                                       30
NaN                                                       30
NaN                                                       30
NaN                                                       29
NaN                                                       28
NaN                                                       28
NaN                                                       27
NaN                                                       24
NaN                                                       23
NaN                                                       20
NaN                                                       15
NaN                                                       14
NaN                                                       14
NaN                                                       14
NaN                                                       13
NaN                                                       13
NaN                                                        7
NaN                                                        3
KSE-100 Index (End June)                                   2
Market Capitalization Rs billion (End June)                2
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 33):
```
Sectors
National Savings Schemes (Net Investment)     0
NaN                                          34
NaN                                          27
NaN                                          30
NaN                                          34
NaN                                          25
NaN                                          33
NaN                                          21
NaN                                          22
NaN                                          34

...

Sectors
NaN                                             5
NaN                                             6
NaN                                            15
NaN                                            20
NaN                                            20
NaN                                            22
NaN                                             7
NaN                                             7
KSE-100 Index (End June)                       33
Market Capitalization Rs billion (End June)    33
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                                                | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev     | Min         | 25%        | 50%       | 75%        | Max        | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull   | LastNonNull   |
|:-------------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:-----------|:------------|:-----------|:----------|:-----------|:-----------|:-----------|:-----------|:----------|:----------|:---------------|:--------------|
| National Savings Schemes (Net Investment)              | float64    |              0 |          35 | 100.00%   |             0 | N/A       | N/A        | N/A         | N/A        | N/A       | N/A        | N/A        | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 10831.862 | 25601.837  | -38530.100  | -6311.950  | 10245.850 | 21656.575  | 92783.100  | 0.740      | 2.264      | NaT       | NaT       | 6770.5         | -24658.1      |
| nan                                                    | float64    |             32 |           3 | 8.57%     |            27 | -205.591  | 387.479    | -1266.800   | -68.250    | -1.900    | -0.375     | 0.100      | -1.629     | 1.114      | NaT       | NaT       | -1015.6        | 0.0           |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            30 | -2469.303 | 7897.749   | -30203.700  | -51.325    | -4.050    | -0.300     | 13.500     | -3.118     | 8.391      | NaT       | NaT       | -30203.7       | -0.1          |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 8185.885  | 44371.321  | -83311.900  | -11108.025 | 13873.150 | 27649.500  | 128469.000 | 0.071      | 0.924      | NaT       | NaT       | 18326.4        | -12701.4      |
| nan                                                    | float64    |             28 |           7 | 20.00%    |            25 | -6.771    | 642.746    | -1670.700   | -5.575     | -0.600    | 2.775      | 1375.600   | -0.301     | 1.470      | NaT       | NaT       | 1375.6         | -0.5          |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            33 | 21051.809 | 53145.784  | -127536.200 | 0.000      | 12985.100 | 44396.625  | 187710.700 | 0.593      | 3.744      | NaT       | NaT       | 0.0            | 187710.7      |
| nan                                                    | float64    |             21 |          14 | 40.00%    |            21 | 49408.762 | 28533.291  | -16017.100  | 38799.700  | 52254.500 | 60654.600  | 119573.100 | -0.053     | 1.713      | NaT       | NaT       | 22691.0        | 36580.0       |
| nan                                                    | float64    |             22 |          13 | 37.14%    |            22 | 19585.059 | 7322.214   | 10170.000   | 16350.275  | 18053.600 | 21289.575  | 43367.400  | 1.966      | 4.892      | NaT       | NaT       | 10170.0        | 26518.8       |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 2221.885  | 5683.629   | -10899.200  | -296.525   | 1091.200  | 4130.525   | 20087.100  | 0.809      | 2.539      | NaT       | NaT       | 1659.3         | 4181.2        |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 1959.165  | 82547.048  | -273790.900 | 1345.200   | 4571.000  | 19780.525  | 200770.600 | -1.077     | 4.451      | NaT       | NaT       | 4875.1         | -38105.3      |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 27.094    | 109.018    | -195.700    | -70.125    | 23.800    | 113.875    | 209.400    | 0.222      | -0.928     | NaT       | NaT       | 154.6          | -73.7         |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 8963.291  | 76011.672  | -315531.700 | 4711.100   | 10097.400 | 39963.250  | 123901.900 | -2.714     | 10.379     | NaT       | NaT       | 3066.1         | 1722.8        |
| nan                                                    | float64    |             20 |          15 | 42.86%    |            20 | 3214.780  | 3539.722   | -1311.900   | 1061.575   | 1477.300  | 4895.125   | 10804.500  | 1.138      | 0.077      | NaT       | NaT       | 397.5          | -1311.9       |
| nan                                                    | float64    |              4 |          31 | 88.57%    |             4 | -0.000    | 2880.943   | -3425.600   | -959.150   | -99.800   | 859.350    | 3625.200   | 0.207      | 1.521      | NaT       | NaT       | 3625.2         | -137.0        |
| nan                                                    | float64    |             12 |          23 | 65.71%    |            12 | 4320.600  | 12705.436  | -20362.200  | 331.300    | 725.650   | 7245.025   | 29906.700  | 0.345      | 1.284      | NaT       | NaT       | 3969.7         | 17071.0       |
| nan                                                    | float64    |              8 |          27 | 77.14%    |             8 | 6775.350  | 9119.076   | -2155.100   | 1521.600   | 2870.850  | 11668.600  | 25147.200  | 1.290      | 1.359      | NaT       | NaT       | 2921.7         | -883.2        |
| nan                                                    | float64    |              6 |          29 | 82.86%    |             6 | 29.300    | 9.550      | 19.000      | 23.525     | 25.600    | 36.900     | 42.100     | 0.668      | -1.688     | NaT       | NaT       | 42.1           | 23.3          |
| nan                                                    | float64    |              2 |          33 | 94.29%    |             2 | 38346.400 | 47042.966  | 5082.000    | 21714.200  | 38346.400 | 54978.600  | 71610.800  | N/A        | N/A        | NaT       | NaT       | 5082.0         | 71610.8       |
| nan                                                    | float64    |             34 |           1 | 2.86%     |            34 | 90033.768 | 184008.545 | -381865.400 | 9430.450   | 91374.650 | 207458.275 | 386075.900 | -0.947     | 1.253      | NaT       | NaT       | 5405.9         | -104993.0     |
| Loans Disbursed by DFIs & Other Financial Institutions | float64    |              0 |          35 | 100.00%   |             0 | N/A       | N/A        | N/A         | N/A        | N/A       | N/A        | N/A        | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                    | float64    |              5 |          30 | 85.71%    |             5 | 12.000    | 8.034      | 2.900       | 8.700      | 10.600    | 13.100     | 24.700     | 1.011      | 1.902      | NaT       | NaT       | 2.9            | 10.6          |
| nan                                                    | float64    |              5 |          30 | 85.71%    |             5 | 29.080    | 13.987     | 11.300      | 23.100     | 25.200    | 38.800     | 47.000     | 0.119      | -1.028     | NaT       | NaT       | 11.3           | 23.1          |
| nan                                                    | float64    |              5 |          30 | 85.71%    |             5 | 19.860    | 15.465     | 2.500       | 11.100     | 17.900    | 24.400     | 43.400     | 0.814      | 0.833      | NaT       | NaT       | 2.5            | 24.4          |
| nan                                                    | float64    |              7 |          28 | 80.00%    |             6 | 1.886     | 0.926      | 0.200       | 1.450      | 2.300     | 2.450      | 2.900      | -1.017     | 0.670      | NaT       | NaT       | 0.2            | 2.6           |
| nan                                                    | float64    |             15 |          20 | 57.14%    |            15 | 57.793    | 67.402     | 0.000       | 0.700      | 2.300     | 116.150    | 170.500    | 0.527      | -1.551     | NaT       | NaT       | 0.0            | 170.5         |
| nan                                                    | float64    |             21 |          14 | 40.00%    |            20 | 12.157    | 8.116      | 1.200       | 3.700      | 14.500    | 16.500     | 29.100     | 0.178      | -0.776     | NaT       | NaT       | 15.9           | 2.0           |
| nan                                                    | float64    |             21 |          14 | 40.00%    |            20 | 15.205    | 22.316     | 0.500       | 2.400      | 7.400     | 20.100     | 84.500     | 2.316      | 5.057      | NaT       | NaT       | 4.4            | 84.5          |
| nan                                                    | float64    |             22 |          13 | 37.14%    |            22 | 10.936    | 6.719      | 4.800       | 7.350      | 9.700     | 12.150     | 37.200     | 3.061      | 11.511     | NaT       | NaT       | 4.8            | 15.1          |
| nan                                                    | float64    |             11 |          24 | 68.57%    |             7 | 0.400     | 0.704      | 0.000       | 0.050      | 0.100     | 0.350      | 2.400      | 2.723      | 7.852      | NaT       | NaT       | 0.1            | 0.2           |
| nan                                                    | float64    |              7 |          28 | 80.00%    |             7 | 1.257     | 1.044      | 0.100       | 0.550      | 1.000     | 1.950      | 2.700      | 0.540      | -1.214     | NaT       | NaT       | 0.1            | 0.9           |
| KSE-100 Index (End June)                               | float64    |             33 |           2 | 5.71%     |            33 | 15852.818 | 16414.698  | 880.000     | 1612.000   | 9722.000  | 33902.000  | 47356.000  | 0.775      | -1.034     | NaT       | NaT       | 1572.0         | 41453.0       |
| Market Capitalization Rs billion (End June)            | float64    |             33 |           2 | 5.71%     |            33 | 3348.121  | 3125.958   | 68.000      | 392.000    | 2732.000  | 6530.000   | 9522.000   | 0.532      | -1.234     | NaT       | NaT       | 68.0           | 6369.0        |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)


*Could not calculate correlations (Error: Unable to allocate 5.40 MiB for an array with shape (841, 841) and data type float64).*


---


## Analysis for: `consumer_confidence_survey.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (10856, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=10856 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (10856, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 97,704
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 5,853,872 Bytes
* **Per Analyzed Column + Index:**
```
Index                      132
Dataset Name           1498128
Observation Date         86848
Series Key              812176
Series Display Name     968944
Observation Value        86848
Unit                    663872
Observation Status      597136
Sequence No.             86848
Series name            1052940
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 10856 entries, 0 to 10855
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         10856 non-null  object        
 1   Observation Date     10856 non-null  datetime64[ns]
 2   Series Key           10856 non-null  object        
 3   Series Display Name  10856 non-null  object        
 4   Observation Value    10848 non-null  float64       
 5   Unit                 10856 non-null  object        
 6   Observation Status   10856 non-null  object        
 7   Sequence No.         10856 non-null  int64         
 8   Series name          10856 non-null  object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 763.4+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2012-01-01 00:00:00
* **Max Date:** 2025-02-01 00:00:00
* **Number of Unique Dates:** 92
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 10764 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 8 (0.01%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    8
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name               1
Observation Date          92
Series Key               118
Series Display Name       44
Observation Value      10799
Unit                       3
Observation Status         2
Sequence No.             118
Series name              118
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Consumer Confidence Survey – Indices    10856
```
**Column: `Series Key`** (Top 20 of 118 unique values)
```
Series Key
TS_GP_RL_CCSIND_M.CCI            92
TS_GP_RL_CCSIND_M.A5_PERC_NEG    92
TS_GP_RL_CCSIND_M.A9_PERC_POS    92
TS_GP_RL_CCSIND_M.A9_INDEX       92
TS_GP_RL_CCSIND_M.A8_PERC_NEG    92
TS_GP_RL_CCSIND_M.A8_PERC_POS    92
TS_GP_RL_CCSIND_M.A8_INDEX       92
TS_GP_RL_CCSIND_M.A7_PERC_NEG    92
TS_GP_RL_CCSIND_M.A7_PERC_POS    92
TS_GP_RL_CCSIND_M.A7_INDEX       92
TS_GP_RL_CCSIND_M.A6_TMEAN10     92
TS_GP_RL_CCSIND_M.A6_TMEAN5      92
TS_GP_RL_CCSIND_M.A6_TMEAN1      92
TS_GP_RL_CCSIND_M.A6_MEAN        92
TS_GP_RL_CCSIND_M.A5_PERC_POS    92
TS_GP_RL_CCSIND_M.A10_INDEX      92
TS_GP_RL_CCSIND_M.A5_INDEX       92
TS_GP_RL_CCSIND_M.A4_PERC_NEG    92
TS_GP_RL_CCSIND_M.A4_PERC_POS    92
TS_GP_RL_CCSIND_M.A4_INDEX       92
```
**Column: `Series Display Name`** (Top 20 of 44 unique values)
```
Series Display Name
......ii Share of Negative Responses                              1656
......i Share of Positive Responses                               1656
............. - Urban                                              368
....... By Gender - Male                                           368
............. - Female                                             368
....... By Education Level - below Matriculation                   368
............. - Matric or Intermediate                             368
............. - Graduate or higher                                 368
....... By Profession - Employee                                   368
............. - Business (services)                                368
............. - Business (industry)                                368
............. - Business (agriculture)                             368
....... By Income Group - less than Rs 50,000                      368
....... By Area - Rural                                            368
............. - More than Rs 100,000                               276
............. - From Rs 50,000 to Rs 100,000                       276
Q19 Unemployment in the next six months compared to today           92
Q17 Current times for purchase or construction of a new house       92
Q16 Next six months for purchasing automobile (car/motorcycle)      92
Q15 Next six months for purchasing durable household items          92
```
**Column: `Unit`** (Top 3 of 3 unique values)
```
Unit
Diffusion Index    7176
Percent            3312
PKR                 368
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           10848
Missing value        8
```
**Column: `Series name`** (Top 20 of 118 unique values)
```
Series name
Consumer Confidence Index                                                                   92
Q5 Share of Negative Responses                                                              92
Q9 Share of Positive Responses                                                              92
Current energy prices compared to last six months                                           92
Q8 Share of Negative Responses                                                              92
Q8 Share of Positive Responses                                                              92
Food prices in next six months compared to today                                            92
Q7 Share of Negative Responses                                                              92
Q7 Share of Positive Responses                                                              92
Current Food prices compared to last six months                                             92
Price of item in six months that costs Rs 100 today (tmean10= 10% trimming at both ends)    92
Price of item in six months that costs Rs 100 today (tmean5= 5% trimming at both ends)      92
Price of item in six months that costs Rs 100 today (tmean1= 1% trimming at both ends)      92
Price of item in six months that costs Rs 100 today (mean)                                  92
Q5 Share of Positive Responses                                                              92
Energy prices in next six months compared to today                                          92
Prices of daily use items in next six months                                                92
Q4 Share of Negative Responses                                                              92
Q4 Share of Positive Responses                                                              92
General Economic conditions over next six months compared to today                          92
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%     | 50%     | 75%     | Max      | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                         | LastNonNull                          |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:--------|:--------|:--------|:---------|:-----------|:-----------|:--------------------|:--------------------|:-------------------------------------|:-------------------------------------|
| Dataset Name        | object         |          10856 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Consumer Confidence Survey – Indices | Consumer Confidence Survey – Indices |
| Observation Date    | datetime64[ns] |          10856 |           0 | 0.00%     |            92 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | 2012-01-01 00:00:00 | 2025-02-01 00:00:00 | 2025-02-01 00:00:00                  | 2012-01-01 00:00:00                  |
| Series Key          | object         |          10856 |           0 | 0.00%     |           118 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | TS_GP_RL_CCSIND_M.CCI                | TS_GP_RL_CCSIND_M.A20_PERC_NEG       |
| Series Display Name | object         |          10856 |           0 | 0.00%     |            44 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | . Consumer Confidence Index          | ......ii Share of Negative Responses |
| Observation Value   | float64        |          10848 |           8 | 0.07%     |         10799 | 45.683  | 30.650   | 0.059  | 30.855  | 41.622  | 57.429  | 324.313  | 2.206      | 9.427      | NaT                 | NaT                 | 40.262421                            | 23.33302681                          |
| Unit                | object         |          10856 |           0 | 0.00%     |             3 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Diffusion Index                      | Percent                              |
| Observation Status  | object         |          10856 |           0 | 0.00%     |             2 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Normal                               | Normal                               |
| Sequence No.        | int64          |          10856 |           0 | 0.00%     |           118 | 595.000 | 340.640  | 10.000 | 300.000 | 595.000 | 890.000 | 1180.000 | 0.000      | -1.200     | NaT                 | NaT                 | 10                                   | 1180                                 |
| Series name         | object         |          10856 |           0 | 0.00%     |           118 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Consumer Confidence Index            | Q20 Share of Negative Responses      |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `country_wise_remittance.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (21651, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=21651 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (21651, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 194,859
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 9,953,352 Bytes
* **Per Analyzed Column + Index:**
```
Index                      132
Dataset Name           1775382
Observation Date        173208
Series Key             1515570
Series Display Name    1533981
Observation Value       173208
Unit                   1299060
Observation Status     1194669
Sequence No.            173208
Series name            2114934
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 21651 entries, 0 to 21650
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         21651 non-null  object        
 1   Observation Date     21651 non-null  datetime64[ns]
 2   Series Key           21651 non-null  object        
 3   Series Display Name  21651 non-null  object        
 4   Observation Value    21099 non-null  float64       
 5   Unit                 21651 non-null  object        
 6   Observation Status   21651 non-null  object        
 7   Sequence No.         21651 non-null  int64         
 8   Series name          21651 non-null  object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 1.5+ MB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 1972-07-31 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 633
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 21018 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 552 (0.28%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    552
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date        633
Series Key               36
Series Display Name      36
Observation Value      4655
Unit                      1
Observation Status        2
Sequence No.             36
Series name              36
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Country-wise Workers' Remittances    21651
```
**Column: `Series Key`** (Top 20 of 36 unique values)
```
Series Key
TS_GP_BOP_WR_M.WR0010    633
TS_GP_BOP_WR_M.WR0260    633
TS_GP_BOP_WR_M.WR0200    633
TS_GP_BOP_WR_M.WR0210    633
TS_GP_BOP_WR_M.WR0220    633
TS_GP_BOP_WR_M.WR0230    633
TS_GP_BOP_WR_M.WR0240    633
TS_GP_BOP_WR_M.WR0250    633
TS_GP_BOP_WR_M.WR0270    633
TS_GP_BOP_WR_M.WR0180    633
TS_GP_BOP_WR_M.WR0280    633
TS_GP_BOP_WR_M.WR0290    633
TS_GP_BOP_WR_M.WR0300    633
TS_GP_BOP_WR_M.WR0310    633
TS_GP_BOP_WR_M.WR0320    633
TS_GP_BOP_WR_M.WR0340    633
TS_GP_BOP_WR_M.WR0020    633
TS_GP_BOP_WR_M.WR0190    633
TS_GP_BOP_WR_M.WR0170    633
TS_GP_BOP_WR_M.WR0090    633
```
**Column: `Series Display Name`** (Top 20 of 36 unique values)
```
Series Display Name
I. Cash Flow                633
......7 Malaysia            633
............. Italy         633
............. Greece        633
............. Sweden        633
............. Denmark       633
............. Ireland       633
............. Belgium       633
......8 Norway              633
............. Netherland    633
......9 Switzerland         633
......10 Australia          633
......11 Canada             633
......12 Japan              633
......15 Other Countries    633
. Total (I+II)              633
......1 USA                 633
............. Spain         633
............. France        633
............. Others        633
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million USD    21651
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           21099
Missing value      552
```
**Column: `Series name`** (Top 20 of 36 unique values)
```
Series name
Total Cash inflow of Workers' remittances in Pakistan in a month    633
Workers' remittances received from Malaysia                         633
Workers' remittances received from Italy                            633
Workers' remittances received from Greece                           633
Workers' remittances received from Sweden                           633
Workers' remittances received from Denmark                          633
Workers' remittances received from Ireland                          633
Workers' remittances received from Belgium                          633
Workers' remittances received from Norway                           633
Workers' remittances received from Netherland                       633
Workers' remittances received from Switzerland                      633
Workers' remittances received from Australia                        633
Workers' remittances received from Canada                           633
Workers' remittances received from Japan                            633
Workers' remittances received from Other Countries                  633
Total inflow of Workers' Remittances in Pakistan.                   633
Workers' remittances received from U.S.A.                           633
Workers' remittances received from Spain                            633
Workers' remittances received from France                           633
Workers' remittances received from Other four U.A.E.'s States       633
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%    | 50%     | 75%     | Max      | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                     | LastNonNull                                       |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:-------|:--------|:--------|:---------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------------------------------|:--------------------------------------------------|
| Dataset Name        | object         |          21651 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Country-wise Workers' Remittances                                | Country-wise Workers' Remittances                 |
| Observation Date    | datetime64[ns] |          21651 |           0 | 0.00%     |           633 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | 1972-07-31 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                                              | 1972-07-31 00:00:00                               |
| Series Key          | object         |          21651 |           0 | 0.00%     |            36 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | TS_GP_BOP_WR_M.WR0010                                            | TS_GP_BOP_WR_M.WR0340                             |
| Series Display Name | object         |          21651 |           0 | 0.00%     |            36 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | I. Cash Flow                                                     | . Total (I+II)                                    |
| Observation Value   | float64        |          21099 |         552 | 2.55%     |          4655 | 66.278  | 260.108  | 0.000  | 0.300  | 3.500   | 23.950  | 4055.334 | 7.461      | 64.879     | NaT                 | NaT                 | 4055.333654                                                      | 9.5                                               |
| Unit                | object         |          21651 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Million USD                                                      | Million USD                                       |
| Observation Status  | object         |          21651 |           0 | 0.00%     |             2 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Normal                                                           | Normal                                            |
| Sequence No.        | int64          |          21651 |           0 | 0.00%     |            36 | 175.785 | 98.338   | 10.000 | 90.000 | 180.000 | 260.000 | 340.000  | -0.010     | -1.211     | NaT                 | NaT                 | 10                                                               | 340                                               |
| Series name         | object         |          21651 |           0 | 0.00%     |            36 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A      | N/A        | N/A        | NaT                 | NaT                 | Total Cash inflow of Workers' remittances in Pakistan in a month | Total inflow of Workers' Remittances in Pakistan. |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `economic_and_social_indicators.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (117, 46) (rows, columns)
* **Format:** Detected **Tall** (Rows=117 >= Cols=46). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (117, 46) (rows, columns)

* **Original Column Names (46):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 5,382
* **Data Types Summary:** {dtype('float64'): 44, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 54,335 Bytes
* **Per Analyzed Column + Index:**
```
Index                  132
Sectors               4819
Sub-Sectors-Level1    8200
1980-81                936
1981-82                936
1982-83                936
1983-84                936
1984-85                936
1985-86                936
1986-87                936
1987-88                936
1988-89                936
1989-90                936
1990-91                936
1991-92                936
1992-93                936
1993-94                936
1994-95                936
1995-96                936
1996-97                936
1997-98                936
1998-99                936
1999-00                936
2000-01                936
2001-02                936
2002-03                936
2003-04                936
2004-05                936
2005-06                936
2006-07                936
2007-08                936
2008-09                936
2009-10                936
2010-11                936
2011-12                936
2012-13                936
2013-14                936
2014-15                936
2015-16                936
2016-17                936
2017-18                936
2018-19                936
2019-20                936
2020-21                936
2021-22                936
2022-23                936
2023-24                936
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 117 entries, 0 to 116
Data columns (total 46 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             25 non-null     object 
 1   Sub-Sectors-Level1  92 non-null     object 
 2   1980-81             94 non-null     float64
 3   1981-82             89 non-null     float64
 4   1982-83             89 non-null     float64
 5   1983-84             89 non-null     float64
 6   1984-85             94 non-null     float64
 7   1985-86             92 non-null     float64
 8   1986-87             92 non-null     float64
 9   1987-88             92 non-null     float64
 10  1988-89             94 non-null     float64
 11  1989-90             92 non-null     float64
 12  1990-91             94 non-null     float64
 13  1991-92             92 non-null     float64
 14  1992-93             95 non-null     float64
 15  1993-94             97 non-null     float64
 16  1994-95             97 non-null     float64
 17  1995-96             97 non-null     float64
 18  1996-97             94 non-null     float64
 19  1997-98             97 non-null     float64
 20  1998-99             94 non-null     float64
 21  1999-00             97 non-null     float64
 22  2000-01             93 non-null     float64
 23  2001-02             96 non-null     float64
 24  2002-03             96 non-null     float64
 25  2003-04             96 non-null     float64
 26  2004-05             98 non-null     float64
 27  2005-06             99 non-null     float64
 28  2006-07             100 non-null    float64
 29  2007-08             102 non-null    float64
 30  2008-09             102 non-null    float64
 31  2009-10             102 non-null    float64
 32  2010-11             102 non-null    float64
 33  2011-12             102 non-null    float64
 34  2012-13             102 non-null    float64
 35  2013-14             102 non-null    float64
 36  2014-15             102 non-null    float64
 37  2015-16             98 non-null     float64
 38  2016-17             95 non-null     float64
 39  2017-18             102 non-null    float64
 40  2018-19             105 non-null    float64
 41  2019-20             101 non-null    float64
 42  2020-21             102 non-null    float64
 43  2021-22             95 non-null     float64
 44  2022-23             95 non-null     float64
 45  2023-24             71 non-null     float64
dtypes: float64(44), object(2)
memory usage: 42.2+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 1,036 (19.25%)
Columns (46 of 46) with missing values (Sorted):
```
Sectors               92
2023-24               46
1982-83               28
1983-84               28
1981-82               28
1985-86               25
1986-87               25
1987-88               25
1989-90               25
Sub-Sectors-Level1    25
1991-92               25
2000-01               24
1996-97               23
1998-99               23
1980-81               23
1988-89               23
1984-85               23
1990-91               23
2022-23               22
2021-22               22
2016-17               22
1992-93               22
2003-04               21
2002-03               21
2001-02               21
1997-98               20
1993-94               20
1994-95               20
1995-96               20
1999-00               20
2015-16               19
2004-05               19
2005-06               18
2006-07               17
2019-20               16
2008-09               15
2009-10               15
2010-11               15
2011-12               15
2012-13               15
2007-08               15
2014-15               15
2017-18               15
2020-21               15
2013-14               15
2018-19               12
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 46):
```
Sectors               25
Sub-Sectors-Level1    92
1980-81               82
1981-82               79
1982-83               78
1983-84               75
1984-85               79
1985-86               81
1986-87               84
1987-88               80

...

2014-15    90
2015-16    88
2016-17    91
2017-18    96
2018-19    98
2019-20    97
2020-21    97
2021-22    88
2022-23    88
2023-24    66
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 25 unique values)
```
Sectors
GDP (Rs billion)                                    1
Agriculture                                         1
Education                                           1
Labour Force & Employment                           1
Infant Mortality Rate (per 1000 person)             1
Crude Death Rate (per 1000 person)                  1
Crude Birth Rate (per 1000 person)                  1
Population (million)                                1
Information Technology and Telecom                  1
Transport & Communications                          1
Energy                                              1
Manufacturing                                       1
Trade and Payments (growth %)                       1
GDP (US $ billion)                                  1
Stock Exchange (growth %)                           1
Money and Credit (growth %)                         1
Overall Deficit (as % of GDP current mp)            1
Development Expenditure (as % of GDP current mp)    1
Total Expenditure (as % of GDP mp)                  1
Total Revenue (as % of GDP mp)                      1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 92 unique values)
```
Sub-Sectors-Level1
Agriculture Growth Rate (%)                  1
Telephones (mln. nos.)                       1
Primary Schools (000 nos.)                   1
Un-employment Rate (% per annum)             1
Un-employed Labour Force (million)           1
Employed Labour Force (million)              1
Labour Force (million)                       1
Broadband Subscribers (mln. nos.)            1
Teledensity (percent)                        1
Telecom Revenues (Rs. bln.)                  1
Mobile Phones (mln. nos.)                    1
TV Sets (000 nos.)                           1
Manufacturing Growth Rate (%)                1
Post Offices (000 nos.)                      1
Motor Vehicles on Roads (mln. nos.)          1
Roads (000 km)                               1
Electricity (installed capacity) (000 MW)    1
Gas (production) (mcf)                       1
Crude Oil Extraction (mln. Barrels)          1
Jute Goods (000 tons)                        1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean     | StdDev    | Min     | 25%   | 50%    | 75%     | Max        | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                | LastNonNull                         |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:---------|:----------|:--------|:------|:-------|:--------|:-----------|:-----------|:-----------|:----------|:----------|:----------------------------|:------------------------------------|
| Sectors            | object     |             25 |          92 | 78.63%    |            25 | N/A      | N/A       | N/A     | N/A   | N/A    | N/A     | N/A        | N/A        | N/A        | NaT       | NaT       | GDP (Rs billion)            | Health                              |
| Sub-Sectors-Level1 | object     |             92 |          25 | 21.37%    |            92 | N/A      | N/A       | N/A     | N/A   | N/A    | N/A     | N/A        | N/A        | N/A        | NaT       | NaT       | Agriculture Growth Rate (%) | Expenditure on Health (as % of GDP) |
| 1980-81            | float64    |             94 |          23 | 19.66%    |            82 | 36.752   | 87.218    | -1.900  | 3.600 | 9.950  | 22.125  | 602.000    | 4.387      | 22.081     | NaT       | NaT       | 6.4                         | 0.6                                 |
| 1981-82            | float64    |             89 |          28 | 23.93%    |            79 | 33.494   | 72.187    | -17.200 | 3.600 | 11.100 | 24.800  | 430.000    | 3.799      | 15.451     | NaT       | NaT       | 7.6                         | 0.6                                 |
| 1982-83            | float64    |             89 |          28 | 23.93%    |            78 | 34.797   | 75.895    | -13.400 | 3.500 | 9.200  | 25.300  | 448.000    | 3.783      | 15.245     | NaT       | NaT       | 6.8                         | 0.6                                 |
| 1983-84            | float64    |             89 |          28 | 23.93%    |            75 | 35.298   | 74.371    | -4.800  | 3.400 | 8.400  | 23.800  | 432.000    | 3.621      | 13.988     | NaT       | NaT       | 4.0                         | 0.6                                 |
| 1984-85            | float64    |             94 |          23 | 19.66%    |            79 | 35.533   | 73.637    | -7.900  | 4.500 | 9.900  | 25.450  | 432.000    | 3.614      | 14.129     | NaT       | NaT       | 8.7                         | 0.7                                 |
| 1985-86            | float64    |             92 |          25 | 21.37%    |            81 | 37.338   | 78.160    | -14.400 | 3.875 | 11.400 | 26.325  | 482.000    | 3.751      | 15.824     | NaT       | NaT       | 6.4                         | 0.7                                 |
| 1986-87            | float64    |             92 |          25 | 21.37%    |            84 | 44.313   | 98.542    | -24.600 | 3.675 | 11.650 | 29.525  | 586.000    | 3.802      | 15.755     | NaT       | NaT       | 5.8                         | 0.7                                 |
| 1987-88            | float64    |             92 |          25 | 21.37%    |            80 | 48.530   | 111.193   | 0.400   | 4.875 | 11.850 | 27.275  | 685.000    | 3.971      | 17.210     | NaT       | NaT       | 6.4                         | 1.0                                 |
| 1988-89            | float64    |             94 |          23 | 19.66%    |            80 | 59.295   | 153.672   | 0.400   | 4.800 | 10.600 | 29.275  | 999.000    | 4.281      | 20.050     | NaT       | NaT       | 4.8                         | 1.0                                 |
| 1989-90            | float64    |             92 |          25 | 21.37%    |            78 | 60.930   | 159.013   | -3.400  | 4.500 | 10.300 | 30.200  | 929.000    | 4.186      | 18.753     | NaT       | NaT       | 4.6                         | 0.9                                 |
| 1990-91            | float64    |             94 |          23 | 19.66%    |            79 | 59.373   | 149.885   | -0.100  | 5.275 | 13.250 | 30.300  | 1041.000   | 4.582      | 23.963     | NaT       | NaT       | 5.6                         | 0.7                                 |
| 1991-92            | float64    |             92 |          25 | 21.37%    |            85 | 65.392   | 160.976   | -9.900  | 5.750 | 14.150 | 32.100  | 1171.000   | 4.754      | 26.942     | NaT       | NaT       | 7.7                         | 0.7                                 |
| 1992-93            | float64    |             95 |          22 | 18.80%    |            90 | 62.375   | 164.498   | -14.200 | 4.650 | 13.300 | 34.750  | 1219.000   | 4.953      | 28.833     | NaT       | NaT       | 2.3                         | 0.7                                 |
| 1993-94            | float64    |             97 |          20 | 17.09%    |            85 | 66.877   | 176.595   | -38.800 | 4.600 | 12.500 | 39.300  | 1310.000   | 4.970      | 28.910     | NaT       | NaT       | 4.4                         | 0.7                                 |
| 1994-95            | float64    |             97 |          20 | 17.09%    |            86 | 67.879   | 185.292   | -35.600 | 5.200 | 13.600 | 33.600  | 1402.700   | 5.147      | 31.109     | NaT       | NaT       | 5.1                         | 0.6                                 |
| 1995-96            | float64    |             97 |          20 | 17.09%    |            90 | 73.409   | 197.141   | -8.900  | 6.400 | 13.800 | 40.900  | 1495.100   | 5.100      | 30.747     | NaT       | NaT       | 6.6                         | 0.8                                 |
| 1996-97            | float64    |             94 |          23 | 19.66%    |            87 | 74.507   | 205.504   | -15.900 | 4.075 | 12.900 | 36.250  | 1520.800   | 4.954      | 28.942     | NaT       | NaT       | 1.7                         | 0.7                                 |
| 1997-98            | float64    |             97 |          20 | 17.09%    |            89 | 72.909   | 203.529   | -44.700 | 3.900 | 13.200 | 37.700  | 1533.100   | 5.060      | 30.313     | NaT       | NaT       | 3.5                         | 0.7                                 |
| 1998-99            | float64    |             94 |          23 | 19.66%    |            81 | 77.164   | 209.991   | -11.400 | 4.125 | 11.700 | 41.750  | 1540.300   | 4.871      | 27.952     | NaT       | NaT       | 4.2                         | 0.7                                 |
| 1999-00            | float64    |             97 |          20 | 17.09%    |            87 | 80.505   | 221.508   | -32.300 | 4.600 | 11.200 | 40.400  | 1672.000   | 5.046      | 30.191     | NaT       | NaT       | 3.9                         | 0.7                                 |
| 2000-01            | float64    |             93 |          24 | 20.51%    |            85 | 82.746   | 232.635   | -13.400 | 3.800 | 10.600 | 41.200  | 1721.000   | 4.947      | 28.944     | NaT       | NaT       | 2.0                         | 0.7                                 |
| 2001-02            | float64    |             96 |          21 | 17.95%    |            90 | 85.304   | 246.565   | -76.800 | 3.200 | 12.300 | 42.225  | 1809.000   | 4.850      | 27.601     | NaT       | NaT       | 3.1                         | 0.7                                 |
| 2002-03            | float64    |             96 |          21 | 17.95%    |            89 | 84.749   | 245.332   | -23.100 | 4.375 | 14.300 | 51.150  | 1915.000   | 5.513      | 35.376     | NaT       | NaT       | 4.7                         | 0.7                                 |
| 2003-04            | float64    |             96 |          21 | 17.95%    |            90 | 90.157   | 257.760   | -8.000  | 5.375 | 14.350 | 53.050  | 1929.000   | 5.245      | 31.307     | NaT       | NaT       | 7.5                         | 0.6                                 |
| 2004-05            | float64    |             98 |          19 | 16.24%    |            92 | 107.138  | 302.062   | -18.700 | 6.775 | 16.500 | 48.375  | 2280.600   | 5.123      | 30.680     | NaT       | NaT       | 8.6                         | 0.6                                 |
| 2005-06            | float64    |             99 |          18 | 15.38%    |            93 | 170.925  | 483.471   | 0.500   | 8.000 | 19.300 | 58.700  | 3059.000   | 4.197      | 19.157     | NaT       | NaT       | 5.6                         | 0.5                                 |
| 2006-07            | float64    |            100 |          17 | 14.53%    |            87 | 264.213  | 1012.769  | 0.400   | 6.875 | 17.800 | 63.900  | 9003.000   | 7.050      | 57.508     | NaT       | NaT       | 5.5                         | 0.4                                 |
| 2007-08            | float64    |            102 |          15 | 12.82%    |            93 | 399.911  | 1639.530  | -10.800 | 7.150 | 18.000 | 68.600  | 12647.000  | 6.279      | 41.808     | NaT       | NaT       | 12647.0                     | 0.4                                 |
| 2008-09            | float64    |            102 |          15 | 12.82%    |            97 | 425.497  | 1832.089  | -43.900 | 6.400 | 16.400 | 71.250  | 14706.000  | 6.548      | 45.611     | NaT       | NaT       | 14706.0                     | 0.5                                 |
| 2009-10            | float64    |            102 |          15 | 12.82%    |            94 | 450.071  | 2005.123  | -2.000  | 5.525 | 14.400 | 72.900  | 16507.000  | 6.757      | 48.657     | NaT       | NaT       | 16507.0                     | 0.5                                 |
| 2010-11            | float64    |            102 |          15 | 12.82%    |            98 | 492.638  | 2298.217  | -0.600  | 6.400 | 16.200 | 75.900  | 19731.000  | 7.124      | 54.492     | NaT       | NaT       | 19731.0                     | 0.2                                 |
| 2011-12            | float64    |            102 |          15 | 12.82%    |            93 | 531.622  | 2563.460  | -2.600  | 7.375 | 16.750 | 79.075  | 22435.000  | 7.344      | 57.916     | NaT       | NaT       | 22435.0                     | 0.2                                 |
| 2012-13            | float64    |            102 |          15 | 12.82%    |            94 | 572.224  | 2842.582  | -0.600  | 6.250 | 15.700 | 82.325  | 25042.000  | 7.456      | 59.445     | NaT       | NaT       | 25042.0                     | 0.6                                 |
| 2013-14            | float64    |            102 |          15 | 12.82%    |            92 | 608.637  | 3117.038  | 0.700   | 6.725 | 15.000 | 85.225  | 27953.000  | 7.672      | 62.997     | NaT       | NaT       | 27953.0                     | 0.7                                 |
| 2014-15            | float64    |            102 |          15 | 12.82%    |            90 | 648.971  | 3359.233  | -3.900  | 5.700 | 16.150 | 88.225  | 30426.000  | 7.790      | 65.061     | NaT       | NaT       | 30426.0                     | 0.7                                 |
| 2015-16            | float64    |             98 |          19 | 16.24%    |            88 | 710.417  | 3662.811  | -8.800  | 6.125 | 15.000 | 85.075  | 32725.000  | 7.715      | 63.778     | NaT       | NaT       | 32725.0                     | 0.7                                 |
| 2016-17            | float64    |             95 |          22 | 18.80%    |            91 | 780.159  | 4028.714  | -2.800  | 6.650 | 18.300 | 90.350  | 35552.800  | 7.651      | 62.551     | NaT       | NaT       | 35552.8                     | 0.8                                 |
| 2017-18            | float64    |            102 |          15 | 12.82%    |            96 | 780.292  | 4260.222  | -10.000 | 6.950 | 17.500 | 74.025  | 39189.800  | 8.043      | 68.993     | NaT       | NaT       | 39189.8                     | 1.1                                 |
| 2018-19            | float64    |            105 |          12 | 10.26%    |            98 | 821.561  | 4663.563  | -24.000 | 6.400 | 19.100 | 75.100  | 43798.400  | 8.277      | 72.866     | NaT       | NaT       | 43798.4                     | 1.0                                 |
| 2019-20            | float64    |            101 |          16 | 13.68%    |            97 | 899.313  | 5138.124  | -15.900 | 5.800 | 17.500 | 90.000  | 47540.400  | 8.197      | 71.261     | NaT       | NaT       | 47540.4                     | 1.1                                 |
| 2020-21            | float64    |            102 |          15 | 12.82%    |            97 | 986.040  | 5873.321  | 0.800   | 8.525 | 23.550 | 94.925  | 55836.200  | 8.595      | 78.114     | NaT       | NaT       | 55836.2                     | 1.0                                 |
| 2021-22            | float64    |             95 |          22 | 18.80%    |            88 | 1211.829 | 7220.940  | -16.100 | 8.900 | 24.200 | 121.950 | 66658.000  | 8.403      | 74.429     | NaT       | NaT       | 66658.0                     | 1.4                                 |
| 2022-23            | float64    |             95 |          22 | 18.80%    |            88 | 1395.893 | 8922.355  | -26.300 | 6.750 | 19.300 | 126.150 | 83875.000  | 8.763      | 80.191     | NaT       | NaT       | 83875.0                     | 1.0                                 |
| 2023-24            | float64    |             71 |          46 | 39.32%    |            66 | 1996.159 | 12877.691 | -8.000  | 5.250 | 13.000 | 54.950  | 106045.000 | 7.836      | 63.365     | NaT       | NaT       | 106045.0                    | 135.4                               |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 789 pairs with absolute correlation > 0.8 (showing top 50):*
```
2015-16  2016-17    0.999927
2018-19  2019-20    0.999835
2020-21  2021-22    0.999816
2017-18  2018-19    0.999804
2016-17  2017-18    0.999799
2014-15  2015-16    0.999795
2011-12  2012-13    0.999790
2014-15  2016-17    0.999632
2015-16  2017-18    0.999523
2012-13  2013-14    0.999436
2013-14  2014-15    0.999435
2010-11  2011-12    0.999405
2005-06  2006-07    0.999352
2017-18  2019-20    0.999338
2016-17  2018-19    0.999252
2006-07  2007-08    0.999212
1995-96  1996-97    0.999123
1999-00  2000-01    0.999072
2014-15  2017-18    0.998936
1996-97  1998-99    0.998866
1998-99  1999-00    0.998787
2015-16  2018-19    0.998775
2011-12  2013-14    0.998752
2022-23  2023-24    0.998716
2010-11  2012-13    0.998642
2007-08  2008-09    0.998616
2013-14  2015-16    0.998595
1996-97  1997-98    0.998577
2006-07  2008-09    0.998569
2016-17  2019-20    0.998509
1995-96  1998-99    0.998420
2019-20  2020-21    0.998382
2013-14  2016-17    0.998381
2012-13  2014-15    0.998199
2008-09  2009-10    0.998167
1994-95  1997-98    0.998135
2021-22  2022-23    0.998135
1997-98  1998-99    0.998132
1996-97  1999-00    0.998045
2014-15  2018-19    0.997989
2009-10  2010-11    0.997939
2015-16  2019-20    0.997846
2005-06  2008-09    0.997794
1998-99  2000-01    0.997788
2018-19  2020-21    0.997741
1994-95  1995-96    0.997629
1986-87  1987-88    0.997529
1994-95  1998-99    0.997499
         1996-97    0.997426
2013-14  2017-18    0.997310
```


---


## Analysis for: `education.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (44, 55) (rows, columns)
* **Format:** Detected **Wide** (Cols=55 > Rows=44). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Could not reliably convert transposed index to numeric/datetime. Kept as: object
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (54, 44) (rows, columns)

* **Original Column Names (55):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23']
  ```

* **Analyzed Column Names (44):**
  ```
  ['Number of Educational Institutions By Kind, Level & Sex', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'Enrolment in Educational Institutions By Kind, Level & Sex', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'Number of Teachers in Educational Institutions By Kind, Level & Sex', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan]
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 2,376
* **Data Types Summary:** {dtype('float64'): 44}

### Memory Usage (Bytes)

* **Total:** 22,043 Bytes
* **Per Analyzed Column + Index:**
```
Index                                                                  3035
Number of Educational Institutions By Kind, Level & Sex                 432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
Enrolment in Educational Institutions By Kind, Level & Sex              432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
Number of Teachers in Educational Institutions By Kind, Level & Sex     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
NaN                                                                     432
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 54 entries, Sub-Sectors-Level1 to 2022-23
Data columns (total 44 columns):
 #   Column                                                               Non-Null Count  Dtype  
---  ------                                                               --------------  -----  
 0   Number of Educational Institutions By Kind, Level & Sex              0 non-null      float64
 1   nan                                                                  53 non-null     float64
 2   nan                                                                  53 non-null     float64
 3   nan                                                                  53 non-null     float64
 4   nan                                                                  53 non-null     float64
 5   nan                                                                  53 non-null     float64
 6   nan                                                                  53 non-null     float64
 7   nan                                                                  53 non-null     float64
 8   nan                                                                  53 non-null     float64
 9   nan                                                                  53 non-null     float64
 10  nan                                                                  53 non-null     float64
 11  nan                                                                  53 non-null     float64
 12  nan                                                                  53 non-null     float64
 13  nan                                                                  53 non-null     float64
 14  Enrolment in Educational Institutions By Kind, Level & Sex           0 non-null      float64
 15  nan                                                                  53 non-null     float64
 16  nan                                                                  53 non-null     float64
 17  nan                                                                  53 non-null     float64
 18  nan                                                                  53 non-null     float64
 19  nan                                                                  53 non-null     float64
 20  nan                                                                  53 non-null     float64
 21  nan                                                                  53 non-null     float64
 22  nan                                                                  53 non-null     float64
 23  nan                                                                  53 non-null     float64
 24  nan                                                                  53 non-null     float64
 25  nan                                                                  53 non-null     float64
 26  nan                                                                  53 non-null     float64
 27  nan                                                                  53 non-null     float64
 28  nan                                                                  53 non-null     float64
 29  Number of Teachers in Educational Institutions By Kind, Level & Sex  0 non-null      float64
 30  nan                                                                  53 non-null     float64
 31  nan                                                                  53 non-null     float64
 32  nan                                                                  53 non-null     float64
 33  nan                                                                  53 non-null     float64
 34  nan                                                                  53 non-null     float64
 35  nan                                                                  53 non-null     float64
 36  nan                                                                  53 non-null     float64
 37  nan                                                                  53 non-null     float64
 38  nan                                                                  53 non-null     float64
 39  nan                                                                  53 non-null     float64
 40  nan                                                                  53 non-null     float64
 41  nan                                                                  53 non-null     float64
 42  nan                                                                  53 non-null     float64
 43  nan                                                                  33 non-null     float64
dtypes: float64(44)
memory usage: 19.0+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 223 (9.39%)
Columns (44 of 44) with missing values (Sorted):
```
Sectors
Number of Educational Institutions By Kind, Level & Sex                54
Enrolment in Educational Institutions By Kind, Level & Sex             54
Number of Teachers in Educational Institutions By Kind, Level & Sex    54
NaN                                                                    21
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
NaN                                                                     1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 44):
```
Sectors
Number of Educational Institutions By Kind, Level & Sex     0
NaN                                                        51
NaN                                                        53
NaN                                                        51
NaN                                                        43
NaN                                                        49
NaN                                                        42
NaN                                                        49
NaN                                                        50
NaN                                                        51

...

Sectors
NaN    53
NaN    51
NaN    48
NaN    47
NaN    53
NaN    53
NaN    53
NaN    52
NaN    50
NaN    33
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                                                             | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean       | StdDev     | Min       | 25%       | 50%        | 75%        | Max         | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull   | LastNonNull   |
|:--------------------------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|:-----------|:-----------|:----------|:----------|:-----------|:-----------|:------------|:-----------|:-----------|:----------|:----------|:---------------|:--------------|
| Number of Educational Institutions By Kind, Level & Sex             | float64    |              0 |          54 | 100.00%   |             0 | N/A        | N/A        | N/A       | N/A       | N/A        | N/A        | N/A         | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            51 | 122.238    | 46.795     | 43.700    | 73.200    | 147.700    | 157.900    | 182.600     | -0.505     | -1.377     | NaT       | NaT       | 43.7           | 160.2         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 44.138     | 22.727     | 12.100    | 20.900    | 52.100     | 60.300     | 90.000      | 0.108      | -1.218     | NaT       | NaT       | 12.1           | 70.3          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            51 | 22.268     | 17.207     | 3.800     | 6.000     | 14.500     | 41.300     | 49.100      | 0.375      | -1.631     | NaT       | NaT       | 3.8            | 48.1          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            43 | 10.674     | 9.562      | 0.900     | 1.800     | 6.300      | 20.400     | 27.900      | 0.490      | -1.414     | NaT       | NaT       | 0.9            | 24.4          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            49 | 14.770     | 11.410     | 2.100     | 4.200     | 9.900      | 24.800     | 35.300      | 0.527      | -1.303     | NaT       | NaT       | 2.1            | 35.3          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            42 | 5.694      | 5.262      | 0.500     | 1.200     | 3.300      | 9.500      | 15.600      | 0.728      | -1.063     | NaT       | NaT       | 0.5            | 15.5          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            49 | 1492.434   | 1468.950   | 206.000   | 301.000   | 607.000    | 3192.000   | 4281.000    | 0.713      | -1.398     | NaT       | NaT       | 206.0          | 4281.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            50 | 703.245    | 746.338    | 76.000    | 141.000   | 252.000    | 1330.000   | 2276.000    | 0.937      | -0.693     | NaT       | NaT       | 97.0           | 1702.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            51 | 2225.811   | 2298.850   | 314.000   | 467.000   | 1056.000   | 3329.000   | 8778.000    | 1.177      | 0.283      | NaT       | NaT       | 314.0          | 8778.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            51 | 979.302    | 1089.298   | 87.000    | 150.000   | 382.000    | 1690.000   | 4007.000    | 1.122      | 0.056      | NaT       | NaT       | 87.0           | 4007.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            38 | 751.132    | 922.158    | 73.000    | 99.000    | 310.000    | 1336.000   | 3692.000    | 1.591      | 1.889      | NaT       | NaT       | 73.0           | 2735.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            36 | 350.623    | 520.547    | 6.000     | 8.000     | 129.000    | 631.000    | 2546.000    | 2.192      | 5.551      | NaT       | NaT       | 6.0            | 1354.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            38 | 76.472     | 69.355     | 7.000     | 20.000    | 41.000     | 132.000    | 228.000     | 0.727      | -0.943     | NaT       | NaT       | 7.0            | 228.0         |
| Enrolment in Educational Institutions By Kind, Level & Sex          | float64    |              0 |          54 | 100.00%   |             0 | N/A        | N/A        | N/A       | N/A       | N/A        | N/A        | N/A         | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 13160.925  | 6613.067   | 3960.000  | 6828.000  | 13088.000  | 18468.000  | 24950.000   | 0.174      | -1.297     | NaT       | NaT       | 3960.0         | 24039.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 5348.340   | 3278.455   | 1040.000  | 2174.000  | 5149.000   | 8144.000   | 11211.000   | 0.267      | -1.335     | NaT       | NaT       | 1040.0         | 10868.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 3919.585   | 2359.458   | 933.000   | 1760.000  | 3759.000   | 5504.000   | 9102.000    | 0.501      | -0.831     | NaT       | NaT       | 933.0          | 9102.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 1541.415   | 1165.227   | 178.000   | 424.000   | 1357.000   | 2337.000   | 4172.000    | 0.593      | -0.787     | NaT       | NaT       | 178.0          | 4172.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 1763.774   | 1283.310   | 336.000   | 606.000   | 1525.000   | 2583.000   | 4636.000    | 0.772      | -0.559     | NaT       | NaT       | 336.0          | 4636.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 691.868    | 604.333    | 67.000    | 146.000   | 520.000    | 1078.000   | 2074.000    | 0.825      | -0.505     | NaT       | NaT       | 67.0           | 2074.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            41 | 159.981    | 137.691    | 26.000    | 57.000    | 90.000     | 273.000    | 455.000     | 0.950      | -0.544     | NaT       | NaT       | 35.0           | 439.0         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            31 | 51.226     | 52.331     | 7.000     | 14.000    | 19.000     | 102.000    | 155.000     | 0.863      | -0.944     | NaT       | NaT       | 10.0           | 155.0         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            50 | 789.830    | 653.164    | 186.000   | 307.000   | 478.000    | 1166.000   | 2531.000    | 1.259      | 0.524      | NaT       | NaT       | 199.0          | 2262.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 324.943    | 303.382    | 47.000    | 111.000   | 201.000    | 452.000    | 1214.000    | 1.440      | 1.317      | NaT       | NaT       | 50.0           | 1049.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 286328.113 | 230095.974 | 36182.000 | 64910.000 | 300400.000 | 431180.000 | 820073.000  | 0.623      | -0.592     | NaT       | NaT       | 37245.0        | 627264.0      |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 130036.887 | 140471.585 | 4612.000  | 11986.000 | 100400.000 | 218374.000 | 688883.000  | 1.616      | 3.662      | NaT       | NaT       | 4612.0         | 342145.0      |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            50 | 524626.830 | 691959.621 | 17057.000 | 50418.000 | 91637.000  | 935599.000 | 2410042.000 | 1.191      | 0.014      | NaT       | NaT       | 17057.0        | 2410042.0     |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            50 | 230987.585 | 324429.457 | 1500.000  | 8483.000  | 24848.000  | 426323.000 | 1098901.000 | 1.171      | -0.104     | NaT       | NaT       | 3703.0         | 1098901.0     |
| Number of Teachers in Educational Institutions By Kind, Level & Sex | float64    |              0 |          54 | 100.00%   |             0 | N/A        | N/A        | N/A       | N/A       | N/A        | N/A        | N/A         | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 323.647    | 139.923    | 96.300    | 177.300   | 377.500    | 441.700    | 522.400     | -0.385     | -1.540     | NaT       | NaT       | 96.3           | 452.7         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 142.953    | 83.230     | 27.200    | 57.100    | 151.700    | 210.100    | 284.000     | 0.036      | -1.482     | NaT       | NaT       | 27.2           | 255.6         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 198.308    | 147.739    | 34.200    | 57.100    | 159.100    | 331.500    | 455.400     | 0.446      | -1.344     | NaT       | NaT       | 34.2           | 431.6         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 123.385    | 111.634    | 8.600     | 17.000    | 91.400     | 216.600    | 325.700     | 0.543      | -1.183     | NaT       | NaT       | 8.6            | 312.2         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 264.545    | 193.433    | 36.400    | 78.300    | 227.600    | 447.100    | 599.000     | 0.427      | -1.323     | NaT       | NaT       | 36.4           | 592.0         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            51 | 136.847    | 124.294    | 10.200    | 24.100    | 102.600    | 230.400    | 368.900     | 0.665      | -1.053     | NaT       | NaT       | 10.2           | 368.9         |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            48 | 9363.717   | 5892.647   | 2204.000  | 3835.000  | 7402.000   | 15338.000  | 19393.000   | 0.391      | -1.357     | NaT       | NaT       | 2208.0         | 18375.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            47 | 2556.547   | 1703.892   | 517.000   | 807.000   | 1957.000   | 4304.000   | 5353.000    | 0.352      | -1.471     | NaT       | NaT       | 532.0          | 4834.0        |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 54800.396  | 49724.260  | 8313.000  | 13130.000 | 32898.000  | 77248.000  | 183258.000  | 1.009      | -0.158     | NaT       | NaT       | 8823.0         | 183258.0      |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 25866.302  | 27067.596  | 2318.000  | 4142.000  | 11729.000  | 37595.000  | 95513.000   | 1.052      | -0.182     | NaT       | NaT       | 2695.0         | 95513.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            53 | 17795.321  | 18989.833  | 1868.000  | 3769.000  | 9969.000   | 25964.000  | 66239.000   | 1.308      | 0.531      | NaT       | NaT       | 1868.0         | 62321.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            52 | 6911.283   | 8795.299   | 224.000   | 604.000   | 3660.000   | 10485.000  | 36778.000   | 1.685      | 2.265      | NaT       | NaT       | 225.0          | 27529.0       |
| nan                                                                 | float64    |             53 |           1 | 1.85%     |            50 | 25226.585  | 28973.711  | 1568.000  | 3573.000  | 5316.000   | 56885.000  | 88288.000   | 0.813      | -1.011     | NaT       | NaT       | 1568.0         | 72717.0       |
| nan                                                                 | float64    |             33 |          21 | 38.89%    |            33 | 623.212    | 343.990    | 137.000   | 351.000   | 585.000    | 918.000    | 1375.000    | 0.614      | -0.469     | NaT       | NaT       | 137.0          | 1375.0        |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)


*Could not calculate correlations (Error: Unable to allocate 21.6 MiB for an array with shape (1681, 1681) and data type float64).*


---


## Analysis for: `energy.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (53, 55) (rows, columns)
* **Format:** Detected **Wide** (Cols=55 > Rows=53). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Could not reliably convert transposed index to numeric/datetime. Kept as: object
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (54, 53) (rows, columns)

* **Original Column Names (55):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

* **Analyzed Column Names (53):**
  ```
  ['Commercial Energy Consumption', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'Commercial Energy Supplies (Electricity)', nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, nan, 'Commercial Energy Supplies (Oil, Gas, Petroleum, Coal)', nan, nan, nan, nan, nan, nan, nan, nan]
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 2,862
* **Data Types Summary:** {dtype('float64'): 53}

### Memory Usage (Bytes)

* **Total:** 25,931 Bytes
* **Per Analyzed Column + Index:**
```
Index                                                     3035
Commercial Energy Consumption                              432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
Commercial Energy Supplies (Electricity)                   432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
Commercial Energy Supplies (Oil, Gas, Petroleum, Coal)     432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
NaN                                                        432
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 54 entries, Sub-Sectors-Level1 to 2023-24
Data columns (total 53 columns):
 #   Column                                                  Non-Null Count  Dtype  
---  ------                                                  --------------  -----  
 0   Commercial Energy Consumption                           0 non-null      float64
 1   nan                                                     53 non-null     float64
 2   nan                                                     53 non-null     float64
 3   nan                                                     53 non-null     float64
 4   nan                                                     53 non-null     float64
 5   nan                                                     53 non-null     float64
 6   nan                                                     53 non-null     float64
 7   nan                                                     53 non-null     float64
 8   nan                                                     53 non-null     float64
 9   nan                                                     53 non-null     float64
 10  nan                                                     52 non-null     float64
 11  nan                                                     53 non-null     float64
 12  nan                                                     53 non-null     float64
 13  nan                                                     4 non-null      float64
 14  nan                                                     53 non-null     float64
 15  nan                                                     33 non-null     float64
 16  nan                                                     53 non-null     float64
 17  nan                                                     32 non-null     float64
 18  nan                                                     53 non-null     float64
 19  nan                                                     53 non-null     float64
 20  nan                                                     53 non-null     float64
 21  nan                                                     53 non-null     float64
 22  nan                                                     52 non-null     float64
 23  nan                                                     6 non-null      float64
 24  nan                                                     53 non-null     float64
 25  nan                                                     53 non-null     float64
 26  nan                                                     40 non-null     float64
 27  nan                                                     53 non-null     float64
 28  nan                                                     53 non-null     float64
 29  nan                                                     24 non-null     float64
 30  nan                                                     18 non-null     float64
 31  nan                                                     53 non-null     float64
 32  Commercial Energy Supplies (Electricity)                0 non-null      float64
 33  nan                                                     53 non-null     float64
 34  nan                                                     53 non-null     float64
 35  nan                                                     53 non-null     float64
 36  nan                                                     53 non-null     float64
 37  nan                                                     53 non-null     float64
 38  nan                                                     53 non-null     float64
 39  nan                                                     53 non-null     float64
 40  nan                                                     53 non-null     float64
 41  nan                                                     10 non-null     float64
 42  nan                                                     10 non-null     float64
 43  nan                                                     20 non-null     float64
 44  Commercial Energy Supplies (Oil, Gas, Petroleum, Coal)  0 non-null      float64
 45  nan                                                     53 non-null     float64
 46  nan                                                     53 non-null     float64
 47  nan                                                     53 non-null     float64
 48  nan                                                     10 non-null     float64
 49  nan                                                     53 non-null     float64
 50  nan                                                     53 non-null     float64
 51  nan                                                     52 non-null     float64
 52  nan                                                     53 non-null     float64
dtypes: float64(53)
memory usage: 22.8+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 591 (20.65%)
Columns (53 of 53) with missing values (Sorted):
```
Sectors
Commercial Energy Consumption                             54
Commercial Energy Supplies (Oil, Gas, Petroleum, Coal)    54
Commercial Energy Supplies (Electricity)                  54
NaN                                                       50
NaN                                                       48
NaN                                                       44
NaN                                                       44
NaN                                                       44
NaN                                                       36
NaN                                                       34
NaN                                                       30
NaN                                                       22
NaN                                                       21
NaN                                                       14
NaN                                                        2
NaN                                                        2
NaN                                                        2
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
NaN                                                        1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 53):
```
Sectors
Commercial Energy Consumption     0
NaN                              53
NaN                              53
NaN                              53
NaN                              53
NaN                              53
NaN                              53
NaN                              53
NaN                              53
NaN                              53

...

Sectors
NaN                                                       18
Commercial Energy Supplies (Oil, Gas, Petroleum, Coal)     0
NaN                                                       53
NaN                                                       53
NaN                                                       53
NaN                                                       10
NaN                                                       53
NaN                                                       53
NaN                                                       52
NaN                                                       53
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                                                | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean         | StdDev      | Min         | 25%         | 50%          | 75%          | Max          | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull   | LastNonNull   |
|:-------------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|:-------------|:------------|:------------|:------------|:-------------|:-------------|:-------------|:-----------|:-----------|:----------|:----------|:---------------|:--------------|
| Commercial Energy Consumption                          | float64    |              0 |          54 | 100.00%   |             0 | N/A          | N/A         | N/A         | N/A         | N/A          | N/A          | N/A          | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 401330.472   | 297444.579  | 13547.000   | 97332.000   | 450960.000   | 596031.000   | 1116896.000  | 0.334      | -0.849     | NaT       | NaT       | 380991.0       | 18803.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 1188486.981  | 630505.418  | 194569.000  | 814713.000  | 1297035.000  | 1604068.000  | 2416278.000  | -0.203     | -0.907     | NaT       | NaT       | 267942.0       | 815318.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 170434.887   | 109684.838  | 7400.000    | 46655.000   | 218887.000   | 264172.000   | 330407.000   | -0.335     | -1.507     | NaT       | NaT       | 287157.0       | 10161.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 7113637.906  | 4288300.824 | 1116175.000 | 3240202.000 | 7364767.000  | 9265883.000  | 17409035.000 | 0.504      | -0.356     | NaT       | NaT       | 1116175.0      | 9764549.0     |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 3623442.434  | 3001135.411 | 15521.000   | 766274.000  | 2775418.000  | 6305419.000  | 9006085.000  | 0.361      | -1.303     | NaT       | NaT       | 99597.0        | 520698.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 429721.679   | 141429.590  | 224695.000  | 328592.000  | 372176.000   | 540389.000   | 725780.000   | 0.895      | -0.600     | NaT       | NaT       | 630586.0       | 224695.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 12927620.415 | 6689172.070 | 2782448.000 | 6615743.000 | 13960167.000 | 17911199.000 | 25561946.000 | -0.079     | -1.173     | NaT       | NaT       | 2782448.0      | 11354224.0    |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 135126.585   | 106555.848  | 2261.000    | 37372.000   | 131656.000   | 232244.000   | 325348.000   | 0.329      | -1.310     | NaT       | NaT       | 2261.0         | 236736.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 19135.585    | 11590.240   | 1945.000    | 9838.000    | 16960.000    | 29269.000    | 40689.000    | 0.274      | -1.208     | NaT       | NaT       | 1945.0         | 13426.0       |
| nan                                                    | float64    |             52 |           2 | 3.70%     |            51 | 10159.865    | 8444.815    | 266.000     | 1802.500    | 7988.000     | 14848.250    | 26319.000    | 0.618      | -0.833     | NaT       | NaT       | 16399.0        | 819.0         |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 149952.000   | 78510.670   | 20030.000   | 99788.000   | 150483.000   | 201100.000   | 319751.000   | 0.039      | -0.722     | NaT       | NaT       | 22286.0        | 209336.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 245423.906   | 154978.191  | 40793.000   | 88906.000   | 193984.000   | 371562.000   | 544654.000   | 0.286      | -1.288     | NaT       | NaT       | 40793.0        | 244956.0      |
| nan                                                    | float64    |              4 |          50 | 92.59%    |             4 | 45801.250    | 13607.992   | 26222.000   | 41969.750   | 50240.000    | 54071.500    | 56503.000    | -1.551     | 2.362      | NaT       | NaT       | 53261.0        | 47219.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 151928.132   | 95534.979   | 27830.000   | 74629.000   | 115250.000   | 246706.000   | 333508.000   | 0.471      | -1.249     | NaT       | NaT       | 27830.0        | 157550.0      |
| nan                                                    | float64    |             33 |          21 | 38.89%    |            33 | 40390.636    | 38631.043   | 25.000      | 2393.000    | 24443.000    | 67245.000    | 119000.000   | 0.523      | -1.072     | NaT       | NaT       | 25.0           | 16714.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 739850.302   | 458719.428  | 111514.000  | 319128.000  | 607890.000   | 1224892.000  | 1463002.000  | 0.187      | -1.531     | NaT       | NaT       | 111514.0       | 878718.0      |
| nan                                                    | float64    |             32 |          22 | 40.74%    |            24 | 22.219       | 13.895      | 1.000       | 11.750      | 19.000       | 36.250       | 44.000       | 0.126      | -1.392     | NaT       | NaT       | 44.0           | 1.0           |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 21792.302    | 17784.098   | 635.000     | 5076.000    | 18750.000    | 35589.000    | 58722.000    | 0.507      | -0.910     | NaT       | NaT       | 635.0          | 39286.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 3542.151     | 2634.209    | 378.000     | 1413.000    | 2544.000     | 5754.000     | 8652.000     | 0.599      | -0.990     | NaT       | NaT       | 378.0          | 6776.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 14327.528    | 8426.015    | 2855.000    | 6249.000    | 12637.000    | 21207.000    | 31600.000    | 0.231      | -1.107     | NaT       | NaT       | 2855.0         | 22031.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            52 | 5711.170     | 2893.235    | 997.000     | 2798.000    | 5847.000     | 8176.000     | 10247.000    | -0.149     | -1.224     | NaT       | NaT       | 997.0          | 6951.0        |
| nan                                                    | float64    |             52 |           2 | 3.70%     |            48 | 275.846      | 152.997     | 31.000      | 125.500     | 297.500      | 413.500      | 523.000      | -0.144     | -1.413     | NaT       | NaT       | 31.0           | 523.0         |
| nan                                                    | float64    |              6 |          48 | 88.89%    |             6 | 1396.333     | 1865.569    | 1.000       | 284.000     | 397.500      | 2126.500     | 4633.000     | 1.381      | 0.688      | NaT       | NaT       | 1.0            | 4633.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 3085.208     | 2008.018    | 436.000     | 1511.000    | 3363.000     | 4373.000     | 8621.000     | 0.846      | 0.781      | NaT       | NaT       | 436.0          | 2909.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 48892.811    | 33637.077   | 5332.000    | 17584.000   | 43296.000    | 76761.000    | 116816.000   | 0.374      | -1.032     | NaT       | NaT       | 5332.0         | 83109.0       |
| nan                                                    | float64    |             40 |          14 | 25.93%    |            28 | 13.365       | 14.850      | 0.800       | 1.450       | 6.400        | 22.250       | 56.000       | 1.124      | 0.332      | NaT       | NaT       | 33.0           | 1.5           |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            49 | 1293.270     | 3193.956    | 2.000       | 40.000      | 104.600      | 249.400      | 12807.800    | 2.683      | 6.080      | NaT       | NaT       | 57.0           | 11907.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            52 | 2897.183     | 1496.290    | 974.000     | 2148.000    | 2837.900     | 3235.800     | 8678.100     | 1.951      | 5.828      | NaT       | NaT       | 1171.0         | 2572.0        |
| nan                                                    | float64    |             24 |          30 | 55.56%    |            24 | 5613.817     | 4674.493    | 50.000      | 3587.600    | 4708.550     | 6102.825     | 23675.100    | 2.636      | 9.552      | NaT       | NaT       | 50.0           | 2800.0        |
| nan                                                    | float64    |             18 |          36 | 66.67%    |            14 | 18.167       | 12.821      | 2.000       | 10.500      | 14.500       | 22.500       | 50.000       | 1.271      | 1.154      | NaT       | NaT       | 50.0           | 2.0           |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 6749.628     | 7915.626    | 1065.000    | 2202.000    | 3461.400     | 7894.100     | 42127.400    | 2.574      | 7.731      | NaT       | NaT       | 1310.0         | 17279.0       |
| Commercial Energy Supplies (Electricity)               | float64    |              0 |          54 | 100.00%   |             0 | N/A          | N/A         | N/A         | N/A         | N/A          | N/A          | N/A          | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            52 | 15835.491    | 11559.670   | 1862.000    | 5615.000    | 15659.000    | 22477.000    | 42131.000    | 0.723      | -0.316     | NaT       | NaT       | 1862.0         | 42131.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 63350.755    | 41007.091   | 7572.000    | 23003.000   | 62104.000    | 95365.000    | 150866.000   | 0.238      | -1.098     | NaT       | NaT       | 7572.0         | 92091.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            34 | 4766.377     | 2631.594    | 667.000     | 2898.000    | 4826.000     | 6499.000     | 10681.000    | 0.221      | -0.713     | NaT       | NaT       | 667.0          | 10681.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 20476.038    | 9506.598    | 3679.000    | 12826.000   | 21112.000    | 28517.000    | 34633.000    | -0.290     | -1.137     | NaT       | NaT       | 3679.0         | 29167.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            49 | 10156.396    | 7699.514    | 1058.000    | 2580.000    | 10696.000    | 15209.000    | 26307.000    | 0.576      | -0.717     | NaT       | NaT       | 1058.0         | 25046.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 39013.264    | 27830.583   | 3738.000    | 10416.000   | 39669.000    | 61711.000    | 92791.000    | 0.248      | -1.186     | NaT       | NaT       | 3789.0         | 42249.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |             9 | 579.849      | 835.229     | 137.000     | 137.000     | 137.000      | 750.000      | 3630.000     | 2.797      | 7.825      | NaT       | NaT       | 137.0          | 3545.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            52 | 3097.321     | 4761.064    | 2.000       | 346.000     | 582.000      | 3420.000     | 19739.000    | 2.245      | 4.787      | NaT       | NaT       | 104.0          | 16754.0       |
| nan                                                    | float64    |             10 |          44 | 81.48%    |             9 | 1813.800     | 817.714     | 438.000     | 1337.000    | 1809.500     | 2536.750     | 2859.000     | -0.180     | -0.823     | NaT       | NaT       | 438.0          | 2859.0        |
| nan                                                    | float64    |             10 |          44 | 81.48%    |            10 | 3606.800     | 1560.150    | 802.000     | 2965.250    | 3920.000     | 4280.250     | 6195.000     | -0.454     | 0.346      | NaT       | NaT       | 802.0          | 3921.0        |
| nan                                                    | float64    |             20 |          34 | 62.96%    |            18 | 345.900      | 144.427     | 109.000     | 220.000     | 382.000      | 469.000      | 556.000      | -0.198     | -1.527     | NaT       | NaT       | 109.0          | 171.0         |
| Commercial Energy Supplies (Oil, Gas, Petroleum, Coal) | float64    |              0 |          54 | 100.00%   |             0 | N/A          | N/A         | N/A         | N/A         | N/A          | N/A          | N/A          | N/A        | N/A        | NaT       | NaT       | <NA>           | <NA>          |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 42183.226    | 17414.596   | 21177.000   | 28386.000   | 32755.000    | 57699.000    | 84441.000    | 0.608      | -0.922     | NaT       | NaT       | 22781.0        | 38849.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 18455.321    | 9799.239    | 2443.000    | 9522.000    | 21063.000    | 24119.000    | 34490.000    | -0.476     | -0.961     | NaT       | NaT       | 3007.0         | 19645.0       |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 821052.434   | 498856.863  | 124786.000  | 361850.000  | 699709.000   | 1400026.000  | 1558959.000  | 0.164      | -1.552     | NaT       | NaT       | 124786.0       | 866345.0      |
| nan                                                    | float64    |             10 |          44 | 81.48%    |            10 | 273570.000   | 133975.431  | 20191.000   | 205326.000  | 302984.000   | 374549.000   | 423951.000   | -0.822     | -0.260     | NaT       | NaT       | 20191.0        | 285788.0      |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 6753.509     | 4364.174    | 419.000     | 2290.000    | 6612.000     | 10398.000    | 15145.000    | 0.062      | -1.330     | NaT       | NaT       | 419.0          | 4320.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 7084.491     | 2951.820    | 2774.000    | 4668.000    | 5961.000     | 9828.000     | 12929.000    | 0.225      | -1.307     | NaT       | NaT       | 3135.0         | 7311.0        |
| nan                                                    | float64    |             52 |           2 | 3.70%     |            52 | 3624.788     | 5921.521    | 16.000      | 809.000     | 1074.500     | 4255.000     | 32533.000    | 3.122      | 11.404     | NaT       | NaT       | 32.0           | 3353.0        |
| nan                                                    | float64    |             53 |           1 | 1.85%     |            53 | 3502.792     | 2182.502    | 1055.000    | 2202.000    | 3266.000     | 3712.000     | 10169.000    | 1.707      | 2.825      | NaT       | NaT       | 1214.0         | 10169.0       |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)


*Could not calculate correlations (Error: Unable to allocate 47.7 MiB for an array with shape (2500, 2500) and data type float64).*


---


## Analysis for: `exchange_rate.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (66332, 10) (rows, columns)
* **Format:** Detected **Tall** (Rows=66332 >= Cols=10). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (66332, 10) (rows, columns)

* **Original Column Names (10):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Observation Status Comment', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 663,320
* **Data Types Summary:** {dtype('O'): 7, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 38,468,925 Bytes
* **Per Analyzed Column + Index:**
```
Index                             132
Dataset Name                  7893508
Observation Date               530656
Series Key                    5240228
Series Display Name           7345548
Observation Value              530656
Unit                          3449264
Observation Status            3648260
Observation Status Comment    2124625
Sequence No.                   530656
Series name                   7175392
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 66332 entries, 0 to 66331
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype         
---  ------                      --------------  -----         
 0   Dataset Name                66332 non-null  object        
 1   Observation Date            66332 non-null  datetime64[ns]
 2   Series Key                  66332 non-null  object        
 3   Series Display Name         66332 non-null  object        
 4   Observation Value           66332 non-null  float64       
 5   Unit                        66332 non-null  object        
 6   Observation Status          66332 non-null  object        
 7   Observation Status Comment  29 non-null     object        
 8   Sequence No.                66332 non-null  int64         
 9   Series name                 66332 non-null  object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(7)
memory usage: 5.1+ MB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2013-07-02 00:00:00
* **Max Date:** 2025-03-28 00:00:00
* **Number of Unique Dates:** 2884
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 63448 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 66,303 (10.00%)
Columns (1 of 10) with missing values (Sorted):
```
Observation Status Comment    66303
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 10):
```
Dataset Name                      1
Observation Date               2884
Series Key                       23
Series Display Name              23
Observation Value             65822
Unit                              1
Observation Status                1
Observation Status Comment        1
Sequence No.                     23
Series name                      23
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Bank Floating Daily Average Exchange Rates (PKR per National Currency)    66332
```
**Column: `Series Key`** (Top 20 of 23 unique values)
```
Series Key
TS_GP_ES_FADERPKR_M.XRDAVG0010    2884
TS_GP_ES_FADERPKR_M.XRDAVG0130    2884
TS_GP_ES_FADERPKR_M.XRDAVG0220    2884
TS_GP_ES_FADERPKR_M.XRDAVG0210    2884
TS_GP_ES_FADERPKR_M.XRDAVG0200    2884
TS_GP_ES_FADERPKR_M.XRDAVG0190    2884
TS_GP_ES_FADERPKR_M.XRDAVG0180    2884
TS_GP_ES_FADERPKR_M.XRDAVG0170    2884
TS_GP_ES_FADERPKR_M.XRDAVG0160    2884
TS_GP_ES_FADERPKR_M.XRDAVG0150    2884
TS_GP_ES_FADERPKR_M.XRDAVG0140    2884
TS_GP_ES_FADERPKR_M.XRDAVG0120    2884
TS_GP_ES_FADERPKR_M.XRDAVG0020    2884
TS_GP_ES_FADERPKR_M.XRDAVG0110    2884
TS_GP_ES_FADERPKR_M.XRDAVG0100    2884
TS_GP_ES_FADERPKR_M.XRDAVG0090    2884
TS_GP_ES_FADERPKR_M.XRDAVG0080    2884
TS_GP_ES_FADERPKR_M.XRDAVG0070    2884
TS_GP_ES_FADERPKR_M.XRDAVG0060    2884
TS_GP_ES_FADERPKR_M.XRDAVG0050    2884
```
**Column: `Series Display Name`** (Top 20 of 23 unique values)
```
Series Display Name
1 Daily Average Exchange rate of PAK Rupees per Australian Dollar       2884
13 Daily Average Exchange rate of PAK Rupees per Qatari Riyal           2884
22 Daily Average Exchange rate of PAK Rupees per U.S. Dollar            2884
21 Daily Average Exchange rate of PAK Rupees per U.K. Pound Sterling    2884
20 Daily Average Exchange rate of PAK Rupees per U.A.E. Dirham          2884
19 Daily Average Exchange rate of PAK Rupees per Turkish Lira           2884
18 Daily Average Exchange rate of PAK Rupees per Thai Baht              2884
17 Daily Average Exchange rate of PAK Rupees per Saudi Riyal            2884
16 Daily Average Exchange rate of PAK Rupees per Swiss Franc            2884
15 Daily Average Exchange rate of PAK Rupees per Swedish Krona          2884
14 Daily Average Exchange rate of PAK Rupees per Singapore Dollar       2884
12 Daily Average Exchange rate of PAK Rupees per Omani Riyal            2884
2 Daily Average Exchange rate of PAK Rupees per Bahraini Dinar          2884
11 Daily Average Exchange rate of PAK Rupees per Norwegian Krone        2884
10 Daily Average Exchange rate of PAK Rupees per New Zealand Dollar     2884
9 Daily Average Exchange rate of PAK Rupees per Malaysian Ringgit       2884
8 Daily Average Exchange rate of PAK Rupees per Kuwaiti Dinar           2884
7 Daily Average Exchange rate of PAK Rupees per Japanese Yen            2884
6 Daily Average Exchange rate of PAK Rupees per Hon Kong Dollar         2884
5 Daily Average Exchange rate of PAK Rupees per Danish Krone            2884
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
PKR    66332
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    66332
```
**Column: `Observation Status Comment`** (Top 1 of 1 unique values)
```
Observation Status Comment
Iraqi invasion of Kuwait from Aug-1990 till Sep-1991    29
```
**Column: `Series name`** (Top 20 of 23 unique values)
```
Series name
Daily Average Exchange rate of PAK Rupees per Australian Dollar      2884
Daily Average Exchange rate of PAK Rupees per Qatari Riyal           2884
Daily Average Exchange rate of PAK Rupees per U.S. Dollar            2884
Daily Average Exchange rate of PAK Rupees per U.K. Pound Sterling    2884
Daily Average Exchange rate of PAK Rupees per U.A.E. Dirham          2884
Daily Average Exchange rate of PAK Rupees per Turkish Lira           2884
Daily Average Exchange rate of PAK Rupees per Thai Baht              2884
Daily Average Exchange rate of PAK Rupees per Saudi Riyal            2884
Daily Average Exchange rate of PAK Rupees per Swiss Franc            2884
Daily Average Exchange rate of PAK Rupees per Swedish Krona          2884
Daily Average Exchange rate of PAK Rupees per Singapore Dollar       2884
Daily Average Exchange rate of PAK Rupees per Omani Riyal            2884
Daily Average Exchange rate of PAK Rupees per Bahraini Dinar         2884
Daily Average Exchange rate of PAK Rupees per Norwegian Krone        2884
Daily Average Exchange rate of PAK Rupees per New Zealand Dollar     2884
Daily Average Exchange rate of PAK Rupees per Malaysian Ringgit      2884
Daily Average Exchange rate of PAK Rupees per Kuwaiti Dinar          2884
Daily Average Exchange rate of PAK Rupees per Japanese Yen           2884
Daily Average Exchange rate of PAK Rupees per Hong Kong Dollar       2884
Daily Average Exchange rate of PAK Rupees per Danish Krone           2884
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                            | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%    | 50%     | 75%     | Max     | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                           | LastNonNull                                                            |
|:---------------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:-------|:--------|:--------|:--------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------------------------------------|:-----------------------------------------------------------------------|
| Dataset Name               | object         |          66332 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Bank Floating Daily Average Exchange Rates (PKR per National Currency) | Bank Floating Daily Average Exchange Rates (PKR per National Currency) |
| Observation Date           | datetime64[ns] |          66332 |           0 | 0.00%     |          2884 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | 2013-07-02 00:00:00 | 2025-03-28 00:00:00 | 2025-03-28 00:00:00                                                    | 2013-07-02 00:00:00                                                    |
| Series Key                 | object         |          66332 |           0 | 0.00%     |            23 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | TS_GP_ES_FADERPKR_M.XRDAVG0010                                         | TS_GP_ES_FADERPKR_M.XRDAVG0230                                         |
| Series Display Name        | object         |          66332 |           0 | 0.00%     |            23 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | 1 Daily Average Exchange rate of PAK Rupees per Australian Dollar      | 23 Daily Average Exchange rate of PAK Rupees per Euro                  |
| Observation Value          | float64        |          66332 |           0 | 0.00%     |         65822 | 125.102 | 162.964  | 0.813  | 22.213 | 70.019  | 161.491 | 995.365 | 2.377      | 6.454      | NaT                 | NaT                 | 175.9695812                                                            | 129.748661                                                             |
| Unit                       | object         |          66332 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | PKR                                                                    | PKR                                                                    |
| Observation Status         | object         |          66332 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                 | Normal                                                                 |
| Observation Status Comment | object         |             29 |       66303 | 99.96%    |             1 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Iraqi invasion of Kuwait from Aug-1990 till Sep-1991                   | Iraqi invasion of Kuwait from Aug-1990 till Sep-1991                   |
| Sequence No.               | int64          |          66332 |           0 | 0.00%     |            23 | 120.000 | 66.333   | 10.000 | 60.000 | 120.000 | 180.000 | 230.000 | 0.000      | -1.205     | NaT                 | NaT                 | 10                                                                     | 230                                                                    |
| Series name                | object         |          66332 |           0 | 0.00%     |            23 | N/A     | N/A      | N/A    | N/A    | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Daily Average Exchange rate of PAK Rupees per Australian Dollar        | Daily Average Exchange rate of PAK Rupees per Euro                     |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `fiscal_development.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (32, 52) (rows, columns)
* **Format:** Detected **Wide** (Cols=52 > Rows=32). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Could not reliably convert transposed index to numeric/datetime. Kept as: object
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (51, 32) (rows, columns)

* **Original Column Names (52):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', 'Sub-Sectors-Level2', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

* **Analyzed Column Names (32):**
  ```
  ['Total Revenues (Rs.Million)', nan, nan, 'Tax Revenues (Rs.Million)', nan, nan, 'Non Tax Revenues (Rs.Million)', nan, nan, 'Revenue Surplus of autonomous bodies', 'Total Expenditures(Rs.Million)', nan, nan, nan, nan, nan, nan, 'Fiscal Balance (Rs.Million)', 'Financing (net)(Rs.Million)', nan, nan, nan, nan, nan, 'GDP(at Cuurent Market Prices) in Rs.million', 'Total Revenue (% of GDP)', nan, nan, 'Total Expenditures (% of GDP)', nan, nan, 'Fiscal Balance (% of GDP)']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 1,632
* **Data Types Summary:** {dtype('float64'): 32}

### Memory Usage (Bytes)

* **Total:** 15,934 Bytes
* **Per Analyzed Column + Index:**
```
Index                                          2878
Total Revenues (Rs.Million)                     408
NaN                                             408
NaN                                             408
Tax Revenues (Rs.Million)                       408
NaN                                             408
NaN                                             408
Non Tax Revenues (Rs.Million)                   408
NaN                                             408
NaN                                             408
Revenue Surplus of autonomous bodies            408
Total Expenditures(Rs.Million)                  408
NaN                                             408
NaN                                             408
NaN                                             408
NaN                                             408
NaN                                             408
NaN                                             408
Fiscal Balance (Rs.Million)                     408
Financing (net)(Rs.Million)                     408
NaN                                             408
NaN                                             408
NaN                                             408
NaN                                             408
NaN                                             408
GDP(at Cuurent Market Prices) in Rs.million     408
Total Revenue (% of GDP)                        408
NaN                                             408
NaN                                             408
Total Expenditures (% of GDP)                   408
NaN                                             408
NaN                                             408
Fiscal Balance (% of GDP)                       408
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 51 entries, Sub-Sectors-Level1 to 2023-24
Data columns (total 32 columns):
 #   Column                                       Non-Null Count  Dtype  
---  ------                                       --------------  -----  
 0   Total Revenues (Rs.Million)                  49 non-null     float64
 1   nan                                          43 non-null     float64
 2   nan                                          43 non-null     float64
 3   Tax Revenues (Rs.Million)                    49 non-null     float64
 4   nan                                          43 non-null     float64
 5   nan                                          43 non-null     float64
 6   Non Tax Revenues (Rs.Million)                49 non-null     float64
 7   nan                                          42 non-null     float64
 8   nan                                          42 non-null     float64
 9   Revenue Surplus of autonomous bodies         16 non-null     float64
 10  Total Expenditures(Rs.Million)               49 non-null     float64
 11  nan                                          49 non-null     float64
 12  nan                                          42 non-null     float64
 13  nan                                          42 non-null     float64
 14  nan                                          49 non-null     float64
 15  nan                                          33 non-null     float64
 16  nan                                          25 non-null     float64
 17  Fiscal Balance (Rs.Million)                  49 non-null     float64
 18  Financing (net)(Rs.Million)                  49 non-null     float64
 19  nan                                          49 non-null     float64
 20  nan                                          49 non-null     float64
 21  nan                                          49 non-null     float64
 22  nan                                          49 non-null     float64
 23  nan                                          26 non-null     float64
 24  GDP(at Cuurent Market Prices) in Rs.million  49 non-null     float64
 25  Total Revenue (% of GDP)                     49 non-null     float64
 26  nan                                          49 non-null     float64
 27  nan                                          49 non-null     float64
 28  Total Expenditures (% of GDP)                49 non-null     float64
 29  nan                                          49 non-null     float64
 30  nan                                          49 non-null     float64
 31  Fiscal Balance (% of GDP)                    49 non-null     float64
dtypes: float64(32)
memory usage: 13.1+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 212 (12.99%)
Columns (32 of 32) with missing values (Sorted):
```
Sectors
Revenue Surplus of autonomous bodies           35
NaN                                            26
NaN                                            25
NaN                                            18
NaN                                             9
NaN                                             9
NaN                                             9
NaN                                             9
NaN                                             8
NaN                                             8
NaN                                             8
NaN                                             8
GDP(at Cuurent Market Prices) in Rs.million     2
Total Revenue (% of GDP)                        2
Total Expenditures (% of GDP)                   2
NaN                                             2
NaN                                             2
NaN                                             2
NaN                                             2
NaN                                             2
NaN                                             2
Total Revenues (Rs.Million)                     2
NaN                                             2
NaN                                             2
Financing (net)(Rs.Million)                     2
Fiscal Balance (Rs.Million)                     2
NaN                                             2
NaN                                             2
Total Expenditures(Rs.Million)                  2
Non Tax Revenues (Rs.Million)                   2
Tax Revenues (Rs.Million)                       2
Fiscal Balance (% of GDP)                       2
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 32):
```
Sectors
Total Revenues (Rs.Million)             49
NaN                                     43
NaN                                     43
Tax Revenues (Rs.Million)               49
NaN                                     43
NaN                                     42
Non Tax Revenues (Rs.Million)           49
NaN                                     42
NaN                                     41
Revenue Surplus of autonomous bodies    16

...

Sectors
NaN                                            49
NaN                                            11
GDP(at Cuurent Market Prices) in Rs.million    49
Total Revenue (% of GDP)                       32
NaN                                            23
NaN                                            22
Total Expenditures (% of GDP)                  36
NaN                                            34
NaN                                            32
Fiscal Balance (% of GDP)                      34
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                                     | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount |              Mean |           StdDev |               Min |              25% |              50% |              75% |              Max |   Skewness |   Kurtosis | MinDate   | MaxDate   |   FirstNonNull |       LastNonNull |
|:--------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|------------------:|-----------------:|------------------:|-----------------:|-----------------:|-----------------:|-----------------:|-----------:|-----------:|:----------|:----------|---------------:|------------------:|
| Total Revenues (Rs.Million)                 | float64    |             49 |           2 | 3.92%     |            49 |       1.86454e+06 |      2.6271e+06  |   19264           | 117021           |  512500          |      2.56651e+06 |      9.78042e+06 |      1.69  |      2.076 | NaT       | NaT       |        19264   |       9.78042e+06 |
| nan                                         | float64    |             43 |           8 | 15.69%    |            43 |       1.94972e+06 |      2.47807e+06 |   39305           | 220894           |  673600          |      3.0792e+06  |      9.07056e+06 |      1.524 |      1.529 | NaT       | NaT       |        39305   |       9.07056e+06 |
| nan                                         | float64    |             43 |           8 | 15.69%    |            43 |  171932           | 233753           |    3324           |  16913           |   53000          | 230672           | 815435           |      1.538 |      1.164 | NaT       | NaT       |        12625   |  709860           |
| Tax Revenues (Rs.Million)                   | float64    |             49 |           2 | 3.92%     |            49 |       1.43502e+06 |      2.0569e+06  |   15544           |  93456           |  405600          |      2.05289e+06 |      7.8187e+06  |      1.749 |      2.289 | NaT       | NaT       |        15544   |       7.26248e+06 |
| nan                                         | float64    |             43 |           8 | 15.69%    |            43 |       1.50738e+06 |      1.93749e+06 |   40368           | 164153           |  534000          |      2.21152e+06 |      7.16914e+06 |      1.575 |      1.692 | NaT       | NaT       |        40368   |       6.71151e+06 |
| nan                                         | float64    |             43 |           8 | 15.69%    |            42 |  124359           | 189141           |    2554           |   7196           |   21800          | 170346           | 649559           |      1.611 |      1.345 | NaT       | NaT       |         2635   |  550969           |
| Non Tax Revenues (Rs.Million)               | float64    |             49 |           2 | 3.92%     |            49 |  428796           | 596490           |    3720           |  27049           |  106900          | 646231           |      2.51794e+06 |      1.725 |      2.614 | NaT       | NaT       |         3720   |       2.51794e+06 |
| nan                                         | float64    |             42 |           9 | 17.65%    |            42 |  452107           | 572544           |    8169           |  49898           |  148800          | 679734           |      2.35905e+06 |      1.597 |      2.185 | NaT       | NaT       |         8169   |       2.35905e+06 |
| nan                                         | float64    |             42 |           9 | 17.65%    |            41 |   46936.6         |  49209           |     758           |   8498.75        |   24131          |  77394           | 165876           |      1.048 |      0.099 | NaT       | NaT       |          758   |  158891           |
| Revenue Surplus of autonomous bodies        | float64    |             16 |          35 | 68.63%    |            16 |    2864.19        |   2312.55        |     423           |   1341.75        |    2152.5        |   3503.75        |   7920           |      1.08  |      0.133 | NaT       | NaT       |          585   |    7920           |
| Total Expenditures(Rs.Million)              | float64    |             49 |           2 | 3.92%     |            49 |       2.78053e+06 |      4.06047e+06 |   32329           | 180373           |  709100          |      4.32718e+06 |      1.6155e+07  |      1.804 |      2.605 | NaT       | NaT       |        32329   |       1.36828e+07 |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |       2.3439e+06  |      3.55864e+06 |   18925           | 133645           |  626400          |      3.46849e+06 |      1.4583e+07  |      1.965 |      3.339 | NaT       | NaT       |        18925   |       1.23333e+07 |
| nan                                         | float64    |             42 |           9 | 17.65%    |            42 |       1.94453e+06 |      2.66474e+06 |   36055           | 213169           |  578400          |      2.76474e+06 |      1.07852e+07 |      1.89  |      3.126 | NaT       | NaT       |        36055   |       9.12374e+06 |
| nan                                         | float64    |             42 |           9 | 17.65%    |            42 |  784556           |      1.05612e+06 |   10315           |  64538.8         |  196100          |      1.1538e+06  |      3.7978e+06  |      1.478 |      1.097 | NaT       | NaT       |        10315   |       3.20956e+06 |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |  438387           | 554479           |   13404           |  46728           |   98286          | 776850           |      1.89299e+06 |      1.227 |      0.174 | NaT       | NaT       |        13404   |       1.15808e+06 |
| nan                                         | float64    |             33 |          18 | 35.29%    |            32 |   25429.5         |  66938.3         |  -28494           |      0           |    7904          |  37625           | 362783           |      4.25  |     21.149 | NaT       | NaT       |        14934   |  -15300           |
| nan                                         | float64    |             25 |          26 | 50.98%    |            24 |  -39681.9         | 119138           | -380960           | -87273           |       0          |  15987           | 206761           |     -0.857 |      1.996 | NaT       | NaT       |         9700   |  206761           |
| Fiscal Balance (Rs.Million)                 | float64    |             49 |           2 | 3.92%     |            49 | -914729           |      1.47328e+06 |      -6.52144e+06 |     -1.34932e+06 | -179700          | -56060           | -12480           |     -2.167 |      4.623 | NaT       | NaT       |       -12480   |      -3.90242e+06 |
| Financing (net)(Rs.Million)                 | float64    |             49 |           2 | 3.92%     |            49 |  914724           |      1.47329e+06 |   12480           |  56060           |  179700          |      1.34932e+06 |      6.52144e+06 |      2.167 |      4.623 | NaT       | NaT       |        12480   |       3.90242e+06 |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |  163162           | 326638           | -679848           |   6977           |   29319          | 149651           |      1.33809e+06 |      1.728 |      5.051 | NaT       | NaT       |         6769   |  493815           |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |  751536           |      1.3541e+06  |    5711           |  38286           |  107350          | 978858           |      7.20129e+06 |      2.935 |     10.509 | NaT       | NaT       |         5711   |       3.4086e+06  |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |  223201           | 554242           | -377980           |  12873           |   56905          | 223846           |      3.6727e+06  |      5.272 |     32.384 | NaT       | NaT       |         1810   | -377980           |
| nan                                         | float64    |             49 |           2 | 3.92%     |            49 |  523406           | 951578           |  -73811           |   6305           |   52273          | 615129           |      3.78658e+06 |      2.189 |      4.254 | NaT       | NaT       |         3901   |       3.78658e+06 |
| nan                                         | float64    |             26 |          25 | 49.02%    |            11 |    9338.04        |  23352.3         |       0           |      0           |       0          |   3275           |  97300           |      3.107 |      9.438 | NaT       | NaT       |            0   |    2000           |
| GDP(at Cuurent Market Prices) in Rs.million | float64    |             49 |           2 | 3.92%     |            49 |       1.58379e+07 |      2.33089e+07 |  193872           |      1.01426e+06 |       5.1471e+06 |      2.23446e+07 |      1.06045e+08 |      2.15  |      4.838 | NaT       | NaT       |       193872   |       1.06045e+08 |
| Total Revenue (% of GDP)                    | float64    |             49 |           2 | 3.92%     |            32 |      11.49        |      1.076       |       9.2         |     10.8         |      11.5        |     12.1         |     13.9         |      0.17  |     -0.411 | NaT       | NaT       |            9.9 |       9.2         |
| nan                                         | float64    |             49 |           2 | 3.92%     |            23 |       8.859       |      0.805       |       6.8         |      8.2         |       8.9        |      9.3         |     10.8         |      0.09  |      0.076 | NaT       | NaT       |            8   |       6.8         |
| nan                                         | float64    |             49 |           2 | 3.92%     |            22 |       2.584       |      0.689       |       1.5         |      2           |       2.5        |      3           |      4.4         |      0.611 |     -0.334 | NaT       | NaT       |            1.9 |       2.4         |
| Total Expenditures (% of GDP)               | float64    |             49 |           2 | 3.92%     |            36 |      16.567       |      2.013       |      12.6         |     15.4         |      16.7        |     17.9         |     20.3         |     -0.247 |     -0.694 | NaT       | NaT       |           16.7 |      12.9         |
| nan                                         | float64    |             49 |           2 | 3.92%     |            34 |      12.888       |      2.182       |       8.6         |     11.4         |      12.8        |     14.5         |     17.9         |      0.258 |     -0.309 | NaT       | NaT       |            9.8 |      11.6         |
| nan                                         | float64    |             49 |           2 | 3.92%     |            32 |       3.776       |      1.424       |       1.1         |      2.6         |       3.8        |      4.6         |      7.1         |      0.294 |     -0.323 | NaT       | NaT       |            6.9 |       1.1         |
| Fiscal Balance (% of GDP)                   | float64    |             49 |           2 | 3.92%     |            34 |      -4.967       |      1.449       |      -7.9         |     -5.8         |      -5          |     -4           |     -1.7         |     -0.264 |     -0.126 | NaT       | NaT       |           -6.4 |      -3.7         |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 35519 pairs with absolute correlation > 0.8 (showing top 50):*
```
Sectors  Sectors
NaN      NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
         NaN        Sectors       NaN       NaN       NaN       Na...
```


---


## Analysis for: `foreign_invest_countires.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (44523, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=44523 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (44523, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 400,707
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 23,506,134 Bytes
* **Per Analyzed Column + Index:**
```
Index                      132
Dataset Name           4096116
Observation Date        356184
Series Key             3428271
Series Display Name    4905333
Observation Value       356184
Unit                   2671380
Observation Status     2448765
Sequence No.            356184
Series name            4887585
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 44523 entries, 0 to 44522
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         44523 non-null  object        
 1   Observation Date     44523 non-null  datetime64[ns]
 2   Series Key           44523 non-null  object        
 3   Series Display Name  44523 non-null  object        
 4   Observation Value    44523 non-null  float64       
 5   Unit                 44523 non-null  object        
 6   Observation Status   44523 non-null  object        
 7   Sequence No.         44523 non-null  int64         
 8   Series name          44523 non-null  object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 3.1+ MB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2012-07-31 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 153
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 44370 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name               1
Observation Date         153
Series Key               291
Series Display Name      291
Observation Value      14456
Unit                       1
Observation Status         1
Sequence No.             291
Series name              291
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Foreign Investment in Pakistan by Countries    44523
```
**Column: `Series Key`** (Top 20 of 291 unique values)
```
Series Key
TS_GP_FI_FIPKBYCOU_M.FIC0010    153
TS_GP_FI_FIPKBYCOU_M.FIC2200    153
TS_GP_FI_FIPKBYCOU_M.FIC2000    153
TS_GP_FI_FIPKBYCOU_M.FIC1990    153
TS_GP_FI_FIPKBYCOU_M.FIC1980    153
TS_GP_FI_FIPKBYCOU_M.FIC1970    153
TS_GP_FI_FIPKBYCOU_M.FIC1960    153
TS_GP_FI_FIPKBYCOU_M.FIC1950    153
TS_GP_FI_FIPKBYCOU_M.FIC1940    153
TS_GP_FI_FIPKBYCOU_M.FIC1930    153
TS_GP_FI_FIPKBYCOU_M.FIC1920    153
TS_GP_FI_FIPKBYCOU_M.FIC1910    153
TS_GP_FI_FIPKBYCOU_M.FIC1900    153
TS_GP_FI_FIPKBYCOU_M.FIC1890    153
TS_GP_FI_FIPKBYCOU_M.FIC1880    153
TS_GP_FI_FIPKBYCOU_M.FIC1870    153
TS_GP_FI_FIPKBYCOU_M.FIC1860    153
TS_GP_FI_FIPKBYCOU_M.FIC2010    153
TS_GP_FI_FIPKBYCOU_M.FIC2020    153
TS_GP_FI_FIPKBYCOU_M.FIC2030    153
```
**Column: `Series Display Name`** (Top 20 of 291 unique values)
```
Series Display Name
1 Net Cash Flow on Foreign Investment in Pakistan during a month                      153
............i Foreign Direct Investment inflows received in Pakistan from Portugal    153
............i Foreign Direct Investment inflows received in Pakistan from Oman        153
......I Foreign Direct Investment Net received in Pakistan from Oman                  153
40 Oman                                                                               153
......II Foreign Portfolio Investment Net in Pakistan from Norway                     153
............ii Foreign Direct Investment outflows from Pakistan to Norway             153
............i Foreign Direct Investment inflows received in Pakistan from Norway      153
......I Foreign Direct Investment Net received in Pakistan from Norway                153
39 Norway                                                                             153
......II Foreign Portfolio Investment Net in Pakistan from Nigeria                    153
............ii Foreign Direct Investment outflows from Pakistan to Nigeria            153
............i Foreign Direct Investment inflows received in Pakistan from Nigeria     153
......I Foreign Direct Investment Net received in Pakistan from Nigeria               153
38 Nigeria                                                                            153
......II Foreign Portfolio Investment Net in Pakistan from New Zealand                153
............ii Foreign Direct Investment outflows from Pakistan to New Zealand        153
............ii Foreign Direct Investment outflows from Pakistan to Oman               153
......II Foreign Portfolio Investment Net in Pakistan from Oman                       153
41 Panama                                                                             153
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million USD    44523
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    44523
```
**Column: `Series name`** (Top 20 of 291 unique values)
```
Series name
Net Foreign Investment received in Pakistan from the World              153
Foreign Direct Investment inflows received in Pakistan from Portugal    153
Foreign Direct Investment inflows received in Pakistan from Oman        153
Foreign Direct Investment Net received in Pakistan from Oman            153
Net Foreign Investment received in Pakistan from Oman                   153
Foreign Portfolio Investment Net in Pakistan from Norway                153
Foreign Direct Investment outflows from Pakistan to Norway              153
Foreign Direct Investment inflows received in Pakistan from Norway      153
Foreign Direct Investment Net received in Pakistan from Norway          153
Net Foreign Investment received in Pakistan from Norway                 153
Foreign Portfolio Investment Net in Pakistan from Nigeria               153
Foreign Direct Investment outflows from Pakistan to Nigeria             153
Foreign Direct Investment inflows received in Pakistan from Nigeria     153
Foreign Direct Investment Net received in Pakistan from Nigeria         153
Net Foreign Investment received in Pakistan from Nigeria                153
Foreign Portfolio Investment Net in Pakistan from New Zealand           153
Foreign Direct Investment outflows from Pakistan to New Zealand         153
Foreign Direct Investment outflows from Pakistan to Oman                153
Foreign Portfolio Investment Net in Pakistan from Oman                  153
Net Foreign Investment received in Pakistan from Panama                 153
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean     | StdDev   | Min       | 25%     | 50%      | 75%      | Max      | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                     | LastNonNull                                                       |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:---------|:---------|:----------|:--------|:---------|:---------|:---------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------------------------------|:------------------------------------------------------------------|
| Dataset Name        | object         |          44523 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Foreign Investment in Pakistan by Countries                      | Foreign Investment in Pakistan by Countries                       |
| Observation Date    | datetime64[ns] |          44523 |           0 | 0.00%     |           153 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | 2012-07-31 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                                              | 2012-07-31 00:00:00                                               |
| Series Key          | object         |          44523 |           0 | 0.00%     |           291 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | TS_GP_FI_FIPKBYCOU_M.FIC0010                                     | TS_GP_FI_FIPKBYCOU_M.FIC2920                                      |
| Series Display Name | object         |          44523 |           0 | 0.00%     |           291 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | 1 Net Cash Flow on Foreign Investment in Pakistan during a month | ......II Foreign Portfolio Investment Net in Pakistan from others |
| Observation Value   | float64        |          44523 |           0 | 0.00%     |         14456 | 4.786    | 49.111   | -1830.060 | 0.000   | 0.000    | 0.999    | 2662.490 | 18.849     | 1039.648   | NaT                 | NaT                 | -105.6517269                                                     | 5.012723                                                          |
| Unit                | object         |          44523 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Million USD                                                      | Million USD                                                       |
| Observation Status  | object         |          44523 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Normal                                                           | Normal                                                            |
| Sequence No.        | int64          |          44523 |           0 | 0.00%     |           291 | 1460.000 | 840.049  | 10.000    | 730.000 | 1460.000 | 2190.000 | 2910.000 | 0.000      | -1.200     | NaT                 | NaT                 | 10                                                               | 2910                                                              |
| Series name         | object         |          44523 |           0 | 0.00%     |           291 | N/A      | N/A      | N/A       | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Net Foreign Investment received in Pakistan from the World       | Foreign Portfolio Investment Net in Pakistan from others          |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `foreign_invest_sectors.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (23409, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=23409 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (23409, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 210,681
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 11,256,495 Bytes
* **Per Analyzed Column + Index:**
```
Index                      132
Dataset Name           2106810
Observation Date        187272
Series Key             1685448
Series Display Name    2228904
Observation Value       187272
Unit                   1404540
Observation Status     1287495
Sequence No.            187272
Series name            1981350
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 23409 entries, 0 to 23408
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         23409 non-null  object        
 1   Observation Date     23409 non-null  datetime64[ns]
 2   Series Key           23409 non-null  object        
 3   Series Display Name  23409 non-null  object        
 4   Observation Value    23409 non-null  float64       
 5   Unit                 23409 non-null  object        
 6   Observation Status   23409 non-null  object        
 7   Sequence No.         23409 non-null  int64         
 8   Series name          23409 non-null  object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 1.6+ MB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2012-07-31 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 153
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 23256 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name               1
Observation Date         153
Series Key               153
Series Display Name      153
Observation Value      10738
Unit                       1
Observation Status         1
Sequence No.             153
Series name              153
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Foreign Investment in Pakistan by Sectors    23409
```
**Column: `Series Key`** (Top 20 of 153 unique values)
```
Series Key
TS_GP_FI_FIPK_M.FIS0010    153
TS_GP_FI_FIPK_M.FIS1060    153
TS_GP_FI_FIPK_M.FIS0990    153
TS_GP_FI_FIPK_M.FIS1000    153
TS_GP_FI_FIPK_M.FIS1010    153
TS_GP_FI_FIPK_M.FIS1020    153
TS_GP_FI_FIPK_M.FIS1030    153
TS_GP_FI_FIPK_M.FIS1040    153
TS_GP_FI_FIPK_M.FIS1050    153
TS_GP_FI_FIPK_M.FIS1070    153
TS_GP_FI_FIPK_M.FIS0780    153
TS_GP_FI_FIPK_M.FIS1080    153
TS_GP_FI_FIPK_M.FIS1090    153
TS_GP_FI_FIPK_M.FIS1100    153
TS_GP_FI_FIPK_M.FIS1110    153
TS_GP_FI_FIPK_M.FIS1120    153
TS_GP_FI_FIPK_M.FIS1130    153
TS_GP_FI_FIPK_M.FIS1140    153
TS_GP_FI_FIPK_M.FIS0980    153
TS_GP_FI_FIPK_M.FIS0970    153
```
**Column: `Series Display Name`** (Top 20 of 153 unique values)
```
Series Display Name
1 Net Foreign Direct Investment in Pakistan                       153
28 Net FDI in Construction Sector                                 153
..................ii FDI outflows by Thermal Sector               153
............b Net FDI in Hydel Sector                             153
..................i FDI inflows in  Hydel Sector                  153
..................ii FDI outflows by Hydel Sector                 153
............c Net FDI in Coal Sector                              153
..................i FDI inflows in  Coal Sector                   153
..................ii FDI outflows by Coal Sector                  153
......i FDI inflows in  Construction Sector                       153
..................ii FDI outflows by Consumer/Household Sector    153
......ii FDI outflows by Construction Sector                      153
29 Net FDI in Trade Sector                                        153
......i FDI inflows in  Trade Sector                              153
......ii FDI outflows by Trade Sector                             153
30 Net FDI in Transport Sector                                    153
......i FDI inflows in  Transport Sector                          153
......ii FDI outflows by Transport Sector                         153
..................i FDI inflows in  Thermal Sector                153
............a Net FDI in Thermal Sector                           153
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million USD    23409
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    23409
```
**Column: `Series name`** (Top 20 of 153 unique values)
```
Series name
Net Foreign Direct Investment in Pakistan    153
Net FDI in Construction Sector               153
FDI outflows by Thermal Sector               153
Net FDI in Hydel Sector                      153
FDI inflows in  Hydel Sector                 153
FDI outflows by Hydel Sector                 153
Net FDI in Coal Sector                       153
FDI inflows in  Coal Sector                  153
FDI outflows by Coal Sector                  153
FDI inflows in  Construction Sector          153
FDI outflows by Consumer/Household Sector    153
FDI outflows by Construction Sector          153
Net FDI in Trade Sector                      153
FDI inflows in  Trade Sector                 153
FDI outflows by Trade Sector                 153
Net FDI in Transport Sector                  153
FDI inflows in  Transport Sector             153
FDI outflows by Transport Sector             153
FDI inflows in  Thermal Sector               153
Net FDI in Thermal Sector                    153
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min      | 25%     | 50%     | 75%      | Max      | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                | LastNonNull                               |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:---------|:--------|:--------|:---------|:---------|:-----------|:-----------|:--------------------|:--------------------|:--------------------------------------------|:------------------------------------------|
| Dataset Name        | object         |          23409 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Foreign Investment in Pakistan by Sectors   | Foreign Investment in Pakistan by Sectors |
| Observation Date    | datetime64[ns] |          23409 |           0 | 0.00%     |           153 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | 2012-07-31 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                         | 2012-07-31 00:00:00                       |
| Series Key          | object         |          23409 |           0 | 0.00%     |           153 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | TS_GP_FI_FIPK_M.FIS0010                     | TS_GP_FI_FIPK_M.FIS1530                   |
| Series Display Name | object         |          23409 |           0 | 0.00%     |           153 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | 1 Net Foreign Direct Investment in Pakistan | ......ii FDI outflows by Others Sector    |
| Observation Value   | float64        |          23409 |           0 | 0.00%     |         10738 | 8.005   | 36.383   | -532.902 | 0.000   | 0.365   | 3.434    | 973.533  | 8.979      | 137.863    | NaT                 | NaT                 | 25.74857695                                 | 0.412526                                  |
| Unit                | object         |          23409 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Million USD                                 | Million USD                               |
| Observation Status  | object         |          23409 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Normal                                      | Normal                                    |
| Sequence No.        | int64          |          23409 |           0 | 0.00%     |           153 | 770.000 | 441.673  | 10.000   | 390.000 | 770.000 | 1150.000 | 1530.000 | 0.000      | -1.200     | NaT                 | NaT                 | 10                                          | 1530                                      |
| Series name         | object         |          23409 |           0 | 0.00%     |           153 | N/A     | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Net Foreign Direct Investment in Pakistan   | FDI outflows by Others Sector             |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `gdp_domestic_2005.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (132, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=132 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (132, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 1,188
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 68,317 Bytes
* **Per Analyzed Column + Index:**
```
Index                    132
Dataset Name           15708
Observation Date        1056
Series Key             10692
Series Display Name    12496
Observation Value       1056
Unit                    7832
Observation Status      7267
Sequence No.            1056
Series name            11022
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 132 entries, 0 to 131
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         132 non-null    object        
 1   Observation Date     132 non-null    datetime64[ns]
 2   Series Key           132 non-null    object        
 3   Series Display Name  132 non-null    object        
 4   Observation Value    131 non-null    float64       
 5   Unit                 132 non-null    object        
 6   Observation Status   132 non-null    object        
 7   Sequence No.         132 non-null    int64         
 8   Series name          132 non-null    object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 9.4+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2000-06-30 00:00:00
* **Max Date:** 2021-06-30 00:00:00
* **Number of Unique Dates:** 22
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 110 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 1 (0.08%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name             1
Observation Date        22
Series Key               6
Series Display Name      6
Observation Value      131
Unit                     2
Observation Status       2
Sequence No.             6
Series name              6
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Gross Domestic Product of Pakistan at constant basic prices of 2005-06    132
```
**Column: `Series Key`** (Top 6 of 6 unique values)
```
Series Key
TS_GP_GA_FISPAKGDP_Y.GDP00060000    22
TS_GP_GA_FISPAKGDP_Y.GDP00050000    22
TS_GP_GA_FISPAKGDP_Y.GDP00010000    22
TS_GP_GA_FISPAKGDP_Y.GDP00020000    22
TS_GP_GA_FISPAKGDP_Y.GDP00030000    22
TS_GP_GA_FISPAKGDP_Y.GDP00040000    22
```
**Column: `Series Display Name`** (Top 6 of 6 unique values)
```
Series Display Name
A. Growth Rate of Real Gross Domestic Product                                                         22
B. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2005-06)): (1+2)    22
......1. Commodity Producing Sector (a+b)                                                             22
............a. Agricultural Sector                                                                    22
............b. Industrial Sector                                                                      22
......2. Services Sector                                                                              22
```
**Column: `Unit`** (Top 2 of 2 unique values)
```
Unit
Million PKR    110
Percent         22
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           131
Missing value      1
```
**Column: `Series name`** (Top 6 of 6 unique values)
```
Series name
Growth Rate of Real Gross Domestic Product                                                  22
Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2005-06))    22
Commodity Producing Sector                                                                  22
Agricultural Sector                                                                         22
Industrial Sector                                                                           22
Services Sector                                                                             22
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev      | Min     | 25%         | 50%         | 75%         | Max          | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                           | LastNonNull                                                            |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:------------|:------------|:--------|:------------|:------------|:------------|:-------------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------------------------------------|:-----------------------------------------------------------------------|
| Dataset Name        | object         |            132 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | Gross Domestic Product of Pakistan at constant basic prices of 2005-06 |
| Observation Date    | datetime64[ns] |            132 |           0 | 0.00%     |            22 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | 2000-06-30 00:00:00 | 2021-06-30 00:00:00 | 2021-06-30 00:00:00                                                    | 2000-06-30 00:00:00                                                    |
| Series Key          | object         |            132 |           0 | 0.00%     |             6 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | TS_GP_GA_FISPAKGDP_Y.GDP00060000                                       | TS_GP_GA_FISPAKGDP_Y.GDP00040000                                       |
| Series Display Name | object         |            132 |           0 | 0.00%     |             6 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | A. Growth Rate of Real Gross Domestic Product                          | ......2. Services Sector                                               |
| Observation Value   | float64        |            131 |           1 | 0.76%     |           131 | 3735965.290 | 3207407.141 | -0.470  | 1689539.000 | 2612310.000 | 5109416.500 | 13036381.000 | 1.063      | 0.594      | NaT                 | NaT                 | 3.94                                                                   | 3018413.0                                                              |
| Unit                | object         |            132 |           0 | 0.00%     |             2 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Percent                                                                | Million PKR                                                            |
| Observation Status  | object         |            132 |           0 | 0.00%     |             2 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                 | Normal                                                                 |
| Sequence No.        | int64          |            132 |           0 | 0.00%     |             6 | 350.000     | 171.433     | 100.000 | 200.000     | 350.000     | 500.000     | 600.000      | 0.000      | -1.271     | NaT                 | NaT                 | 100                                                                    | 600                                                                    |
| Series name         | object         |            132 |           0 | 0.00%     |             6 | N/A         | N/A         | N/A     | N/A         | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Growth Rate of Real Gross Domestic Product                             | Services Sector                                                        |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `gold_foreign_exchange_reserves.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (6808, 10) (rows, columns)
* **Format:** Detected **Tall** (Rows=6808 >= Cols=10). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (6808, 10) (rows, columns)

* **Original Column Names (10):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Observation Status Comment', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 68,080
* **Data Types Summary:** {dtype('O'): 7, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 3,350,074 Bytes
* **Per Analyzed Column + Index:**
```
Index                            132
Dataset Name                  646760
Observation Date               54464
Series Key                    503792
Series Display Name           536290
Observation Value              54464
Unit                          408480
Observation Status            374440
Observation Status Comment    224228
Sequence No.                   54464
Series name                   492560
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 6808 entries, 0 to 6807
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype         
---  ------                      --------------  -----         
 0   Dataset Name                6808 non-null   object        
 1   Observation Date            6808 non-null   datetime64[ns]
 2   Series Key                  6808 non-null   object        
 3   Series Display Name         6808 non-null   object        
 4   Observation Value           6808 non-null   float64       
 5   Unit                        6808 non-null   object        
 6   Observation Status          6808 non-null   object        
 7   Observation Status Comment  288 non-null    object        
 8   Sequence No.                6808 non-null   int64         
 9   Series name                 6808 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(7)
memory usage: 532.0+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 1948-06-30 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 669
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 6139 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 6,520 (9.58%)
Columns (1 of 10) with missing values (Sorted):
```
Observation Status Comment    6520
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               669
Series Key                      19
Series Display Name             19
Observation Value             4392
Unit                             1
Observation Status               1
Observation Status Comment       2
Sequence No.                    19
Series name                     19
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Gold and Foreign Exchange Reserves of Pakistan    6808
```
**Column: `Series Key`** (Top 19 of 19 unique values)
```
Series Key
TS_GP_EXT_PAKRES_M.Z00010    669
TS_GP_EXT_PAKRES_M.Z00020    669
TS_GP_EXT_PAKRES_M.Z00013    669
TS_GP_EXT_PAKRES_M.Z00070    663
TS_GP_EXT_PAKRES_M.Z00018    646
TS_GP_EXT_PAKRES_M.Z00040    646
TS_GP_EXT_PAKRES_M.Z00011    646
TS_GP_EXT_PAKRES_M.Z00017    321
TS_GP_EXT_PAKRES_M.Z00012    237
TS_GP_EXT_PAKRES_M.Z00021    237
TS_GP_EXT_PAKRES_M.Z00022    237
TS_GP_EXT_PAKRES_M.Z00023    237
TS_GP_EXT_PAKRES_M.Z00019    217
TS_GP_EXT_PAKRES_M.Z00050    177
TS_GP_EXT_PAKRES_M.Z00030    177
TS_GP_EXT_PAKRES_M.Z00060    171
TS_GP_EXT_PAKRES_M.Z00016     73
TS_GP_EXT_PAKRES_M.Z00014     58
TS_GP_EXT_PAKRES_M.Z00015     58
```
**Column: `Series Display Name`** (Top 19 of 19 unique values)
```
Series Display Name
. Gold (1)                                          669
. Total SBP Reserves (3=4+5+6+7+8-9)                669
....... Nostro balances (5)                         669
. Total Reserve Assets (18=1+3+11)                  663
....... Trade Nostro (13)                           646
. Total Banks Reserves (11=12+13+14-15-16-17)       646
....... SDR holdings (4)                            646
....... FE-25 deposits (12)                         321
....... Cash Foreign Currency (6)                   237
....... Trade Finance (15)                          237
....... FE-25 Placements in Pakistan (16)           237
....... Others (17)                                 237
....... Placement abroad (other than FE-25) (14)    217
. Net Reserves With Banks (10=12-15)                177
. Net Reserves with SBP (2=4+5-9)                   177
. Total Liquid FX Reserves (19=2+10)                171
....... CRR/SCRR (9)                                 73
....... ACU Balances Net (7)                         58
....... IMF reserve position (8)                     58
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million USD    6808
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    6808
```
**Column: `Observation Status Comment`** (Top 2 of 2 unique values)
```
Observation Status Comment
.......    198
.           90
```
**Column: `Series name`** (Top 19 of 19 unique values)
```
Series name
Gold reserves                                                               669
Total SBP Reserves                                                          669
Nostro balances of SBP                                                      669
Total Reserve Assets                                                        663
Trade Nostro of banks                                                       646
Total Banks Reserves                                                        646
Special Drawing rights holdings                                             646
FE-25 deposits of banks                                                     321
Cash Foreign Currency with SBP-BSC                                          237
Trade Finance from FCA                                                      237
FE-25 Placements of banks in Pakistan                                       237
FE-25 utilization-Others                                                    237
Place abroad(other than FE-25) of banks                                     217
Net Reserves With Banks                                                     177
Net Reserves with SBP                                                       177
Total Liquid FX Reserves                                                    171
Cash reserve requirement and special cash reserve requirement (CRR/SCRR)     73
Net Asian clearing unit balances                                             58
IMF reserve position                                                         58
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                            | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean     | StdDev   | Min      | 25%    | 50%     | 75%      | Max       | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                   | LastNonNull                                    |
|:---------------------------|:---------------|---------------:|------------:|:----------|--------------:|:---------|:---------|:---------|:-------|:--------|:---------|:----------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------------|:-----------------------------------------------|
| Dataset Name               | object         |           6808 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | Gold and Foreign Exchange Reserves of Pakistan | Gold and Foreign Exchange Reserves of Pakistan |
| Observation Date           | datetime64[ns] |           6808 |           0 | 0.00%     |           669 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | 1948-06-30 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                            | 1948-06-30 00:00:00                            |
| Series Key                 | object         |           6808 |           0 | 0.00%     |            19 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | TS_GP_EXT_PAKRES_M.Z00010                      | TS_GP_EXT_PAKRES_M.Z00070                      |
| Series Display Name        | object         |           6808 |           0 | 0.00%     |            19 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | . Gold (1)                                     | . Total Reserve Assets (18=1+3+11)             |
| Observation Value          | float64        |           6808 |           0 | 0.00%     |          4392 | 3127.311 | 4989.080 | -846.000 | 84.150 | 725.000 | 3409.750 | 27067.700 | 1.995      | 3.305      | NaT                 | NaT                 | 6484.78475                                     | 157.0                                          |
| Unit                       | object         |           6808 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | Million USD                                    | Million USD                                    |
| Observation Status         | object         |           6808 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | Normal                                         | Normal                                         |
| Observation Status Comment | object         |            288 |        6520 | 95.77%    |             2 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | .                                              | .......                                        |
| Sequence No.               | int64          |           6808 |           0 | 0.00%     |            19 | 9.200    | 5.839    | 1.000    | 4.000  | 10.000  | 14.000   | 19.000    | 0.128      | -1.398     | NaT                 | NaT                 | 1                                              | 18                                             |
| Series name                | object         |           6808 |           0 | 0.00%     |            19 | N/A      | N/A      | N/A      | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | NaT                 | NaT                 | Gold reserves                                  | Total Reserve Assets                           |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `growth_and_investment.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (286, 28) (rows, columns)
* **Format:** Detected **Tall** (Rows=286 >= Cols=28). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (286, 28) (rows, columns)

* **Original Column Names (28):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', 'Sub-Sectors-Level2', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 8,008
* **Data Types Summary:** {dtype('float64'): 25, dtype('O'): 3}

### Memory Usage (Bytes)

* **Total:** 107,139 Bytes
* **Per Analyzed Column + Index:**
```
Index                   132
Sectors               12523
Sub-Sectors-Level1    24750
Sub-Sectors-Level2    12534
1999-00                2288
2000-01                2288
2001-02                2288
2002-03                2288
2003-04                2288
2004-05                2288
2005-06                2288
2006-07                2288
2007-08                2288
2008-09                2288
2009-10                2288
2010-11                2288
2011-12                2288
2012-13                2288
2013-14                2288
2014-15                2288
2015-16                2288
2016-17                2288
2017-18                2288
2018-19                2288
2019-20                2288
2020-21                2288
2021-22                2288
2022-23                2288
2023-24                2288
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 286 entries, 0 to 285
Data columns (total 28 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             46 non-null     object 
 1   Sub-Sectors-Level1  192 non-null    object 
 2   Sub-Sectors-Level2  48 non-null     object 
 3   1999-00             256 non-null    float64
 4   2000-01             286 non-null    float64
 5   2001-02             286 non-null    float64
 6   2002-03             286 non-null    float64
 7   2003-04             286 non-null    float64
 8   2004-05             286 non-null    float64
 9   2005-06             286 non-null    float64
 10  2006-07             286 non-null    float64
 11  2007-08             286 non-null    float64
 12  2008-09             286 non-null    float64
 13  2009-10             286 non-null    float64
 14  2010-11             286 non-null    float64
 15  2011-12             286 non-null    float64
 16  2012-13             286 non-null    float64
 17  2013-14             286 non-null    float64
 18  2014-15             286 non-null    float64
 19  2015-16             286 non-null    float64
 20  2016-17             286 non-null    float64
 21  2017-18             286 non-null    float64
 22  2018-19             286 non-null    float64
 23  2019-20             286 non-null    float64
 24  2020-21             286 non-null    float64
 25  2021-22             286 non-null    float64
 26  2022-23             286 non-null    float64
 27  2023-24             286 non-null    float64
dtypes: float64(25), object(3)
memory usage: 62.7+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 602 (7.52%)
Columns (4 of 28) with missing values (Sorted):
```
Sectors               240
Sub-Sectors-Level2    238
Sub-Sectors-Level1     94
1999-00                30
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 28):
```
Sectors                46
Sub-Sectors-Level1    192
Sub-Sectors-Level2     48
1999-00               224
2000-01               253
2001-02               257
2002-03               257
2003-04               257
2004-05               254
2005-06               257

...

2014-15    255
2015-16    158
2016-17    255
2017-18    257
2018-19    258
2019-20    259
2020-21    255
2021-22    256
2022-23    258
2023-24    252
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 46 unique values)
```
Sectors
Agriculture at Basic Prices (Rs Million)                                             1
Private Sector GFCF at Current Prices (Rs Million)                                   1
NPISH Final Consumption Expenditure at Current Prices (Rs Million)                   1
General Government Final Consumption Expenditure at Current Prices (Rs Million)      1
Total Gross Capital Formation at Current Prices (Rs Million)                         1
Gross Fixed Capital Formation at Current Prices (Rs Million)                         1
Change in Inventories at Current Prices (Rs Million)                                 1
Valuable at Current Prices (Rs Million)                                              1
Expenditure on GDP at Market Prices at Current Prices (Rs Million)                   1
GNI at Basic Prices at Current Prices (Rs Million)                                   1
Private & Public at Current Prices GFCF (Rs Million)                                 1
Public Sector and General Govt. GFCF at Current Prices (Rs Million)                  1
Industrial Sector at Basic Prices (Rs Million)                                       1
Public Sector GFCF (Autonomous & Semi Auto-Bodies) at Current Prices (Rs Million)    1
General Govt. GFCF at Current Prices (Rs Million)                                    1
General Government GFCF (By industries) at Current Prices (Rs Million)               1
GFCF at Constant Prices 2015-16 (Rs Million)                                         1
Private & Public GFCF at Constant Prices 2015-16 (Rs Million)                        1
Private Sector GFCF at Constant Prices 2015-16 (Rs Million)                          1
Public Sector and General Govt. GFCF at Constant Prices 2015-16 (Rs Million)         1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 192 unique values)
```
Sub-Sectors-Level1
Crops at Basic Prices (Rs Million)                                                                                          1
Livestock at Basic Prices (Rs Million)                                                                                      1
Private Sector GFCF of Mining and quarrying at Current Prices (Rs Million)                                                  1
Private Sector GFCF of Manufacturing at Current Prices (Rs Million)                                                         1
Private Sector GFCF of Electricity, gas, and water supply at Current Prices (Rs Million)                                    1
Private Sector GFCF of Construction at Current Prices (Rs Million)                                                          1
Private Sector GFCF of Wholesale and retail trade at Current Prices (Rs Million)                                            1
Private Sector GFCF of Accommodation and food service activities (Hotels and Restaurants) at Current Prices (Rs Million)    1
Private Sector GFCF of Transportation and storage at Current Prices (Rs Million)                                            1
Private Sector GFCF of Information and communication at Current Prices (Rs Million)                                         1
Private Sector GFCF of Financial and insurance activities at Current Prices (Rs Million)                                    1
Private Sector GFCF of Real estate activities (Ownership of Dwellings) at Current Prices (Rs Million)                       1
Private Sector GFCF of Education at Current Prices (Rs Million)                                                             1
Private Sector GFCF of Human health and social work activities at Current Prices (Rs Million)                               1
Private Sector GFCF of Other Private Services at Current Prices (Rs Million)                                                1
Public Sector GFCF of Agriculture, Forestry & Fishing at Current Prices (Rs Million)                                        1
Public Sector GFCF of Mining and Quarrying at Current Prices (Rs Million)                                                   1
Public Sector GFCF of Manufacturing (Large Scale) at Current Prices (Rs Million)                                            1
Public Sector GFCF of Electricity, Gas & Water Supply at Current Prices (Rs Million)                                        1
Public Sector GFCF of Construction at Current Prices (Rs Million)                                                           1
```
**Column: `Sub-Sectors-Level2`** (Top 20 of 48 unique values)
```
Sub-Sectors-Level2
Important Crops at Basic Prices (Rs Million)                                                             1
Other Crops at Basic Prices (Rs Million)                                                                 1
Private Sector GFCF of Crops at Current Prices (Rs Million)                                              1
Private Sector GFCF of Cotton Ginning at Current Prices (Rs Million)                                     1
Private Sector GFCF of Livestock at Current Prices (Rs Million)                                          1
Private Sector GFCF of Forestry at Current Prices (Rs Million)                                           1
Private Sector GFCF of Fishing at Current Prices (Rs Million)                                            1
Private Sector GFCF of Large Scale at Current Prices (Rs Million)                                        1
Private Sector GFCF of Small Scale (including Slaughtering) at Current Prices (Rs Million)               1
Public Sector GFCF of Railways at Current Prices (Rs Million)                                            1
Public Sector GFCF of Post Office & PTCL at Current Prices (Rs Million)                                  1
Public Sector GFCF of Others at Current Prices (Rs Million)                                              1
Private & Public GFCF of Large Scale at Constant Prices 2015-16 (Rs Million)                             1
Private & Public GFCF of Small Scale (including Slaughtering) at Constant Prices 2015-16 (Rs Million)    1
Private Sector GFCF of Crops at Constant Prices 2015-16 (Rs Million)                                     1
Private Sector GFCF of Cotton Ginning at Constant Prices 2015-16 (Rs Million)                            1
Private Sector GFCF of Livestock at Constant Prices 2015-16 (Rs Million)                                 1
Private Sector GFCF of Forestry at Constant Prices 2015-16 (Rs Million)                                  1
Private Sector GFCF of Fishing at Constant Prices 2015-16 (Rs Million)                                   1
Private Sector GFCF of Large Scale at Constant Prices 2015-16 (Rs Million)                               1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev       | Min         | 25%       | 50%        | 75%         | Max           | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                                 | LastNonNull                                                                                           |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:------------|:-------------|:------------|:----------|:-----------|:------------|:--------------|:-----------|:-----------|:----------|:----------|:---------------------------------------------|:------------------------------------------------------------------------------------------------------|
| Sectors            | object     |             46 |         240 | 83.92%    |            46 | N/A         | N/A          | N/A         | N/A       | N/A        | N/A         | N/A           | N/A        | N/A        | NaT       | NaT       | Agriculture at Basic Prices (Rs Million)     | General Govt. GFCF (By industries) at Constant Prices 2015-16 (Rs Million)                            |
| Sub-Sectors-Level1 | object     |            192 |          94 | 32.87%    |           192 | N/A         | N/A          | N/A         | N/A       | N/A        | N/A         | N/A           | N/A        | N/A        | NaT       | NaT       | Crops at Basic Prices (Rs Million)           | General Govt. GFCF of Human health and social work activities at Constant Prices 2015-16 (Rs Million) |
| Sub-Sectors-Level2 | object     |             48 |         238 | 83.22%    |            48 | N/A         | N/A          | N/A         | N/A       | N/A        | N/A         | N/A           | N/A        | N/A        | NaT       | NaT       | Important Crops at Basic Prices (Rs Million) | Public Sector GFCF of Others at Constant Prices 2015-16 (Rs Million)                                  |
| 1999-00            | float64    |            256 |          30 | 10.49%    |           224 | 930918.299  | 2779700.277  | -256166.000 | 11724.500 | 75546.500  | 405882.500  | 16640026.000  | 4.550      | 21.434     | NaT       | NaT       | 5018356.0                                    | 20490.0                                                                                               |
| 2000-01            | float64    |            286 |           0 | 0.00%     |           253 | 875824.872  | 2754646.932  | -256563.000 | 832.750   | 53534.500  | 356707.500  | 17247611.000  | 4.775      | 23.819     | NaT       | NaT       | 5013941.0                                    | 20143.0                                                                                               |
| 2001-02            | float64    |            286 |           0 | 0.00%     |           257 | 904596.414  | 2846260.357  | -12.340     | 3120.000  | 54019.000  | 332315.250  | 17707862.000  | 4.760      | 23.689     | NaT       | NaT       | 5077194.0                                    | 19588.0                                                                                               |
| 2002-03            | float64    |            286 |           0 | 0.00%     |           257 | 974552.280  | 3032144.239  | -2.480      | 2357.000  | 66538.500  | 410705.000  | 19110937.000  | 4.737      | 23.528     | NaT       | NaT       | 5258170.0                                    | 23815.0                                                                                               |
| 2003-04            | float64    |            286 |           0 | 0.00%     |           257 | 1070267.195 | 3280221.418  | -0.470      | 3171.000  | 79181.000  | 421154.250  | 20430601.000  | 4.650      | 22.689     | NaT       | NaT       | 5420793.0                                    | 32021.0                                                                                               |
| 2004-05            | float64    |            286 |           0 | 0.00%     |           254 | 1181206.074 | 3564636.899  | -15.210     | 2346.250  | 83668.500  | 469223.000  | 21884205.000  | 4.555      | 21.753     | NaT       | NaT       | 5789117.0                                    | 37959.0                                                                                               |
| 2005-06            | float64    |            286 |           0 | 0.00%     |           257 | 1290385.607 | 3792391.122  | -37.190     | 3895.250  | 103938.000 | 505550.000  | 23174633.000  | 4.459      | 20.935     | NaT       | NaT       | 5898414.0                                    | 46765.0                                                                                               |
| 2006-07            | float64    |            286 |           0 | 0.00%     |           257 | 1384554.247 | 4025548.515  | -10.310     | 3766.750  | 106904.500 | 585615.000  | 24170020.000  | 4.339      | 19.699     | NaT       | NaT       | 6103888.0                                    | 34292.0                                                                                               |
| 2007-08            | float64    |            286 |           0 | 0.00%     |           257 | 1486346.779 | 4220969.224  | -17.040     | 2709.000  | 117933.000 | 632410.000  | 24697233.000  | 4.183      | 18.155     | NaT       | NaT       | 6153614.0                                    | 80767.0                                                                                               |
| 2008-09            | float64    |            286 |           0 | 0.00%     |           257 | 1572091.704 | 4435240.825  | -10.350     | 2445.000  | 122721.000 | 627138.000  | 25652056.000  | 4.070      | 16.920     | NaT       | NaT       | 6363627.0                                    | 73436.0                                                                                               |
| 2009-10            | float64    |            286 |           0 | 0.00%     |           256 | 1646694.295 | 4653360.977  | -7.500      | 2727.500  | 139449.000 | 624658.750  | 26299695.000  | 3.963      | 15.723     | NaT       | NaT       | 6383525.0                                    | 54515.0                                                                                               |
| 2010-11            | float64    |            286 |           0 | 0.00%     |           255 | 1789413.081 | 5037877.361  | -16.910     | 2636.000  | 135957.000 | 639792.000  | 27141393.000  | 3.814      | 14.069     | NaT       | NaT       | 6556680.0                                    | 48890.0                                                                                               |
| 2011-12            | float64    |            286 |           0 | 0.00%     |           256 | 1926851.297 | 5389850.969  | -8.780      | 3542.750  | 151744.000 | 713548.000  | 27973083.000  | 3.741      | 13.270     | NaT       | NaT       | 6768528.0                                    | 56700.0                                                                                               |
| 2012-13            | float64    |            286 |           0 | 0.00%     |           256 | 2064633.238 | 5779985.608  | -21.150     | 7268.250  | 161234.000 | 757169.750  | 29188670.000  | 3.712      | 12.930     | NaT       | NaT       | 6981192.0                                    | 45618.0                                                                                               |
| 2013-14            | float64    |            286 |           0 | 0.00%     |           256 | 2218598.310 | 6218920.092  | -8.620      | 5140.500  | 169698.500 | 806455.500  | 30515843.000  | 3.696      | 12.740     | NaT       | NaT       | 7150034.0                                    | 25068.0                                                                                               |
| 2014-15            | float64    |            286 |           0 | 0.00%     |           255 | 2370026.441 | 6611652.778  | -13.490     | 2689.250  | 194686.000 | 880353.000  | 31934959.000  | 3.700      | 12.765     | NaT       | NaT       | 7277452.0                                    | 53750.0                                                                                               |
| 2015-16            | float64    |            286 |           0 | 0.00%     |           158 | 2523990.064 | 7031477.333  | -21.690     | 2524.500  | 184962.000 | 904250.000  | 34217243.000  | 3.713      | 12.870     | NaT       | NaT       | 7306957.0                                    | 37389.0                                                                                               |
| 2016-17            | float64    |            286 |           0 | 0.00%     |           255 | 2701718.386 | 7497739.413  | -2.920      | 8415.500  | 205613.500 | 1043000.000 | 37012862.000  | 3.707      | 12.819     | NaT       | NaT       | 7468900.0                                    | 45712.0                                                                                               |
| 2017-18            | float64    |            286 |           0 | 0.00%     |           257 | 2942347.446 | 8116700.851  | 0.000       | 6200.000  | 239510.500 | 1235883.000 | 40729483.000  | 3.704      | 12.830     | NaT       | NaT       | 7758432.0                                    | 54968.0                                                                                               |
| 2018-19            | float64    |            286 |           0 | 0.00%     |           258 | 3138262.322 | 8814360.131  | -18.140     | 1611.500  | 291448.000 | 1130939.250 | 45934032.000  | 3.746      | 13.232     | NaT       | NaT       | 7831296.0                                    | 27680.0                                                                                               |
| 2019-20            | float64    |            286 |           0 | 0.00%     |           259 | 3258860.850 | 9243423.699  | -11.230     | 4230.000  | 257481.000 | 1195117.750 | 50271344.000  | 3.828      | 14.061     | NaT       | NaT       | 8137860.0                                    | 35482.0                                                                                               |
| 2020-21            | float64    |            286 |           0 | 0.00%     |           255 | 3694560.742 | 10566366.840 | -13.080     | 4879.250  | 271909.000 | 1258564.500 | 59743784.000  | 3.919      | 15.050     | NaT       | NaT       | 8424041.0                                    | 44745.0                                                                                               |
| 2021-22            | float64    |            286 |           0 | 0.00%     |           256 | 4239381.941 | 12208810.749 | -6.580      | 8103.250  | 301656.000 | 1768973.500 | 71143623.000  | 4.045      | 16.462     | NaT       | NaT       | 8784839.0                                    | 42532.0                                                                                               |
| 2022-23            | float64    |            286 |           0 | 0.00%     |           258 | 4825984.462 | 14557117.431 | -22.840     | 5368.000  | 255237.500 | 1945917.000 | 89181901.000  | 4.366      | 19.743     | NaT       | NaT       | 8982649.0                                    | 26587.0                                                                                               |
| 2023-24            | float64    |            286 |           0 | 0.00%     |           252 | 5338269.217 | 16633491.903 | -10.550     | 5344.250  | 283903.000 | 2383453.250 | 112142513.000 | 4.796      | 24.544     | NaT       | NaT       | 9539130.0                                    | 35259.0                                                                                               |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 268 pairs with absolute correlation > 0.8 (showing top 50):*
```
2014-15  2015-16    0.999790
1999-00  2000-01    0.999772
2016-17  2017-18    0.999737
2015-16  2016-17    0.999729
2000-01  2001-02    0.999712
2001-02  2002-03    0.999695
2013-14  2014-15    0.999618
2002-03  2003-04    0.999601
2003-04  2004-05    0.999541
2004-05  2005-06    0.999437
2014-15  2016-17    0.999429
2012-13  2013-14    0.999294
2011-12  2012-13    0.999238
1999-00  2001-02    0.999238
2013-14  2015-16    0.999208
2001-02  2003-04    0.999195
2005-06  2006-07    0.999184
2015-16  2017-18    0.998979
2000-01  2002-03    0.998974
2006-07  2007-08    0.998843
2017-18  2018-19    0.998718
2018-19  2019-20    0.998699
2019-20  2020-21    0.998684
2008-09  2009-10    0.998674
2010-11  2011-12    0.998632
2014-15  2017-18    0.998625
2002-03  2004-05    0.998599
2003-04  2005-06    0.998585
2013-14  2016-17    0.998431
2000-01  2003-04    0.998316
2007-08  2008-09    0.998261
1999-00  2002-03    0.998260
2012-13  2014-15    0.998105
2001-02  2004-05    0.998087
2004-05  2006-07    0.997944
2016-17  2018-19    0.997622
2012-13  2015-16    0.997558
2020-21  2021-22    0.997388
2013-14  2017-18    0.997217
2000-01  2004-05    0.997206
2011-12  2013-14    0.997192
1999-00  2003-04    0.997120
2002-03  2005-06    0.997080
2009-10  2010-11    0.996931
2003-04  2006-07    0.996385
2005-06  2007-08    0.996270
2001-02  2005-06    0.996161
2012-13  2016-17    0.996039
2010-11  2012-13    0.996031
2015-16  2018-19    0.996019
```


---


## Analysis for: `health_and_nutrition.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (59, 53) (rows, columns)
* **Format:** Detected **Tall** (Rows=59 >= Cols=53). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (59, 53) (rows, columns)

* **Original Column Names (53):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 3,127
* **Data Types Summary:** {dtype('float64'): 51, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 30,290 Bytes
* **Per Analyzed Column + Index:**
```
Index                  132
Sectors               2771
Sub-Sectors-Level1    3315
1973-74                472
1974-75                472
1975-76                472
1976-77                472
1977-78                472
1978-79                472
1979-80                472
1980-81                472
1981-82                472
1982-83                472
1983-84                472
1984-85                472
1985-86                472
1986-87                472
1987-88                472
1988-89                472
1989-90                472
1990-91                472
1991-92                472
1992-93                472
1993-94                472
1994-95                472
1995-96                472
1996-97                472
1997-98                472
1998-99                472
1999-00                472
2000-01                472
2001-02                472
2002-03                472
2003-04                472
2004-05                472
2005-06                472
2006-07                472
2007-08                472
2008-09                472
2009-10                472
2010-11                472
2011-12                472
2012-13                472
2013-14                472
2014-15                472
2015-16                472
2016-17                472
2017-18                472
2018-19                472
2019-20                472
2020-21                472
2021-22                472
2022-23                472
2023-24                472
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 59 entries, 0 to 58
Data columns (total 53 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             19 non-null     object 
 1   Sub-Sectors-Level1  40 non-null     object 
 2   1973-74             25 non-null     float64
 3   1974-75             28 non-null     float64
 4   1975-76             28 non-null     float64
 5   1976-77             28 non-null     float64
 6   1977-78             28 non-null     float64
 7   1978-79             28 non-null     float64
 8   1979-80             27 non-null     float64
 9   1980-81             28 non-null     float64
 10  1981-82             28 non-null     float64
 11  1982-83             28 non-null     float64
 12  1983-84             27 non-null     float64
 13  1984-85             28 non-null     float64
 14  1985-86             28 non-null     float64
 15  1986-87             28 non-null     float64
 16  1987-88             28 non-null     float64
 17  1988-89             28 non-null     float64
 18  1989-90             28 non-null     float64
 19  1990-91             36 non-null     float64
 20  1991-92             36 non-null     float64
 21  1992-93             40 non-null     float64
 22  1993-94             40 non-null     float64
 23  1994-95             43 non-null     float64
 24  1995-96             44 non-null     float64
 25  1996-97             43 non-null     float64
 26  1997-98             43 non-null     float64
 27  1998-99             43 non-null     float64
 28  1999-00             43 non-null     float64
 29  2000-01             43 non-null     float64
 30  2001-02             43 non-null     float64
 31  2002-03             43 non-null     float64
 32  2003-04             43 non-null     float64
 33  2004-05             43 non-null     float64
 34  2005-06             43 non-null     float64
 35  2006-07             40 non-null     float64
 36  2007-08             43 non-null     float64
 37  2008-09             43 non-null     float64
 38  2009-10             44 non-null     float64
 39  2010-11             44 non-null     float64
 40  2011-12             43 non-null     float64
 41  2012-13             28 non-null     float64
 42  2013-14             28 non-null     float64
 43  2014-15             46 non-null     float64
 44  2015-16             46 non-null     float64
 45  2016-17             46 non-null     float64
 46  2017-18             46 non-null     float64
 47  2018-19             46 non-null     float64
 48  2019-20             43 non-null     float64
 49  2020-21             43 non-null     float64
 50  2021-22             43 non-null     float64
 51  2022-23             43 non-null     float64
 52  2023-24             43 non-null     float64
dtypes: float64(51), object(2)
memory usage: 24.6+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 1,170 (37.42%)
Columns (53 of 53) with missing values (Sorted):
```
Sectors               40
1973-74               34
1983-84               32
1979-80               32
2012-13               31
2013-14               31
1989-90               31
1987-88               31
1986-87               31
1985-86               31
1984-85               31
1988-89               31
1982-83               31
1981-82               31
1980-81               31
1978-79               31
1977-78               31
1974-75               31
1976-77               31
1975-76               31
1990-91               23
1991-92               23
Sub-Sectors-Level1    19
2006-07               19
1993-94               19
1992-93               19
2021-22               16
2020-21               16
2019-20               16
2005-06               16
2011-12               16
2008-09               16
2007-08               16
2022-23               16
1997-98               16
2004-05               16
1999-00               16
1994-95               16
1996-97               16
1998-99               16
2003-04               16
2023-24               16
2000-01               16
2001-02               16
2002-03               16
2010-11               15
2009-10               15
1995-96               15
2014-15               13
2016-17               13
2017-18               13
2018-19               13
2015-16               13
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 53):
```
Sectors               19
Sub-Sectors-Level1    40
1973-74               18
1974-75               23
1975-76               22
1976-77               25
1977-78               22
1978-79               25
1979-80               25
1980-81               25

...

2014-15    42
2015-16    43
2016-17    43
2017-18    44
2018-19    44
2019-20    42
2020-21    42
2021-22    43
2022-23    43
2023-24    43
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 19 of 19 unique values)
```
Sectors
Hospitals (Numbers)                            1
Registered Nurses (Numbers)                    1
EPIVP (Calendar Year Basis) (Vaccine/doze.)    1
Non-Dev-exp (Rs. Million)                      1
Dev-exp (Rs. Million)                          1
Population per dentist (Numbers)               1
Population per Doctor (Numbers)                1
Registered Lady Health Visitors (Numbers)      1
Registered Mid-wifes (Numbers)                 1
Registered Dentists (Numbers)                  1
Dispensaries (Numbers)                         1
Registered Doctors (Numbers)                   1
Population per Bed (Numbers)                   1
Total Beds (Numbers)                           1
TB Centres (Numbers)                           1
Rural Health Centres (Numbers)                 1
Maternity & Child Health Centres (Numbers)     1
BHUs Sub Health Centres (Numbers)              1
Doctor Consulting Fee in Various Cities        1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 40 unique values)
```
Sub-Sectors-Level1
B.C.G. (000)                             1
POLIO, 0 (000)                           1
MEASLES, II (000)                        1
PNEUMOCOCCAL (PCV10), I (000)            1
PNEUMOCOCCAL (PCV10), II (000)           1
PNEUMOCOCCAL (PCV10), III (000)          1
PENTAVALENT (Vaccine/doze), I (000)      1
PENTAVALENT (Vaccine/doze),II (000)      1
PENTAVALENT (Vaccine/doze), III (000)    1
Faisalabad (Rs)                          1
Gujranwala (Rs)                          1
Hyderabad (Rs)                           1
Islamabad (Rs)                           1
Karachi (Rs)                             1
Lahore (Rs)                              1
Peshawar (Rs)                            1
Quetta (Rs)                              1
Rawalpindi (Rs)                          1
Sukkur (Rs)                              1
MEASLES, I (000)                         1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev     | Min    | 25%     | 50%      | 75%       | Max        | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull        | LastNonNull                             |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:-----------|:-------|:--------|:---------|:----------|:-----------|:-----------|:-----------|:----------|:----------|:--------------------|:----------------------------------------|
| Sectors            | object     |             19 |          40 | 67.80%    |            19 | N/A       | N/A        | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | N/A        | NaT       | NaT       | Hospitals (Numbers) | Doctor Consulting Fee in Various Cities |
| Sub-Sectors-Level1 | object     |             40 |          19 | 32.20%    |            40 | N/A       | N/A        | N/A    | N/A     | N/A      | N/A       | N/A        | N/A        | N/A        | NaT       | NaT       | B.C.G. (000)        | Pakistan (Rs)                           |
| 1973-74            | float64    |             25 |          34 | 57.63%    |            18 | 7229.331  | 24639.941  | 10.000 | 12.500  | 90.000   | 662.000   | 120018.000 | 4.393      | 20.186     | NaT       | NaT       | 521.0               | 12.5                                    |
| 1974-75            | float64    |             28 |          31 | 52.54%    |            23 | 6225.178  | 21760.291  | 15.000 | 19.688  | 190.000  | 754.000   | 111311.000 | 4.575      | 21.966     | NaT       | NaT       | 517.0               | 17.73                                   |
| 1975-76            | float64    |             28 |          31 | 52.54%    |            22 | 6243.455  | 21184.408  | 15.000 | 20.000  | 247.320  | 1363.750  | 107661.000 | 4.488      | 21.173     | NaT       | NaT       | 518.0               | 20.0                                    |
| 1976-77            | float64    |             28 |          31 | 52.54%    |            25 | 6147.947  | 20273.938  | 17.500 | 23.750  | 318.100  | 1688.500  | 102153.000 | 4.386      | 20.232     | NaT       | NaT       | 525.0               | 23.12                                   |
| 1977-78            | float64    |             28 |          31 | 52.54%    |            22 | 6238.812  | 20207.945  | 20.000 | 28.157  | 379.000  | 2019.750  | 101405.000 | 4.339      | 19.783     | NaT       | NaT       | 528.0               | 26.38                                   |
| 1978-79            | float64    |             28 |          31 | 52.54%    |            25 | 6246.180  | 19745.694  | 20.000 | 32.883  | 438.500  | 2129.500  | 98079.000  | 4.235      | 18.814     | NaT       | NaT       | 536.0               | 27.68                                   |
| 1979-80            | float64    |             27 |          32 | 54.24%    |            25 | 6446.221  | 19377.300  | 20.000 | 37.500  | 550.000  | 2573.000  | 93309.000  | 4.027      | 16.909     | NaT       | NaT       | 550.0               | 32.01                                   |
| 1980-81            | float64    |             28 |          31 | 52.54%    |            25 | 6223.773  | 18346.671  | 32.000 | 46.097  | 574.500  | 2153.500  | 87672.000  | 3.914      | 15.792     | NaT       | NaT       | 602.0               | 41.89                                   |
| 1981-82            | float64    |             28 |          31 | 52.54%    |            26 | 6243.229  | 17761.355  | 25.000 | 50.000  | 659.000  | 2183.500  | 83369.000  | 3.773      | 14.573     | NaT       | NaT       | 600.0               | 45.3                                    |
| 1982-83            | float64    |             28 |          31 | 52.54%    |            25 | 6298.309  | 17126.927  | 12.000 | 50.000  | 715.000  | 2166.000  | 77948.000  | 3.574      | 12.850     | NaT       | NaT       | 613.0               | 42.15                                   |
| 1983-84            | float64    |             27 |          32 | 54.24%    |            23 | 6632.447  | 17001.419  | 12.000 | 54.375  | 794.000  | 2666.500  | 73560.000  | 3.317      | 10.791     | NaT       | NaT       | 626.0               | 42.83                                   |
| 1984-85            | float64    |             28 |          31 | 52.54%    |            25 | 6517.019  | 16323.417  | 10.000 | 45.000  | 710.000  | 2621.000  | 68490.000  | 3.162      | 9.557      | NaT       | NaT       | 633.0               | 34.67                                   |
| 1985-86            | float64    |             28 |          31 | 52.54%    |            26 | 6859.465  | 16584.672  | 10.000 | 42.500  | 715.000  | 2775.250  | 67041.000  | 2.999      | 8.389      | NaT       | NaT       | 652.0               | 34.7                                    |
| 1986-87            | float64    |             28 |          31 | 52.54%    |            26 | 7121.636  | 16434.617  | 14.170 | 42.315  | 721.500  | 2994.000  | 62580.000  | 2.819      | 7.146      | NaT       | NaT       | 670.0               | 34.26                                   |
| 1987-88            | float64    |             28 |          31 | 52.54%    |            27 | 7456.068  | 16837.899  | 20.000 | 30.442  | 740.000  | 3237.000  | 61180.000  | 2.711      | 6.417      | NaT       | NaT       | 682.0               | 30.59                                   |
| 1988-89            | float64    |             28 |          31 | 52.54%    |            27 | 7775.559  | 17316.408  | 20.000 | 31.500  | 854.000  | 3494.500  | 64471.000  | 2.647      | 6.026      | NaT       | NaT       | 710.0               | 32.15                                   |
| 1989-90            | float64    |             28 |          31 | 52.54%    |            28 | 8013.065  | 17616.995  | 20.000 | 34.235  | 873.000  | 3698.750  | 66375.000  | 2.589      | 5.711      | NaT       | NaT       | 719.0               | 34.98                                   |
| 1990-91            | float64    |             36 |          23 | 38.98%    |            36 | 7471.007  | 16443.382  | 22.500 | 51.252  | 2079.500 | 4462.962  | 72997.000  | 3.072      | 8.938      | NaT       | NaT       | 756.0               | 35.79                                   |
| 1991-92            | float64    |             36 |          23 | 38.98%    |            36 | 7691.665  | 16980.634  | 22.500 | 48.000  | 2093.000 | 4417.747  | 75805.000  | 3.079      | 9.052      | NaT       | NaT       | 776.0               | 35.29                                   |
| 1992-93            | float64    |             40 |          19 | 32.20%    |            40 | 7128.835  | 16719.575  | 13.450 | 63.127  | 1468.140 | 4085.940  | 76938.000  | 3.246      | 10.151     | NaT       | NaT       | 778.0               | 38.86                                   |
| 1993-94            | float64    |             40 |          19 | 32.20%    |            39 | 7258.340  | 17254.069  | 27.140 | 78.750  | 1200.210 | 3991.500  | 80047.000  | 3.283      | 10.496     | NaT       | NaT       | 799.0               | 42.4                                    |
| 1994-95            | float64    |             43 |          16 | 27.12%    |            43 | 7233.636  | 17324.189  | 24.640 | 89.890  | 1803.000 | 4091.890  | 84883.000  | 3.501      | 12.277     | NaT       | NaT       | 822.0               | 43.23                                   |
| 1995-96            | float64    |             44 |          15 | 25.42%    |            42 | 7159.778  | 17517.245  | 27.500 | 97.492  | 1440.500 | 3647.830  | 85805.000  | 3.539      | 12.576     | NaT       | NaT       | 827.0               | 45.79                                   |
| 1996-97            | float64    |             43 |          16 | 27.12%    |            41 | 7873.754  | 18271.520  | 27.860 | 111.270 | 1689.000 | 4655.020  | 88454.000  | 3.500      | 12.350     | NaT       | NaT       | 858.0               | 41.02                                   |
| 1997-98            | float64    |             43 |          16 | 27.12%    |            43 | 8081.731  | 18817.355  | 27.860 | 85.750  | 1636.000 | 4663.995  | 89929.000  | 3.493      | 12.294     | NaT       | NaT       | 865.0               | 41.43                                   |
| 1998-99            | float64    |             43 |          16 | 27.12%    |            41 | 8289.307  | 19313.900  | 30.000 | 88.020  | 1605.410 | 4727.955  | 90659.000  | 3.478      | 12.162     | NaT       | NaT       | 872.0               | 40.45                                   |
| 1999-00            | float64    |             43 |          16 | 27.12%    |            42 | 8604.926  | 19864.624  | 30.000 | 82.350  | 2031.140 | 5127.550  | 92174.000  | 3.496      | 12.293     | NaT       | NaT       | 879.0               | 40.75                                   |
| 2000-01            | float64    |             43 |          16 | 27.12%    |            41 | 8711.529  | 20521.760  | 30.000 | 129.920 | 1787.970 | 4664.100  | 93907.000  | 3.529      | 12.512     | NaT       | NaT       | 876.0               | 41.86                                   |
| 2001-02            | float64    |             43 |          16 | 27.12%    |            41 | 8981.134  | 21378.445  | 30.000 | 135.625 | 1734.710 | 4656.885  | 97945.000  | 3.574      | 12.816     | NaT       | NaT       | 907.0               | 43.64                                   |
| 2002-03            | float64    |             43 |          16 | 27.12%    |            42 | 9272.219  | 22097.712  | 30.000 | 116.605 | 1842.280 | 4727.720  | 101635.000 | 3.546      | 12.603     | NaT       | NaT       | 906.0               | 43.17                                   |
| 2003-04            | float64    |             43 |          16 | 27.12%    |            42 | 9553.683  | 22840.802  | 30.000 | 102.820 | 2132.470 | 4967.305  | 108062.000 | 3.576      | 12.866     | NaT       | NaT       | 906.0               | 46.33                                   |
| 2004-05            | float64    |             43 |          16 | 27.12%    |            42 | 9779.555  | 23590.724  | 30.000 | 88.860  | 2352.550 | 4722.245  | 113206.000 | 3.589      | 13.004     | NaT       | NaT       | 916.0               | 46.62                                   |
| 2005-06            | float64    |             43 |          16 | 27.12%    |            42 | 10158.813 | 24291.684  | 30.000 | 75.000  | 2625.600 | 5030.825  | 117905.000 | 3.603      | 13.146     | NaT       | NaT       | 919.0               | 47.57                                   |
| 2006-07            | float64    |             40 |          19 | 32.20%    |            38 | 11175.262 | 26116.802  | 33.010 | 54.420  | 1381.000 | 5343.035  | 123146.000 | 3.388      | 11.579     | NaT       | NaT       | 924.0               | 51.81                                   |
| 2007-08            | float64    |             43 |          16 | 27.12%    |            39 | 11209.935 | 26206.214  | 43.750 | 97.500  | 3048.350 | 5515.605  | 128042.000 | 3.465      | 12.255     | NaT       | NaT       | 945.0               | 59.52                                   |
| 2008-09            | float64    |             43 |          16 | 27.12%    |            41 | 11819.794 | 27187.402  | 50.000 | 115.000 | 3384.970 | 5433.065  | 133925.000 | 3.397      | 11.912     | NaT       | NaT       | 948.0               | 77.49                                   |
| 2009-10            | float64    |             44 |          15 | 25.42%    |            42 | 12086.649 | 27807.491  | 35.840 | 115.000 | 2728.170 | 5894.900  | 139488.000 | 3.432      | 12.264     | NaT       | NaT       | 968.0               | 78.45                                   |
| 2010-11            | float64    |             44 |          15 | 25.42%    |            43 | 11572.625 | 28056.918  | 60.000 | 128.750 | 3286.390 | 5855.180  | 144901.000 | 3.718      | 14.226     | NaT       | NaT       | 972.0               | 88.95                                   |
| 2011-12            | float64    |             43 |          16 | 27.12%    |            42 | 13757.874 | 31413.459  | 68.750 | 146.950 | 3844.450 | 5755.900  | 152368.000 | 3.196      | 10.354     | NaT       | NaT       | 980.0               | 101.93                                  |
| 2012-13            | float64    |             28 |          31 | 52.54%    |            26 | 20661.131 | 41521.180  | 70.360 | 118.775 | 866.000  | 13818.000 | 160880.000 | 2.331      | 4.757      | NaT       | NaT       | 1092.0              | 121.7                                   |
| 2013-14            | float64    |             28 |          31 | 52.54%    |            25 | 22338.514 | 45166.536  | 75.000 | 133.032 | 893.000  | 13884.000 | 167759.000 | 2.277      | 4.246      | NaT       | NaT       | 1113.0              | 127.13                                  |
| 2014-15            | float64    |             46 |          13 | 22.03%    |            42 | 16509.064 | 38580.279  | 75.000 | 205.208 | 4715.450 | 5766.025  | 175223.000 | 3.068      | 8.904      | NaT       | NaT       | 1143.0              | 132.75                                  |
| 2015-16            | float64    |             46 |          13 | 22.03%    |            43 | 17546.143 | 41469.991  | 75.000 | 216.668 | 4922.450 | 5709.025  | 184711.000 | 3.076      | 8.957      | NaT       | NaT       | 1172.0              | 140.83                                  |
| 2016-17            | float64    |             46 |          13 | 22.03%    |            43 | 18919.304 | 45390.932  | 56.800 | 216.668 | 4902.400 | 5961.650  | 195896.000 | 3.108      | 9.193      | NaT       | NaT       | 1243.0              | 140.83                                  |
| 2017-18            | float64    |             46 |          13 | 22.03%    |            44 | 20853.671 | 50927.266  | 27.500 | 214.583 | 5065.850 | 5999.650  | 229957.000 | 3.140      | 9.531      | NaT       | NaT       | 1264.0              | 155.38                                  |
| 2018-19            | float64    |             46 |          13 | 22.03%    |            44 | 23338.661 | 61830.081  | 30.700 | 231.250 | 5165.150 | 6138.100  | 329033.000 | 3.745      | 14.983     | NaT       | NaT       | 1279.0              | 178.59                                  |
| 2019-20            | float64    |             43 |          16 | 27.12%    |            42 | 25524.831 | 68243.085  | 37.000 | 239.080 | 5492.700 | 6671.550  | 363154.000 | 3.850      | 15.847     | NaT       | NaT       | 1282.0              | 228.16                                  |
| 2020-21            | float64    |             43 |          16 | 27.12%    |            42 | 28246.847 | 77804.697  | 27.600 | 285.170 | 5617.200 | 6465.300  | 427915.000 | 4.033      | 17.794     | NaT       | NaT       | 1289.0              | 254.29                                  |
| 2021-22            | float64    |             43 |          16 | 27.12%    |            43 | 30836.180 | 87724.880  | 26.300 | 327.370 | 5504.600 | 6584.850  | 494606.000 | 4.237      | 19.787     | NaT       | NaT       | 1276.0              | 289.61                                  |
| 2022-23            | float64    |             43 |          16 | 27.12%    |            43 | 39423.645 | 120054.982 | 77.800 | 444.115 | 5832.000 | 7071.000  | 712289.000 | 4.674      | 24.475     | NaT       | NaT       | 1276.0              | 337.04                                  |
| 2023-24            | float64    |             43 |          16 | 27.12%    |            43 | 38225.416 | 114112.841 | 60.600 | 424.150 | 5584.000 | 6952.300  | 667307.000 | 4.537      | 22.998     | NaT       | NaT       | 1284.0              | 405.2                                   |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 581 pairs with absolute correlation > 0.8 (showing top 50):*
```
1976-77  1977-78    0.999782
1973-74  1974-75    0.999706
2000-01  2001-02    0.999632
1974-75  1975-76    0.999593
1975-76  1976-77    0.999545
1977-78  1978-79    0.999485
2008-09  2009-10    0.999475
1992-93  1993-94    0.999440
1999-00  2000-01    0.999425
2003-04  2004-05    0.999406
1998-99  1999-00    0.999242
2002-03  2003-04    0.999234
1978-79  1979-80    0.999215
2004-05  2005-06    0.999120
1990-91  1991-92    0.999098
1994-95  1995-96    0.999067
1991-92  1992-93    0.999050
1993-94  1994-95    0.999034
1995-96  1996-97    0.999032
1996-97  1997-98    0.999017
2001-02  2002-03    0.998922
1997-98  1998-99    0.998881
2006-07  2007-08    0.998881
2020-21  2021-22    0.998811
1975-76  1977-78    0.998798
2014-15  2015-16    0.998786
2015-16  2016-17    0.998710
1973-74  1975-76    0.998702
1980-81  1981-82    0.998674
1976-77  1978-79    0.998654
2022-23  2023-24    0.998457
2007-08  2008-09    0.998448
1999-00  2001-02    0.998428
1986-87  1987-88    0.998376
1974-75  1976-77    0.998299
2019-20  2020-21    0.998288
1979-80  1980-81    0.998256
2005-06  2006-07    0.998138
2003-04  2005-06    0.998078
1984-85  1985-86    0.998044
1988-89  1989-90    0.998002
1981-82  1982-83    0.997844
1982-83  1983-84    0.997838
2000-01  2002-03    0.997837
1998-99  2000-01    0.997666
1991-92  1993-94    0.997552
1977-78  1979-80    0.997433
2002-03  2004-05    0.997429
1989-90  1990-91    0.997404
1987-88  1988-89    0.997312
```


---


## Analysis for: `inflation.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (143, 66) (rows, columns)
* **Format:** Detected **Tall** (Rows=143 >= Cols=66). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (143, 66) (rows, columns)

* **Original Column Names (66):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1960-61', '1961-62', '1962-63', '1963-64', '1964-65', '1965-66', '1966-67', '1967-68', '1968-69', '1969-70', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 9,438
* **Data Types Summary:** {dtype('float64'): 64, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 90,087 Bytes
* **Per Analyzed Column + Index:**
```
Index                   132
Sectors               11685
Sub-Sectors-Level1     5054
1960-61                1144
1961-62                1144
1962-63                1144
1963-64                1144
1964-65                1144
1965-66                1144
1966-67                1144
1967-68                1144
1968-69                1144
1969-70                1144
1970-71                1144
1971-72                1144
1972-73                1144
1973-74                1144
1974-75                1144
1975-76                1144
1976-77                1144
1977-78                1144
1978-79                1144
1979-80                1144
1980-81                1144
1981-82                1144
1982-83                1144
1983-84                1144
1984-85                1144
1985-86                1144
1986-87                1144
1987-88                1144
1988-89                1144
1989-90                1144
1990-91                1144
1991-92                1144
1992-93                1144
1993-94                1144
1994-95                1144
1995-96                1144
1996-97                1144
1997-98                1144
1998-99                1144
1999-00                1144
2000-01                1144
2001-02                1144
2002-03                1144
2003-04                1144
2004-05                1144
2005-06                1144
2006-07                1144
2007-08                1144
2008-09                1144
2009-10                1144
2010-11                1144
2011-12                1144
2012-13                1144
2013-14                1144
2014-15                1144
2015-16                1144
2016-17                1144
2017-18                1144
2018-19                1144
2019-20                1144
2020-21                1144
2021-22                1144
2022-23                1144
2023-24                1144
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 143 entries, 0 to 142
Data columns (total 66 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             131 non-null    object 
 1   Sub-Sectors-Level1  12 non-null     object 
 2   1960-61             42 non-null     float64
 3   1961-62             42 non-null     float64
 4   1962-63             42 non-null     float64
 5   1963-64             42 non-null     float64
 6   1964-65             42 non-null     float64
 7   1965-66             43 non-null     float64
 8   1966-67             43 non-null     float64
 9   1967-68             43 non-null     float64
 10  1968-69             43 non-null     float64
 11  1969-70             51 non-null     float64
 12  1970-71             50 non-null     float64
 13  1971-72             51 non-null     float64
 14  1972-73             51 non-null     float64
 15  1973-74             50 non-null     float64
 16  1974-75             50 non-null     float64
 17  1975-76             50 non-null     float64
 18  1976-77             51 non-null     float64
 19  1977-78             51 non-null     float64
 20  1978-79             51 non-null     float64
 21  1979-80             51 non-null     float64
 22  1980-81             69 non-null     float64
 23  1981-82             77 non-null     float64
 24  1982-83             79 non-null     float64
 25  1983-84             79 non-null     float64
 26  1984-85             79 non-null     float64
 27  1985-86             79 non-null     float64
 28  1986-87             79 non-null     float64
 29  1987-88             79 non-null     float64
 30  1988-89             79 non-null     float64
 31  1989-90             79 non-null     float64
 32  1990-91             86 non-null     float64
 33  1991-92             94 non-null     float64
 34  1992-93             94 non-null     float64
 35  1993-94             94 non-null     float64
 36  1994-95             94 non-null     float64
 37  1995-96             94 non-null     float64
 38  1996-97             94 non-null     float64
 39  1997-98             95 non-null     float64
 40  1998-99             95 non-null     float64
 41  1999-00             95 non-null     float64
 42  2000-01             96 non-null     float64
 43  2001-02             96 non-null     float64
 44  2002-03             96 non-null     float64
 45  2003-04             96 non-null     float64
 46  2004-05             96 non-null     float64
 47  2005-06             101 non-null    float64
 48  2006-07             101 non-null    float64
 49  2007-08             101 non-null    float64
 50  2008-09             110 non-null    float64
 51  2009-10             110 non-null    float64
 52  2010-11             110 non-null    float64
 53  2011-12             108 non-null    float64
 54  2012-13             108 non-null    float64
 55  2013-14             108 non-null    float64
 56  2014-15             108 non-null    float64
 57  2015-16             108 non-null    float64
 58  2016-17             117 non-null    float64
 59  2017-18             117 non-null    float64
 60  2018-19             117 non-null    float64
 61  2019-20             115 non-null    float64
 62  2020-21             115 non-null    float64
 63  2021-22             115 non-null    float64
 64  2022-23             115 non-null    float64
 65  2023-24             115 non-null    float64
dtypes: float64(64), object(2)
memory usage: 73.9+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 4,064 (43.06%)
Columns (66 of 66) with missing values (Sorted):
```
Sub-Sectors-Level1    131
1960-61               101
1961-62               101
1962-63               101
1963-64               101
1964-65               101
1966-67               100
1968-69               100
1967-68               100
1965-66               100
1970-71                93
1973-74                93
1974-75                93
1975-76                93
1976-77                92
1979-80                92
1978-79                92
1977-78                92
1971-72                92
1972-73                92
1969-70                92
1980-81                74
1981-82                66
1985-86                64
1989-90                64
1987-88                64
1986-87                64
1988-89                64
1984-85                64
1983-84                64
1982-83                64
1990-91                57
1996-97                49
1994-95                49
1995-96                49
1991-92                49
1993-94                49
1992-93                49
1997-98                48
1998-99                48
1999-00                48
2000-01                47
2001-02                47
2002-03                47
2003-04                47
2004-05                47
2007-08                42
2006-07                42
2005-06                42
2011-12                35
2012-13                35
2013-14                35
2014-15                35
2015-16                35
2008-09                33
2009-10                33
2010-11                33
2019-20                28
2022-23                28
2021-22                28
2020-21                28
2023-24                28
2018-19                26
2017-18                26
2016-17                26
Sectors                12
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 66):
```
Sectors               131
Sub-Sectors-Level1     12
1960-61                42
1961-62                42
1962-63                42
1963-64                41
1964-65                41
1965-66                43
1966-67                42
1967-68                43

...

2014-15     96
2015-16     98
2016-17    110
2017-18    108
2018-19    110
2019-20    106
2020-21    106
2021-22    112
2022-23    107
2023-24    107
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 131 unique values)
```
Sectors
CPI, General                                              1
Average Retail Prices of Banana Doz.                      1
Average Retail Prices of Curd Kg                          1
Average Retail Prices of Vegetable Ghee 2.5 Kg            1
Average Retail Prices of Cooking Oil Dalda 2.5 Ltr        1
Average Retail Prices of Garlic Kg                        1
Average Retail Prices of Mash Pulse Kg                    1
Average Retail Prices of Masoor Pulse Kg                  1
Average Retail Prices of Rice Irri-6 Kg                   1
Average Retail Prices of Cooked Dal Plate                 1
Average Retail Prices of Cooked Beef Plate                1
Average Retail Prices of Electric Bulb (60-W)             1
Average Retail Prices of Lifebuoy soap Cake               1
Average Retail Prices of Washing Soap 707/555 Cake        1
Average Retail Prices of Match Box (40/50 Sticks) Each    1
Average Retail Prices of Firewood Kikar/Babul) 40 Kgs.    1
Average Retail Prices of Shoes gents Bata                 1
Average Retail Prices of Voil Printed Mtr.                1
Average Retail Prices of Coarse Latha Mtr.                1
Average Retail Prices of Cigarettes Pkt                   1
```
**Column: `Sub-Sectors-Level1`** (Top 12 of 12 unique values)
```
Sub-Sectors-Level1
Indices, Urban, Food           1
Indices, Urban, Non-food       1
Indices, Urban, Core           1
Indices, Rural, Food           1
Indices, Rural, Non-food       1
Indices, Rural, Core           1
Growth (%), Urban, Food        1
Growth (%), Urban, Non-food    1
Growth (%), Urban, Core        1
Growth (%), Rural, Food        1
Growth (%), Rural, Non-food    1
Growth (%), Rural, Core        1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%     | 50%     | 75%     | Max      | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull         | LastNonNull                           |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:--------|:--------|:--------|:---------|:-----------|:-----------|:----------|:----------|:---------------------|:--------------------------------------|
| Sectors            | object     |            131 |          12 | 8.39%     |           131 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT       | NaT       | CPI, General         | Indices of Wholesale Prices of Cement |
| Sub-Sectors-Level1 | object     |             12 |         131 | 91.61%    |            12 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A      | N/A        | N/A        | NaT       | NaT       | Indices, Urban, Food | Growth (%), Rural, Core               |
| 1960-61            | float64    |             42 |         101 | 70.63%    |            42 | 16.515  | 17.633   | 0.060  | 0.792   | 3.815   | 33.312  | 60.380   | 0.598      | -0.968     | NaT       | NaT       | 33.67                | 12.48                                 |
| 1961-62            | float64    |             42 |         101 | 70.63%    |            42 | 16.255  | 17.147   | 0.060  | 0.780   | 3.580   | 33.517  | 53.340   | 0.503      | -1.320     | NaT       | NaT       | 33.83                | 12.3                                  |
| 1962-63            | float64    |             42 |         101 | 70.63%    |            42 | 16.425  | 17.778   | 0.060  | 0.712   | 3.545   | 33.220  | 66.470   | 0.735      | -0.404     | NaT       | NaT       | 33.63                | 13.0                                  |
| 1963-64            | float64    |             42 |         101 | 70.63%    |            41 | 16.584  | 17.653   | 0.060  | 0.730   | 3.720   | 33.310  | 60.230   | 0.590      | -1.013     | NaT       | NaT       | 35.04                | 13.23                                 |
| 1964-65            | float64    |             42 |         101 | 70.63%    |            41 | 18.956  | 21.307   | 0.060  | 0.885   | 4.125   | 35.115  | 71.920   | 0.880      | -0.207     | NaT       | NaT       | 36.72                | 13.38                                 |
| 1965-66            | float64    |             43 |         100 | 69.93%    |            43 | 17.610  | 18.958   | 0.060  | 0.770   | 4.180   | 35.705  | 69.390   | 0.655      | -0.699     | NaT       | NaT       | 37.65                | 17.38                                 |
| 1966-67            | float64    |             43 |         100 | 69.93%    |            42 | 19.106  | 20.393   | 0.060  | 0.815   | 4.650   | 37.370  | 70.210   | 0.617      | -0.899     | NaT       | NaT       | 40.88                | 23.79                                 |
| 1967-68            | float64    |             43 |         100 | 69.93%    |            43 | 19.875  | 20.928   | 0.060  | 0.995   | 4.700   | 39.975  | 63.440   | 0.466      | -1.427     | NaT       | NaT       | 42.34                | 24.52                                 |
| 1968-69            | float64    |             43 |         100 | 69.93%    |            42 | 20.617  | 21.929   | 0.060  | 1.040   | 4.870   | 40.680  | 67.580   | 0.520      | -1.250     | NaT       | NaT       | 43.01                | 24.8                                  |
| 1969-70            | float64    |             51 |          92 | 64.34%    |            51 | 21.599  | 21.991   | 0.060  | 1.230   | 5.060   | 40.090  | 69.920   | 0.483      | -1.194     | NaT       | NaT       | 44.78                | 24.67                                 |
| 1970-71            | float64    |             50 |          93 | 65.03%    |            47 | 23.249  | 22.930   | 0.070  | 1.448   | 12.940  | 45.197  | 70.580   | 0.361      | -1.443     | NaT       | NaT       | 47.34                | 24.39                                 |
| 1971-72            | float64    |             51 |          92 | 64.34%    |            50 | 24.399  | 24.713   | 0.140  | 1.260   | 6.110   | 47.165  | 79.620   | 0.447      | -1.316     | NaT       | NaT       | 49.57                | 25.01                                 |
| 1972-73            | float64    |             51 |          92 | 64.34%    |            51 | 27.893  | 28.905   | 0.160  | 1.825   | 6.370   | 52.285  | 96.240   | 0.570      | -1.002     | NaT       | NaT       | 54.37                | 27.95                                 |
| 1973-74            | float64    |             50 |          93 | 65.03%    |            48 | 37.796  | 38.336   | 0.160  | 2.183   | 17.840  | 70.268  | 134.360  | 0.508      | -1.058     | NaT       | NaT       | 70.67                | 35.66                                 |
| 1974-75            | float64    |             50 |          93 | 65.03%    |            50 | 45.164  | 43.091   | 0.180  | 2.348   | 24.780  | 89.250  | 106.810  | 0.146      | -1.935     | NaT       | NaT       | 89.55                | 61.56                                 |
| 1975-76            | float64    |             50 |          93 | 65.03%    |            26 | 52.145  | 48.415   | 0.190  | 2.827   | 56.960  | 100.000 | 100.000  | -0.009     | -2.073     | NaT       | NaT       | 100.0                | 100.0                                 |
| 1976-77            | float64    |             51 |          92 | 64.34%    |            51 | 55.333  | 52.903   | 0.200  | 3.345   | 15.530  | 105.180 | 145.240  | 0.168      | -1.829     | NaT       | NaT       | 111.77               | 123.87                                |
| 1977-78            | float64    |             51 |          92 | 64.34%    |            50 | 63.370  | 59.792   | 0.230  | 3.585   | 79.990  | 118.415 | 171.820  | 0.174      | -1.718     | NaT       | NaT       | 120.48               | 150.7                                 |
| 1978-79            | float64    |             51 |          92 | 64.34%    |            51 | 67.290  | 64.561   | 0.250  | 3.960   | 80.220  | 125.400 | 211.870  | 0.283      | -1.463     | NaT       | NaT       | 128.47               | 211.87                                |
| 1979-80            | float64    |             51 |          92 | 64.34%    |            51 | 78.219  | 77.886   | 0.250  | 4.980   | 92.800  | 142.920 | 317.170  | 0.594      | -0.264     | NaT       | NaT       | 142.23               | 317.17                                |
| 1980-81            | float64    |             69 |          74 | 51.75%    |            48 | 46.171  | 51.376   | 0.250  | 4.830   | 10.930  | 100.000 | 159.810  | 0.720      | -1.019     | NaT       | NaT       | 159.81               | 100.0                                 |
| 1981-82            | float64    |             77 |          66 | 46.15%    |            76 | 53.098  | 50.308   | 0.250  | 5.710   | 24.100  | 105.470 | 139.750  | 0.257      | -1.836     | NaT       | NaT       | 111.1                | 114.12                                |
| 1982-83            | float64    |             79 |          64 | 44.76%    |            78 | 53.807  | 52.313   | 0.250  | 5.450   | 18.350  | 111.265 | 147.870  | 0.304      | -1.809     | NaT       | NaT       | 116.29               | 117.84                                |
| 1983-84            | float64    |             79 |          64 | 44.76%    |            78 | 59.828  | 59.119   | 0.250  | 6.280   | 19.820  | 122.555 | 189.990  | 0.390      | -1.597     | NaT       | NaT       | 124.76               | 129.71                                |
| 1984-85            | float64    |             79 |          64 | 44.76%    |            78 | 62.079  | 60.949   | 0.250  | 6.225   | 20.400  | 128.030 | 191.290  | 0.360      | -1.662     | NaT       | NaT       | 131.83               | 131.51                                |
| 1985-86            | float64    |             79 |          64 | 44.76%    |            76 | 64.660  | 62.711   | 0.250  | 6.180   | 21.330  | 133.345 | 199.950  | 0.339      | -1.644     | NaT       | NaT       | 137.57               | 140.41                                |
| 1986-87            | float64    |             79 |          64 | 44.76%    |            77 | 66.080  | 65.277   | 0.250  | 6.745   | 22.500  | 134.555 | 213.280  | 0.423      | -1.511     | NaT       | NaT       | 142.52               | 140.91                                |
| 1987-88            | float64    |             79 |          64 | 44.76%    |            77 | 71.974  | 70.955   | 0.260  | 7.340   | 23.930  | 146.770 | 229.730  | 0.428      | -1.489     | NaT       | NaT       | 151.49               | 149.45                                |
| 1988-89            | float64    |             79 |          64 | 44.76%    |            78 | 80.433  | 78.172   | 0.300  | 9.150   | 36.510  | 163.545 | 229.950  | 0.378      | -1.586     | NaT       | NaT       | 167.23               | 166.71                                |
| 1989-90            | float64    |             79 |          64 | 44.76%    |            77 | 86.002  | 84.643   | 0.310  | 8.465   | 33.090  | 177.465 | 281.270  | 0.426      | -1.436     | NaT       | NaT       | 177.33               | 172.04                                |
| 1990-91            | float64    |             86 |          57 | 39.86%    |            85 | 66.046  | 74.149   | 0.350  | 11.360  | 41.930  | 105.910 | 429.950  | 1.984      | 5.857      | NaT       | NaT       | 43.2                 | 108.0                                 |
| 1991-92            | float64    |             94 |          49 | 34.27%    |            89 | 49.817  | 45.268   | 0.440  | 10.580  | 41.400  | 71.650  | 174.950  | 0.873      | -0.451     | NaT       | NaT       | 47.41                | 114.13                                |
| 1992-93            | float64    |             94 |          49 | 34.27%    |            91 | 56.037  | 54.054   | 0.490  | 10.870  | 40.540  | 81.405  | 220.320  | 0.981      | -0.186     | NaT       | NaT       | 52.07                | 137.61                                |
| 1993-94            | float64    |             94 |          49 | 34.27%    |            90 | 64.792  | 64.239   | 0.490  | 11.912  | 50.545  | 89.605  | 313.710  | 1.280      | 1.338      | NaT       | NaT       | 57.94                | 169.92                                |
| 1994-95            | float64    |             94 |          49 | 34.27%    |            90 | 72.333  | 68.794   | 0.500  | 15.070  | 59.170  | 113.990 | 303.570  | 1.067      | 0.329      | NaT       | NaT       | 65.48                | 166.18                                |
| 1995-96            | float64    |             94 |          49 | 34.27%    |            90 | 81.445  | 78.479   | 0.500  | 14.158  | 64.660  | 119.330 | 299.950  | 0.937      | -0.408     | NaT       | NaT       | 72.55                | 200.32                                |
| 1996-97            | float64    |             94 |          49 | 34.27%    |            90 | 88.996  | 85.272   | 0.500  | 15.030  | 73.790  | 130.745 | 337.700  | 0.961      | -0.263     | NaT       | NaT       | 81.11                | 212.05                                |
| 1997-98            | float64    |             95 |          48 | 33.57%    |            91 | 92.681  | 89.168   | 0.500  | 17.675  | 76.930  | 130.125 | 339.000  | 0.986      | -0.179     | NaT       | NaT       | 87.45                | 216.99                                |
| 1998-99            | float64    |             95 |          48 | 33.57%    |            91 | 97.199  | 93.270   | 0.500  | 17.780  | 79.000  | 145.570 | 370.240  | 1.010      | 0.044      | NaT       | NaT       | 92.46                | 212.65                                |
| 1999-00            | float64    |             95 |          48 | 33.57%    |            90 | 102.586 | 103.616  | 0.500  | 18.105  | 82.720  | 152.510 | 430.670  | 1.186      | 0.660      | NaT       | NaT       | 95.78                | 215.14                                |
| 2000-01            | float64    |             96 |          47 | 32.87%    |            53 | 70.552  | 60.205   | 0.500  | 18.455  | 100.000 | 100.000 | 399.000  | 2.280      | 10.562     | NaT       | NaT       | 100.0                | 100.0                                 |
| 2001-02            | float64    |             96 |          47 | 32.87%    |            90 | 71.826  | 61.175   | 0.510  | 18.415  | 87.770  | 102.825 | 399.000  | 2.159      | 9.622      | NaT       | NaT       | 103.54               | 100.42                                |
| 2002-03            | float64    |             96 |          47 | 32.87%    |            90 | 74.674  | 66.039   | 0.510  | 18.747  | 83.500  | 106.750 | 428.170  | 2.252      | 9.776      | NaT       | NaT       | 106.75               | 102.77                                |
| 2003-04            | float64    |             96 |          47 | 32.87%    |            91 | 81.114  | 74.206   | 0.510  | 19.183  | 86.320  | 114.637 | 499.000  | 2.423      | 11.103     | NaT       | NaT       | 111.63               | 102.45                                |
| 2004-05            | float64    |             96 |          47 | 32.87%    |            92 | 85.074  | 71.027   | 0.530  | 23.848  | 95.030  | 123.142 | 492.330  | 2.066      | 10.068     | NaT       | NaT       | 121.98               | 104.82                                |
| 2005-06            | float64    |            101 |          42 | 29.37%    |            98 | 88.502  | 70.833   | 0.620  | 23.900  | 93.990  | 131.640 | 399.000  | 1.094      | 2.685      | NaT       | NaT       | 131.64               | 122.67                                |
| 2006-07            | float64    |            101 |          42 | 29.37%    |            98 | 95.331  | 75.393   | 0.710  | 27.430  | 100.480 | 141.870 | 429.000  | 1.064      | 2.631      | NaT       | NaT       | 141.87               | 127.42                                |
| 2007-08            | float64    |            101 |          42 | 29.37%    |            98 | 109.107 | 89.184   | 0.920  | 30.450  | 108.430 | 158.900 | 499.000  | 1.167      | 2.539      | NaT       | NaT       | 158.9                | 111.61                                |
| 2008-09            | float64    |            110 |          33 | 23.08%    |           100 | 105.385 | 79.441   | 1.000  | 44.517  | 111.875 | 123.430 | 499.000  | 2.077      | 7.067      | NaT       | NaT       | 117.03               | 129.08                                |
| 2009-10            | float64    |            110 |          33 | 23.08%    |            99 | 115.049 | 83.138   | 1.000  | 58.660  | 119.590 | 136.710 | 499.000  | 1.680      | 5.040      | NaT       | NaT       | 128.85               | 117.3                                 |
| 2010-11            | float64    |            110 |          33 | 23.08%    |            98 | 127.666 | 92.627   | 1.000  | 61.370  | 131.005 | 158.697 | 499.000  | 1.609      | 4.230      | NaT       | NaT       | 146.45               | 140.8                                 |
| 2011-12            | float64    |            108 |          35 | 24.48%    |            96 | 141.325 | 105.327  | 1.060  | 64.072  | 145.350 | 179.037 | 502.660  | 1.531      | 3.605      | NaT       | NaT       | 162.57               | 162.19                                |
| 2012-13            | float64    |            108 |          35 | 24.48%    |            97 | 151.398 | 113.188  | 1.100  | 68.965  | 156.690 | 191.020 | 549.000  | 1.545      | 3.719      | NaT       | NaT       | 174.53               | 185.77                                |
| 2013-14            | float64    |            108 |          35 | 24.48%    |            97 | 164.097 | 122.514  | 1.420  | 74.600  | 171.090 | 210.233 | 671.920  | 1.629      | 4.323      | NaT       | NaT       | 189.58               | 203.42                                |
| 2014-15            | float64    |            108 |          35 | 24.48%    |            96 | 168.829 | 125.944  | -0.300 | 78.690  | 175.975 | 214.532 | 699.000  | 1.562      | 4.262      | NaT       | NaT       | 198.16               | 225.95                                |
| 2015-16            | float64    |            108 |          35 | 24.48%    |            98 | 174.577 | 129.780  | -1.050 | 77.605  | 179.345 | 224.180 | 699.000  | 1.392      | 3.549      | NaT       | NaT       | 203.82               | 212.23                                |
| 2016-17            | float64    |            117 |          26 | 18.18%    |           110 | 140.943 | 127.978  | 2.000  | 77.480  | 105.290 | 178.770 | 699.000  | 2.165      | 5.988      | NaT       | NaT       | 104.81               | 214.45                                |
| 2017-18            | float64    |            117 |          26 | 18.18%    |           108 | 143.548 | 131.831  | 2.000  | 81.040  | 110.940 | 172.150 | 733.680  | 2.298      | 6.733      | NaT       | NaT       | 109.72               | 217.99                                |
| 2018-19            | float64    |            117 |          26 | 18.18%    |           110 | 154.639 | 138.094  | 2.000  | 85.750  | 119.100 | 195.430 | 783.880  | 2.127      | 5.869      | NaT       | NaT       | 117.18               | 236.62                                |
| 2019-20            | float64    |            115 |          28 | 19.58%    |           106 | 174.882 | 211.578  | 1.550  | 103.940 | 129.560 | 147.225 | 1199.220 | 3.203      | 10.874     | NaT       | NaT       | 129.76               | 113.42                                |
| 2020-21            | float64    |            115 |          28 | 19.58%    |           106 | 192.159 | 232.965  | 1.600  | 106.145 | 142.610 | 162.115 | 1374.940 | 3.182      | 10.793     | NaT       | NaT       | 141.31               | 122.71                                |
| 2021-22            | float64    |            115 |          28 | 19.58%    |           112 | 226.299 | 294.998  | 1.790  | 117.725 | 157.190 | 195.330 | 2038.510 | 3.632      | 15.485     | NaT       | NaT       | 158.48               | 151.5                                 |
| 2022-23            | float64    |            115 |          28 | 19.58%    |           107 | 303.967 | 415.127  | 1.790  | 149.420 | 204.110 | 266.290 | 2967.220 | 3.953      | 18.384     | NaT       | NaT       | 204.73               | 204.11                                |
| 2023-24            | float64    |            115 |          28 | 19.58%    |           107 | 380.197 | 523.263  | 1.790  | 182.935 | 252.660 | 353.920 | 3309.900 | 3.769      | 15.484     | NaT       | NaT       | 252.66               | 238.19                                |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 629 pairs with absolute correlation > 0.8 (showing top 50):*
```
1960-61  1961-62    0.997187
2000-01  2001-02    0.996885
2005-06  2006-07    0.996613
1962-63  1963-64    0.996328
1961-62  1963-64    0.995816
1960-61  1962-63    0.995810
         1963-64    0.995638
2001-02  2002-03    0.994833
2019-20  2020-21    0.994714
1968-69  1970-71    0.994635
1996-97  1997-98    0.993913
2011-12  2012-13    0.993911
2017-18  2018-19    0.993909
1967-68  1968-69    0.993852
2012-13  2013-14    0.993142
1968-69  1969-70    0.993070
1961-62  1962-63    0.993057
2016-17  2017-18    0.992549
1995-96  1996-97    0.992358
1983-84  1984-85    0.992060
1993-94  1994-95    0.991926
1961-62  1968-69    0.991693
1986-87  1987-88    0.991581
1987-88  1988-89    0.991477
1963-64  1965-66    0.991320
1997-98  1998-99    0.991280
2021-22  2022-23    0.990964
1962-63  1965-66    0.990929
1966-67  1967-68    0.990451
1984-85  1985-86    0.990216
1960-61  1965-66    0.990183
1961-62  1970-71    0.990019
1984-85  1986-87    0.989787
2013-14  2014-15    0.989614
2000-01  2002-03    0.989477
1975-76  1982-83    0.989068
1985-86  1986-87    0.989056
1961-62  1967-68    0.988886
2002-03  2003-04    0.988772
1984-85  1987-88    0.988496
1998-99  1999-00    0.988491
1982-83  1984-85    0.987787
1981-82  1982-83    0.987689
1986-87  1989-90    0.987603
1975-76  1981-82    0.987532
1961-62  1965-66    0.986934
1960-61  1968-69    0.986741
1967-68  1970-71    0.986617
         1969-70    0.986576
1992-93  1993-94    0.986263
```


---


## Analysis for: `inflation_base_2007.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (852, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=852 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (852, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 7,668
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 394,313 Bytes
* **Per Analyzed Column + Index:**
```
Index                    132
Dataset Name           74976
Observation Date        6816
Series Key             66456
Series Display Name    53392
Observation Value       6816
Unit                   47712
Observation Status     47133
Sequence No.            6816
Series name            84064
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 852 entries, 0 to 851
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         852 non-null    object        
 1   Observation Date     852 non-null    datetime64[ns]
 2   Series Key           852 non-null    object        
 3   Series Display Name  852 non-null    object        
 4   Observation Value    813 non-null    float64       
 5   Unit                 852 non-null    object        
 6   Observation Status   852 non-null    object        
 7   Sequence No.         852 non-null    int64         
 8   Series name          852 non-null    object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 60.0+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2008-07-31 00:00:00
* **Max Date:** 2020-04-30 00:00:00
* **Number of Unique Dates:** 142
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 710 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 39 (0.51%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    39
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name             1
Observation Date       142
Series Key               6
Series Display Name      6
Observation Value      813
Unit                     1
Observation Status       2
Sequence No.             6
Series name              6
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Inflation Snapshot (Base Year: 2007-08)    852
```
**Column: `Series Key`** (Top 6 of 6 unique values)
```
Series Key
TS_GP_RLS_CPI0708_M.P00010708    142
TS_GP_RLS_CPI0708_M.P00020708    142
TS_GP_RLS_CPI0708_M.P00030708    142
TS_GP_RLS_CPI0708_M.P00040708    142
TS_GP_RLS_CPI0708_M.P00050708    142
TS_GP_RLS_CPI0708_M.P00060708    142
```
**Column: `Series Display Name`** (Top 6 of 6 unique values)
```
Series Display Name
. General CPI (YoY)    142
. WPI (YoY)            142
. SPI (YoY)            142
. General CPI (MoM)    142
. WPI (MoM)            142
. SPI (MoM)            142
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Percent    852
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           813
Missing value     39
```
**Column: `Series name`** (Top 6 of 6 unique values)
```
Series name
General CPI, an Inflation Measure (Year-on-Year basis)      142
WPI, an Inflation Measure (Year-on-Year basis)              142
SPI, an Inflation Measure (Year-on-Year basis)              142
General CPI, an Inflation Measure (Month-on-Month basis)    142
WPI, an Inflation Measure (Month-on-Month basis)            142
SPI, an Inflation Measure (Month-on-Month basis)            142
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean   | StdDev   | Min    | 25%    | 50%    | 75%    | Max    | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                           | LastNonNull                                      |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:-------|:---------|:-------|:-------|:-------|:-------|:-------|:-----------|:-----------|:--------------------|:--------------------|:-------------------------------------------------------|:-------------------------------------------------|
| Dataset Name        | object         |            852 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Inflation Snapshot (Base Year: 2007-08)                | Inflation Snapshot (Base Year: 2007-08)          |
| Observation Date    | datetime64[ns] |            852 |           0 | 0.00%     |           142 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | 2008-07-31 00:00:00 | 2020-04-30 00:00:00 | 2020-04-30 00:00:00                                    | 2008-07-31 00:00:00                              |
| Series Key          | object         |            852 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | TS_GP_RLS_CPI0708_M.P00010708                          | TS_GP_RLS_CPI0708_M.P00060708                    |
| Series Display Name | object         |            852 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | . General CPI (YoY)                                    | . SPI (MoM)                                      |
| Observation Value   | float64        |            813 |          39 | 4.58%     |           813 | 4.129  | 5.481    | -3.671 | 0.343  | 1.662  | 7.342  | 24.872 | 1.382      | 1.272      | NaT                 | NaT                 | 9.461951399                                            | 2.887608312                                      |
| Unit                | object         |            852 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Percent                                                | Percent                                          |
| Observation Status  | object         |            852 |           0 | 0.00%     |             2 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Normal                                                 | Missing value                                    |
| Sequence No.        | int64          |            852 |           0 | 0.00%     |             6 | 35.000 | 17.088   | 10.000 | 20.000 | 35.000 | 50.000 | 60.000 | 0.000      | -1.269     | NaT                 | NaT                 | 10                                                     | 60                                               |
| Series name         | object         |            852 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | General CPI, an Inflation Measure (Year-on-Year basis) | SPI, an Inflation Measure (Month-on-Month basis) |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `inflation_base_2015.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (6360, 10) (rows, columns)
* **Format:** Detected **Tall** (Rows=6360 >= Cols=10). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (6360, 10) (rows, columns)

* **Original Column Names (10):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Observation Status Comment', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 63,600
* **Data Types Summary:** {dtype('O'): 7, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 3,294,392 Bytes
* **Per Analyzed Column + Index:**
```
Index                            132
Dataset Name                  553320
Observation Date               50880
Series Key                    464280
Series Display Name           442656
Observation Value              50880
Unit                          356160
Observation Status            351683
Observation Status Comment    249647
Sequence No.                   50880
Series name                   723874
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 6360 entries, 0 to 6359
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype         
---  ------                      --------------  -----         
 0   Dataset Name                6360 non-null   object        
 1   Observation Date            6360 non-null   datetime64[ns]
 2   Series Key                  6360 non-null   object        
 3   Series Display Name         6360 non-null   object        
 4   Observation Value           6091 non-null   float64       
 5   Unit                        6360 non-null   object        
 6   Observation Status          6360 non-null   object        
 7   Observation Status Comment  239 non-null    object        
 8   Sequence No.                6360 non-null   int64         
 9   Series name                 6360 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(7)
memory usage: 497.0+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2016-07-31 00:00:00
* **Max Date:** 2025-04-30 00:00:00
* **Number of Unique Dates:** 106
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 6254 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 6,390 (10.05%)
Columns (2 of 10) with missing values (Sorted):
```
Observation Status Comment    6121
Observation Value              269
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               106
Series Key                      60
Series Display Name             26
Observation Value             2140
Unit                             1
Observation Status               2
Observation Status Comment       1
Sequence No.                    60
Series name                     60
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Inflation Snapshot (New Base: 2015-16)    6360
```
**Column: `Series Key`** (Top 20 of 60 unique values)
```
Series Key
TS_GP_PT_CPI_M.P00011516    106
TS_GP_PT_CPI_M.P00021516    106
TS_GP_PT_CPI_M.P00421516    106
TS_GP_PT_CPI_M.P00431516    106
TS_GP_PT_CPI_M.P00571516    106
TS_GP_PT_CPI_M.P00581516    106
TS_GP_PT_CPI_M.P00141516    106
TS_GP_PT_CPI_M.P00151516    106
TS_GP_PT_CPI_M.P00291516    106
TS_GP_PT_CPI_M.P00301516    106
TS_GP_PT_CPI_M.P00441516    106
TS_GP_PT_CPI_M.P00451516    106
TS_GP_PT_CPI_M.P00591516    106
TS_GP_PT_CPI_M.P00601516    106
TS_GP_PT_CPI_M.P00081516    106
TS_GP_PT_CPI_M.P00091516    106
TS_GP_PT_CPI_M.P00101516    106
TS_GP_PT_CPI_M.P00231516    106
TS_GP_PT_CPI_M.P00241516    106
TS_GP_PT_CPI_M.P00251516    106
```
**Column: `Series Display Name`** (Top 20 of 26 unique values)
```
Series Display Name
............. Rural             1272
................... Food         848
................... Non-Food     848
............. Non-Food           424
............. Food               424
............. Urban              424
. CPI-YoY-National               106
. Trimmed-MoM-Urban              106
............. PA                 106
............. 12MMA              106
. SPI - Combined-YoY             106
. WPI-MoM-General                106
. WPI-PA-General                 106
. WPI-12MMA-General              106
. WPI-YoY-General                106
. Trimmed-12MMA-Urban            106
. Trimmed-PA-Urban               106
. Trimmed-YoY-Urban              106
. NFNE-MoM-Urban                 106
. NFNE-PA-Urban                  106
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Percent    6360
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           6091
Missing value     269
```
**Column: `Observation Status Comment`** (Top 1 of 1 unique values)
```
Observation Status Comment
The observation status is missing "MIS" due to trimmed inflation for YoY, MoM, 12MMA and Period Average. Further MIS is also used against 12MMA due to its computational nature.    239
```
**Column: `Series name`** (Top 20 of 60 unique values)
```
Series name
National CPI, an Inflation Measure (Year-on-Year basis)                                 106
Urban CPI, an Inflation Measure (Year-on-Year basis)                                    106
Urban NFNE Core Inflation, an Inflation Measure (Period average Since July basis)       106
Rural NFNE Core Inflation, an Inflation Measure (Period average Since July basis)       106
Urban NFNE Core Inflation, an Inflation Measure (Month-on-Month basis)                  106
Rural NFNE Core Inflation, an Inflation Measure (Month-on-Month basis)                  106
Urban Trimmed Core Inflation, an Inflation Measure (Year-on-Year basis)                 106
Rural Trimmed Core Inflation, an Inflation Measure (Year-on-Year basis)                 106
Urban Trimmed Core Inflation, an Inflation Measure (12-Months Moving average basis)     106
Rural Trimmed Core Inflation, an Inflation Measure (12-Months Moving average basis)     106
Urban Trimmed Core Inflation, an Inflation Measure (Period average Since July basis)    106
Rural Trimmed Core Inflation, an Inflation Measure (Period average Since July basis)    106
Urban Trimmed Core Inflation, an Inflation Measure (Month-on-Month basis)               106
Rural Trimmed Core Inflation, an Inflation Measure (Month-on-Month basis)               106
WPI, an Inflation Measure (Year-on-Year basis)                                          106
WPI Food, an Inflation Measure (Year-on-Year basis)                                     106
WPI Non-Food, an Inflation Measure (Year-on-Year basis)                                 106
WPI, an Inflation Measure (12-Months Moving average basis)                              106
WPI Food, an Inflation Measure (12-Months Moving average basis)                         106
WPI Non-Food, an Inflation Measure (12-Months Moving average basis)                     106
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                            | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean    | StdDev   | Min    | 25%     | 50%     | 75%     | Max     | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                                                                                                                                     | LastNonNull                                                                                                                                                                      |
|:---------------------------|:---------------|---------------:|------------:|:----------|--------------:|:--------|:---------|:-------|:--------|:--------|:--------|:--------|:-----------|:-----------|:--------------------|:--------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Dataset Name               | object         |           6360 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Inflation Snapshot (New Base: 2015-16)                                                                                                                                           | Inflation Snapshot (New Base: 2015-16)                                                                                                                                           |
| Observation Date           | datetime64[ns] |           6360 |           0 | 0.00%     |           106 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | 2016-07-31 00:00:00 | 2025-04-30 00:00:00 | 2025-04-30 00:00:00                                                                                                                                                              | 2016-07-31 00:00:00                                                                                                                                                              |
| Series Key                 | object         |           6360 |           0 | 0.00%     |            60 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | TS_GP_PT_CPI_M.P00011516                                                                                                                                                         | TS_GP_PT_CPI_M.P00561516                                                                                                                                                         |
| Series Display Name        | object         |           6360 |           0 | 0.00%     |            26 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | . CPI-YoY-National                                                                                                                                                               | ............. MoM                                                                                                                                                                |
| Observation Value          | float64        |           6091 |         269 | 4.23%     |          2140 | 9.602   | 9.722    | -7.400 | 2.260   | 6.760   | 13.374  | 52.400  | 1.324      | 1.277      | NaT                 | NaT                 | 0.3                                                                                                                                                                              | -1.19                                                                                                                                                                            |
| Unit                       | object         |           6360 |           0 | 0.00%     |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Percent                                                                                                                                                                          | Percent                                                                                                                                                                          |
| Observation Status         | object         |           6360 |           0 | 0.00%     |             2 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                                                                                                                           | Normal                                                                                                                                                                           |
| Observation Status Comment | object         |            239 |        6121 | 96.24%    |             1 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | The observation status is missing "MIS" due to trimmed inflation for YoY, MoM, 12MMA and Period Average. Further MIS is also used against 12MMA due to its computational nature. | The observation status is missing "MIS" due to trimmed inflation for YoY, MoM, 12MMA and Period Average. Further MIS is also used against 12MMA due to its computational nature. |
| Sequence No.               | int64          |           6360 |           0 | 0.00%     |            60 | 305.000 | 173.195  | 10.000 | 157.500 | 305.000 | 452.500 | 600.000 | 0.000      | -1.201     | NaT                 | NaT                 | 10                                                                                                                                                                               | 600                                                                                                                                                                              |
| Series name                | object         |           6360 |           0 | 0.00%     |            60 | N/A     | N/A      | N/A    | N/A     | N/A     | N/A     | N/A     | N/A        | N/A        | NaT                 | NaT                 | National CPI, an Inflation Measure (Year-on-Year basis)                                                                                                                          | SPI, an Inflation Measure (Month-on-Month basis)                                                                                                                                 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `information_technology_and_telecommunication.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (4, 7) (rows, columns)
* **Format:** Detected **Wide** (Cols=7 > Rows=4). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Transposed index converted to: datetime64[ns] (YYYY format)
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (6, 4) (rows, columns)

* **Original Column Names (7):**
  ```
  ['Sectors', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

* **Analyzed Column Names (4):**
  ```
  ['Telecom Revenues (Rs. bln)', 'Telecom Subscribers (mln. nos.)', 'Teledensity (percent)', 'Broadband Subscribers (mln.nos.)']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 24
* **Data Types Summary:** {dtype('float64'): 4}

### Memory Usage (Bytes)

* **Total:** 240 Bytes
* **Per Analyzed Column + Index:**
```
Index                               48
Telecom Revenues (Rs. bln)          48
Telecom Subscribers (mln. nos.)     48
Teledensity (percent)               48
Broadband Subscribers (mln.nos.)    48
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
DatetimeIndex: 6 entries, 2018-01-01 to 2023-01-01
Data columns (total 4 columns):
 #   Column                            Non-Null Count  Dtype  
---  ------                            --------------  -----  
 0   Telecom Revenues (Rs. bln)        6 non-null      float64
 1   Telecom Subscribers (mln. nos.)   6 non-null      float64
 2   Teledensity (percent)             6 non-null      float64
 3   Broadband Subscribers (mln.nos.)  6 non-null      float64
dtypes: float64(4)
memory usage: 240.0 bytes

```


### Date Analysis (Index (TimePeriod))

* **Data Type:** datetime64[ns]
* **Min Date:** 2018-01-01 00:00:00
* **Max Date:** 2023-01-01 00:00:00
* **Number of Unique Dates:** 6
* **Inferred Frequency:** YS-JAN
* **Missing Dates (based on inferred freq):** 0
* **Duplicate Dates:** 0



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 4):
```
Sectors
Telecom Revenues (Rs. bln)          6
Telecom Subscribers (mln. nos.)     6
Teledensity (percent)               6
Broadband Subscribers (mln.nos.)    6
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                          | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount |    Mean |   StdDev |   Min |     25% |    50% |     75% |   Max |   Skewness |   Kurtosis | MinDate   | MaxDate   |   FirstNonNull |   LastNonNull |
|:---------------------------------|:-----------|---------------:|------------:|:----------|--------------:|--------:|---------:|------:|--------:|-------:|--------:|------:|-----------:|-----------:|:----------|:----------|---------------:|--------------:|
| Telecom Revenues (Rs. bln)       | float64    |              6 |           0 | 0.00%     |             6 | 184.683 |   13.514 | 164.9 | 175.025 | 190.15 | 194.325 | 197.2 |     -0.804 |     -1.475 | NaT       | NaT       |          164.9 |         194.6 |
| Telecom Subscribers (mln. nos.)  | float64    |              6 |           0 | 0.00%     |             6 | 692.667 |   97.033 | 595   | 614.75  | 686    | 732.5   | 850   |      0.749 |     -0.137 | NaT       | NaT       |          604   |         735   |
| Teledensity (percent)            | float64    |              6 |           0 | 0.00%     |             6 |  79.967 |    3.583 |  75.1 |  77.4   |  81.05 |  81.625 |  84.6 |     -0.369 |     -1.085 | NaT       | NaT       |           75.1 |          80.7 |
| Broadband Subscribers (mln.nos.) | float64    |              6 |           0 | 0.00%     |             6 | 104.533 |   25.462 |  69.4 |  86.5   | 108    | 122.3   | 135.4 |     -0.293 |     -1.482 | NaT       | NaT       |           69.4 |         135.4 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 3 pairs with absolute correlation > 0.8 (showing top 50):*
```
Sectors                          Sectors                         
Telecom Revenues (Rs. bln)       Teledensity (percent)               0.940317
                                 Broadband Subscribers (mln.nos.)    0.939478
Telecom Subscribers (mln. nos.)  Broadband Subscribers (mln.nos.)    0.835894
```


---


## Analysis for: `kibor_kibid.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (88330, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=88330 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (88330, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 794,970
* **Data Types Summary:** {dtype('O'): 7, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 47,352,852 Bytes
* **Per Analyzed Column + Index:**
```
Index                      132
Dataset Name           8391350
Observation Date       5299800
Series Key             6959868
Series Display Name    7830226
Observation Value       706640
Unit                   4946480
Observation Status     4858150
Sequence No.            706640
Series name            7653566
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 88330 entries, 0 to 88329
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype  
---  ------               --------------  -----  
 0   Dataset Name         88330 non-null  object 
 1   Observation Date     88330 non-null  object 
 2   Series Key           88330 non-null  object 
 3   Series Display Name  88330 non-null  object 
 4   Observation Value    88330 non-null  float64
 5   Unit                 88330 non-null  object 
 6   Observation Status   88330 non-null  object 
 7   Sequence No.         88330 non-null  int64  
 8   Series name          88330 non-null  object 
dtypes: float64(1), int64(1), object(7)
memory usage: 6.1+ MB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date       5194
Series Key               18
Series Display Name      18
Observation Value      1828
Unit                      1
Observation Status        1
Sequence No.             18
Series name              18
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Structure of Interest Rates: KIBORs and KIBIDs    88330
```
**Column: `Observation Date`** (Top 20 of 5194 unique values)
```
Observation Date
30-Sep-2014    18
14-May-2011    18
23-Apr-2011    18
25-Apr-2011    18
26-Apr-2011    18
27-Apr-2011    18
28-Apr-2011    18
29-Apr-2011    18
30-Apr-2011    18
02-May-2011    18
03-May-2011    18
04-May-2011    18
05-May-2011    18
06-May-2011    18
07-May-2011    18
09-May-2011    18
10-May-2011    18
11-May-2011    18
12-May-2011    18
22-Apr-2011    18
```
**Column: `Series Key`** (Top 18 of 18 unique values)
```
Series Key
TS_GP_BAM_SIRKIBOR_D.KIBOR0030     5194
TS_GP_BAM_SIRKIBOR_D.KIBOR0010     5194
TS_GP_BAM_SIRKIBOR_D.KIBOR0020     5194
TS_GP_BAM_SIRKIBOR_D.1KIBOR1W      5192
TS_GP_BAM_SIRKIBOR_D.7KIBOR12M     5192
TS_GP_BAM_SIRKIBOR_D.16KIBID12M    5192
TS_GP_BAM_SIRKIBOR_D.6KIBOR9M      5192
TS_GP_BAM_SIRKIBOR_D.15KIBID9M     5192
TS_GP_BAM_SIRKIBOR_D.10KIBID1W     5192
TS_GP_BAM_SIRKIBOR_D.14KIBID6M     5192
TS_GP_BAM_SIRKIBOR_D.13KIBID3M     5192
TS_GP_BAM_SIRKIBOR_D.12KIBID1M     5192
TS_GP_BAM_SIRKIBOR_D.2KIBOR2W      5192
TS_GP_BAM_SIRKIBOR_D.11KIBID2W     5192
TS_GP_BAM_SIRKIBOR_D.17KIBID2Y     3909
TS_GP_BAM_SIRKIBOR_D.8KIBOR2Y      3909
TS_GP_BAM_SIRKIBOR_D.18KIBID3Y     3909
TS_GP_BAM_SIRKIBOR_D.9KIBOR3Y      3909
```
**Column: `Series Display Name`** (Top 18 of 18 unique values)
```
Series Display Name
. Six-Months Karachi Interbank Offer Rate      5194
. One-Month Karachi Interbank Offer Rate       5194
. Three-Months Karachi Interbank Offer Rate    5194
. One-Week Karachi Interbank Offer Rate        5192
. One-Year Karachi Interbank Offer Rate        5192
. One-Year Karachi Interbank Bid Rate          5192
. Nine-Months Karachi Interbank Offer Rate     5192
. Nine-Months Karachi Interbank Bid Rate       5192
. One-Week Karachi Interbank Bid Rate          5192
. Six-Months Karachi Interbank Bid Rate        5192
. Three-Months Karachi Interbank Bid Rate      5192
. One-Month Karachi Interbank Bid Rate         5192
. Two-Weeks Karachi Interbank Offer Rate       5192
. Two-Weeks Karachi Interbank Bid Rate         5192
. Two-Years Karachi Interbank Bid Rate         3909
. Two-Years Karachi Interbank Offer Rate       3909
. Three-Years Karachi Interbank Bid Rate       3909
. Three-Years Karachi Interbank Offer Rate     3909
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Percent    88330
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    88330
```
**Column: `Series name`** (Top 18 of 18 unique values)
```
Series name
Six-Months Karachi Interbank Offer Rate      5194
One-Month Karachi Interbank Offer Rate       5194
Three-Months Karachi Interbank Offer Rate    5194
One-Week Karachi Interbank Offer Rate        5192
One-Year Karachi Interbank Offer Rate        5192
One-Year Karachi Interbank Bid Rate          5192
Nine-Months Karachi Interbank Offer Rate     5192
Nine-Months Karachi Interbank Bid Rate       5192
One-Week Karachi Interbank Bid Rate          5192
Six-Months Karachi Interbank Bid Rate        5192
Three-Months Karachi Interbank Bid Rate      5192
One-Month Karachi Interbank Bid Rate         5192
Two-Weeks Karachi Interbank Offer Rate       5192
Two-Weeks Karachi Interbank Bid Rate         5192
Two-Years Karachi Interbank Bid Rate         3909
Two-Years Karachi Interbank Offer Rate       3909
Three-Years Karachi Interbank Bid Rate       3909
Three-Years Karachi Interbank Offer Rate     3909
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean   | StdDev   | Min    | 25%    | 50%    | 75%     | Max     | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                                   | LastNonNull                                    |
|:--------------------|:-----------|---------------:|------------:|:----------|--------------:|:-------|:---------|:-------|:-------|:-------|:--------|:--------|:-----------|:-----------|:----------|:----------|:-----------------------------------------------|:-----------------------------------------------|
| Dataset Name        | object     |          88330 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | Structure of Interest Rates: KIBORs and KIBIDs | Structure of Interest Rates: KIBORs and KIBIDs |
| Observation Date    | object     |          88330 |           0 | 0.00%     |          5194 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | 02-May-2025                                    | 09-Jun-2005                                    |
| Series Key          | object     |          88330 |           0 | 0.00%     |            18 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | TS_GP_BAM_SIRKIBOR_D.10KIBID1W                 | TS_GP_BAM_SIRKIBOR_D.9KIBOR3Y                  |
| Series Display Name | object     |          88330 |           0 | 0.00%     |            18 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | . One-Week Karachi Interbank Bid Rate          | . Three-Years Karachi Interbank Offer Rate     |
| Observation Value   | float64    |          88330 |           0 | 0.00%     |          1828 | 10.954 | 3.747    | 5.010  | 8.350  | 10.340 | 12.860  | 25.160  | 1.102      | 1.467      | NaT       | NaT       | 11.87                                          | 10.53                                          |
| Unit                | object     |          88330 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | Percent                                        | Percent                                        |
| Observation Status  | object     |          88330 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | Normal                                         | Normal                                         |
| Sequence No.        | int64      |          88330 |           0 | 0.00%     |            18 | 90.932 | 50.393   | 10.000 | 50.000 | 90.000 | 130.000 | 180.000 | 0.075      | -1.134     | NaT       | NaT       | 10                                             | 180                                            |
| Series name         | object     |          88330 |           0 | 0.00%     |            18 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A     | N/A     | N/A        | N/A        | NaT       | NaT       | One-Week Karachi Interbank Bid Rate            | Three-Years Karachi Interbank Offer Rate       |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `m2_broad_money.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (28200, 10) (rows, columns)
* **Format:** Detected **Tall** (Rows=28200 >= Cols=10). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (28200, 10) (rows, columns)

* **Original Column Names (10):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Observation Status Comment', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 282,000
* **Data Types Summary:** {dtype('O'): 6, dtype('float64'): 2, dtype('<M8[ns]'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 13,480,860 Bytes
* **Per Analyzed Column + Index:**
```
Index                             132
Dataset Name                  1974000
Observation Date               225600
Series Key                    2002200
Series Display Name           2623728
Observation Value              225600
Unit                          1685232
Observation Status            1551000
Observation Status Comment     225600
Sequence No.                   225600
Series name                   2742168
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 28200 entries, 0 to 28199
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype         
---  ------                      --------------  -----         
 0   Dataset Name                28200 non-null  object        
 1   Observation Date            28200 non-null  datetime64[ns]
 2   Series Key                  28200 non-null  object        
 3   Series Display Name         28200 non-null  object        
 4   Observation Value           28200 non-null  float64       
 5   Unit                        28200 non-null  object        
 6   Observation Status          28200 non-null  object        
 7   Observation Status Comment  3 non-null      float64       
 8   Sequence No.                28200 non-null  int64         
 9   Series name                 28200 non-null  object        
dtypes: datetime64[ns](1), float64(2), int64(1), object(6)
memory usage: 2.2+ MB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2014-07-04 00:00:00
* **Max Date:** 2025-04-18 00:00:00
* **Number of Unique Dates:** 564
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 27636 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 28,197 (10.00%)
Columns (1 of 10) with missing values (Sorted):
```
Observation Status Comment    28197
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 10):
```
Dataset Name                      1
Observation Date                564
Series Key                       50
Series Display Name              45
Observation Value             25403
Unit                              2
Observation Status                1
Observation Status Comment        3
Sequence No.                     50
Series name                      50
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Weekly Broad Money M2    28200
```
**Column: `Series Key`** (Top 20 of 50 unique values)
```
Series Key
TS_GP_BAM_M2_W.M000010    564
TS_GP_BAM_M2_W.M000380    564
TS_GP_BAM_M2_W.M000280    564
TS_GP_BAM_M2_W.M000290    564
TS_GP_BAM_M2_W.M000300    564
TS_GP_BAM_M2_W.M000310    564
TS_GP_BAM_M2_W.M000320    564
TS_GP_BAM_M2_W.M000330    564
TS_GP_BAM_M2_W.M000340    564
TS_GP_BAM_M2_W.M000350    564
TS_GP_BAM_M2_W.M000360    564
TS_GP_BAM_M2_W.M000370    564
TS_GP_BAM_M2_W.M000390    564
TS_GP_BAM_M2_W.M000020    564
TS_GP_BAM_M2_W.M000400    564
TS_GP_BAM_M2_W.M000410    564
TS_GP_BAM_M2_W.M000420    564
TS_GP_BAM_M2_W.M000430    564
TS_GP_BAM_M2_W.M000440    564
TS_GP_BAM_M2_W.M000450    564
```
**Column: `Series Display Name`** (Top 20 of 45 unique values)
```
Series Display Name
............................... Deposits with banks                       1128
........................a) Federal Government                             1128
............(i) State Bank of Pakistan                                    1128
............(ii) Scheduled Banks                                          1128
........................b) Provincial Government                          1128
............c. Net effect of Zakat Fund etc.                               564
......2 Credit to Non-Government Sector  (a+b+c+d)                         564
............a. Credit to Private Sector                                    564
................... Conventional Banking Branches                          564
................... Islamic Banks                                          564
................... Islamic Banking Branches of Conventional Banks         564
............b. Credit to Public Sectors Enterprises (PSEs)                 564
............c. PSEs Special Account-Debt Repayment with SBP                564
......A. Currency in Circulation                                           564
............d. Credit to NBFIs                                             564
............b. Commodity Operations                                        564
. Monetary Assets (M2)                                                     564
............. Accrued profit on SBP holdings of MRTBs/MTBs                 564
............. Outstanding  amount of MTBs (realized value in auctions)     564
....... Net Government Budgetary Borrowings (cash basis)                   564
```
**Column: `Unit`** (Top 2 of 2 unique values)
```
Unit
Million PKR    26508
Percent         1692
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    28200
```
**Column: `Series name`** (Top 20 of 50 unique values)
```
Series name
Currency in Circulation                                                                     564
Credit to Public Sectors Enterprises (PSEs)                                                 564
Federal Government Deposits with Scheduled Banks                                            564
Provincial Government Borrowings from Scheduled Banks                                       564
Provincial Government Deposits with Scheduled Banks                                         564
Commodity Operations                                                                        564
Net effect of Zakat Fund etc.                                                               564
Credit to Non-Government Sector                                                             564
Credit to Private Sector                                                                    564
Credit to Private Sector from Conventional Banking Branches                                 564
Credit to Private Sector from Islamic Banks                                                 564
Credit to Private Sector from Islamic Banking Branches of Conventional Banks                564
PSEs Special Account-Debt Repayment with SBP                                                564
Deposits with SBP excluding banks, IMF and other Intl. Organizations                        564
Credit to Non-Bank Financial Institutions                                                   564
Other Items (net)                                                                           564
Broad Money (Assets  side)                                                                  564
Accrued profit on holdings of MRTBs/MTBs  by SBP and its subsidiaries (memorandum Item)     564
Outstanding  amount of MTBs realized value in auctions  (memorandum Item)                   564
Net Government Budgetary Borrowings on cash basis from Banking Sector  (memorandum Item)    564
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                            | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev      | Min          | 25%        | 50%        | 75%         | Max          | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                     | LastNonNull                               |
|:---------------------------|:---------------|---------------:|------------:|:----------|--------------:|:------------|:------------|:-------------|:-----------|:-----------|:------------|:-------------|:-----------|:-----------|:--------------------|:--------------------|:---------------------------------|:------------------------------------------|
| Dataset Name               | object         |          28200 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Weekly Broad Money M2            | Weekly Broad Money M2                     |
| Observation Date           | datetime64[ns] |          28200 |           0 | 0.00%     |           564 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | 2014-07-04 00:00:00 | 2025-04-18 00:00:00 | 2025-04-18 00:00:00              | 2014-07-04 00:00:00                       |
| Series Key                 | object         |          28200 |           0 | 0.00%     |            50 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | TS_GP_BAM_M2_W.M000010           | TS_GP_BAM_M2_W.M000500                    |
| Series Display Name        | object         |          28200 |           0 | 0.00%     |            45 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | ......A. Currency in Circulation | . Broad Money (M2) - YoY Growth           |
| Observation Value          | float64        |          28200 |           0 | 0.00%     |         25403 | 4386612.705 | 7225760.530 | -8268371.865 | -20807.453 | 703955.273 | 6379745.053 | 37431512.110 | 1.938      | 3.656      | NaT                 | NaT                 | 10145601.02                      | 12.94642                                  |
| Unit                       | object         |          28200 |           0 | 0.00%     |             2 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Million PKR                      | Percent                                   |
| Observation Status         | object         |          28200 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Normal                           | Normal                                    |
| Observation Status Comment | float64        |              3 |       28197 | 99.99%    |             3 | 78.192      | 81.606      | 15.933       | 31.999     | 48.065     | 109.321     | 170.578      | 1.435      | N/A        | NaT                 | NaT                 | 170.5775549                      | 15.93270524                               |
| Sequence No.               | int64          |          28200 |           0 | 0.00%     |            50 | 255.000     | 144.311     | 10.000       | 130.000    | 255.000    | 380.000     | 500.000      | 0.000      | -1.201     | NaT                 | NaT                 | 10                               | 500                                       |
| Series name                | object         |          28200 |           0 | 0.00%     |            50 | N/A         | N/A         | N/A          | N/A        | N/A        | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Currency in Circulation          | Memorandum: Broad Money (M2) - YoY growth |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 2 pairs with absolute correlation > 0.8 (showing top 50):*
```
Observation Value           Observation Status Comment    1.000000
Observation Status Comment  Sequence No.                 -0.947514
```


---


## Analysis for: `manufacturing_and_mining.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (79, 56) (rows, columns)
* **Format:** Detected **Tall** (Rows=79 >= Cols=56). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (79, 56) (rows, columns)

* **Original Column Names (56):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 4,424
* **Data Types Summary:** {dtype('float64'): 54, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 43,054 Bytes
* **Per Analyzed Column + Index:**
```
Index                  132
Sectors               2715
Sub-Sectors-Level1    6079
1970-71                632
1971-72                632
1972-73                632
1973-74                632
1974-75                632
1975-76                632
1976-77                632
1977-78                632
1978-79                632
1979-80                632
1980-81                632
1981-82                632
1982-83                632
1983-84                632
1984-85                632
1985-86                632
1986-87                632
1987-88                632
1988-89                632
1989-90                632
1990-91                632
1991-92                632
1992-93                632
1993-94                632
1994-95                632
1995-96                632
1996-97                632
1997-98                632
1998-99                632
1999-00                632
2000-01                632
2001-02                632
2002-03                632
2003-04                632
2004-05                632
2005-06                632
2006-07                632
2007-08                632
2008-09                632
2009-10                632
2010-11                632
2011-12                632
2012-13                632
2013-14                632
2014-15                632
2015-16                632
2016-17                632
2017-18                632
2018-19                632
2019-20                632
2020-21                632
2021-22                632
2022-23                632
2023-24                632
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 79 entries, 0 to 78
Data columns (total 56 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             5 non-null      object 
 1   Sub-Sectors-Level1  74 non-null     object 
 2   1970-71             54 non-null     float64
 3   1971-72             55 non-null     float64
 4   1972-73             54 non-null     float64
 5   1973-74             55 non-null     float64
 6   1974-75             55 non-null     float64
 7   1975-76             54 non-null     float64
 8   1976-77             55 non-null     float64
 9   1977-78             55 non-null     float64
 10  1978-79             56 non-null     float64
 11  1979-80             55 non-null     float64
 12  1980-81             66 non-null     float64
 13  1981-82             66 non-null     float64
 14  1982-83             65 non-null     float64
 15  1983-84             65 non-null     float64
 16  1984-85             66 non-null     float64
 17  1985-86             67 non-null     float64
 18  1986-87             67 non-null     float64
 19  1987-88             66 non-null     float64
 20  1988-89             66 non-null     float64
 21  1989-90             66 non-null     float64
 22  1990-91             76 non-null     float64
 23  1991-92             75 non-null     float64
 24  1992-93             76 non-null     float64
 25  1993-94             76 non-null     float64
 26  1994-95             75 non-null     float64
 27  1995-96             75 non-null     float64
 28  1996-97             75 non-null     float64
 29  1997-98             75 non-null     float64
 30  1998-99             75 non-null     float64
 31  1999-00             75 non-null     float64
 32  2000-01             76 non-null     float64
 33  2001-02             76 non-null     float64
 34  2002-03             75 non-null     float64
 35  2003-04             75 non-null     float64
 36  2004-05             76 non-null     float64
 37  2005-06             75 non-null     float64
 38  2006-07             75 non-null     float64
 39  2007-08             75 non-null     float64
 40  2008-09             75 non-null     float64
 41  2009-10             75 non-null     float64
 42  2010-11             75 non-null     float64
 43  2011-12             75 non-null     float64
 44  2012-13             74 non-null     float64
 45  2013-14             74 non-null     float64
 46  2014-15             74 non-null     float64
 47  2015-16             74 non-null     float64
 48  2016-17             74 non-null     float64
 49  2017-18             73 non-null     float64
 50  2018-19             73 non-null     float64
 51  2019-20             73 non-null     float64
 52  2020-21             73 non-null     float64
 53  2021-22             73 non-null     float64
 54  2022-23             73 non-null     float64
 55  2023-24             74 non-null     float64
dtypes: float64(54), object(2)
memory usage: 34.7+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 599 (13.54%)
Columns (56 of 56) with missing values (Sorted):
```
Sectors               74
1970-71               25
1972-73               25
1975-76               25
1971-72               24
1973-74               24
1974-75               24
1976-77               24
1977-78               24
1979-80               24
1978-79               23
1982-83               14
1983-84               14
1987-88               13
1989-90               13
1988-89               13
1984-85               13
1981-82               13
1980-81               13
1985-86               12
1986-87               12
2022-23                6
2021-22                6
2020-21                6
2019-20                6
2018-19                6
2017-18                6
2012-13                5
2016-17                5
2015-16                5
2014-15                5
2013-14                5
2023-24                5
Sub-Sectors-Level1     5
1996-97                4
2011-12                4
1994-95                4
1995-96                4
1997-98                4
1998-99                4
1999-00                4
2002-03                4
2010-11                4
2009-10                4
2008-09                4
2007-08                4
2006-07                4
2005-06                4
2003-04                4
1991-92                4
1992-93                3
1990-91                3
2001-02                3
1993-94                3
2004-05                3
2000-01                3
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 56):
```
Sectors                5
Sub-Sectors-Level1    74
1970-71               53
1971-72               54
1972-73               53
1973-74               55
1974-75               53
1975-76               53
1976-77               55
1977-78               54

...

2014-15    73
2015-16    72
2016-17    73
2017-18    70
2018-19    72
2019-20    71
2020-21    72
2021-22    72
2022-23    71
2023-24    73
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 5 of 5 unique values)
```
Sectors
Mining and Quarrying               1
Mining Index                       1
Large Scale Manufacturing Index    1
Cotton Textile                     1
Large Scale Manufacturing          1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 74 unique values)
```
Sub-Sectors-Level1
Antimony (tonnes)                                                            1
Transport, Machinery & Electrical Appliances - Sewing Machines (000 Nos.)    1
Chemical - Polishes & Creams for Footwear (mln. grams)                       1
Chemical - Paints & Varnishes (tonnes)                                       1
Chemical - Chlorine Gas (000 tonnes)                                         1
Chemical - Caustic Soda (000 tonnes)                                         1
Chemical - Sulphuric Acid (000 tonnes)                                       1
Chemical - Soda Ash (000 tonnes)                                             1
Rubber - Cycle Tubes (000 Nos)                                               1
Rubber - Cycle Tyres (000 Nos)                                               1
Rubber - Motor Tubes (000 Nos)                                               1
Rubber - Motor Tyres (000 Nos)                                               1
Jute Textiles (000 tonnes)                                                   1
Food and Tobacco - Cigarettes (Million Nos)                                  1
Food and Tobacco - Beverages (000 litres)                                    1
Cement (000 tonnes)                                                          1
Sugar (000 tonnes)                                                           1
Transport, Machinery & Electrical Appliances - Bicycles (000 Nos.)           1
Transport, Machinery & Electrical Appliances - Total TV Sets (000 Nos.)      1
Argonite/Marble (000 tonnes)                                                 1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev     | Min     | 25%    | 50%     | 75%      | Max         | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull         | LastNonNull               |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:-----------|:--------|:-------|:--------|:---------|:------------|:-----------|:-----------|:----------|:----------|:---------------------|:--------------------------|
| Sectors            | object     |              5 |          74 | 93.67%    |             5 | N/A       | N/A        | N/A     | N/A    | N/A     | N/A      | N/A         | N/A        | N/A        | NaT       | NaT       | Mining and Quarrying | Large Scale Manufacturing |
| Sub-Sectors-Level1 | object     |             74 |           5 | 6.33%     |            74 | N/A       | N/A        | N/A     | N/A    | N/A     | N/A      | N/A         | N/A        | N/A        | NaT       | NaT       | Antimony (tonnes)    | Sugar (% Growth)          |
| 1970-71            | float64    |             54 |          25 | 31.65%    |            53 | 1636.234  | 4379.370   | 3.000   | 31.800 | 175.500 | 655.725  | 24166.000   | 4.059      | 17.082     | NaT       | NaT       | 184.0                | 215.7                     |
| 1971-72            | float64    |             55 |          24 | 30.38%    |            54 | 1668.515  | 4427.960   | 2.000   | 32.100 | 140.000 | 577.350  | 21772.000   | 3.727      | 13.579     | NaT       | NaT       | 323.0                | 201.1                     |
| 1972-73            | float64    |             54 |          25 | 31.65%    |            53 | 1897.600  | 5065.177   | 2.000   | 34.725 | 177.500 | 1041.150 | 27623.000   | 4.094      | 17.318     | NaT       | NaT       | 77.0                 | 223.0                     |
| 1973-74            | float64    |             55 |          24 | 30.38%    |            55 | 2042.534  | 5271.121   | 1.000   | 33.500 | 192.700 | 910.000  | 27477.000   | 3.790      | 14.725     | NaT       | NaT       | 33.0                 | 191.0                     |
| 1974-75            | float64    |             55 |          24 | 30.38%    |            53 | 2148.153  | 5436.092   | 1.000   | 34.000 | 214.000 | 981.000  | 26804.000   | 3.479      | 11.795     | NaT       | NaT       | 199.0                | 193.2                     |
| 1975-76            | float64    |             54 |          25 | 31.65%    |            53 | 2369.798  | 5898.350   | 2.510   | 49.300 | 241.750 | 1030.500 | 27454.000   | 3.417      | 11.417     | NaT       | NaT       | 360.0                | 143.2                     |
| 1976-77            | float64    |             55 |          24 | 30.38%    |            55 | 2293.021  | 6011.016   | 3.640   | 46.500 | 175.800 | 1183.500 | 28878.000   | 3.656      | 13.294     | NaT       | NaT       | 93.0                 | 175.8                     |
| 1977-78            | float64    |             55 |          24 | 30.38%    |            54 | 2704.485  | 7421.011   | 3.540   | 59.150 | 213.000 | 1163.000 | 41893.000   | 4.147      | 18.085     | NaT       | NaT       | 103.0                | 207.2                     |
| 1978-79            | float64    |             56 |          23 | 29.11%    |            56 | 2911.412  | 8745.845   | 3.710   | 59.725 | 220.700 | 1122.750 | 53356.000   | 4.534      | 22.361     | NaT       | NaT       | 69.0                 | 207.4                     |
| 1979-80            | float64    |             55 |          24 | 30.38%    |            55 | 2943.347  | 8476.768   | 3.570   | 66.950 | 279.400 | 1236.500 | 48033.000   | 4.139      | 18.034     | NaT       | NaT       | 92.0                 | 288.5                     |
| 1980-81            | float64    |             66 |          13 | 16.46%    |            65 | 2881.400  | 9378.707   | -10.060 | 30.100 | 164.600 | 544.000  | 60787.000   | 4.738      | 24.734     | NaT       | NaT       | 39.0                 | 45.22                     |
| 1981-82            | float64    |             66 |          13 | 16.46%    |            66 | 4212.904  | 15006.718  | 3.000   | 26.250 | 145.500 | 1134.350 | 93488.000   | 4.844      | 24.500     | NaT       | NaT       | 51.0                 | 52.88                     |
| 1982-83            | float64    |             65 |          14 | 17.72%    |            64 | 4225.595  | 15215.435  | -13.370 | 21.000 | 141.000 | 871.200  | 100300.000  | 5.084      | 27.894     | NaT       | NaT       | 121.0                | -13.37                    |
| 1983-84            | float64    |             65 |          14 | 17.72%    |            64 | 15579.772 | 101014.081 | -11.610 | 21.000 | 162.000 | 1089.800 | 812406.000  | 7.914      | 63.304     | NaT       | NaT       | 101.0                | 1.77                      |
| 1984-85            | float64    |             66 |          13 | 16.46%    |            66 | 4972.862  | 18263.176  | -8.350  | 14.872 | 140.050 | 951.725  | 120812.000  | 5.136      | 28.367     | NaT       | NaT       | 6.0                  | 13.86                     |
| 1985-86            | float64    |             67 |          12 | 15.19%    |            65 | 5447.841  | 19317.168  | -14.550 | 21.500 | 190.100 | 1226.500 | 127492.000  | 5.159      | 28.462     | NaT       | NaT       | 24.0                 | -14.55                    |
| 1986-87            | float64    |             67 |          12 | 15.19%    |            66 | 5686.287  | 21197.384  | -6.150  | 20.805 | 203.000 | 1261.500 | 151304.000  | 5.734      | 36.104     | NaT       | NaT       | 45.0                 | 15.23                     |
| 1987-88            | float64    |             66 |          13 | 16.46%    |            65 | 6057.695  | 20630.044  | -2.420  | 22.043 | 248.800 | 1760.750 | 134717.000  | 5.005      | 27.078     | NaT       | NaT       | 216.0                | 37.71                     |
| 1988-89            | float64    |             66 |          13 | 16.46%    |            64 | 5214.212  | 16987.574  | -22.430 | 19.053 | 246.450 | 1641.500 | 99942.000   | 4.729      | 23.136     | NaT       | NaT       | 25.0                 | 4.9                       |
| 1989-90            | float64    |             66 |          13 | 16.46%    |            66 | 5373.368  | 17402.978  | -7.840  | 25.250 | 280.900 | 2045.625 | 105451.000  | 4.734      | 23.405     | NaT       | NaT       | 26.0                 | -0.05                     |
| 1990-91            | float64    |             76 |           3 | 3.80%     |            76 | 5305.902  | 19982.065  | -7.410  | 41.000 | 278.100 | 1219.375 | 154591.000  | 6.220      | 43.413     | NaT       | NaT       | 128.0                | 4.15                      |
| 1991-92            | float64    |             75 |           4 | 5.06%     |            75 | 6053.361  | 23608.638  | -5.520  | 39.500 | 277.800 | 1152.700 | 180987.000  | 6.237      | 43.025     | NaT       | NaT       | 321.0                | 20.06                     |
| 1992-93            | float64    |             76 |           3 | 3.80%     |            75 | 7208.258  | 30141.623  | -3.370  | 34.250 | 290.650 | 1490.750 | 220241.000  | 6.028      | 38.379     | NaT       | NaT       | 5.0                  | 2.67                      |
| 1993-94            | float64    |             76 |           3 | 3.80%     |            75 | 7333.836  | 29699.425  | -21.640 | 37.265 | 263.300 | 1822.800 | 228090.000  | 6.298      | 43.417     | NaT       | NaT       | 3.0                  | 19.17                     |
| 1994-95            | float64    |             75 |           4 | 5.06%     |            74 | 7758.764  | 31326.584  | -10.340 | 32.500 | 313.900 | 2261.450 | 227079.000  | 5.918      | 37.238     | NaT       | NaT       | 467.0                | 4.33                      |
| 1995-96            | float64    |             75 |           4 | 5.06%     |            75 | 7282.382  | 26881.270  | -18.150 | 38.030 | 327.000 | 2043.950 | 185115.000  | 5.470      | 31.723     | NaT       | NaT       | 458.0                | -18.15                    |
| 1996-97            | float64    |             75 |           4 | 5.06%     |            75 | 7504.030  | 29027.293  | -3.530  | 32.900 | 333.500 | 1858.550 | 215556.000  | 5.920      | 38.544     | NaT       | NaT       | 459.0                | -1.77                     |
| 1997-98            | float64    |             75 |           4 | 5.06%     |            74 | 6858.093  | 23135.262  | -3.150  | 35.600 | 307.000 | 2448.000 | 149848.000  | 4.939      | 25.974     | NaT       | NaT       | 345.0                | 49.18                     |
| 1998-99            | float64    |             75 |           4 | 5.06%     |            74 | 9091.997  | 32339.897  | -10.380 | 21.260 | 283.100 | 3416.500 | 198831.000  | 5.120      | 27.208     | NaT       | NaT       | 403.0                | -0.48                     |
| 1999-00            | float64    |             75 |           4 | 5.06%     |            73 | 11433.485 | 46463.645  | -31.410 | 26.800 | 345.200 | 2796.700 | 347583.000  | 6.126      | 40.573     | NaT       | NaT       | 579.0                | -31.41                    |
| 2000-01            | float64    |             76 |           3 | 3.80%     |            75 | 11380.252 | 47493.398  | -11.300 | 27.725 | 318.900 | 3038.250 | 352689.000  | 6.131      | 40.014     | NaT       | NaT       | 95.0                 | 21.7                      |
| 2001-02            | float64    |             76 |           3 | 3.80%     |            75 | 10656.059 | 43486.519  | -8.610  | 25.620 | 341.700 | 3313.250 | 312886.000  | 5.899      | 36.704     | NaT       | NaT       | 37.0                 | 9.84                      |
| 2002-03            | float64    |             75 |           4 | 5.06%     |            74 | 11381.791 | 45804.666  | -10.420 | 34.850 | 363.000 | 3127.000 | 340864.000  | 6.045      | 39.624     | NaT       | NaT       | 1066.0               | 13.48                     |
| 2003-04            | float64    |             75 |           4 | 5.06%     |            75 | 12908.540 | 45138.886  | 0.000   | 33.330 | 363.500 | 3673.000 | 297419.000  | 5.045      | 27.307     | NaT       | NaT       | 994.0                | 9.09                      |
| 2004-05            | float64    |             76 |           3 | 3.80%     |            74 | 11845.369 | 36623.193  | -23.100 | 34.500 | 334.400 | 3044.750 | 207803.000  | 4.318      | 19.609     | NaT       | NaT       | 5.0                  | -23.1                     |
| 2005-06            | float64    |             75 |           4 | 5.06%     |            73 | 9863.862  | 28675.302  | -5.000  | 45.825 | 411.000 | 3630.800 | 183952.000  | 4.477      | 22.225     | NaT       | NaT       | 91.0                 | -5.0                      |
| 2006-07            | float64    |             75 |           4 | 5.06%     |            75 | 14255.510 | 47244.729  | -2.760  | 46.000 | 402.000 | 3689.900 | 342463.000  | 5.371      | 33.137     | NaT       | NaT       | 119.0                | 19.16                     |
| 2007-08            | float64    |             75 |           4 | 5.06%     |            75 | 16567.088 | 56717.708  | -3.630  | 47.585 | 403.000 | 4154.400 | 359994.000  | 4.884      | 24.974     | NaT       | NaT       | 245.0                | 34.2                      |
| 2008-09            | float64    |             75 |           4 | 5.06%     |            75 | 15162.178 | 50065.352  | -32.610 | 46.085 | 402.300 | 3204.300 | 320214.000  | 4.812      | 24.755     | NaT       | NaT       | 75.0                 | -32.61                    |
| 2009-10            | float64    |             75 |           4 | 5.06%     |            75 | 15939.710 | 58379.558  | -25.700 | 45.295 | 345.500 | 3388.700 | 447541.000  | 6.096      | 42.061     | NaT       | NaT       | 25.0                 | -1.44                     |
| 2010-11            | float64    |             75 |           4 | 5.06%     |            75 | 16977.115 | 58685.390  | -12.300 | 37.150 | 345.200 | 3348.850 | 329100.000  | 4.551      | 20.558     | NaT       | NaT       | 25.0                 | 32.62                     |
| 2011-12            | float64    |             75 |           4 | 5.06%     |            74 | 17423.173 | 62095.177  | -5.270  | 41.875 | 283.000 | 3429.050 | 384893.000  | 4.892      | 24.618     | NaT       | NaT       | 12.0                 | 11.16                     |
| 2012-13            | float64    |             74 |           5 | 6.33%     |            73 | 20422.718 | 73382.924  | -4.020  | 51.812 | 374.050 | 3511.725 | 412108.000  | 4.568      | 20.332     | NaT       | NaT       | 89.0                 | 9.48                      |
| 2013-14            | float64    |             74 |           5 | 6.33%     |            73 | 24747.569 | 102088.395 | -8.420  | 34.500 | 456.100 | 3947.375 | 720633.000  | 5.768      | 34.991     | NaT       | NaT       | 979.0                | 10.03                     |
| 2014-15            | float64    |             74 |           5 | 6.33%     |            73 | 19425.195 | 69399.945  | -7.750  | 47.032 | 413.350 | 4287.750 | 451818.000  | 5.001      | 26.253     | NaT       | NaT       | 114.0                | -7.75                     |
| 2015-16            | float64    |             74 |           5 | 6.33%     |            72 | 32182.925 | 127114.742 | -41.330 | 28.913 | 430.600 | 4611.500 | 773289.000  | 4.995      | 24.940     | NaT       | NaT       | 21.0                 | -0.68                     |
| 2016-17            | float64    |             74 |           5 | 6.33%     |            73 | 27381.584 | 106447.229 | -35.840 | 33.653 | 423.450 | 4704.250 | 719030.000  | 5.338      | 29.898     | NaT       | NaT       | 65.0                 | 37.8                      |
| 2017-18            | float64    |             73 |           6 | 7.59%     |            70 | 36800.024 | 149727.075 | -9.870  | 32.560 | 457.300 | 5405.200 | 995855.000  | 5.252      | 28.592     | NaT       | NaT       | 8813.0               | -6.85                     |
| 2018-19            | float64    |             73 |           6 | 7.59%     |            72 | 33875.051 | 127574.963 | -19.890 | 32.500 | 447.300 | 5407.000 | 779118.000  | 4.854      | 23.639     | NaT       | NaT       | 7736.0               | -19.89                    |
| 2019-20            | float64    |             73 |           6 | 7.59%     |            71 | 27896.119 | 105643.601 | -24.110 | 28.600 | 545.700 | 5797.000 | 639890.000  | 4.996      | 25.330     | NaT       | NaT       | 5797.0               | -7.2                      |
| 2020-21            | float64    |             73 |           6 | 7.59%     |            72 | 39727.604 | 162556.050 | 0.000   | 27.560 | 501.200 | 6294.900 | 1085913.000 | 5.432      | 30.534     | NaT       | NaT       | 7917.0               | 16.66                     |
| 2021-22            | float64    |             73 |           6 | 7.59%     |            72 | 31518.532 | 116509.671 | -17.380 | 34.600 | 637.000 | 6442.400 | 717281.000  | 4.771      | 22.972     | NaT       | NaT       | 6626.0               | 39.11                     |
| 2022-23            | float64    |             73 |           6 | 7.59%     |            71 | 23076.876 | 88171.001  | -23.780 | 14.000 | 451.000 | 4401.000 | 528476.000  | 4.885      | 23.925     | NaT       | NaT       | 4401.0               | -14.35                    |
| 2023-24            | float64    |             74 |           5 | 6.33%     |            73 | 27712.763 | 112166.681 | -36.670 | 14.300 | 430.500 | 4687.000 | 676906.000  | 4.941      | 24.185     | NaT       | NaT       | 10.0                 | 1.74                      |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 495 pairs with absolute correlation > 0.8 (showing top 50):*
```
1988-89  1989-90    0.998802
1985-86  1987-88    0.998334
1990-91  1991-92    0.998135
1993-94  1996-97    0.997817
1982-83  1984-85    0.997784
1992-93  1994-95    0.997698
2015-16  2022-23    0.997644
2016-17  2020-21    0.997512
2000-01  2001-02    0.997424
2018-19  2023-24    0.997217
1991-92  1993-94    0.997007
1994-95  2001-02    0.996978
1999-00  2000-01    0.996931
1994-95  2000-01    0.996670
2016-17  2017-18    0.996584
1992-93  2001-02    0.996261
2010-11  2012-13    0.996087
1978-79  1979-80    0.995861
1993-94  2002-03    0.995858
1981-82  1982-83    0.995743
1970-71  1972-73    0.995677
1994-95  2002-03    0.995653
1992-93  2000-01    0.995499
1990-91  1993-94    0.995467
1991-92  1996-97    0.995449
1990-91  1996-97    0.994949
1981-82  1984-85    0.994895
1994-95  1996-97    0.994768
2000-01  2002-03    0.994759
1989-90  1995-96    0.994754
1986-87  1996-97    0.994622
1999-00  2002-03    0.994564
1993-94  1994-95    0.994393
2017-18  2018-19    0.994373
1996-97  2002-03    0.994250
2001-02  2002-03    0.993911
2014-15  2016-17    0.993885
1978-79  1980-81    0.993755
1986-87  1991-92    0.993146
         1993-94    0.993057
1994-95  1995-96    0.993019
2014-15  2018-19    0.992651
2017-18  2020-21    0.992629
         2023-24    0.992489
1993-94  2000-01    0.992472
1995-96  2001-02    0.992431
1994-95  1999-00    0.992375
2014-15  2017-18    0.992308
2012-13  2021-22    0.992213
1992-93  1995-96    0.992090
```


---


## Analysis for: `money_and_credit.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (236, 57) (rows, columns)
* **Format:** Detected **Tall** (Rows=236 >= Cols=57). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (236, 57) (rows, columns)

* **Original Column Names (57):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', 'Sub-Sectors-Level2', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 13,452
* **Data Types Summary:** {dtype('float64'): 54, dtype('O'): 3}

### Memory Usage (Bytes)

* **Total:** 141,259 Bytes
* **Per Analyzed Column + Index:**
```
Index                   132
Sectors               10509
Sub-Sectors-Level1    16374
Sub-Sectors-Level2    12292
1970-71                1888
1971-72                1888
1972-73                1888
1973-74                1888
1974-75                1888
1975-76                1888
1976-77                1888
1977-78                1888
1978-79                1888
1979-80                1888
1980-81                1888
1981-82                1888
1982-83                1888
1983-84                1888
1984-85                1888
1985-86                1888
1986-87                1888
1987-88                1888
1988-89                1888
1989-90                1888
1990-91                1888
1991-92                1888
1992-93                1888
1993-94                1888
1994-95                1888
1995-96                1888
1996-97                1888
1997-98                1888
1998-99                1888
1999-00                1888
2000-01                1888
2001-02                1888
2002-03                1888
2003-04                1888
2004-05                1888
2005-06                1888
2006-07                1888
2007-08                1888
2008-09                1888
2009-10                1888
2010-11                1888
2011-12                1888
2012-13                1888
2013-14                1888
2014-15                1888
2015-16                1888
2016-17                1888
2017-18                1888
2018-19                1888
2019-20                1888
2020-21                1888
2021-22                1888
2022-23                1888
2023-24                1888
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 236 entries, 0 to 235
Data columns (total 57 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             55 non-null     object 
 1   Sub-Sectors-Level1  126 non-null    object 
 2   Sub-Sectors-Level2  55 non-null     object 
 3   1970-71             43 non-null     float64
 4   1971-72             43 non-null     float64
 5   1972-73             51 non-null     float64
 6   1973-74             64 non-null     float64
 7   1974-75             64 non-null     float64
 8   1975-76             64 non-null     float64
 9   1976-77             64 non-null     float64
 10  1977-78             64 non-null     float64
 11  1978-79             64 non-null     float64
 12  1979-80             76 non-null     float64
 13  1980-81             76 non-null     float64
 14  1981-82             76 non-null     float64
 15  1982-83             76 non-null     float64
 16  1983-84             76 non-null     float64
 17  1984-85             76 non-null     float64
 18  1985-86             76 non-null     float64
 19  1986-87             76 non-null     float64
 20  1987-88             76 non-null     float64
 21  1988-89             76 non-null     float64
 22  1989-90             77 non-null     float64
 23  1990-91             78 non-null     float64
 24  1991-92             82 non-null     float64
 25  1992-93             82 non-null     float64
 26  1993-94             82 non-null     float64
 27  1994-95             82 non-null     float64
 28  1995-96             82 non-null     float64
 29  1996-97             81 non-null     float64
 30  1997-98             84 non-null     float64
 31  1998-99             102 non-null    float64
 32  1999-00             102 non-null    float64
 33  2000-01             114 non-null    float64
 34  2001-02             114 non-null    float64
 35  2002-03             114 non-null    float64
 36  2003-04             122 non-null    float64
 37  2004-05             122 non-null    float64
 38  2005-06             142 non-null    float64
 39  2006-07             108 non-null    float64
 40  2007-08             108 non-null    float64
 41  2008-09             111 non-null    float64
 42  2009-10             111 non-null    float64
 43  2010-11             111 non-null    float64
 44  2011-12             111 non-null    float64
 45  2012-13             100 non-null    float64
 46  2013-14             100 non-null    float64
 47  2014-15             100 non-null    float64
 48  2015-16             96 non-null     float64
 49  2016-17             97 non-null     float64
 50  2017-18             96 non-null     float64
 51  2018-19             101 non-null    float64
 52  2019-20             118 non-null    float64
 53  2020-21             132 non-null    float64
 54  2021-22             113 non-null    float64
 55  2022-23             109 non-null    float64
 56  2023-24             106 non-null    float64
dtypes: float64(54), object(3)
memory usage: 105.2+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 8,345 (62.04%)
Columns (57 of 57) with missing values (Sorted):
```
1970-71               193
1971-72               193
1972-73               185
Sectors               181
Sub-Sectors-Level2    181
1973-74               172
1974-75               172
1975-76               172
1976-77               172
1977-78               172
1978-79               172
1984-85               160
1988-89               160
1987-88               160
1986-87               160
1985-86               160
1980-81               160
1983-84               160
1982-83               160
1981-82               160
1979-80               160
1989-90               159
1990-91               158
1996-97               155
1993-94               154
1994-95               154
1995-96               154
1992-93               154
1991-92               154
1997-98               152
2017-18               140
2015-16               140
2016-17               139
2012-13               136
2014-15               136
2013-14               136
2018-19               135
1998-99               134
1999-00               134
2023-24               130
2007-08               128
2006-07               128
2022-23               127
2008-09               125
2009-10               125
2011-12               125
2010-11               125
2021-22               123
2002-03               122
2001-02               122
2000-01               122
2019-20               118
2004-05               114
2003-04               114
Sub-Sectors-Level1    110
2020-21               104
2005-06                94
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 57):
```
Sectors                55
Sub-Sectors-Level1    126
Sub-Sectors-Level2     55
1970-71                42
1971-72                42
1972-73                50
1973-74                60
1974-75                58
1975-76                58
1976-77                59

...

2014-15     99
2015-16     95
2016-17     97
2017-18     96
2018-19     99
2019-20    113
2020-21    129
2021-22    108
2022-23    106
2023-24    104
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 55 unique values)
```
Sectors
Broad Money (Rs Million)                                                  1
Net Assets,Reserves (Rs Million)                                          1
Liabilities, Bills Payable (Rs Million)                                   1
Liabilities,Borrowings (Rs Million)                                       1
Liabilities,Deposits and other Accounts (Rs Million)                      1
Liabilities,Sub-ordinated Loans (Rs Million)                              1
Liabilities Against Assets Subject to Finance Lease (Rs Million)          1
Deferred Tax Liabilities (Rs Million)                                     1
Other Liabilities (Rs Million)                                            1
Total Liabilities (Rs Million)                                            1
Net Assets (Rs Million)                                                   1
Represented by:                                                           1
Net Assets, Paid up Capital / Head Office Capital Account (Rs Million)    1
Net Assets,Un-appropriated / Un-remitted Profit (Rs Million)              1
Total Assets (Rs Million)                                                 1
Net Assets,Sub total (Rs Million)                                         1
Net Assets,Surplus/ (Deficit) on Revaluation of Assets (Rs Million)       1
Net Assets,Total (Rs Million)                                             1
T Bills, Three Months Maturity                                            1
T Bills, Six Months Maturity                                              1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 126 unique values)
```
Sub-Sectors-Level1
Currency in circulation (Rs Million)                                   1
PIBs Amount Offered (Rs Million), 20 Years Maturity                    1
PIBs, 10 Years Maturity Amount Accepted, Weighted Average Yield        1
PIBs, 10 Years Maturity Amount Accepted (Rs Million)                   1
PIBs, 10 Years Maturity                                                1
PIBs 7 Years Maturity, Amount Accepted, Weighted Average Yield         1
PIBs 7 Years Maturity, Amount Accepted (Rs Million)                    1
PIBs 7 Years Maturity                                                  1
PIBs 5 Years Maturity Amount Accepted, Weighted Average Yield          1
PIBs 5 Years Maturity Amount Accepted (Rs Million)                     1
PIBs 5 Years Maturity                                                  1
PIBs Amount Accepted, 3 Years Maturity Weighted Average Yield          1
PIBs Amount Accepted, 3 Years Maturity Amount Accepted (Rs Million)    1
3 Years Maturity                                                       1
PIBs Amount Offered (Rs Million), 30 Years Maturity                    1
PIBs Amount Offered (Rs Million), 15 Years Maturity                    1
PIBs 15 Years Maturity Amount Accepted (Rs Million)                    1
PIBs Amount Offered (Rs Million), 10 Years Maturity                    1
PIBs Amount Offered (Rs Million), 07 Years Maturity                    1
PIBs Amount Offered (Rs Million), 05 Years Maturity                    1
```
**Column: `Sub-Sectors-Level2`** (Top 20 of 55 unique values)
```
Sub-Sectors-Level2
Currency Issued (Rs Million)                                                       1
PIBs, 02 Years (Floater) Quarterly Maturity (PFL) Cut-Off Price, Minimum           1
PIBs 5 Years Maturity Amount Accepted, Weighted Average Yield, Maximum % p.a.      1
PIBs 7 Years Maturity, Amount Accepted, Weighted Average Yield, Minimum % p.a.     1
PIBs 7 Years Maturity, Amount Accepted, Weighted Average Yield, Maximum % p.a.     1
PIBs, 10 Years Maturity Amount Accepted, Weighted Average Yield, Minimum % p.a.    1
PIBs, 10 Years Maturity Amount Accepted, Weighted Average Yield, Maximum % p.a.    1
PIBs 15 Years Maturity Amount Accepted, Weighted Average Yield, Minimum % p.a.     1
PIBs 15 Years Maturity Amount Accepted, Weighted Average Yield, Maximum % p.a.     1
PIBs 20 Years Maturity Amount Accepted, Weighted Average Yield, Minimum % p.a.     1
PIBs 20 Years Maturity Amount Accepted, Weighted Average Yield, Maximum % p.a.     1
PIBs 30 Years Maturity Amount Accepted, Weighted Average Yield, Minimum % p.a.     1
PIBs 30 Years Maturity Amount Accepted, Weighted Average Yield, Maximum % p.a.     1
PIBs, 02 Years (Floater) Quarterly Maturity (PFL) Cut-Off Price, Maximum           1
PIBs Amount Accepted, 3 Years Maturity Weighted Average Yield, Maximum % p.a.      1
PIBs 03 Years (Floater) Maturity (PFL) Semi-Annual, Minimum bps / Cut-Off Price    1
PIBs 03 Years (Floater) Maturity (PFL) Semi-Annual, Maximum bps / Cut-Off Price    1
PIBs 03 Years (Floater) Quarterly Maturity (PFL), Cut-Off Price, Minimum           1
PIBs 03 Years (Floater) Quarterly Maturity (PFL), Cut-Off Price, Maximum           1
PIBs 05 Years (Floater) Maturity (PFL) Semi-Annual, Minimum bps / Cut-Off Price    1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev      | Min          | 25%      | 50%        | 75%         | Max          | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                         | LastNonNull                                                             |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:------------|:------------|:-------------|:---------|:-----------|:------------|:-------------|:-----------|:-----------|:----------|:----------|:-------------------------------------|:------------------------------------------------------------------------|
| Sectors            | object     |             55 |         181 | 76.69%    |            55 | N/A         | N/A         | N/A          | N/A      | N/A        | N/A         | N/A          | N/A        | N/A        | NaT       | NaT       | Broad Money (Rs Million)             | PIBs 10 Years (Floater) Quarterly Maturity (PFL)                        |
| Sub-Sectors-Level1 | object     |            126 |         110 | 46.61%    |           126 | N/A         | N/A         | N/A          | N/A      | N/A        | N/A         | N/A          | N/A        | N/A        | NaT       | NaT       | Currency in circulation (Rs Million) | PIBs 10 Years (Floater) Quarterly Maturity (PFL), Cut-Off Price         |
| Sub-Sectors-Level2 | object     |             55 |         181 | 76.69%    |            55 | N/A         | N/A         | N/A          | N/A      | N/A        | N/A         | N/A          | N/A        | N/A        | NaT       | NaT       | Currency Issued (Rs Million)         | PIBs 10 Years (Floater) Quarterly Maturity (PFL), Maximum Cut-Off Price |
| 1970-71            | float64    |             43 |         193 | 81.78%    |            42 | 3458.213    | 5272.845    | -67.000      | 141.000  | 658.000    | 6506.500    | 22092.000    | 1.761      | 2.743      | NaT       | NaT       | 22092.0                              | -67.0                                                                   |
| 1971-72            | float64    |             43 |         193 | 81.78%    |            42 | 3860.308    | 5820.986    | -0.150       | 196.500  | 836.000    | 5576.000    | 22059.000    | 1.684      | 1.945      | NaT       | NaT       | 22059.0                              | 179.0                                                                   |
| 1972-73            | float64    |             51 |         185 | 78.39%    |            50 | 6135.001    | 10056.797   | -9582.000    | 211.500  | 1118.000   | 10163.000   | 47503.000    | 1.839      | 4.669      | NaT       | NaT       | 27033.0                              | 160.0                                                                   |
| 1973-74            | float64    |             64 |         172 | 72.88%    |            60 | 5632.452    | 10034.582   | -8726.000    | 92.250   | 873.000    | 9360.500    | 50315.000    | 2.127      | 5.639      | NaT       | NaT       | 30644.0                              | 94.0                                                                    |
| 1974-75            | float64    |             64 |         172 | 72.88%    |            58 | 6132.250    | 10726.890   | -7323.000    | 148.250  | 893.000    | 10517.000   | 51528.000    | 2.013      | 4.538      | NaT       | NaT       | 33039.0                              | 377.0                                                                   |
| 1975-76            | float64    |             64 |         172 | 72.88%    |            58 | 7622.298    | 12489.796   | -6213.000    | 156.750  | 1103.500   | 12951.000   | 52848.000    | 1.754      | 2.609      | NaT       | NaT       | 41719.0                              | 419.0                                                                   |
| 1976-77            | float64    |             64 |         172 | 72.88%    |            59 | 9526.774    | 15216.238   | -6868.000    | 123.000  | 1353.500   | 16031.000   | 57435.000    | 1.619      | 1.829      | NaT       | NaT       | 51842.0                              | 693.0                                                                   |
| 1977-78            | float64    |             64 |         172 | 72.88%    |            59 | 11047.283   | 17700.721   | -8557.000    | 143.250  | 1654.000   | 18850.500   | 63722.000    | 1.610      | 1.682      | NaT       | NaT       | 63722.0                              | 475.0                                                                   |
| 1978-79            | float64    |             64 |         172 | 72.88%    |            59 | 13603.468   | 21242.457   | -7613.000    | 187.750  | 1891.000   | 24354.750   | 78611.000    | 1.607      | 1.716      | NaT       | NaT       | 78611.0                              | 1381.0                                                                  |
| 1979-80            | float64    |             76 |         160 | 67.80%    |            70 | 17873.735   | 30197.001   | -10636.000   | 313.750  | 2261.000   | 30581.500   | 132173.000   | 2.078      | 4.377      | NaT       | NaT       | 92423.0                              | 1544.0                                                                  |
| 1980-81            | float64    |             76 |         160 | 67.80%    |            71 | 20244.657   | 34154.772   | -12259.000   | 377.750  | 1945.500   | 34555.000   | 150020.000   | 2.081      | 4.445      | NaT       | NaT       | 104620.0                             | 1271.0                                                                  |
| 1981-82            | float64    |             76 |         160 | 67.80%    |            71 | 22889.594   | 38679.758   | -13782.000   | 531.500  | 2232.000   | 39322.250   | 169706.000   | 2.084      | 4.459      | NaT       | NaT       | 116509.0                             | 1415.0                                                                  |
| 1982-83            | float64    |             76 |         160 | 67.80%    |            71 | 28367.886   | 47415.987   | -18374.000   | 703.000  | 3333.500   | 49356.250   | 212375.000   | 2.151      | 4.910      | NaT       | NaT       | 146024.0                             | 1048.0                                                                  |
| 1983-84            | float64    |             76 |         160 | 67.80%    |            71 | 31863.319   | 54196.817   | -24595.000   | 531.250  | 3658.500   | 52799.250   | 241585.000   | 2.131      | 4.803      | NaT       | NaT       | 163266.0                             | 2060.0                                                                  |
| 1984-85            | float64    |             76 |         160 | 67.80%    |            71 | 37256.208   | 63376.814   | -22554.000   | 646.250  | 4087.000   | 61528.500   | 283167.000   | 2.146      | 4.910      | NaT       | NaT       | 183904.0                             | 2179.0                                                                  |
| 1985-86            | float64    |             76 |         160 | 67.80%    |            72 | 44149.918   | 75761.499   | -24798.000   | 870.000  | 5125.500   | 68937.500   | 346019.000   | 2.236      | 5.462      | NaT       | NaT       | 211110.0                             | 2811.0                                                                  |
| 1986-87            | float64    |             76 |         160 | 67.80%    |            71 | 51469.891   | 88829.897   | -27131.000   | 1013.000 | 5112.500   | 81076.250   | 414006.000   | 2.320      | 6.053      | NaT       | NaT       | 240022.0                             | 11984.0                                                                 |
| 1987-88            | float64    |             76 |         160 | 67.80%    |            71 | 58533.412   | 101567.216  | -36330.000   | 1157.000 | 6099.000   | 96308.500   | 481457.000   | 2.396      | 6.629      | NaT       | NaT       | 269513.0                             | 5116.0                                                                  |
| 1988-89            | float64    |             76 |         160 | 67.80%    |            71 | 63731.498   | 112297.888  | -43855.000   | 1156.500 | 7124.500   | 103893.750  | 534201.000   | 2.422      | 6.806      | NaT       | NaT       | 290455.0                             | 6750.0                                                                  |
| 1989-90            | float64    |             77 |         159 | 67.37%    |            73 | 74382.253   | 131630.265  | -41339.000   | 2209.000 | 10085.000  | 120817.000  | 633948.000   | 2.495      | 7.216      | NaT       | NaT       | 341251.0                             | 6474.0                                                                  |
| 1990-91            | float64    |             78 |         158 | 66.95%    |            76 | 91773.633   | 157878.266  | -36799.000   | 3098.250 | 11006.500  | 156418.250  | 778287.000   | 2.550      | 7.811      | NaT       | NaT       | 400643.0                             | 7280.0                                                                  |
| 1991-92            | float64    |             82 |         154 | 65.25%    |            80 | 108058.067  | 190016.790  | -41263.000   | 1003.500 | 17817.000  | 180123.000  | 963227.000   | 2.697      | 8.768      | NaT       | NaT       | 505568.0                             | 26665.0                                                                 |
| 1992-93            | float64    |             82 |         154 | 65.25%    |            80 | 129109.252  | 229216.848  | -53004.000   | 1068.250 | 18544.000  | 202864.750  | 1146201.000  | 2.615      | 8.207      | NaT       | NaT       | 595390.0                             | 22474.0                                                                 |
| 1993-94            | float64    |             82 |         154 | 65.25%    |            81 | 151936.698  | 276721.355  | -46537.000   | 1304.250 | 24929.000  | 241908.500  | 1413114.000  | 2.784      | 9.290      | NaT       | NaT       | 703398.0                             | 31523.0                                                                 |
| 1994-95            | float64    |             82 |         154 | 65.25%    |            80 | 177695.368  | 322601.308  | -74705.000   | 3065.500 | 28132.500  | 279619.250  | 1647616.000  | 2.777      | 9.264      | NaT       | NaT       | 824735.0                             | 40668.0                                                                 |
| 1995-96            | float64    |             82 |         154 | 65.25%    |            80 | 204801.350  | 376237.325  | -58844.000   | 2992.000 | 20166.500  | 309388.500  | 1910391.000  | 2.768      | 9.102      | NaT       | NaT       | 938679.0                             | 19207.0                                                                 |
| 1996-97            | float64    |             81 |         155 | 65.68%    |            79 | 232219.102  | 423066.947  | -61621.000   | 627.000  | 29196.000  | 343784.000  | 2129084.000  | 2.721      | 8.767      | NaT       | NaT       | 1053234.0                            | 40678.0                                                                 |
| 1997-98            | float64    |             84 |         152 | 64.41%    |            82 | 215190.554  | 366523.481  | -75157.000   | 2004.000 | 28993.000  | 274330.500  | 1587593.000  | 2.128      | 4.390      | NaT       | NaT       | 1206320.0                            | 29684.0                                                                 |
| 1998-99            | float64    |            102 |         134 | 56.78%    |           100 | 207358.774  | 368841.154  | -73544.000   | 45.475   | 42562.000  | 253517.000  | 1734309.000  | 2.380      | 5.803      | NaT       | NaT       | 1280546.0                            | 16.0                                                                    |
| 1999-00            | float64    |            102 |         134 | 56.78%    |           100 | 211494.571  | 387949.943  | -59087.000   | 373.150  | 45011.500  | 176864.500  | 1801633.000  | 2.435      | 5.890      | NaT       | NaT       | 1400632.0                            | 10.871                                                                  |
| 2000-01            | float64    |            114 |         122 | 51.69%    |           111 | 280404.444  | 720915.807  | -59962.000   | 24.600   | 43238.000  | 114293.750  | 4998888.000  | 4.640      | 25.359     | NaT       | NaT       | 1526046.0                            | 14.004                                                                  |
| 2001-02            | float64    |            114 |         122 | 51.69%    |           112 | 198983.422  | 628787.177  | -4431680.000 | 24.450   | 47339.500  | 198619.750  | 2301032.000  | -2.483     | 27.618     | NaT       | NaT       | 1761370.0                            | 13.981                                                                  |
| 2002-03            | float64    |            114 |         122 | 51.69%    |           112 | 287236.862  | 516648.954  | -107258.000  | 10.291   | 42179.000  | 352633.750  | 2540004.000  | 2.480      | 6.698      | NaT       | NaT       | 2078704.0                            | 9.587                                                                   |
| 2003-04            | float64    |            122 |         114 | 48.31%    |           119 | 312626.475  | 599738.838  | -116405.000  | 11.646   | 46108.500  | 325889.250  | 3003025.000  | 2.692      | 7.602      | NaT       | NaT       | 2486556.0                            | 8.993                                                                   |
| 2004-05            | float64    |            122 |         114 | 48.31%    |           108 | 380082.839  | 736693.872  | -204929.000  | 7.596    | 43472.000  | 424728.000  | 3640129.000  | 2.569      | 6.731      | NaT       | NaT       | 2966352.0                            | 0.0                                                                     |
| 2005-06            | float64    |            142 |          94 | 39.83%    |           132 | 486658.886  | 908706.686  | -327346.000  | 3404.000 | 85475.500  | 398641.000  | 3884057.000  | 2.293      | 4.444      | NaT       | NaT       | 3406905.0                            | 9.8454                                                                  |
| 2006-07            | float64    |            108 |         128 | 54.24%    |           108 | 470032.950  | 989676.491  | -422223.000  | 17.395   | 62067.000  | 384200.500  | 4701641.000  | 2.700      | 6.751      | NaT       | NaT       | 4065155.0                            | 11.68                                                                   |
| 2007-08            | float64    |            108 |         128 | 54.24%    |           108 | 533362.426  | 1133268.667 | -506291.000  | 15.005   | 66859.000  | 424482.250  | 5074398.000  | 2.602      | 5.984      | NaT       | NaT       | 4689143.0                            | 14.118                                                                  |
| 2008-09            | float64    |            111 |         125 | 52.97%    |           108 | 602559.780  | 1228540.619 | -582434.000  | 15.700   | 67235.000  | 490577.000  | 5595364.000  | 2.562      | 5.990      | NaT       | NaT       | 5137218.0                            | 16.225                                                                  |
| 2009-10            | float64    |            111 |         125 | 52.97%    |           109 | 632622.957  | 1373230.197 | -1267831.000 | 13.034   | 58393.000  | 550866.500  | 6309551.000  | 2.619      | 6.514      | NaT       | NaT       | 5777234.0                            | 13.749                                                                  |
| 2010-11            | float64    |            111 |         125 | 52.97%    |           108 | 875197.376  | 1599890.789 | -652416.000  | 14.224   | 104852.000 | 789712.500  | 7294816.000  | 2.344      | 5.265      | NaT       | NaT       | 6695194.0                            | 14.187                                                                  |
| 2011-12            | float64    |            111 |         125 | 52.97%    |           103 | 935299.331  | 1802912.866 | -800038.000  | 13.509   | 92049.000  | 1099265.500 | 8203563.000  | 2.510      | 6.042      | NaT       | NaT       | 7641795.0                            | 0.0                                                                     |
| 2012-13            | float64    |            100 |         136 | 57.63%    |            98 | 1274103.927 | 2222161.525 | -767938.000  | 59.575   | 163984.500 | 1563788.250 | 9643420.000  | 2.232      | 4.629      | NaT       | NaT       | 8856364.0                            | 13.35                                                                   |
| 2013-14            | float64    |            100 |         136 | 57.63%    |           100 | 1404920.886 | 2500476.566 | -803699.000  | 30.225   | 377417.500 | 977460.750  | 10421184.000 | 2.183      | 4.032      | NaT       | NaT       | 9966583.0                            | 13.289                                                                  |
| 2014-15            | float64    |            100 |         136 | 57.63%    |            99 | 1481228.641 | 2733597.075 | -944289.000  | 25.900   | 300863.000 | 1254337.750 | 12402582.000 | 2.530      | 5.991      | NaT       | NaT       | 11282144.0                           | 13.591                                                                  |
| 2015-16            | float64    |             96 |         140 | 59.32%    |            95 | 1811589.384 | 3177568.040 | -1014348.000 | 59.925   | 429141.500 | 1739618.500 | 14365309.000 | 2.402      | 5.448      | NaT       | NaT       | 12824853.0                           | 9.401                                                                   |
| 2016-17            | float64    |             97 |         139 | 58.90%    |            97 | 2144144.319 | 3726574.996 | -987502.000  | 64.300   | 456701.000 | 2654899.000 | 16803028.000 | 2.308      | 5.069      | NaT       | NaT       | 14580882.0                           | 7.941                                                                   |
| 2017-18            | float64    |             96 |         140 | 59.32%    |            96 | 2738362.919 | 5230536.893 | -1027153.000 | 18.500   | 245629.000 | 1457253.750 | 19826420.000 | 2.094      | 3.235      | NaT       | NaT       | 15997162.0                           | 8.7                                                                     |
| 2018-19            | float64    |            101 |         135 | 57.20%    |            99 | 2925417.901 | 5876483.750 | -1507081.000 | 13.600   | 299737.000 | 1481039.000 | 23757544.000 | 2.212      | 3.859      | NaT       | NaT       | 17798494.0                           | 13.6                                                                    |
| 2019-20            | float64    |            118 |         118 | 50.00%    |           113 | 2853604.436 | 5329784.833 | -1494971.000 | 46.000   | 312566.500 | 2143526.250 | 22375037.000 | 2.175      | 3.959      | NaT       | NaT       | 20908003.0                           | 75.0                                                                    |
| 2020-21            | float64    |            132 |         104 | 44.07%    |           129 | 2717016.578 | 5656139.462 | -1806007.000 | 98.179   | 263102.500 | 1552473.250 | 26141812.000 | 2.558      | 6.114      | NaT       | NaT       | 24297696.0                           | 95.2853                                                                 |
| 2021-22            | float64    |            113 |         123 | 52.12%    |           108 | 4120652.305 | 8392127.589 | -1962285.000 | 98.209   | 563210.000 | 3133004.000 | 53782274.000 | 3.141      | 12.259     | NaT       | NaT       | 27602634.0                           | 100.0                                                                   |
| 2022-23            | float64    |            109 |         127 | 53.81%    |           106 | 4582224.728 | 9148084.687 | -2687737.000 | 96.351   | 583249.000 | 2406658.000 | 39444861.000 | 2.377      | 4.805      | NaT       | NaT       | 31523253.0                           | 93.8497                                                                 |
| 2023-24            | float64    |            106 |         130 | 55.08%    |           104 | 5000106.457 | 9615706.041 | -3099830.000 | 94.610   | 611901.500 | 4148847.000 | 45119194.000 | 2.417      | 5.558      | NaT       | NaT       | 33739371.0                           | 94.8112                                                                 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 1237 pairs with absolute correlation > 0.8 (showing top 50):*
```
1993-94  1994-95    0.999601
1987-88  1988-89    0.999572
1995-96  1996-97    0.999376
1980-81  1981-82    0.999208
1971-72  2014-15    0.999071
1985-86  1986-87    0.999069
1971-72  2010-11    0.999066
         2009-10    0.999048
         2008-09    0.999040
         2011-12    0.998909
         1972-73    0.998892
         2013-14    0.998884
         2012-13    0.998864
1988-89  1989-90    0.998788
1994-95  1995-96    0.998774
1986-87  1987-88    0.998735
1982-83  1983-84    0.998729
1993-94  1995-96    0.998714
1991-92  1992-93    0.998596
1971-72  2023-24    0.998562
         2007-08    0.998533
         2006-07    0.998415
         2015-16    0.998307
1993-94  1996-97    0.998006
1990-91  1991-92    0.997991
1986-87  1988-89    0.997989
1994-95  1996-97    0.997962
1987-88  1989-90    0.997924
1971-72  2016-17    0.997715
1980-81  1982-83    0.997698
1979-80  1980-81    0.997677
1983-84  1985-86    0.997605
1981-82  1982-83    0.997529
         1984-85    0.997459
         1983-84    0.997443
1984-85  1985-86    0.997443
1983-84  1984-85    0.997373
1991-92  1993-94    0.997360
2014-15  2015-16    0.997337
1971-72  2021-22    0.997302
1989-90  1990-91    0.997283
1971-72  2017-18    0.997236
1973-74  1974-75    0.997177
1991-92  1994-95    0.997167
2005-06  2006-07    0.996988
1985-86  1987-88    0.996948
1990-91  1992-93    0.996867
1978-79  1979-80    0.996853
1971-72  2018-19    0.996778
1979-80  1981-82    0.996665
```


---


## Analysis for: `policy_rate.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (182, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=182 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (182, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 1,638
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 91,774 Bytes
* **Per Analyzed Column + Index:**
```
Index                    132
Dataset Name           20384
Observation Date        1456
Series Key             13832
Series Display Name    16610
Observation Value       1456
Unit                   10192
Observation Status     10010
Sequence No.            1456
Series name            16246
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 182 entries, 0 to 181
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         182 non-null    object        
 1   Observation Date     182 non-null    datetime64[ns]
 2   Series Key           182 non-null    object        
 3   Series Display Name  182 non-null    object        
 4   Observation Value    182 non-null    float64       
 5   Unit                 182 non-null    object        
 6   Observation Status   182 non-null    object        
 7   Sequence No.         182 non-null    int64         
 8   Series name          182 non-null    object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 12.9+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 1956-01-01 00:00:00
* **Max Date:** 2025-01-28 00:00:00
* **Number of Unique Dates:** 93
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 89 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name            1
Observation Date       93
Series Key              3
Series Display Name     3
Observation Value      56
Unit                    1
Observation Status      1
Sequence No.            3
Series name             3
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Structure of Interest Rate: State Bank of Pakistan Policy Rates    182
```
**Column: `Series Key`** (Top 3 of 3 unique values)
```
Series Key
TS_GP_IR_SIRPR_AH.SBPOL0010    93
TS_GP_IR_SIRPR_AH.SBPOL0020    53
TS_GP_IR_SIRPR_AH.SBPOL0030    36
```
**Column: `Series Display Name`** (Top 3 of 3 unique values)
```
Series Display Name
. State Bank of Pakistan's Reverse Repo Rate       93
. State Bank of Pakistan's Repo Rate               53
. State Bank of Pakistan's Policy (Target) Rate    36
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Percent    182
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    182
```
**Column: `Series name`** (Top 3 of 3 unique values)
```
Series name
State Bank of Pakistan's Reverse Repo Rate       93
State Bank of Pakistan's Repo Rate               53
State Bank of Pakistan's Policy (Target) Rate    36
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean   | StdDev   | Min    | 25%    | 50%    | 75%    | Max    | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                    | LastNonNull                                                     |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:-------|:---------|:-------|:-------|:-------|:-------|:-------|:-----------|:-----------|:--------------------|:--------------------|:----------------------------------------------------------------|:----------------------------------------------------------------|
| Dataset Name        | object         |            182 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Structure of Interest Rate: State Bank of Pakistan Policy Rates | Structure of Interest Rate: State Bank of Pakistan Policy Rates |
| Observation Date    | datetime64[ns] |            182 |           0 | 0.00%     |            93 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | 1956-01-01 00:00:00 | 2025-01-28 00:00:00 | 2025-01-28 00:00:00                                             | 1956-01-01 00:00:00                                             |
| Series Key          | object         |            182 |           0 | 0.00%     |             3 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | TS_GP_IR_SIRPR_AH.SBPOL0010                                     | TS_GP_IR_SIRPR_AH.SBPOL0010                                     |
| Series Display Name | object         |            182 |           0 | 0.00%     |             3 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | . State Bank of Pakistan's Reverse Repo Rate                    | . State Bank of Pakistan's Reverse Repo Rate                    |
| Observation Value   | float64        |            182 |           0 | 0.00%     |            56 | 11.497 | 4.435    | 3.000  | 8.000  | 10.625 | 14.000 | 23.000 | 0.575      | -0.345     | NaT                 | NaT                 | 13.0                                                            | 3.0                                                             |
| Unit                | object         |            182 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Percent                                                         | Percent                                                         |
| Observation Status  | object         |            182 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Normal                                                          | Normal                                                          |
| Sequence No.        | int64          |            182 |           0 | 0.00%     |             3 | 16.868 | 7.836    | 10.000 | 10.000 | 10.000 | 20.000 | 30.000 | 0.616      | -1.108     | NaT                 | NaT                 | 10                                                              | 10                                                              |
| Series name         | object         |            182 |           0 | 0.00%     |             3 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | State Bank of Pakistan's Reverse Repo Rate                      | State Bank of Pakistan's Reverse Repo Rate                      |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `population,_labor_force_and_employment.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (65, 53) (rows, columns)
* **Format:** Detected **Tall** (Rows=65 >= Cols=53). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (65, 53) (rows, columns)

* **Original Column Names (53):**
  ```
  ['Sectors', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 3,445
* **Data Types Summary:** {dtype('float64'): 52, dtype('O'): 1}

### Memory Usage (Bytes)

* **Total:** 32,945 Bytes
* **Per Analyzed Column + Index:**
```
Index       132
Sectors    5773
1972-73     520
1973-74     520
1974-75     520
1975-76     520
1976-77     520
1977-78     520
1978-79     520
1979-80     520
1980-81     520
1981-82     520
1982-83     520
1983-84     520
1984-85     520
1985-86     520
1986-87     520
1987-88     520
1988-89     520
1989-90     520
1990-91     520
1991-92     520
1992-93     520
1993-94     520
1994-95     520
1995-96     520
1996-97     520
1997-98     520
1998-99     520
1999-00     520
2000-01     520
2001-02     520
2002-03     520
2003-04     520
2004-05     520
2005-06     520
2006-07     520
2007-08     520
2008-09     520
2009-10     520
2010-11     520
2011-12     520
2012-13     520
2013-14     520
2014-15     520
2015-16     520
2016-17     520
2017-18     520
2018-19     520
2019-20     520
2020-21     520
2021-22     520
2022-23     520
2023-24     520
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 65 entries, 0 to 64
Data columns (total 53 columns):
 #   Column   Non-Null Count  Dtype  
---  ------   --------------  -----  
 0   Sectors  65 non-null     object 
 1   1972-73  31 non-null     float64
 2   1973-74  21 non-null     float64
 3   1974-75  36 non-null     float64
 4   1975-76  36 non-null     float64
 5   1976-77  39 non-null     float64
 6   1977-78  39 non-null     float64
 7   1978-79  39 non-null     float64
 8   1979-80  39 non-null     float64
 9   1980-81  36 non-null     float64
 10  1981-82  46 non-null     float64
 11  1982-83  36 non-null     float64
 12  1983-84  36 non-null     float64
 13  1984-85  36 non-null     float64
 14  1985-86  36 non-null     float64
 15  1986-87  39 non-null     float64
 16  1987-88  52 non-null     float64
 17  1988-89  51 non-null     float64
 18  1989-90  51 non-null     float64
 19  1990-91  50 non-null     float64
 20  1991-92  59 non-null     float64
 21  1992-93  59 non-null     float64
 22  1993-94  59 non-null     float64
 23  1994-95  59 non-null     float64
 24  1995-96  59 non-null     float64
 25  1996-97  59 non-null     float64
 26  1997-98  59 non-null     float64
 27  1998-99  62 non-null     float64
 28  1999-00  59 non-null     float64
 29  2000-01  56 non-null     float64
 30  2001-02  56 non-null     float64
 31  2002-03  58 non-null     float64
 32  2003-04  65 non-null     float64
 33  2004-05  58 non-null     float64
 34  2005-06  61 non-null     float64
 35  2006-07  64 non-null     float64
 36  2007-08  65 non-null     float64
 37  2008-09  59 non-null     float64
 38  2009-10  59 non-null     float64
 39  2010-11  61 non-null     float64
 40  2011-12  65 non-null     float64
 41  2012-13  65 non-null     float64
 42  2013-14  65 non-null     float64
 43  2014-15  65 non-null     float64
 44  2015-16  65 non-null     float64
 45  2016-17  30 non-null     float64
 46  2017-18  29 non-null     float64
 47  2018-19  64 non-null     float64
 48  2019-20  64 non-null     float64
 49  2020-21  29 non-null     float64
 50  2021-22  60 non-null     float64
 51  2022-23  25 non-null     float64
 52  2023-24  23 non-null     float64
dtypes: float64(52), object(1)
memory usage: 27.0+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 786 (22.82%)
Columns (45 of 53) with missing values (Sorted):
```
1973-74    44
2023-24    42
2022-23    40
2020-21    36
2017-18    36
2016-17    35
1972-73    34
1975-76    29
1982-83    29
1983-84    29
1984-85    29
1985-86    29
1980-81    29
1974-75    29
1979-80    26
1986-87    26
1977-78    26
1978-79    26
1976-77    26
1981-82    19
1990-91    15
1989-90    14
1988-89    14
1987-88    13
2000-01     9
2001-02     9
2002-03     7
2004-05     7
2009-10     6
2008-09     6
1994-95     6
1999-00     6
1997-98     6
1996-97     6
1995-96     6
1993-94     6
1992-93     6
1991-92     6
2021-22     5
2005-06     4
2010-11     4
1998-99     3
2006-07     1
2018-19     1
2019-20     1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 53):
```
Sectors    65
1972-73    31
1973-74    21
1974-75    29
1975-76    30
1976-77    35
1977-78    35
1978-79    33
1979-80    33
1980-81    29

...

2014-15    62
2015-16    62
2016-17    29
2017-18    28
2018-19    60
2019-20    62
2020-21    29
2021-22    59
2022-23    24
2023-24    23
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 65 unique values)
```
Sectors
Population (Million)                                                   1
Labour Force Participation Rates (%)                                   1
Labour Force Participation Rates, Urban (%)                            1
Employed labourforce in Agriculture (Million)                          1
Employed labourforce in Mining & Maufcaturing (Million)                1
Employed labourforce in Construction (Million)                         1
Employed labourforce in Electricity & Gas Distribution (Million)       1
Employed labourforce in Transport storage & Communication (Million)    1
Employed labourforce in Wholesale &Retail Trade (Million)              1
Employed Labourforce in other sectors (Million)                        1
Employed labourforce in Agriculture (%)                                1
Employed labourforce in Mining & Maufcaturing (%)                      1
Employed labourforce in Construction (%age)                            1
Employed labourforce in Electricity & Gas Distribution (%)             1
Employed labourforce in Transport storage & Communication (%)          1
Employed labourforce in Wholesale &Retail Trade (%)                    1
Employed Labourforce in other sectors (%)                              1
Daily wages of Carpenters in Islamabad (Rupees)                        1
Daily wages of Carpenters inKarachi (Rupees)                           1
Daily wages of Carpenters inLahore (Rupees)                            1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|         | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean      | StdDev    | Min    | 25%      | 50%      | 75%      | Max        | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull         | LastNonNull                                         |
|:--------|:-----------|---------------:|------------:|:----------|--------------:|:----------|:----------|:-------|:---------|:---------|:---------|:-----------|:-----------|:-----------|:----------|:----------|:---------------------|:----------------------------------------------------|
| Sectors | object     |             65 |           0 | 0.00%     |            65 | N/A       | N/A       | N/A    | N/A      | N/A      | N/A      | N/A        | N/A        | N/A        | NaT       | NaT       | Population (Million) | Daily Wages of un skilled labour in Quetta (Rupees) |
| 1972-73 | float64    |             31 |          34 | 52.31%    |            31 | 2119.270  | 7206.478  | 0.070  | 2.245    | 12.920   | 53.015   | 37607.000  | 4.422      | 20.970     | NaT       | NaT       | 65.3                 | 11.25                                               |
| 1973-74 | float64    |             21 |          44 | 67.69%    |            21 | 12.340    | 18.114    | 0.080  | 1.920    | 3.660    | 13.200   | 65.890     | 2.148      | 4.190      | NaT       | NaT       | 65.89                | 11.15                                               |
| 1974-75 | float64    |             36 |          29 | 44.62%    |            29 | 14.713    | 14.733    | 0.090  | 2.990    | 10.990   | 20.590   | 67.900     | 1.908      | 4.836      | NaT       | NaT       | 67.9                 | 10.0                                                |
| 1975-76 | float64    |             36 |          29 | 44.62%    |            30 | 17.204    | 16.212    | 0.100  | 3.025    | 12.310   | 28.000   | 69.980     | 1.295      | 2.068      | NaT       | NaT       | 69.98                | 10.0                                                |
| 1976-77 | float64    |             39 |          26 | 40.00%    |            35 | 21.627    | 20.421    | 0.110  | 3.735    | 15.000   | 33.750   | 87.000     | 1.263      | 1.803      | NaT       | NaT       | 72.12                | 15.0                                                |
| 1977-78 | float64    |             39 |          26 | 40.00%    |            35 | 23.724    | 22.686    | 0.130  | 3.830    | 15.000   | 37.500   | 100.000    | 1.291      | 2.066      | NaT       | NaT       | 74.33                | 15.0                                                |
| 1978-79 | float64    |             39 |          26 | 40.00%    |            33 | 25.061    | 23.226    | 0.150  | 4.005    | 18.000   | 41.700   | 95.000     | 0.998      | 0.744      | NaT       | NaT       | 76.6                 | 15.0                                                |
| 1979-80 | float64    |             39 |          26 | 40.00%    |            33 | 28.180    | 25.833    | 0.170  | 4.140    | 20.000   | 50.000   | 95.000     | 0.727      | -0.466     | NaT       | NaT       | 78.94                | 20.0                                                |
| 1980-81 | float64    |             36 |          29 | 44.62%    |            29 | 28.204    | 25.727    | 0.200  | 3.598    | 23.325   | 55.830   | 81.360     | 0.520      | -1.270     | NaT       | NaT       | 81.36                | 22.5                                                |
| 1981-82 | float64    |             46 |          19 | 29.23%    |            41 | 1859.417  | 7580.279  | 0.230  | 6.465    | 28.750   | 69.375   | 47292.000  | 5.301      | 30.284     | NaT       | NaT       | 84.25                | 25.0                                                |
| 1982-83 | float64    |             36 |          29 | 44.62%    |            32 | 31.401    | 29.129    | 0.260  | 3.730    | 25.770   | 61.873   | 86.440     | 0.536      | -1.291     | NaT       | NaT       | 86.44                | 27.5                                                |
| 1983-84 | float64    |             36 |          29 | 44.62%    |            32 | 32.486    | 30.205    | 0.290  | 3.808    | 26.380   | 65.000   | 89.120     | 0.539      | -1.281     | NaT       | NaT       | 89.12                | 27.5                                                |
| 1984-85 | float64    |             36 |          29 | 44.62%    |            32 | 33.765    | 31.610    | 0.230  | 3.835    | 26.925   | 71.250   | 91.880     | 0.527      | -1.370     | NaT       | NaT       | 91.88                | 27.5                                                |
| 1985-86 | float64    |             36 |          29 | 44.62%    |            30 | 35.354    | 32.733    | 0.190  | 3.865    | 27.480   | 75.625   | 97.730     | 0.490      | -1.383     | NaT       | NaT       | 97.73                | 32.5                                                |
| 1986-87 | float64    |             39 |          26 | 40.00%    |            31 | 37.292    | 34.403    | 0.140  | 4.165    | 28.720   | 75.000   | 97.670     | 0.500      | -1.332     | NaT       | NaT       | 97.67                | 35.0                                                |
| 1987-88 | float64    |             52 |          13 | 20.00%    |            49 | 35.373    | 34.317    | 0.210  | 4.402    | 26.880   | 68.578   | 101.930    | 0.724      | -0.929     | NaT       | NaT       | 100.7                | 35.0                                                |
| 1988-89 | float64    |             51 |          14 | 21.54%    |            50 | 38.371    | 37.615    | 0.170  | 4.735    | 28.830   | 71.175   | 117.690    | 0.757      | -0.866     | NaT       | NaT       | 103.82               | 33.75                                               |
| 1989-90 | float64    |             51 |          14 | 21.54%    |            44 | 40.607    | 39.984    | 0.180  | 4.735    | 28.830   | 73.375   | 119.620    | 0.732      | -0.967     | NaT       | NaT       | 107.04               | 37.5                                                |
| 1990-91 | float64    |             50 |          15 | 23.08%    |            45 | 41.204    | 41.479    | 0.180  | 4.657    | 27.555   | 69.670   | 121.860    | 0.788      | -0.874     | NaT       | NaT       | 110.36               | 45.0                                                |
| 1991-92 | float64    |             59 |           6 | 9.23%     |            55 | 46.274    | 44.548    | 0.240  | 7.405    | 29.830   | 75.835   | 131.660    | 0.759      | -0.847     | NaT       | NaT       | 112.61               | 51.25                                               |
| 1992-93 | float64    |             59 |           6 | 9.23%     |            55 | 49.679    | 50.061    | 0.240  | 6.650    | 31.040   | 78.220   | 170.000    | 0.933      | -0.354     | NaT       | NaT       | 115.54               | 58.75                                               |
| 1993-94 | float64    |             59 |           6 | 9.23%     |            55 | 52.821    | 53.980    | 0.260  | 6.405    | 32.080   | 82.110   | 170.000    | 0.911      | -0.482     | NaT       | NaT       | 118.5                | 75.0                                                |
| 1994-95 | float64    |             59 |           6 | 9.23%     |            55 | 55.289    | 57.302    | 0.280  | 6.190    | 28.770   | 85.480   | 180.000    | 0.919      | -0.465     | NaT       | NaT       | 121.48               | 77.5                                                |
| 1995-96 | float64    |             59 |           6 | 9.23%     |            52 | 59.777    | 64.760    | 0.260  | 7.055    | 29.540   | 94.950   | 205.000    | 1.035      | -0.204     | NaT       | NaT       | 124.49               | 77.5                                                |
| 1996-97 | float64    |             59 |           6 | 9.23%     |            52 | 63.806    | 70.481    | 0.270  | 7.055    | 33.130   | 95.000   | 234.610    | 1.092      | -0.062     | NaT       | NaT       | 127.51               | 95.0                                                |
| 1997-98 | float64    |             59 |           6 | 9.23%     |            53 | 67.892    | 76.049    | 0.350  | 6.960    | 33.800   | 97.500   | 245.190    | 1.105      | -0.113     | NaT       | NaT       | 130.56               | 95.0                                                |
| 1998-99 | float64    |             62 |           3 | 4.62%     |            53 | 2200.405  | 10255.603 | 0.250  | 8.500    | 43.195   | 190.000  | 73621.000  | 6.127      | 40.529     | NaT       | NaT       | 132.35               | 110.0                                               |
| 1999-00 | float64    |             59 |           6 | 9.23%     |            53 | 75.711    | 88.226    | 0.260  | 7.105    | 31.510   | 115.000  | 285.570    | 1.189      | 0.107      | NaT       | NaT       | 136.41               | 110.0                                               |
| 2000-01 | float64    |             56 |           9 | 13.85%    |            49 | 77.971    | 90.082    | 0.260  | 7.600    | 35.240   | 124.888  | 292.300    | 1.145      | -0.003     | NaT       | NaT       | 139.55               | 100.0                                               |
| 2001-02 | float64    |             56 |           9 | 13.85%    |            48 | 79.705    | 91.765    | 0.260  | 7.600    | 36.225   | 125.690  | 291.340    | 1.108      | -0.157     | NaT       | NaT       | 142.76               | 100.0                                               |
| 2002-03 | float64    |             58 |           7 | 10.77%    |            52 | 80.164    | 90.976    | 0.320  | 8.652    | 37.130   | 118.750  | 298.080    | 1.136      | -0.035     | NaT       | NaT       | 146.02               | 115.0                                               |
| 2003-04 | float64    |             65 |           0 | 0.00%     |            60 | 2366.181  | 11267.629 | 0.330  | 9.800    | 44.120   | 183.270  | 82710.000  | 6.267      | 42.426     | NaT       | NaT       | 149.32               | 111.67                                              |
| 2004-05 | float64    |             58 |           7 | 10.77%    |            53 | 92.244    | 108.240   | 0.280  | 8.950    | 40.720   | 150.352  | 331.000    | 1.156      | -0.062     | NaT       | NaT       | 152.66               | 150.0                                               |
| 2005-06 | float64    |             61 |           4 | 6.15%     |            56 | 2617.243  | 12019.444 | 0.290  | 13.570   | 52.410   | 275.000  | 85650.000  | 6.081      | 39.910     | NaT       | NaT       | 156.04               | 185.0                                               |
| 2006-07 | float64    |             64 |           1 | 1.54%     |            60 | 2595.841  | 12082.351 | 0.310  | 12.783   | 51.520   | 283.250  | 87633.000  | 6.164      | 41.021     | NaT       | NaT       | 159.46               | 250.0                                               |
| 2007-08 | float64    |             65 |           0 | 0.00%     |            59 | 2622.534  | 12238.399 | 0.370  | 7.900    | 52.410   | 300.000  | 89388.000  | 6.205      | 41.578     | NaT       | NaT       | 162.91               | 300.0                                               |
| 2008-09 | float64    |             59 |           6 | 9.23%     |            54 | 149.151   | 208.114   | 0.360  | 7.515    | 41.550   | 199.705  | 625.000    | 1.369      | 0.307      | NaT       | NaT       | 166.41               | 300.0                                               |
| 2009-10 | float64    |             59 |           6 | 9.23%     |            55 | 153.559   | 213.265   | 0.360  | 7.375    | 43.140   | 222.470  | 650.000    | 1.355      | 0.275      | NaT       | NaT       | 169.94               | 300.0                                               |
| 2010-11 | float64    |             61 |           4 | 6.15%     |            56 | 3001.070  | 13398.871 | 0.430  | 12.640   | 64.090   | 500.000  | 94745.000  | 5.984      | 38.654     | NaT       | NaT       | 173.51               | 350.0                                               |
| 2011-12 | float64    |             65 |           0 | 0.00%     |            65 | 2880.443  | 13248.366 | 0.260  | 8.840    | 57.840   | 410.420  | 96545.000  | 6.174      | 41.167     | NaT       | NaT       | 177.1                | 397.92                                              |
| 2012-13 | float64    |             65 |           0 | 0.00%     |            63 | 2956.189  | 13502.681 | 0.270  | 8.840    | 59.330   | 500.000  | 98355.000  | 6.167      | 41.068     | NaT       | NaT       | 180.71               | 425.0                                               |
| 2013-14 | float64    |             65 |           0 | 0.00%     |            63 | 3028.508  | 13759.109 | 0.300  | 8.830    | 59.740   | 550.000  | 100174.000 | 6.159      | 40.970     | NaT       | NaT       | 184.35               | 550.0                                               |
| 2014-15 | float64    |             65 |           0 | 0.00%     |            62 | 3099.980  | 14017.511 | 0.270  | 8.240    | 60.100   | 600.000  | 102005.000 | 6.152      | 40.873     | NaT       | NaT       | 188.02               | 550.0                                               |
| 2015-16 | float64    |             65 |           0 | 0.00%     |            62 | 3173.912  | 14276.224 | 0.450  | 8.890    | 61.040   | 700.000  | 103837.000 | 6.144      | 40.774     | NaT       | NaT       | 191.71               | 550.0                                               |
| 2016-17 | float64    |             30 |          35 | 53.85%    |            29 | 7079.077  | 21362.498 | 2.080  | 136.582  | 815.180  | 1175.000 | 107959.000 | 4.131      | 18.299     | NaT       | NaT       | 198.78               | 550.0                                               |
| 2017-18 | float64    |             29 |          36 | 55.38%    |            28 | 7668.243  | 22450.565 | 2.400  | 131.940  | 861.540  | 1200.000 | 109989.000 | 3.895      | 16.317     | NaT       | NaT       | 207.68               | 550.0                                               |
| 2018-19 | float64    |             64 |           1 | 1.54%     |            60 | 3588.725  | 15743.477 | 0.450  | 10.050   | 61.105   | 870.673  | 111995.000 | 5.885      | 37.652     | NaT       | NaT       | 211.82               | 700.0                                               |
| 2019-20 | float64    |             64 |           1 | 1.54%     |            62 | 3686.074  | 16045.334 | 0.500  | 10.165   | 61.765   | 984.938  | 114048.000 | 5.875      | 37.515     | NaT       | NaT       | 216.08               | 996.66                                              |
| 2020-21 | float64    |             29 |          36 | 55.38%    |            29 | 8243.641  | 23744.614 | 1.800  | 139.390  | 1205.270 | 1440.830 | 116130.000 | 3.877      | 16.132     | NaT       | NaT       | 220.4                | 988.3                                               |
| 2021-22 | float64    |             60 |           5 | 7.69%     |            59 | 4095.697  | 17194.340 | 0.430  | 13.582   | 76.055   | 1074.418 | 118235.000 | 5.665      | 34.825     | NaT       | NaT       | 224.78               | 1021.74                                             |
| 2022-23 | float64    |             25 |          40 | 61.54%    |            24 | 10015.431 | 26344.098 | 84.690 | 1000.000 | 1454.830 | 1713.020 | 120359.000 | 3.570      | 13.595     | NaT       | NaT       | 229.22               | 1096.96                                             |
| 2023-24 | float64    |             23 |          42 | 64.62%    |            23 | 11613.177 | 28797.845 | 93.750 | 1433.100 | 1747.070 | 2064.475 | 127689.000 | 3.449      | 12.721     | NaT       | NaT       | 241.5                | 1107.86                                             |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 1040 pairs with absolute correlation > 0.8 (showing top 50):*
```
1973-74  2020-21    1.000000
         2016-17    1.000000
         2017-18    1.000000
2010-11  2011-12    0.999999
2006-07  2007-08    0.999997
2013-14  2014-15    0.999997
2011-12  2012-13    0.999996
2012-13  2013-14    0.999995
2014-15  2015-16    0.999995
1998-99  2005-06    0.999994
         2003-04    0.999994
2010-11  2012-13    0.999992
2019-20  2020-21    0.999991
2020-21  2021-22    0.999990
2012-13  2014-15    0.999990
2021-22  2022-23    0.999988
2003-04  2005-06    0.999986
2011-12  2013-14    0.999986
2013-14  2015-16    0.999986
2007-08  2010-11    0.999983
2018-19  2019-20    0.999983
2017-18  2018-19    0.999980
2010-11  2013-14    0.999979
2012-13  2015-16    0.999976
2011-12  2014-15    0.999976
2007-08  2011-12    0.999973
2006-07  2010-11    0.999969
2019-20  2021-22    0.999967
2010-11  2014-15    0.999966
2020-21  2022-23    0.999961
2018-19  2020-21    0.999960
         2023-24    0.999960
2006-07  2011-12    0.999956
2011-12  2015-16    0.999955
2007-08  2012-13    0.999953
2017-18  2023-24    0.999949
2019-20  2023-24    0.999944
2010-11  2015-16    0.999944
2017-18  2019-20    0.999943
2006-07  2012-13    0.999930
2007-08  2013-14    0.999927
2010-11  2016-17    0.999923
2019-20  2022-23    0.999921
2012-13  2016-17    0.999921
2018-19  2021-22    0.999919
2013-14  2016-17    0.999918
1981-82  1998-99    0.999917
2011-12  2016-17    0.999917
2003-04  2006-07    0.999916
2014-15  2016-17    0.999916
```


---


## Analysis for: `public_debt.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (3, 55) (rows, columns)
* **Format:** Detected **Wide** (Cols=55 > Rows=3). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Transposed index converted to: datetime64[ns] (YYYY format)
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (54, 3) (rows, columns)

* **Original Column Names (55):**
  ```
  ['Sectors', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

* **Analyzed Column Names (3):**
  ```
  ['Domestic Debt (Rs. billion)', 'External Debt (Rs. billion)', 'Total Public Debt (Rs. billion)']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 162
* **Data Types Summary:** {dtype('int64'): 3}

### Memory Usage (Bytes)

* **Total:** 1,728 Bytes
* **Per Analyzed Column + Index:**
```
Index                              432
Domestic Debt (Rs. billion)        432
External Debt (Rs. billion)        432
Total Public Debt (Rs. billion)    432
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
DatetimeIndex: 54 entries, 1970-01-01 to 2023-01-01
Data columns (total 3 columns):
 #   Column                           Non-Null Count  Dtype
---  ------                           --------------  -----
 0   Domestic Debt (Rs. billion)      54 non-null     int64
 1   External Debt (Rs. billion)      54 non-null     int64
 2   Total Public Debt (Rs. billion)  54 non-null     int64
dtypes: int64(3)
memory usage: 1.7 KB

```


### Date Analysis (Index (TimePeriod))

* **Data Type:** datetime64[ns]
* **Min Date:** 1970-01-01 00:00:00
* **Max Date:** 2023-01-01 00:00:00
* **Number of Unique Dates:** 54
* **Inferred Frequency:** YS-JAN
* **Missing Dates (based on inferred freq):** 0
* **Duplicate Dates:** 0



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 3):
```
Sectors
Domestic Debt (Rs. billion)        54
External Debt (Rs. billion)        54
Total Public Debt (Rs. billion)    54
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors                         | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount |    Mean |   StdDev |   Min |   25% |    50% |      75% |   Max |   Skewness |   Kurtosis | MinDate   | MaxDate   |   FirstNonNull |   LastNonNull |
|:--------------------------------|:-----------|---------------:|------------:|:----------|--------------:|--------:|---------:|------:|------:|-------:|---------:|------:|-----------:|-----------:|:----------|:----------|---------------:|--------------:|
| Domestic Debt (Rs. billion)     | int64      |             54 |           0 | 0.00%     |            54 | 5861.07 | 10389.2  |    14 |   132 | 1127.5 |  5673.75 | 47160 |      2.389 |      5.64  | NaT       | NaT       |             14 |         47160 |
| External Debt (Rs. billion)     | int64      |             54 |           0 | 0.00%     |            54 | 3459.18 |  5660.31 |    16 |   138 | 1066   |  4656.25 | 24086 |      2.432 |      5.809 | NaT       | NaT       |             16 |         24086 |
| Total Public Debt (Rs. billion) | int64      |             54 |           0 | 0.00%     |            54 | 9320.3  | 16012.3  |    30 |   270 | 2193.5 | 10330.8  | 71246 |      2.401 |      5.648 | NaT       | NaT       |             30 |         71246 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 3 pairs with absolute correlation > 0.8 (showing top 50):*
```
Sectors                      Sectors                        
Domestic Debt (Rs. billion)  Total Public Debt (Rs. billion)    0.998737
External Debt (Rs. billion)  Total Public Debt (Rs. billion)    0.995739
Domestic Debt (Rs. billion)  External Debt (Rs. billion)        0.989849
```


---


## Analysis for: `quaterly_gdp_2015.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (304, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=304 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (304, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 2,736
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 152,472 Bytes
* **Per Analyzed Column + Index:**
```
Index                    132
Dataset Name           29792
Observation Date        2432
Series Key             24624
Series Display Name    30856
Observation Value       2432
Unit                   17632
Observation Status     16832
Sequence No.            2432
Series name            25308
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 304 entries, 0 to 303
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         304 non-null    object        
 1   Observation Date     304 non-null    datetime64[ns]
 2   Series Key           304 non-null    object        
 3   Series Display Name  304 non-null    object        
 4   Observation Value    288 non-null    float64       
 5   Unit                 304 non-null    object        
 6   Observation Status   304 non-null    object        
 7   Sequence No.         304 non-null    int64         
 8   Series name          304 non-null    object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 21.5+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2015-09-30 00:00:00
* **Max Date:** 2024-12-31 00:00:00
* **Number of Unique Dates:** 38
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 266 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 16 (0.58%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    16
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name             1
Observation Date        38
Series Key               8
Series Display Name      8
Observation Value      281
Unit                     2
Observation Status       2
Sequence No.             8
Series name              8
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Quarterly GDP at Constant Basic Prices of 2015-16    304
```
**Column: `Series Key`** (Top 8 of 8 unique values)
```
Series Key
TS_GP_RS_QGDP1516_Q.QGDP00070000    38
TS_GP_RS_QGDP1516_Q.QGDP00080000    38
TS_GP_RS_QGDP1516_Q.QGDP00010000    38
TS_GP_RS_QGDP1516_Q.QGDP00020000    38
TS_GP_RS_QGDP1516_Q.QGDP00030000    38
TS_GP_RS_QGDP1516_Q.QGDP00040000    38
TS_GP_RS_QGDP1516_Q.QGDP00050000    38
TS_GP_RS_QGDP1516_Q.QGDP00060000    38
```
**Column: `Series Display Name`** (Top 8 of 8 unique values)
```
Series Display Name
A. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16))                  38
B. Growth Rate of Gross Domestic Product (Total of Gross Value Addition at Constant Factor Cost(2015-16))    38
......I(a). Agricultural Sector                                                                              38
......I(b). Growth Rate of Agriculture Sector                                                                38
......II(a). Industrial Sector                                                                               38
......II(b). Growth Rate of Industrial Sector                                                                38
......III(a). Services Sector                                                                                38
......III(b). Growth Rate of Services Sector                                                                 38
```
**Column: `Unit`** (Top 2 of 2 unique values)
```
Unit
Million PKR    152
Percent        152
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           288
Missing value     16
```
**Column: `Series name`** (Top 8 of 8 unique values)
```
Series name
Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16))    38
Growth Rate of Real Gross Domestic Product                                                  38
Agricultural Sector                                                                         38
Growth Rate of Agriculture Sector                                                           38
Industrial Sector                                                                           38
Growth Rate of Industry Sector                                                              38
Services Sector                                                                             38
Growth Rate of Services Sector                                                              38
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean        | StdDev      | Min     | 25%     | 50%         | 75%         | Max          | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                                                                | LastNonNull                                       |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:------------|:------------|:--------|:--------|:------------|:------------|:-------------|:-----------|:-----------|:--------------------|:--------------------|:--------------------------------------------------------------------------------------------|:--------------------------------------------------|
| Dataset Name        | object         |            304 |           0 | 0.00%     |             1 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Quarterly GDP at Constant Basic Prices of 2015-16                                           | Quarterly GDP at Constant Basic Prices of 2015-16 |
| Observation Date    | datetime64[ns] |            304 |           0 | 0.00%     |            38 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | 2015-09-30 00:00:00 | 2024-12-31 00:00:00 | 2024-12-31 00:00:00                                                                         | 2015-09-30 00:00:00                               |
| Series Key          | object         |            304 |           0 | 0.00%     |             8 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | TS_GP_RS_QGDP1516_Q.QGDP00070000                                                            | TS_GP_RS_QGDP1516_Q.QGDP00060000                  |
| Series Display Name | object         |            304 |           0 | 0.00%     |             8 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | A. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16)) | ......III(b). Growth Rate of Services Sector      |
| Observation Value   | float64        |            288 |          16 | 5.26%     |           281 | 2360321.558 | 3102508.930 | -20.880 | 3.625   | 1586785.970 | 4377108.740 | 10135261.000 | 1.228      | 0.222      | NaT                 | NaT                 | 10135261.0                                                                                  | 4177900.956                                       |
| Unit                | object         |            304 |           0 | 0.00%     |             2 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Million PKR                                                                                 | Percent                                           |
| Observation Status  | object         |            304 |           0 | 0.00%     |             2 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Normal                                                                                      | Missing value                                     |
| Sequence No.        | int64          |            304 |           0 | 0.00%     |             8 | 450.000     | 229.507     | 100.000 | 275.000 | 450.000     | 625.000     | 800.000      | 0.000      | -1.239     | NaT                 | NaT                 | 100                                                                                         | 800                                               |
| Series name         | object         |            304 |           0 | 0.00%     |             8 | N/A         | N/A         | N/A     | N/A     | N/A         | N/A         | N/A          | N/A        | N/A        | NaT                 | NaT                 | Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16))    | Growth Rate of Services Sector                    |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `seasonal_worker_remittance.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (474, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=474 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (474, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 4,266
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 245,427 Bytes
* **Per Analyzed Column + Index:**
```
Index                    132
Dataset Name           69204
Observation Date        3792
Series Key             33654
Series Display Name    40053
Observation Value       3792
Unit                   28440
Observation Status     26070
Sequence No.            3792
Series name            36498
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 474 entries, 0 to 473
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         474 non-null    object        
 1   Observation Date     474 non-null    datetime64[ns]
 2   Series Key           474 non-null    object        
 3   Series Display Name  474 non-null    object        
 4   Observation Value    474 non-null    float64       
 5   Unit                 474 non-null    object        
 6   Observation Status   474 non-null    object        
 7   Sequence No.         474 non-null    int64         
 8   Series name          474 non-null    object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 33.5+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2005-07-31 00:00:00
* **Max Date:** 2025-03-31 00:00:00
* **Number of Unique Dates:** 237
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 237 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name             1
Observation Date       237
Series Key               2
Series Display Name      2
Observation Value      474
Unit                     1
Observation Status       1
Sequence No.             1
Series name              2
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Seasonally Adjusted Workers’ Remittances    474
```
**Column: `Series Key`** (Top 2 of 2 unique values)
```
Series Key
TS_GP_ES_SWR_M.SWR0001    237
TS_GP_ES_SWR_M.SWR0002    237
```
**Column: `Series Display Name`** (Top 2 of 2 unique values)
```
Series Display Name
1 Workers Remittances (WR)                       237
1 Seasonally adjusted Worker Remittance (SWR)    237
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Million USD    474
```
**Column: `Observation Status`** (Top 1 of 1 unique values)
```
Observation Status
Normal    474
```
**Column: `Series name`** (Top 2 of 2 unique values)
```
Series name
Workers Remittances                      237
Seasonally adjusted Worker Remittance    237
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean     | StdDev   | Min     | 25%     | 50%      | 75%      | Max      | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                             | LastNonNull                              |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:---------|:---------|:--------|:--------|:---------|:---------|:---------|:-----------|:-----------|:--------------------|:--------------------|:-----------------------------------------|:-----------------------------------------|
| Dataset Name        | object         |            474 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Seasonally Adjusted Workers’ Remittances | Seasonally Adjusted Workers’ Remittances |
| Observation Date    | datetime64[ns] |            474 |           0 | 0.00%     |           237 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | 2005-07-31 00:00:00 | 2025-03-31 00:00:00 | 2025-03-31 00:00:00                      | 2005-07-31 00:00:00                      |
| Series Key          | object         |            474 |           0 | 0.00%     |             2 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | TS_GP_ES_SWR_M.SWR0001                   | TS_GP_ES_SWR_M.SWR0001                   |
| Series Display Name | object         |            474 |           0 | 0.00%     |             2 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | 1 Workers Remittances (WR)               | 1 Workers Remittances (WR)               |
| Observation Value   | float64        |            474 |           0 | 0.00%     |           474 | 1503.932 | 774.728  | 308.810 | 804.543 | 1505.225 | 2049.178 | 4055.334 | 0.375      | -0.611     | NaT                 | NaT                 | 4055.333654                              | 313.14                                   |
| Unit                | object         |            474 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Million USD                              | Million USD                              |
| Observation Status  | object         |            474 |           0 | 0.00%     |             1 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Normal                                   | Normal                                   |
| Sequence No.        | int64          |            474 |           0 | 0.00%     |             1 | 1.000    | 0.000    | 1.000   | 1.000   | 1.000    | 1.000    | 1.000    | 0.000      | 0.000      | NaT                 | NaT                 | 1                                        | 1                                        |
| Series name         | object         |            474 |           0 | 0.00%     |             2 | N/A      | N/A      | N/A     | N/A     | N/A      | N/A      | N/A      | N/A        | N/A        | NaT                 | NaT                 | Workers Remittances                      | Workers Remittances                      |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `social_protection.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (2, 9) (rows, columns)
* **Format:** Detected **Wide** (Cols=9 > Rows=2). Transposing.
* Using original column `Sectors` as index for transposition.
* **Transposition Successful.**
* Transposed index converted to: datetime64[ns] (YYYY format)
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (8, 2) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Sectors', '2004-05', '2005-06', '2007-08', '2010-11', '2011-12', '2013-14', '2015-16', '2018-19']
  ```

* **Analyzed Column Names (2):**
  ```
  ['Poverty', 'Gini Co-efficient']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 16
* **Data Types Summary:** {dtype('float64'): 2}

### Memory Usage (Bytes)

* **Total:** 192 Bytes
* **Per Analyzed Column + Index:**
```
Index                64
Poverty              64
Gini Co-efficient    64
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
DatetimeIndex: 8 entries, 2004-01-01 to 2018-01-01
Data columns (total 2 columns):
 #   Column             Non-Null Count  Dtype  
---  ------             --------------  -----  
 0   Poverty            8 non-null      float64
 1   Gini Co-efficient  8 non-null      float64
dtypes: float64(2)
memory usage: 192.0 bytes

```


### Date Analysis (Index (TimePeriod))

* **Data Type:** datetime64[ns]
* **Min Date:** 2004-01-01 00:00:00
* **Max Date:** 2018-01-01 00:00:00
* **Number of Unique Dates:** 8
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 0



### Missing Values Summary (per Analyzed Column)

Total missing values: 0 (0.00%)
* No missing values found.*


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 2):
```
Sectors
Poverty              8
Gini Co-efficient    7
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Sectors           | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount |   Mean |   StdDev |    Min |   25% |    50% |    75% |    Max |   Skewness |   Kurtosis | MinDate   | MaxDate   |   FirstNonNull |   LastNonNull |
|:------------------|:-----------|---------------:|------------:|:----------|--------------:|-------:|---------:|-------:|------:|-------:|-------:|-------:|-----------:|-----------:|:----------|:----------|---------------:|--------------:|
| Poverty           | float64    |              8 |           0 | 0.00%     |             8 | 33.4   |   10.309 | 21.9   |  24.2 | 32.9   | 38.625 | 50.4   |      0.523 |     -0.968 | NaT       | NaT       |           23.9 |        21.9   |
| Gini Co-efficient | float64    |              8 |           0 | 0.00%     |             7 |  0.306 |    0.01  |  0.296 |   0.3 |  0.301 |  0.309 |  0.326 |      1.446 |      1.724 | NaT       | NaT       |            0.3 |         0.303 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `t_bills.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (3276, 9) (rows, columns)
* **Format:** Detected **Tall** (Rows=3276 >= Cols=9). Analyzing original format.
* Applying generic type conversion...
* Type Conversions Applied: `Observation Date`: object -> datetime64
* **Shape Analyzed:** (3276, 9) (rows, columns)

* **Original Column Names (9):**
  ```
  ['Dataset Name', 'Observation Date', 'Series Key', 'Series Display Name', 'Observation Value', 'Unit', 'Observation Status', 'Sequence No.', 'Series name']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 29,484
* **Data Types Summary:** {dtype('O'): 6, dtype('<M8[ns]'): 1, dtype('float64'): 1, dtype('int64'): 1}

### Memory Usage (Bytes)

* **Total:** 1,627,485 Bytes
* **Per Analyzed Column + Index:**
```
Index                     132
Dataset Name           324324
Observation Date        26208
Series Key             248976
Series Display Name    307398
Observation Value       26208
Unit                   183456
Observation Status     183729
Sequence No.            26208
Series name            300846
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 3276 entries, 0 to 3275
Data columns (total 9 columns):
 #   Column               Non-Null Count  Dtype         
---  ------               --------------  -----         
 0   Dataset Name         3276 non-null   object        
 1   Observation Date     3276 non-null   datetime64[ns]
 2   Series Key           3276 non-null   object        
 3   Series Display Name  3276 non-null   object        
 4   Observation Value    2773 non-null   float64       
 5   Unit                 3276 non-null   object        
 6   Observation Status   3276 non-null   object        
 7   Sequence No.         3276 non-null   int64         
 8   Series name          3276 non-null   object        
dtypes: datetime64[ns](1), float64(1), int64(1), object(6)
memory usage: 230.5+ KB

```


### Date Analysis (Column `Observation Date`)

* **Data Type:** datetime64[ns]
* **Min Date:** 2004-06-24 00:00:00
* **Max Date:** 2025-03-26 00:00:00
* **Number of Unique Dates:** 546
* **Inferred Frequency:** None
* **Missing Dates:** Could not infer frequency.
* **Duplicate Dates:** 2730 (Potential issue!)



### Missing Values Summary (per Analyzed Column)

Total missing values: 503 (1.71%)
Columns (1 of 9) with missing values (Sorted):
```
Observation Value    503
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 9):
```
Dataset Name              1
Observation Date        546
Series Key                6
Series Display Name       6
Observation Value      1676
Unit                      1
Observation Status        2
Sequence No.              6
Series name               6
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Dataset Name`** (Top 1 of 1 unique values)
```
Dataset Name
Structure of Interest Rate: T-Bills Auction Result    3276
```
**Column: `Series Key`** (Top 6 of 6 unique values)
```
Series Key
TS_GP_BAM_SIRTBIL_AH.TB0010    546
TS_GP_BAM_SIRTBIL_AH.TB0020    546
TS_GP_BAM_SIRTBIL_AH.TB0030    546
TS_GP_BAM_SIRTBIL_AH.TB0040    546
TS_GP_BAM_SIRTBIL_AH.TB0050    546
TS_GP_BAM_SIRTBIL_AH.TB0060    546
```
**Column: `Series Display Name`** (Top 6 of 6 unique values)
```
Series Display Name
. Treasury Bills' Cut-off Yield 3-Months              546
. Treasury Bills' Cut-off Yield 6-Months              546
. Treasury Bills' Cut-off Yield 12-Months             546
. Treasury Bills' Weighted Average Yield 3-Months     546
. Treasury Bills' Weighted Average Yield 6-Months     546
. Treasury Bills' Weighted Average Yield 12-Months    546
```
**Column: `Unit`** (Top 1 of 1 unique values)
```
Unit
Percent    3276
```
**Column: `Observation Status`** (Top 2 of 2 unique values)
```
Observation Status
Normal           2769
Missing value     507
```
**Column: `Series name`** (Top 6 of 6 unique values)
```
Series name
Treasury Bills' Cut-off Yield 3-Months              546
Treasury Bills' Cut-off Yield 6-Months              546
Treasury Bills' Cut-off Yield 12-Months             546
Treasury Bills' Weighted Average Yield 3-Months     546
Treasury Bills' Weighted Average Yield 6-Months     546
Treasury Bills' Weighted Average Yield 12-Months    546
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                     | DataType       |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean   | StdDev   | Min    | 25%    | 50%    | 75%    | Max    | Skewness   | Kurtosis   | MinDate             | MaxDate             | FirstNonNull                                       | LastNonNull                                        |
|:--------------------|:---------------|---------------:|------------:|:----------|--------------:|:-------|:---------|:-------|:-------|:-------|:-------|:-------|:-----------|:-----------|:--------------------|:--------------------|:---------------------------------------------------|:---------------------------------------------------|
| Dataset Name        | object         |           3276 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Structure of Interest Rate: T-Bills Auction Result | Structure of Interest Rate: T-Bills Auction Result |
| Observation Date    | datetime64[ns] |           3276 |           0 | 0.00%     |           546 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | 2004-06-24 00:00:00 | 2025-03-26 00:00:00 | 2025-03-26 00:00:00                                | 2004-06-24 00:00:00                                |
| Series Key          | object         |           3276 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | TS_GP_BAM_SIRTBIL_AH.TB0010                        | TS_GP_BAM_SIRTBIL_AH.TB0060                        |
| Series Display Name | object         |           3276 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | . Treasury Bills' Cut-off Yield 3-Months           | . Treasury Bills' Weighted Average Yield 12-Months |
| Observation Value   | float64        |           2773 |         503 | 15.35%    |          1676 | 10.897 | 4.241    | 0.121  | 7.838  | 9.976  | 13.022 | 25.070 | 1.030      | 0.933      | NaT                 | NaT                 | 12.01                                              | 2.6912                                             |
| Unit                | object         |           3276 |           0 | 0.00%     |             1 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Percent                                            | Percent                                            |
| Observation Status  | object         |           3276 |           0 | 0.00%     |             2 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Normal                                             | Missing value                                      |
| Sequence No.        | int64          |           3276 |           0 | 0.00%     |             6 | 35.000 | 17.081   | 10.000 | 20.000 | 35.000 | 50.000 | 60.000 | 0.000      | -1.269     | NaT                 | NaT                 | 10                                                 | 60                                                 |
| Series name         | object         |           3276 |           0 | 0.00%     |             6 | N/A    | N/A      | N/A    | N/A    | N/A    | N/A    | N/A    | N/A        | N/A        | NaT                 | NaT                 | Treasury Bills' Cut-off Yield 3-Months             | Treasury Bills' Weighted Average Yield 12-Months   |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*No pairs found with absolute correlation > 0.8.*


---


## Analysis for: `trade_and_payments.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (185, 80) (rows, columns)
* **Format:** Detected **Tall** (Rows=185 >= Cols=80). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (185, 80) (rows, columns)

* **Original Column Names (80):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', 'Sub-Sectors-Level2', '1947-48', '1948-49', '1949-50', '1950-51', '1951-52', '1952-53', '1953-54', '1954-55', '1955-56', '1956-57', '1957-58', '1958-59', '1959-60', '1960-61', '1961-62', '1962-63', '1963-64', '1964-65', '1965-66', '1966-67', '1967-68', '1968-69', '1969-70', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 14,800
* **Data Types Summary:** {dtype('float64'): 77, dtype('O'): 3}

### Memory Usage (Bytes)

* **Total:** 141,023 Bytes
* **Per Analyzed Column + Index:**
```
Index                   132
Sectors                7563
Sub-Sectors-Level1    12357
Sub-Sectors-Level2     7011
1947-48                1480
1948-49                1480
1949-50                1480
1950-51                1480
1951-52                1480
1952-53                1480
1953-54                1480
1954-55                1480
1955-56                1480
1956-57                1480
1957-58                1480
1958-59                1480
1959-60                1480
1960-61                1480
1961-62                1480
1962-63                1480
1963-64                1480
1964-65                1480
1965-66                1480
1966-67                1480
1967-68                1480
1968-69                1480
1969-70                1480
1970-71                1480
1971-72                1480
1972-73                1480
1973-74                1480
1974-75                1480
1975-76                1480
1976-77                1480
1977-78                1480
1978-79                1480
1979-80                1480
1980-81                1480
1981-82                1480
1982-83                1480
1983-84                1480
1984-85                1480
1985-86                1480
1986-87                1480
1987-88                1480
1988-89                1480
1989-90                1480
1990-91                1480
1991-92                1480
1992-93                1480
1993-94                1480
1994-95                1480
1995-96                1480
1996-97                1480
1997-98                1480
1998-99                1480
1999-00                1480
2000-01                1480
2001-02                1480
2002-03                1480
2003-04                1480
2004-05                1480
2005-06                1480
2006-07                1480
2007-08                1480
2008-09                1480
2009-10                1480
2010-11                1480
2011-12                1480
2012-13                1480
2013-14                1480
2014-15                1480
2015-16                1480
2016-17                1480
2017-18                1480
2018-19                1480
2019-20                1480
2020-21                1480
2021-22                1480
2022-23                1480
2023-24                1480
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 185 entries, 0 to 184
Data columns (total 80 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             32 non-null     object 
 1   Sub-Sectors-Level1  133 non-null    object 
 2   Sub-Sectors-Level2  20 non-null     object 
 3   1947-48             3 non-null      float64
 4   1948-49             10 non-null     float64
 5   1949-50             13 non-null     float64
 6   1950-51             13 non-null     float64
 7   1951-52             13 non-null     float64
 8   1952-53             13 non-null     float64
 9   1953-54             13 non-null     float64
 10  1954-55             13 non-null     float64
 11  1955-56             32 non-null     float64
 12  1956-57             32 non-null     float64
 13  1957-58             48 non-null     float64
 14  1958-59             48 non-null     float64
 15  1959-60             48 non-null     float64
 16  1960-61             48 non-null     float64
 17  1961-62             48 non-null     float64
 18  1962-63             48 non-null     float64
 19  1963-64             48 non-null     float64
 20  1964-65             48 non-null     float64
 21  1965-66             48 non-null     float64
 22  1966-67             48 non-null     float64
 23  1967-68             48 non-null     float64
 24  1968-69             48 non-null     float64
 25  1969-70             64 non-null     float64
 26  1970-71             80 non-null     float64
 27  1971-72             80 non-null     float64
 28  1972-73             115 non-null    float64
 29  1973-74             115 non-null    float64
 30  1974-75             118 non-null    float64
 31  1975-76             118 non-null    float64
 32  1976-77             118 non-null    float64
 33  1977-78             118 non-null    float64
 34  1978-79             118 non-null    float64
 35  1979-80             118 non-null    float64
 36  1980-81             118 non-null    float64
 37  1981-82             119 non-null    float64
 38  1982-83             124 non-null    float64
 39  1983-84             124 non-null    float64
 40  1984-85             124 non-null    float64
 41  1985-86             124 non-null    float64
 42  1986-87             124 non-null    float64
 43  1987-88             124 non-null    float64
 44  1988-89             124 non-null    float64
 45  1989-90             123 non-null    float64
 46  1990-91             127 non-null    float64
 47  1991-92             129 non-null    float64
 48  1992-93             129 non-null    float64
 49  1993-94             129 non-null    float64
 50  1994-95             129 non-null    float64
 51  1995-96             132 non-null    float64
 52  1996-97             132 non-null    float64
 53  1997-98             132 non-null    float64
 54  1998-99             132 non-null    float64
 55  1999-00             132 non-null    float64
 56  2000-01             132 non-null    float64
 57  2001-02             132 non-null    float64
 58  2002-03             172 non-null    float64
 59  2003-04             171 non-null    float64
 60  2004-05             172 non-null    float64
 61  2005-06             171 non-null    float64
 62  2006-07             170 non-null    float64
 63  2007-08             173 non-null    float64
 64  2008-09             173 non-null    float64
 65  2009-10             174 non-null    float64
 66  2010-11             174 non-null    float64
 67  2011-12             174 non-null    float64
 68  2012-13             174 non-null    float64
 69  2013-14             174 non-null    float64
 70  2014-15             174 non-null    float64
 71  2015-16             174 non-null    float64
 72  2016-17             174 non-null    float64
 73  2017-18             174 non-null    float64
 74  2018-19             174 non-null    float64
 75  2019-20             174 non-null    float64
 76  2020-21             174 non-null    float64
 77  2021-22             174 non-null    float64
 78  2022-23             174 non-null    float64
 79  2023-24             173 non-null    float64
dtypes: float64(77), object(3)
memory usage: 115.8+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 6,116 (41.32%)
Columns (80 of 80) with missing values (Sorted):
```
1947-48               182
1948-49               175
1953-54               172
1949-50               172
1950-51               172
1951-52               172
1952-53               172
1954-55               172
Sub-Sectors-Level2    165
1955-56               153
1956-57               153
Sectors               153
1962-63               137
1968-69               137
1967-68               137
1966-67               137
1965-66               137
1963-64               137
1964-65               137
1961-62               137
1960-61               137
1959-60               137
1958-59               137
1957-58               137
1969-70               121
1970-71               105
1971-72               105
1972-73                70
1973-74                70
1977-78                67
1980-81                67
1979-80                67
1978-79                67
1974-75                67
1976-77                67
1975-76                67
1981-82                66
1989-90                62
1986-87                61
1988-89                61
1987-88                61
1984-85                61
1985-86                61
1983-84                61
1982-83                61
1990-91                58
1992-93                56
1993-94                56
1994-95                56
1991-92                56
1995-96                53
1996-97                53
1997-98                53
1998-99                53
1999-00                53
2000-01                53
2001-02                53
Sub-Sectors-Level1     52
2006-07                15
2005-06                14
2003-04                14
2004-05                13
2002-03                13
2008-09                12
2023-24                12
2007-08                12
2009-10                11
2010-11                11
2011-12                11
2012-13                11
2013-14                11
2015-16                11
2016-17                11
2017-18                11
2018-19                11
2019-20                11
2020-21                11
2021-22                11
2022-23                11
2014-15                11
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 80):
```
Sectors                32
Sub-Sectors-Level1    132
Sub-Sectors-Level2     20
1947-48                 3
1948-49                10
1949-50                13
1950-51                13
1951-52                13
1952-53                13
1953-54                13

...

2014-15    165
2015-16    165
2016-17    164
2017-18    163
2018-19    164
2019-20    168
2020-21    165
2021-22    168
2022-23    168
2023-24    163
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 20 of 32 unique values)
```
Sectors
Current Account Balance ($ Million)                              1
Current Account Balance without off. Transfers ($ Million)       1
Worker's Remittances (% Share)                                   1
Worker's Remittances ($ Million)                                 1
Economic Classification of Imports                               1
Economic Classification of Exports                               1
UNIT VALUE INDICES AND TERMS OF TRADE (T.O.T) (1990-91 = 100)    1
Balance in $ (Growth Rate (%))                                   1
Imports in $ (Growth Rate (%))                                   1
Exports in $ (Growth Rate (%))                                   1
Balance ($ Million)                                              1
Imports ($ Million)                                              1
Exports ($ Million)                                              1
Balance (Growth Rate (%))                                        1
Imports (Growth Rate (%))                                        1
Exports (Growth Rate (%))                                        1
Balance (RS Million)                                             1
Imports (RS Million)                                             1
Exports (RS Million)                                             1
Current Acount balance (as % of GDP)                             1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 132 unique values)
```
Sub-Sectors-Level1
Total Value (Rs Million)            2
Exports of Goods FOB ($ Million)    1
Germany (% Share)                   1
Other Countries ($ Million)         1
Encashment * ($ Million)            1
TOTAL ($ Million)                   1
Cash Flow                           1
Bahrain (% Share)                   1
Canada (% Share)                    1
Japan (% Share)                     1
U.K. ($ Million)                    1
Kuwait (% Share)                    1
Norway (% Share)                    1
Qatar (% Share)                     1
Saudi Arabia (% Share)              1
Sultanat-e-Oman (% Share)           1
USA ($ Million)                     1
UAE, Other ($ Million)              1
Consumer Goods, Percentage Share    1
UAE, Sharjah ($ Million)            1
```
**Column: `Sub-Sectors-Level2`** (Top 20 of 20 unique values)
```
Sub-Sectors-Level2
Transportation ($ Million)                                                       1
Travel ($ Million)                                                               1
Amortization Short Term ($ Million)                                              1
Amortization Other Long Term ($ Million)                                         1
Amortization Credit and Loans with the IMF (Other than Reserves) ($ Million)     1
Amortization ($ Million)                                                         1
Disbursements Short Term ($ Million)                                             1
Disbursements Other Long Term ($ Million)                                        1
Disbursements Credit and Loans with the IMF (Other than Reserves) ($ Million)    1
Disbursements ($ Million)                                                        1
General Government ($ Million)                                                   1
Portfolio Investment in Pakistan ($ Million)                                     1
Portfolio Investment Abroad ($ Million)                                          1
Direct Investment in Pakistan ($ Million)                                        1
Direct Investment Abroad ($ Million)                                             1
Capital Account debit ($ Million)                                                1
Capital Account credit ($ Million)                                               1
Workers' Remittances ($ Million)                                                 1
Interest Payments ($ Million)                                                    1
Other Liabilities (Net) ($ Million)                                              1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean       | StdDev      | Min          | 25%      | 50%     | 75%      | Max          | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull                        | LastNonNull                                                                                  |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:-----------|:------------|:-------------|:---------|:--------|:---------|:-------------|:-----------|:-----------|:----------|:----------|:------------------------------------|:---------------------------------------------------------------------------------------------|
| Sectors            | object     |             32 |         153 | 82.70%    |            32 | N/A        | N/A         | N/A          | N/A      | N/A     | N/A      | N/A          | N/A        | N/A        | NaT       | NaT       | Current Account Balance ($ Million) | Exchange Rate Position (Pakistan Rupees in Terms of One Unit of Selected Foreign Currencies) |
| Sub-Sectors-Level1 | object     |            133 |          52 | 28.11%    |           132 | N/A        | N/A         | N/A          | N/A      | N/A     | N/A      | N/A          | N/A        | N/A        | NaT       | NaT       | Exports of Goods FOB ($ Million)    | IMF (SDR, Average During the Year)                                                           |
| Sub-Sectors-Level2 | object     |             20 |         165 | 89.19%    |            20 | N/A        | N/A         | N/A          | N/A      | N/A     | N/A      | N/A          | N/A        | N/A        | NaT       | NaT       | Transportation ($ Million)          | Other Liabilities (Net) ($ Million)                                                          |
| 1947-48            | float64    |              3 |         182 | 98.38%    |             3 | 296.000    | 160.739     | 125.000      | 222.000  | 319.000 | 381.500  | 444.000      | -0.631     | N/A        | NaT       | NaT       | 444.0                               | 125.0                                                                                        |
| 1948-49            | float64    |             10 |         175 | 94.59%    |            10 | 109.544    | 536.959     | -635.000     | -143.750 | 92.985  | 333.868  | 1177.000     | 0.453      | 0.698      | NaT       | NaT       | 1.0                                 | -192.0                                                                                       |
| 1949-50            | float64    |             13 |         172 | 92.97%    |            13 | 97.423     | 323.538     | -377.000     | -40.550  | -1.340  | 161.700  | 912.000      | 1.461      | 2.768      | NaT       | NaT       | 2.0                                 | -40.55                                                                                       |
| 1950-51            | float64    |             13 |         172 | 92.97%    |            13 | 274.288    | 465.496     | -146.680     | 27.940   | 150.830 | 352.600  | 1343.000     | 1.680      | 2.000      | NaT       | NaT       | 4.0                                 | -146.53                                                                                      |
| 1951-52            | float64    |             13 |         172 | 92.97%    |            13 | 206.644    | 553.570     | -552.000     | -31.350  | 26.310  | 593.000  | 1474.000     | 1.036      | 1.040      | NaT       | NaT       | 6.0                                 | -74.91                                                                                       |
| 1952-53            | float64    |             13 |         172 | 92.97%    |            13 | 271.604    | 443.457     | -150.000     | -31.000  | 7.000   | 441.800  | 1095.490     | 1.066      | -0.433     | NaT       | NaT       | 7.0                                 | 1095.49                                                                                      |
| 1953-54            | float64    |             13 |         172 | 92.97%    |            13 | 153.013    | 294.335     | -183.000     | -18.980  | 7.000   | 222.100  | 824.000      | 1.400      | 1.212      | NaT       | NaT       | 7.0                                 | -0.94                                                                                        |
| 1954-55            | float64    |             13 |         172 | 92.97%    |            13 | 110.187    | 274.325     | -292.000     | -23.400  | 7.000   | 205.000  | 783.000      | 1.353      | 2.278      | NaT       | NaT       | 7.0                                 | -65.9                                                                                        |
| 1955-56            | float64    |             32 |         153 | 82.70%    |            32 | 148.373    | 209.388     | -223.000     | 65.695   | 117.095 | 147.260  | 965.000      | 2.612      | 8.764      | NaT       | NaT       | 2.0                                 | 116.62                                                                                       |
| 1956-57            | float64    |             32 |         153 | 82.70%    |            32 | 149.364    | 331.377     | -818.000     | 59.927   | 122.815 | 179.260  | 1516.000     | 1.696      | 11.180     | NaT       | NaT       | 5.0                                 | 112.34                                                                                       |
| 1957-58            | float64    |             48 |         137 | 74.05%    |            48 | -1.078     | 691.030     | -4358.060    | 1.227    | 21.038  | 148.618  | 1314.000     | -5.439     | 35.395     | NaT       | NaT       | 6.0                                 | 4.7619                                                                                       |
| 1958-59            | float64    |             48 |         137 | 74.05%    |            48 | 79.736     | 197.242     | -581.000     | 1.049    | 13.348  | 129.300  | 1025.000     | 1.789      | 13.005     | NaT       | NaT       | 2.0                                 | 4.7619                                                                                       |
| 1959-60            | float64    |             48 |         137 | 74.05%    |            48 | 111.065    | 331.891     | -1043.000    | 2.734    | 72.640  | 145.305  | 1806.000     | 2.225      | 17.214     | NaT       | NaT       | 3.0                                 | 4.7619                                                                                       |
| 1960-61            | float64    |             48 |         137 | 74.05%    |            48 | 98.396     | 421.242     | -1633.000    | 1.558    | 48.995  | 137.998  | 2173.000     | 1.178      | 18.057     | NaT       | NaT       | 5.0                                 | 4.7619                                                                                       |
| 1961-62            | float64    |             48 |         137 | 74.05%    |            48 | 94.143     | 432.376     | -1693.000    | 1.441    | 13.348  | 143.088  | 2236.000     | 1.196      | 18.526     | NaT       | NaT       | 2.0                                 | 4.7619                                                                                       |
| 1962-63            | float64    |             48 |         137 | 74.05%    |            48 | 118.840    | 521.167     | -1802.000    | 1.843    | 38.820  | 148.355  | 2800.000     | 2.056      | 18.480     | NaT       | NaT       | -1.0                                | 4.7619                                                                                       |
| 1963-64            | float64    |             48 |         137 | 74.05%    |            48 | 120.990    | 558.569     | -1907.000    | 2.217    | 25.790  | 141.933  | 2982.000     | 2.077      | 17.983     | NaT       | NaT       | 3.0                                 | 4.7619                                                                                       |
| 1964-65            | float64    |             48 |         137 | 74.05%    |            48 | 124.685    | 695.367     | -2532.000    | 3.804    | 38.100  | 131.207  | 3672.000     | 1.819      | 18.572     | NaT       | NaT       | 37.0                                | 4.7619                                                                                       |
| 1965-66            | float64    |             48 |         137 | 74.05%    |            48 | 112.555    | 533.370     | -1676.000    | 0.982    | 9.240   | 112.400  | 2880.000     | 2.519      | 17.931     | NaT       | NaT       | 4.0                                 | 4.7619                                                                                       |
| 1966-67            | float64    |             48 |         137 | 74.05%    |            48 | 125.045    | 676.801     | -2329.000    | 1.558    | 32.430  | 110.975  | 3626.000     | 2.184      | 18.626     | NaT       | NaT       | 50.0                                | 4.7619                                                                                       |
| 1967-68            | float64    |             48 |         137 | 74.05%    |            48 | 136.869    | 609.103     | -1682.000    | 0.858    | 9.905   | 108.975  | 3327.000     | 2.992      | 17.930     | NaT       | NaT       | -1.0                                | 4.7619                                                                                       |
| 1968-69            | float64    |             48 |         137 | 74.05%    |            48 | 142.308    | 563.185     | -1347.000    | 1.083    | 9.850   | 108.525  | 3047.000     | 3.188      | 16.687     | NaT       | NaT       | 59.0                                | 4.7619                                                                                       |
| 1969-70            | float64    |             64 |         121 | 65.41%    |            61 | 260.828    | 713.028     | -1676.000    | 3.567    | 47.000  | 148.305  | 3285.000     | 2.526      | 9.874      | NaT       | NaT       | 72.0                                | 4.7619                                                                                       |
| 1970-71            | float64    |             80 |         105 | 56.76%    |            77 | 265.901    | 722.993     | -1604.000    | 4.745    | 83.820  | 120.228  | 3602.000     | 2.852      | 11.236     | NaT       | NaT       | 683.0                               | 4.7619                                                                                       |
| 1971-72            | float64    |             80 |         105 | 56.76%    |            78 | 334.353    | 785.984     | -329.000     | 3.470    | 72.210  | 157.623  | 3495.000     | 3.243      | 10.288     | NaT       | NaT       | 625.0                               | 5.8326                                                                                       |
| 1972-73            | float64    |            115 |          70 | 37.84%    |           103 | 522.426    | 1619.973    | -223.390     | 2.481    | 30.000  | 239.065  | 8551.000     | 4.303      | 18.542     | NaT       | NaT       | 766.0                               | 11.9264                                                                                      |
| 1973-74            | float64    |            115 |          70 | 37.84%    |           106 | 667.936    | 2375.003    | -3318.000    | 2.753    | 24.000  | 302.825  | 13479.000    | 4.003      | 17.681     | NaT       | NaT       | 1020.0                              | 11.9429                                                                                      |
| 1974-75            | float64    |            118 |          67 | 36.22%    |           112 | 849.974    | 3347.078    | -10639.000   | 4.567    | 26.135  | 391.772  | 20925.000    | 3.942      | 22.913     | NaT       | NaT       | 978.0                               | 12.0943                                                                                      |
| 1975-76            | float64    |            118 |          67 | 36.22%    |           110 | 882.148    | 3312.656    | -9212.000    | 5.128    | 25.575  | 385.230  | 20465.000    | 4.036      | 21.724     | NaT       | NaT       | 1162.0                              | 11.5925                                                                                      |
| 1976-77            | float64    |            118 |          67 | 36.22%    |           113 | 864.849    | 3703.910    | -11718.000   | 6.123    | 31.771  | 116.750  | 23012.000    | 3.958      | 22.690     | NaT       | NaT       | 1132.0                              | 11.4399                                                                                      |
| 1977-78            | float64    |            118 |          67 | 36.22%    |           111 | 1033.587   | 4452.451    | -14835.000   | 6.768    | 41.785  | 119.340  | 27815.000    | 3.899      | 23.233     | NaT       | NaT       | 1497.0                              | 11.8781                                                                                      |
| 1978-79            | float64    |            118 |          67 | 36.22%    |           112 | 1335.245   | 5823.922    | -19463.000   | 6.383    | 42.555  | 139.220  | 36388.000    | 3.909      | 23.332     | NaT       | NaT       | 1644.0                              | 12.6892                                                                                      |
| 1979-80            | float64    |            118 |          67 | 36.22%    |           110 | 1771.521   | 7572.901    | -23519.000   | 6.431    | 48.400  | 155.735  | 46929.000    | 3.967      | 22.448     | NaT       | NaT       | 2341.0                              | 12.8824                                                                                      |
| 1980-81            | float64    |            118 |          67 | 36.22%    |           111 | 2115.314   | 8761.565    | -24264.000   | 6.248    | 54.570  | 180.157  | 53544.000    | 4.043      | 21.343     | NaT       | NaT       | 2799.0                              | 12.4504                                                                                      |
| 1981-82            | float64    |            119 |          66 | 35.68%    |           116 | 2070.385   | 9509.637    | -33212.000   | 5.215    | 52.000  | 110.845  | 59482.000    | 3.875      | 23.689     | NaT       | NaT       | 2316.0                              | 11.9888                                                                                      |
| 1982-83            | float64    |            124 |          61 | 32.97%    |           120 | 2421.717   | 10807.471   | -33709.000   | 4.985    | 47.900  | 123.010  | 68151.000    | 4.104      | 23.378     | NaT       | NaT       | 2627.0                              | 13.7574                                                                                      |
| 1983-84            | float64    |            124 |          61 | 32.97%    |           118 | 2651.439   | 12118.968   | -39368.000   | 5.798    | 48.000  | 123.605  | 76707.000    | 4.076      | 23.806     | NaT       | NaT       | 2665.0                              | 14.154                                                                                       |
| 1984-85            | float64    |            124 |          61 | 32.97%    |           120 | 2867.320   | 14018.950   | -51799.000   | 4.895    | 48.094  | 129.500  | 89778.000    | 3.949      | 25.417     | NaT       | NaT       | 2458.0                              | 15.0198                                                                                      |
| 1985-86            | float64    |            124 |          61 | 32.97%    |           120 | 3282.651   | 14437.006   | -41354.000   | 4.855    | 47.405  | 144.093  | 90946.000    | 4.204      | 23.172     | NaT       | NaT       | 2943.0                              | 17.719                                                                                       |
| 1986-87            | float64    |            124 |          61 | 32.97%    |           120 | 3759.666   | 15261.401   | -29076.000   | 4.620    | 41.205  | 137.123  | 92431.000    | 4.345      | 20.972     | NaT       | NaT       | 3488.0                              | 21.3056                                                                                      |
| 1987-88            | float64    |            124 |          61 | 32.97%    |           121 | 4592.774   | 18700.892   | -34106.000   | 6.298    | 35.875  | 162.472  | 112551.000   | 4.345      | 20.697     | NaT       | NaT       | 4361.0                              | 23.5047                                                                                      |
| 1988-89            | float64    |            124 |          61 | 32.97%    |           121 | 5350.338   | 22242.730   | -45658.000   | 5.658    | 35.145  | 168.757  | 135841.000   | 4.347      | 21.406     | NaT       | NaT       | 4628.0                              | 25.0111                                                                                      |
| 1989-90            | float64    |            123 |          62 | 33.51%    |           120 | 6148.579   | 24961.970   | -42384.000   | 5.751    | 35.840  | 190.120  | 148853.000   | 4.346      | 20.408     | NaT       | NaT       | 4924.0                              | 27.6604                                                                                      |
| 1990-91            | float64    |            127 |          58 | 31.35%    |           124 | 7315.976   | 29433.903   | -32832.000   | 5.221    | 32.620  | 193.640  | 171114.000   | 4.432      | 20.061     | NaT       | NaT       | 5894.0                              | 31.0517                                                                                      |
| 1991-92            | float64    |            129 |          56 | 30.27%    |           124 | 9146.194   | 38399.118   | -58161.000   | 6.644    | 38.000  | 119.040  | 229889.000   | 4.448      | 20.813     | NaT       | NaT       | 6762.0                              | 34.1379                                                                                      |
| 1992-93            | float64    |            129 |          56 | 30.27%    |           125 | 9744.161   | 42349.637   | -81615.000   | 4.306    | 35.622  | 125.640  | 258643.000   | 4.411      | 21.351     | NaT       | NaT       | 6782.0                              | 35.6217                                                                                      |
| 1993-94            | float64    |            129 |          56 | 30.27%    |           125 | 10633.991  | 44244.898   | -52751.000   | 3.801    | 30.164  | 139.750  | 258250.000   | 4.437      | 20.045     | NaT       | NaT       | 6685.0                              | 42.2162                                                                                      |
| 1994-95            | float64    |            129 |          56 | 30.27%    |           126 | 13074.366  | 54669.281   | -69719.000   | 5.253    | 35.000  | 155.040  | 320892.000   | 4.435      | 20.159     | NaT       | NaT       | 7759.0                              | 46.1616                                                                                      |
| 1995-96            | float64    |            132 |          53 | 28.65%    |           129 | 15209.103  | 65736.230   | -102834.000  | 5.508    | 35.475  | 182.233  | 397575.000   | 4.498      | 21.306     | NaT       | NaT       | -4575.0                             | 49.6416                                                                                      |
| 1996-97            | float64    |            132 |          53 | 28.65%    |           128 | 17140.466  | 75951.017   | -139688.000  | 4.925    | 36.420  | 195.542  | 465001.000   | 4.468      | 21.573     | NaT       | NaT       | -3846.0                             | 55.24769                                                                                     |
| 1997-98            | float64    |            132 |          53 | 28.65%    |           129 | 18199.721  | 76112.413   | -63178.000   | 4.155    | 33.155  | 210.160  | 436338.000   | 4.508      | 20.183     | NaT       | NaT       | -1921.0                             | 58.465441                                                                                    |
| 1998-99            | float64    |            132 |          53 | 28.65%    |           129 | 19144.061  | 80804.610   | -75622.000   | 5.252    | 31.781  | 222.210  | 465964.000   | 4.500      | 20.171     | NaT       | NaT       | -2429.0                             | 63.685                                                                                       |
| 1999-00            | float64    |            132 |          53 | 28.65%    |           129 | 21821.991  | 92845.345   | -90114.000   | 6.059    | 32.565  | 230.998  | 533792.000   | 4.490      | 19.968     | NaT       | NaT       | -1143.0                             | 70.1077                                                                                      |
| 2000-01            | float64    |            132 |          53 | 28.65%    |           129 | 26159.527  | 110586.751  | -87930.000   | 5.888    | 33.635  | 256.493  | 627000.000   | 4.491      | 19.777     | NaT       | NaT       | -513.0                              | 74.776                                                                                       |
| 2001-02            | float64    |            132 |          53 | 28.65%    |           126 | 27033.725  | 113551.911  | -73683.000   | 4.270    | 39.376  | 284.692  | 634630.000   | 4.483      | 19.528     | NaT       | NaT       | 1338.0                              | 78.0627                                                                                      |
| 2002-03            | float64    |            172 |          13 | 7.03%     |           163 | 24203.530  | 114603.118  | -62078.000   | 5.167    | 71.730  | 580.842  | 714372.000   | 5.180      | 26.381     | NaT       | NaT       | 4070.0                              | 79.3198                                                                                      |
| 2003-04            | float64    |            171 |          14 | 7.57%     |           165 | 27731.474  | 136077.067  | -188789.000  | 6.115    | 80.550  | 434.745  | 897825.000   | 5.146      | 27.035     | NaT       | NaT       | 1811.4                              | 83.247                                                                                       |
| 2004-05            | float64    |            172 |          13 | 7.03%     |           165 | 34712.915  | 177453.088  | -368991.000  | 2.692    | 62.679  | 454.567  | 1223079.000  | 5.145      | 28.634     | NaT       | NaT       | -1534.0                             | 88.5631                                                                                      |
| 2005-06            | float64    |            171 |          14 | 7.57%     |           166 | 43619.494  | 238299.182  | -726317.000  | 4.300    | 72.866  | 539.190  | 1711158.000  | 5.031      | 31.068     | NaT       | NaT       | -4990.0                             | 86.959                                                                                       |
| 2006-07            | float64    |            170 |          15 | 8.11%     |           163 | 46599.344  | 257373.691  | -822494.000  | 3.802    | 75.530  | 634.720  | 1851806.000  | 4.988      | 31.300     | NaT       | NaT       | -6878.0                             | 90.773                                                                                       |
| 2007-08            | float64    |            173 |          12 | 6.49%     |           167 | 57154.628  | 340130.567  | -1315434.000 | 3.620    | 73.330  | 695.450  | 2512072.000  | 4.914      | 34.207     | NaT       | NaT       | -13874.0                            | 98.627                                                                                       |
| 2008-09            | float64    |            173 |          12 | 6.49%     |           168 | 64172.015  | 369434.394  | -1339852.000 | 4.200    | 79.070  | 884.260  | 2723570.000  | 4.991      | 33.718     | NaT       | NaT       | -9260.5                             | 119.96                                                                                       |
| 2009-10            | float64    |            174 |          11 | 5.95%     |           169 | 71584.905  | 399041.827  | -1293517.000 | 4.625    | 79.222  | 964.972  | 2910975.000  | 5.087      | 32.557     | NaT       | NaT       | -3946.43                            | 129.743                                                                                      |
| 2010-11            | float64    |            174 |          11 | 5.95%     |           165 | 89723.898  | 481024.313  | -1334440.000 | 4.540    | 85.487  | 1154.243 | 3455287.000  | 5.170      | 31.355     | NaT       | NaT       | 214.0                               | 133.341                                                                                      |
| 2011-12            | float64    |            174 |          11 | 5.95%     |           164 | 95678.724  | 547895.444  | -1898488.000 | 2.480    | 80.140  | 1238.590 | 4009093.000  | 5.052      | 33.166     | NaT       | NaT       | -4658.0                             | 138.941                                                                                      |
| 2012-13            | float64    |            174 |          11 | 5.95%     |           166 | 105567.852 | 594201.393  | -1983402.000 | 2.898    | 95.075  | 1229.000 | 4349880.000  | 5.088      | 33.043     | NaT       | NaT       | -2496.0                             | 147.226                                                                                      |
| 2013-14            | float64    |            174 |          11 | 5.95%     |           165 | 113915.996 | 634457.394  | -2047058.000 | 2.025    | 91.412  | 1595.007 | 4630521.000  | 5.106      | 32.697     | NaT       | NaT       | -3130.0                             | 158.004                                                                                      |
| 2014-15            | float64    |            174 |          11 | 5.95%     |           165 | 109901.242 | 626032.704  | -2246639.000 | 1.950    | 88.367  | 1677.162 | 4644152.000  | 5.049      | 34.272     | NaT       | NaT       | -2815.0                             | 146.955                                                                                      |
| 2015-16            | float64    |            174 |          11 | 5.95%     |           165 | 104716.800 | 619614.148  | -2491903.000 | 4.575    | 96.945  | 1813.848 | 4658749.000  | 4.931      | 35.939     | NaT       | NaT       | -4961.0                             | 145.878                                                                                      |
| 2016-17            | float64    |            174 |          11 | 5.95%     |           164 | 113968.243 | 729389.063  | -3401535.000 | 3.900    | 90.085  | 1756.995 | 5539721.000  | 4.683      | 38.249     | NaT       | NaT       | -12270.0                            | 143.813                                                                                      |
| 2017-18            | float64    |            174 |          11 | 5.95%     |           163 | 136607.773 | 881215.089  | -4139854.000 | 4.178    | 91.285  | 1894.992 | 6694897.000  | 4.678      | 38.451     | NaT       | NaT       | -19195.0                            | 156.785                                                                                      |
| 2018-19            | float64    |            174 |          11 | 5.95%     |           164 | 158629.921 | 984299.278  | -4315023.000 | 1.665    | 99.858  | 1557.845 | 7443253.000  | 4.810      | 37.240     | NaT       | NaT       | -13434.0                            | 189.563                                                                                      |
| 2019-20            | float64    |            174 |          11 | 5.95%     |           168 | 159827.776 | 937862.039  | -3660037.000 | 3.050    | 108.655 | 1709.872 | 7029819.000  | 4.968      | 35.506     | NaT       | NaT       | -4449.0                             | 217.295                                                                                      |
| 2020-21            | float64    |            174 |          11 | 5.95%     |           165 | 197999.695 | 1194014.263 | -4940514.000 | 7.105    | 122.049 | 1812.000 | 8982441.000  | 4.884      | 36.185     | NaT       | NaT       | -2820.0                             | 228.283                                                                                      |
| 2021-22            | float64    |            174 |          11 | 5.95%     |           168 | 295852.530 | 1886727.465 | -8612266.552 | 5.736    | 121.115 | 2238.378 | 14273394.000 | 4.724      | 37.698     | NaT       | NaT       | -17481.0                            | 246.993                                                                                      |
| 2022-23            | float64    |            174 |          11 | 5.95%     |           168 | 211954.905 | 1195653.762 | -3793038.000 | 2.549    | 126.590 | 1984.027 | 10195090.000 | 5.391      | 37.446     | NaT       | NaT       | -3372.0                             | 310.479                                                                                      |
| 2023-24            | float64    |            173 |          12 | 6.49%     |           163 | 283346.889 | 1564175.643 | -4832218.000 | 4.200    | 136.000 | 2198.170 | 11344676.000 | 5.116      | 32.177     | NaT       | NaT       | -508.0                              | 378.123                                                                                      |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 2628 pairs with absolute correlation > 0.8 (showing top 50):*
```
1982-83  1983-84    0.999775
2012-13  2013-14    0.999772
1997-98  1998-99    0.999734
1999-00  2000-01    0.999710
2005-06  2006-07    0.999705
1976-77  1979-80    0.999626
1993-94  1994-95    0.999587
2011-12  2012-13    0.999550
2016-17  2017-18    0.999539
1986-87  1987-88    0.999529
2015-16  2019-20    0.999525
2019-20  2020-21    0.999507
2000-01  2001-02    0.999473
1977-78  1978-79    0.999405
2015-16  2020-21    0.999346
2009-10  2013-14    0.999329
2001-02  2002-03    0.999309
2008-09  2014-15    0.999277
2009-10  2012-13    0.999277
1986-87  1988-89    0.999272
2018-19  2020-21    0.999171
         2021-22    0.999163
2007-08  2008-09    0.999116
2011-12  2013-14    0.999060
1967-68  1969-70    0.998982
1998-99  1999-00    0.998972
1994-95  1995-96    0.998960
1987-88  1988-89    0.998918
1995-96  1996-97    0.998910
1962-63  1963-64    0.998876
1999-00  2001-02    0.998841
1981-82  1984-85    0.998804
2012-13  2014-15    0.998785
2017-18  2018-19    0.998785
2008-09  2009-10    0.998746
1992-93  1996-97    0.998724
1990-91  1994-95    0.998704
1977-78  1979-80    0.998657
1986-87  1989-90    0.998644
2009-10  2011-12    0.998627
1976-77  1977-78    0.998608
2014-15  2019-20    0.998577
1991-92  1995-96    0.998559
1987-88  1989-90    0.998511
2013-14  2014-15    0.998475
2010-11  2013-14    0.998471
1998-99  2000-01    0.998465
2009-10  2014-15    0.998442
2015-16  2018-19    0.998317
2008-09  2019-20    0.998300
```


---


## Analysis for: `trade_partner_inflations.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (12, 52) (rows, columns)
* **Format:** Detected **Wide** (Cols=52 > Rows=12). Transposing.
* Using original column `Inflation rate, average consumer prices (Annual percent change)` as index for transposition.
* **Transposition Successful.**
* Transposed index converted to: int64 (likely years)
* Attempting conversion of data to numeric...
* Data conversion to numeric attempted.
* **Shape Analyzed:** (51, 12) (rows, columns)

* **Original Column Names (52):**
  ```
  ['Inflation rate, average consumer prices (Annual percent change)', '1980', '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030']
  ```

* **Analyzed Column Names (12):**
  ```
  ['Afghanistan', 'Bangladesh', "China, People's Republic of", 'Germany', 'Italy', 'Netherlands', 'Pakistan', 'Spain', 'United Arab Emirates', 'United Kingdom', 'United States', 'World']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 612
* **Data Types Summary:** {dtype('float64'): 12}

### Memory Usage (Bytes)

* **Total:** 7,408 Bytes
* **Per Analyzed Column + Index:**
```
Index                          2512
Afghanistan                     408
Bangladesh                      408
China, People's Republic of     408
Germany                         408
Italy                           408
Netherlands                     408
Pakistan                        408
Spain                           408
United Arab Emirates            408
United Kingdom                  408
United States                   408
World                           408
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
Index: 51 entries, 1980 to 2030
Data columns (total 12 columns):
 #   Column                       Non-Null Count  Dtype  
---  ------                       --------------  -----  
 0   Afghanistan                  21 non-null     float64
 1   Bangladesh                   51 non-null     float64
 2   China, People's Republic of  50 non-null     float64
 3   Germany                      51 non-null     float64
 4   Italy                        51 non-null     float64
 5   Netherlands                  50 non-null     float64
 6   Pakistan                     51 non-null     float64
 7   Spain                        51 non-null     float64
 8   United Arab Emirates         51 non-null     float64
 9   United Kingdom               51 non-null     float64
 10  United States                51 non-null     float64
 11  World                        51 non-null     float64
dtypes: float64(12)
memory usage: 7.2 KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 32 (5.23%)
Columns (3 of 12) with missing values (Sorted):
```
Inflation rate, average consumer prices (Annual percent change)
Afghanistan                    30
China, People's Republic of     1
Netherlands                     1
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 12):
```
Inflation rate, average consumer prices (Annual percent change)
Afghanistan                    20
Bangladesh                     38
China, People's Republic of    38
Germany                        31
Italy                          38
Netherlands                    33
Pakistan                       42
Spain                          35
United Arab Emirates           37
United Kingdom                 35
United States                  33
World                          38
```


### Analyzed Column Summary Table (Stats per Column: Transposed Columns (Original First Col as Index))

```markdown
| Inflation rate, average consumer prices (Annual percent change)   | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount |   Mean |   StdDev |   Min |   25% |   50% |    75% |   Max |   Skewness |   Kurtosis | MinDate   | MaxDate   |   FirstNonNull |   LastNonNull |
|:------------------------------------------------------------------|:-----------|---------------:|------------:|:----------|--------------:|-------:|---------:|------:|------:|------:|-------:|------:|-----------:|-----------:|:----------|:----------|---------------:|--------------:|
| Afghanistan                                                       | float64    |             21 |          30 | 58.82%    |            20 |  7.533 |    9.761 |  -7.7 |  2.3  |  6.4  | 10.6   |  35.7 |      1.316 |      2.947 | NaT       | NaT       |           35.7 |          -7.7 |
| Bangladesh                                                        | float64    |             51 |           0 | 0.00%     |            38 |  7.306 |    2.729 |   1.8 |  5.6  |  6.8  |  9.25  |  14.9 |      0.359 |      0.296 | NaT       | NaT       |            7.7 |           5.6 |
| China, People's Republic of                                       | float64    |             50 |           1 | 1.96%     |            38 |  4.1   |    5.448 |  -1.4 |  1.4  |  2.05 |  4.575 |  24.3 |      2.17  |      4.514 | NaT       | NaT       |            2.5 |           2   |
| Germany                                                           | float64    |             51 |           0 | 0.00%     |            31 |  2.302 |    1.724 |  -0.1 |  1.3  |  1.9  |  2.7   |   8.7 |      1.6   |      3.215 | NaT       | NaT       |            5.4 |           2.2 |
| Italy                                                             | float64    |             51 |           0 | 0.00%     |            38 |  4.314 |    4.757 |  -0.1 |  1.75 |  2.3  |  5.25  |  21.8 |      2.224 |      4.98  | NaT       | NaT       |           21.8 |           2   |
| Netherlands                                                       | float64    |             50 |           1 | 1.96%     |            33 |  2.326 |    1.938 |  -1   |  1.4  |  2    |  2.8   |  11.6 |      2.534 |     10.349 | NaT       | NaT       |            6.8 |           2   |
| Pakistan                                                          | float64    |             51 |           0 | 0.00%     |            42 |  8.684 |    4.963 |   2.9 |  5.35 |  7.8  | 10.9   |  29.2 |      2.072 |      5.983 | NaT       | NaT       |           11.9 |           6.5 |
| Spain                                                             | float64    |             51 |           0 | 0.00%     |            35 |  4.261 |    3.838 |  -0.6 |  2    |  3.1  |  5     |  15.6 |      1.481 |      1.857 | NaT       | NaT       |           15.6 |           2   |
| United Arab Emirates                                              | float64    |             51 |           0 | 0.00%     |            37 |  3.312 |    3.17  |  -4.7 |  1.65 |  2.8  |  5     |  12.3 |      0.656 |      1.427 | NaT       | NaT       |           10.1 |           2   |
| United Kingdom                                                    | float64    |             51 |           0 | 0.00%     |            35 |  3.516 |    3.044 |   0   |  1.9  |  2.5  |  4.3   |  16.8 |      2.402 |      7.205 | NaT       | NaT       |           16.8 |           2   |
| United States                                                     | float64    |             51 |           0 | 0.00%     |            33 |  3.22  |    2.29  |  -0.3 |  2.1  |  2.8  |  3.55  |  13.5 |      2.577 |      8.947 | NaT       | NaT       |           13.5 |           2.2 |
| World                                                             | float64    |             51 |           0 | 0.00%     |            38 |  9.38  |    8.997 |   2.6 |  3.6  |  4.9  | 13.85  |  39.8 |      1.953 |      3.736 | NaT       | NaT       |           17.3 |           3.2 |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 6 pairs with absolute correlation > 0.8 (showing top 50):*
```
Inflation rate, average consumer prices (Annual percent change)  Inflation rate, average consumer prices (Annual percent change)
Italy                                                            Spain                                                              0.961932
United Kingdom                                                   United States                                                      0.915461
Italy                                                            United Kingdom                                                     0.882629
                                                                 United States                                                      0.842578
Spain                                                            United Kingdom                                                     0.818006
Germany                                                          Netherlands                                                        0.814125
```


---


## Analysis for: `transport_and_communications.csv`

### Processing Notes & Columns

* **Original Shape (after header detection & cleaning):** (117, 61) (rows, columns)
* **Format:** Detected **Tall** (Rows=117 >= Cols=61). Analyzing original format.
* Applying generic type conversion...
* No significant type conversions applied.
* **Shape Analyzed:** (117, 61) (rows, columns)

* **Original Column Names (61):**
  ```
  ['Sectors', 'Sub-Sectors-Level1', '1965-66', '1966-67', '1967-68', '1968-69', '1969-70', '1970-71', '1971-72', '1972-73', '1973-74', '1974-75', '1975-76', '1976-77', '1977-78', '1978-79', '1979-80', '1980-81', '1981-82', '1982-83', '1983-84', '1984-85', '1985-86', '1986-87', '1987-88', '1988-89', '1989-90', '1990-91', '1991-92', '1992-93', '1993-94', '1994-95', '1995-96', '1996-97', '1997-98', '1998-99', '1999-00', '2000-01', '2001-02', '2002-03', '2003-04', '2004-05', '2005-06', '2006-07', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17', '2017-18', '2018-19', '2019-20', '2020-21', '2021-22', '2022-23', '2023-24']
  ```

### Basic Information (Analyzed Data)

* **Total Cells:** 7,137
* **Data Types Summary:** {dtype('float64'): 59, dtype('O'): 2}

### Memory Usage (Bytes)

* **Total:** 67,909 Bytes
* **Per Analyzed Column + Index:**
```
Index                  132
Sectors               4288
Sub-Sectors-Level1    8265
1965-66                936
1966-67                936
1967-68                936
1968-69                936
1969-70                936
1970-71                936
1971-72                936
1972-73                936
1973-74                936
1974-75                936
1975-76                936
1976-77                936
1977-78                936
1978-79                936
1979-80                936
1980-81                936
1981-82                936
1982-83                936
1983-84                936
1984-85                936
1985-86                936
1986-87                936
1987-88                936
1988-89                936
1989-90                936
1990-91                936
1991-92                936
1992-93                936
1993-94                936
1994-95                936
1995-96                936
1996-97                936
1997-98                936
1998-99                936
1999-00                936
2000-01                936
2001-02                936
2002-03                936
2003-04                936
2004-05                936
2005-06                936
2006-07                936
2007-08                936
2008-09                936
2009-10                936
2010-11                936
2011-12                936
2012-13                936
2013-14                936
2014-15                936
2015-16                936
2016-17                936
2017-18                936
2018-19                936
2019-20                936
2020-21                936
2021-22                936
2022-23                936
2023-24                936
```


### DataFrame Info Summary (Analyzed Data)

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 117 entries, 0 to 116
Data columns (total 61 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Sectors             12 non-null     object 
 1   Sub-Sectors-Level1  105 non-null    object 
 2   1965-66             28 non-null     float64
 3   1966-67             49 non-null     float64
 4   1967-68             49 non-null     float64
 5   1968-69             49 non-null     float64
 6   1969-70             49 non-null     float64
 7   1970-71             49 non-null     float64
 8   1971-72             51 non-null     float64
 9   1972-73             51 non-null     float64
 10  1973-74             51 non-null     float64
 11  1974-75             73 non-null     float64
 12  1975-76             74 non-null     float64
 13  1976-77             73 non-null     float64
 14  1977-78             73 non-null     float64
 15  1978-79             73 non-null     float64
 16  1979-80             74 non-null     float64
 17  1980-81             73 non-null     float64
 18  1981-82             76 non-null     float64
 19  1982-83             83 non-null     float64
 20  1983-84             83 non-null     float64
 21  1984-85             82 non-null     float64
 22  1985-86             83 non-null     float64
 23  1986-87             80 non-null     float64
 24  1987-88             81 non-null     float64
 25  1988-89             80 non-null     float64
 26  1989-90             81 non-null     float64
 27  1990-91             80 non-null     float64
 28  1991-92             87 non-null     float64
 29  1992-93             82 non-null     float64
 30  1993-94             85 non-null     float64
 31  1994-95             83 non-null     float64
 32  1995-96             80 non-null     float64
 33  1996-97             84 non-null     float64
 34  1997-98             83 non-null     float64
 35  1998-99             83 non-null     float64
 36  1999-00             87 non-null     float64
 37  2000-01             88 non-null     float64
 38  2001-02             87 non-null     float64
 39  2002-03             88 non-null     float64
 40  2003-04             88 non-null     float64
 41  2004-05             88 non-null     float64
 42  2005-06             89 non-null     float64
 43  2006-07             90 non-null     float64
 44  2007-08             89 non-null     float64
 45  2008-09             89 non-null     float64
 46  2009-10             88 non-null     float64
 47  2010-11             88 non-null     float64
 48  2011-12             89 non-null     float64
 49  2012-13             84 non-null     float64
 50  2013-14             88 non-null     float64
 51  2014-15             89 non-null     float64
 52  2015-16             92 non-null     float64
 53  2016-17             90 non-null     float64
 54  2017-18             90 non-null     float64
 55  2018-19             86 non-null     float64
 56  2019-20             86 non-null     float64
 57  2020-21             96 non-null     float64
 58  2021-22             94 non-null     float64
 59  2022-23             92 non-null     float64
 60  2023-24             91 non-null     float64
dtypes: float64(59), object(2)
memory usage: 55.9+ KB

```


### Missing Values Summary (per Analyzed Column)

Total missing values: 2,379 (33.33%)
Columns (61 of 61) with missing values (Sorted):
```
Sectors               105
1965-66                89
1966-67                68
1967-68                68
1968-69                68
1969-70                68
1970-71                68
1971-72                66
1972-73                66
1973-74                66
1976-77                44
1978-79                44
1977-78                44
1980-81                44
1974-75                44
1975-76                43
1979-80                43
1981-82                41
1986-87                37
1995-96                37
1990-91                37
1988-89                37
1989-90                36
1987-88                36
1984-85                35
1992-93                35
1985-86                34
1983-84                34
1982-83                34
1998-99                34
1994-95                34
1997-98                34
2012-13                33
1996-97                33
1993-94                32
2019-20                31
2018-19                31
1991-92                30
2001-02                30
1999-00                30
2000-01                29
2002-03                29
2003-04                29
2004-05                29
2013-14                29
2009-10                29
2010-11                29
2011-12                28
2014-15                28
2008-09                28
2007-08                28
2005-06                28
2006-07                27
2016-17                27
2017-18                27
2023-24                26
2015-16                25
2022-23                25
2021-22                23
2020-21                21
Sub-Sectors-Level1     12
```


### Unique Values per Analyzed Column (Sample)

Showing unique counts for first/last 10 analyzed columns (Total columns: 61):
```
Sectors                12
Sub-Sectors-Level1    100
1965-66                27
1966-67                48
1967-68                47
1968-69                48
1969-70                48
1970-71                48
1971-72                49
1972-73                50

...

2014-15    87
2015-16    89
2016-17    89
2017-18    88
2018-19    85
2019-20    85
2020-21    93
2021-22    93
2022-23    91
2023-24    90
```


### Value Counts for Categorical/Object Columns (Top 20)

*Showing top 20 values for up to 50 columns.*

**Column: `Sectors`** (Top 12 of 12 unique values)
```
Sectors
Transport (Roads)                                          1
Railways                                                   1
Pakistan National Shipping Corporation (PNSC)              1
PORTS-Cargo Handled                                        1
Pakistan International Airlines Corporation-Operational    1
Pakistan International Airlines Corporation-Revenue        1
Motor Vehicles Registered                                  1
Motor Vehicles on Road-HCV                                 1
Motor Vehicles on Road-LCV                                 1
Motor Vehicles-Production                                  1
Motor Vehicles-Imports                                     1
Pakistan Post Offices                                      1
```
**Column: `Sub-Sectors-Level1`** (Top 20 of 100 unique values)
```
Sub-Sectors-Level1
Route (KM)                                2
Trucks (Numbers)                          2
Buses (Numbers)                           2
Gross Earnings (Rs. Million)              2
Cars (Numbers)                            2
Motor Cycle/Rickshaw (Numbers)            1
Rickshaw chassis with Engine (Numbers)    1
Motor Rickshaw (Numbers)                  1
Motor Cycles (Numbers)                    1
Motorised Cycles (Numbers)                1
Bicycle (Numbers)                         1
Tractors (Numbers)                        1
L.C.Vs (Numbers)                          1
Jeeps 4 x 4 Vehicles (Numbers)            1
Expressway (in Kilometers)                1
Total (in 000 Nos.)                       1
Car Chassis with Engine (Numbers)         1
Others (in 000 Nos.)                      1
Tankers (Oil & Water) (in 000 Nos.)       1
Tractor (in 000 Nos.)                     1
```



### Analyzed Column Summary Table (Stats per Column: Original Columns)

```markdown
|                    | DataType   |   NonNullCount |   NullCount | NullPct   |   UniqueCount | Mean       | StdDev      | Min    | 25%     | 50%      | 75%       | Max          | Skewness   | Kurtosis   | MinDate   | MaxDate   | FirstNonNull               | LastNonNull                   |
|:-------------------|:-----------|---------------:|------------:|:----------|--------------:|:-----------|:------------|:-------|:--------|:---------|:----------|:-------------|:-----------|:-----------|:----------|:----------|:---------------------------|:------------------------------|
| Sectors            | object     |             12 |         105 | 89.74%    |            12 | N/A        | N/A         | N/A    | N/A     | N/A      | N/A       | N/A          | N/A        | N/A        | NaT       | NaT       | Transport (Roads)          | Pakistan Post Offices         |
| Sub-Sectors-Level1 | object     |            105 |          12 | 10.26%    |           100 | N/A        | N/A         | N/A    | N/A     | N/A      | N/A       | N/A          | N/A        | N/A        | NaT       | NaT       | Expressway (in Kilometers) | Number of Post Offices, Total |
| 1965-66            | float64    |             28 |          89 | 76.07%    |            27 | 30256.822  | 97295.118   | 16.000 | 179.000 | 1198.000 | 19314.250 | 516137.000   | 4.951      | 25.421     | NaT       | NaT       | 73788.0                    | 264.0                         |
| 1966-67            | float64    |             49 |          68 | 58.12%    |            48 | 29142.592  | 90878.394   | 1.000  | 42.300  | 1045.000 | 15153.000 | 593826.000   | 5.448      | 32.613     | NaT       | NaT       | 70007.0                    | 7139.0                        |
| 1967-68            | float64    |             49 |          68 | 58.12%    |            47 | 30662.074  | 95002.087   | 1.000  | 44.400  | 1097.000 | 15808.000 | 618758.000   | 5.403      | 32.132     | NaT       | NaT       | 72463.0                    | 7317.0                        |
| 1968-69            | float64    |             49 |          68 | 58.12%    |            48 | 33415.484  | 105158.685  | 1.000  | 53.200  | 1223.000 | 17519.000 | 682913.000   | 5.396      | 31.911     | NaT       | NaT       | 71428.0                    | 7582.0                        |
| 1969-70            | float64    |             49 |          68 | 58.12%    |            48 | 34635.442  | 106028.345  | 1.200  | 62.700  | 1378.000 | 18712.000 | 679692.000   | 5.232      | 30.117     | NaT       | NaT       | 72153.0                    | 7821.0                        |
| 1970-71            | float64    |             49 |          68 | 58.12%    |            48 | 38671.554  | 118787.151  | 1.200  | 59.100  | 1230.000 | 21600.000 | 749046.000   | 5.088      | 28.347     | NaT       | NaT       | 73006.0                    | 8151.0                        |
| 1971-72            | float64    |             51 |          66 | 56.41%    |            49 | 36749.215  | 106374.223  | 1.300  | 56.700  | 1271.000 | 22474.500 | 635937.000   | 4.591      | 22.750     | NaT       | NaT       | 74187.0                    | 7906.0                        |
| 1972-73            | float64    |             51 |          66 | 56.41%    |            50 | 37113.410  | 105398.146  | 1.200  | 56.800  | 1252.000 | 22839.000 | 608845.000   | 4.399      | 20.597     | NaT       | NaT       | 76029.0                    | 7860.0                        |
| 1973-74            | float64    |             51 |          66 | 56.41%    |            49 | 38235.851  | 107041.574  | 1.100  | 54.500  | 1289.000 | 25068.000 | 597685.000   | 4.262      | 19.048     | NaT       | NaT       | 76660.0                    | 7904.0                        |
| 1974-75            | float64    |             73 |          44 | 37.61%    |            71 | 29776.306  | 95993.799   | 1.400  | 52.000  | 1375.000 | 10161.000 | 602741.000   | 4.941      | 25.755     | NaT       | NaT       | 78630.0                    | 8149.0                        |
| 1975-76            | float64    |             74 |          43 | 36.75%    |            73 | 32342.480  | 103320.916  | 1.000  | 59.500  | 1890.500 | 9807.850  | 621341.000   | 4.887      | 25.000     | NaT       | NaT       | 80623.0                    | 8749.0                        |
| 1976-77            | float64    |             73 |          44 | 37.61%    |            71 | 35535.592  | 109965.734  | 2.600  | 81.600  | 2129.000 | 17771.000 | 674514.000   | 4.747      | 23.803     | NaT       | NaT       | 84589.0                    | 8043.0                        |
| 1977-78            | float64    |             73 |          44 | 37.61%    |            72 | 37988.215  | 116114.537  | 3.700  | 95.600  | 2213.000 | 15095.000 | 743402.000   | 4.745      | 24.290     | NaT       | NaT       | 85757.0                    | 9586.0                        |
| 1978-79            | float64    |             73 |          44 | 37.61%    |            71 | 42977.024  | 130906.069  | 1.000  | 50.000  | 2403.000 | 21267.000 | 876104.000   | 4.848      | 26.083     | NaT       | NaT       | 87715.0                    | 9888.0                        |
| 1979-80            | float64    |             74 |          43 | 36.75%    |            71 | 47243.394  | 146833.721  | 2.000  | 76.150  | 2781.200 | 21031.250 | 1015537.000  | 5.018      | 28.388     | NaT       | NaT       | 94173.0                    | 10488.0                       |
| 1980-81            | float64    |             73 |          44 | 37.61%    |            72 | 50984.336  | 162341.087  | 1.000  | 123.000 | 2395.000 | 15796.000 | 1109756.000  | 5.011      | 27.915     | NaT       | NaT       | 93960.0                    | 11088.0                       |
| 1981-82            | float64    |             76 |          41 | 35.04%    |            75 | 52116.017  | 173087.669  | 2.000  | 132.000 | 2667.000 | 17411.750 | 1189592.000  | 5.092      | 28.433     | NaT       | NaT       | 96859.0                    | 11238.0                       |
| 1982-83            | float64    |             83 |          34 | 29.06%    |            81 | 52493.970  | 184189.695  | 3.000  | 173.000 | 2133.000 | 16738.000 | 1338957.000  | 5.416      | 32.465     | NaT       | NaT       | 99793.0                    | 11388.0                       |
| 1983-84            | float64    |             83 |          34 | 29.06%    |            81 | 56342.972  | 199065.256  | 1.000  | 265.900 | 2450.000 | 16565.000 | 1485152.000  | 5.586      | 35.039     | NaT       | NaT       | 111916.0                   | 11528.0                       |
| 1984-85            | float64    |             82 |          35 | 29.91%    |            81 | 59932.912  | 215856.158  | 1.000  | 250.225 | 2530.500 | 14758.750 | 1659672.000  | 5.888      | 39.355     | NaT       | NaT       | 118471.0                   | 11698.0                       |
| 1985-86            | float64    |             83 |          34 | 29.06%    |            80 | 62940.680  | 235064.979  | 2.000  | 122.000 | 2321.000 | 14165.500 | 1840753.000  | 6.100      | 42.086     | NaT       | NaT       | 126243.0                   | 11898.0                       |
| 1986-87            | float64    |             80 |          37 | 31.62%    |            79 | 68665.606  | 259824.070  | 1.000  | 75.025  | 1815.500 | 13961.250 | 2017307.000  | 6.107      | 42.112     | NaT       | NaT       | 133953.0                   | 12006.0                       |
| 1987-88            | float64    |             81 |          36 | 30.77%    |            80 | 73837.353  | 280077.578  | 1.000  | 64.900  | 2788.000 | 18584.000 | 2201309.000  | 6.229      | 43.715     | NaT       | NaT       | 142941.0                   | 12116.0                       |
| 1988-89            | float64    |             80 |          37 | 31.62%    |            79 | 79973.143  | 302611.346  | 4.000  | 89.425  | 3239.500 | 20906.500 | 2369909.000  | 6.221      | 43.576     | NaT       | NaT       | 151449.0                   | 12226.0                       |
| 1989-90            | float64    |             81 |          36 | 30.77%    |            77 | 84185.289  | 321073.517  | 3.000  | 69.300  | 2008.000 | 19376.000 | 2537917.000  | 6.305      | 44.719     | NaT       | NaT       | 162345.0                   | 12193.0                       |
| 1990-91            | float64    |             80 |          37 | 31.62%    |            76 | 90017.697  | 345215.078  | 1.000  | 84.350  | 2435.500 | 20323.250 | 2712837.000  | 6.286      | 44.313     | NaT       | NaT       | 170823.0                   | 12193.0                       |
| 1991-92            | float64    |             87 |          30 | 25.64%    |            83 | 98459.190  | 370337.182  | 1.000  | 62.700  | 1627.000 | 19817.500 | 2923913.000  | 6.016      | 41.467     | NaT       | NaT       | 182709.0                   | 13413.0                       |
| 1992-93            | float64    |             82 |          35 | 29.91%    |            81 | 102090.656 | 400024.185  | 2.000  | 88.650  | 2406.150 | 22299.750 | 3179184.000  | 6.392      | 45.579     | NaT       | NaT       | 189321.0                   | 13380.0                       |
| 1993-94            | float64    |             85 |          32 | 27.35%    |            82 | 101856.569 | 415458.966  | 1.000  | 66.700  | 1394.000 | 22569.000 | 3351292.000  | 6.482      | 46.951     | NaT       | NaT       | 196817.0                   | 13196.0                       |
| 1994-95            | float64    |             83 |          34 | 29.06%    |            81 | 105651.212 | 440787.154  | 2.000  | 72.950  | 1970.000 | 23648.500 | 3537866.000  | 6.554      | 47.420     | NaT       | NaT       | 207645.0                   | 13285.0                       |
| 1995-96            | float64    |             80 |          37 | 31.62%    |            79 | 114736.361 | 465322.925  | 1.000  | 139.300 | 3015.900 | 27238.750 | 3669948.000  | 6.437      | 45.678     | NaT       | NaT       | 218344.0                   | 13320.0                       |
| 1996-97            | float64    |             84 |          33 | 28.21%    |            81 | 113821.188 | 475675.939  | 3.700  | 68.650  | 2375.000 | 26864.000 | 3838157.000  | 6.598      | 47.980     | NaT       | NaT       | 229595.0                   | 13419.0                       |
| 1997-98            | float64    |             83 |          34 | 29.06%    |            82 | 122121.707 | 519739.121  | 1.000  | 81.100  | 2024.000 | 19899.000 | 4173945.000  | 6.590      | 47.733     | NaT       | NaT       | 240885.0                   | 13216.0                       |
| 1998-99            | float64    |             83 |          34 | 29.06%    |            82 | 126148.173 | 535874.845  | 1.000  | 109.000 | 3281.000 | 27068.000 | 4303296.000  | 6.595      | 47.754     | NaT       | NaT       | 247484.0                   | 13294.0                       |
| 1999-00            | float64    |             87 |          30 | 25.64%    |            85 | 126540.351 | 554223.191  | 1.000  | 72.450  | 2469.000 | 28183.500 | 4559490.000  | 6.778      | 50.427     | NaT       | NaT       | 240340.0                   | 12854.0                       |
| 2000-01            | float64    |             88 |          29 | 24.79%    |            85 | 129187.601 | 568520.733  | 1.700  | 72.400  | 2198.450 | 27624.000 | 4701596.000  | 6.822      | 51.021     | NaT       | NaT       | 249972.0                   | 12828.0                       |
| 2001-02            | float64    |             87 |          30 | 25.64%    |            86 | 132426.505 | 589592.939  | 1.000  | 105.800 | 2385.000 | 23378.000 | 4843702.000  | 6.783      | 50.361     | NaT       | NaT       | 251661.0                   | 12233.0                       |
| 2002-03            | float64    |             88 |          29 | 24.79%    |            87 | 138007.803 | 609586.896  | 1.000  | 125.300 | 3050.000 | 29334.750 | 5048549.000  | 6.842      | 51.292     | NaT       | NaT       | 252168.0                   | 12267.0                       |
| 2003-04            | float64    |             88 |          29 | 24.79%    |            87 | 145507.361 | 620564.116  | 2.000  | 145.000 | 2882.750 | 36858.500 | 5132037.000  | 6.785      | 50.724     | NaT       | NaT       | 256070.0                   | 12254.0                       |
| 2004-05            | float64    |             88 |          29 | 24.79%    |            87 | 156604.414 | 657271.165  | 4.500  | 171.450 | 3787.000 | 44608.750 | 5395731.000  | 6.696      | 49.425     | NaT       | NaT       | 258214.0                   | 12107.0                       |
| 2005-06            | float64    |             89 |          28 | 23.93%    |            87 | 165277.992 | 682483.705  | 4.500  | 315.000 | 4971.000 | 36563.000 | 5633353.000  | 6.696      | 49.705     | NaT       | NaT       | 259021.0                   | 12330.0                       |
| 2006-07            | float64    |             90 |          27 | 23.08%    |            89 | 173964.926 | 712587.195  | 1.000  | 451.750 | 5146.500 | 30781.500 | 5907813.000  | 6.709      | 49.992     | NaT       | NaT       | 259197.0                   | 12342.0                       |
| 2007-08            | float64    |             89 |          28 | 23.93%    |            89 | 188118.525 | 755100.616  | 1.000  | 311.000 | 5037.000 | 38249.000 | 6201755.000  | 6.589      | 48.478     | NaT       | NaT       | 259038.0                   | 12366.0                       |
| 2008-09            | float64    |             89 |          28 | 23.93%    |            87 | 190229.657 | 794765.913  | 2.000  | 155.600 | 3135.000 | 42966.000 | 6559364.000  | 6.710      | 49.792     | NaT       | NaT       | 260200.0                   | 12035.0                       |
| 2009-10            | float64    |             88 |          29 | 24.79%    |            88 | 234819.910 | 976162.193  | 1.000  | 171.150 | 6284.500 | 73760.000 | 7853002.000  | 6.505      | 46.401     | NaT       | NaT       | 260040.0                   | 12035.0                       |
| 2010-11            | float64    |             88 |          29 | 24.79%    |            88 | 281566.406 | 1217289.537 | 3.000  | 174.800 | 6097.500 | 79344.750 | 9660995.000  | 6.505      | 45.497     | NaT       | NaT       | 259463.0                   | 12035.0                       |
| 2011-12            | float64    |             89 |          28 | 23.93%    |            88 | 338433.085 | 1498051.115 | 1.000  | 230.500 | 7791.000 | 73809.000 | 11788569.000 | 6.489      | 44.811     | NaT       | NaT       | 259463.0                   | 12035.0                       |
| 2012-13            | float64    |             84 |          33 | 28.21%    |            81 | 387515.883 | 1812970.077 | 1.000  | 223.875 | 5750.000 | 37098.000 | 13784931.000 | 6.396      | 42.663     | NaT       | NaT       | 522.0                      | 12828.0                       |
| 2013-14            | float64    |             88 |          29 | 24.79%    |            86 | 419597.668 | 2068866.810 | 1.000  | 165.850 | 4223.000 | 33189.750 | 15940561.000 | 6.551      | 44.364     | NaT       | NaT       | 493.0                      | 12077.0                       |
| 2014-15            | float64    |             89 |          28 | 23.93%    |            87 | 489476.137 | 2406576.506 | 2.000  | 190.000 | 4820.000 | 48883.000 | 18502109.000 | 6.547      | 44.206     | NaT       | NaT       | 421.0                      | 12077.0                       |
| 2015-16            | float64    |             92 |          25 | 21.37%    |            89 | 530422.202 | 2711179.529 | 0.000  | 181.450 | 5898.850 | 43794.250 | 21067850.000 | 6.678      | 45.704     | NaT       | NaT       | 458.0                      | 11744.0                       |
| 2016-17            | float64    |             90 |          27 | 23.08%    |            89 | 614044.913 | 3115271.046 | 1.000  | 180.300 | 7209.000 | 53076.250 | 23812676.000 | 6.585      | 44.288     | NaT       | NaT       | 460.0                      | 11496.0                       |
| 2017-18            | float64    |             90 |          27 | 23.08%    |            88 | 692237.467 | 3491279.116 | 2.000  | 189.825 | 6773.250 | 60851.750 | 26566167.000 | 6.563      | 43.939     | NaT       | NaT       | 455.0                      | 11496.0                       |
| 2018-19            | float64    |             86 |          31 | 26.50%    |            85 | 770828.353 | 3928416.116 | 1.000  | 207.925 | 7277.400 | 53489.250 | 29137562.000 | 6.437      | 41.992     | NaT       | NaT       | 478.0                      | 10069.0                       |
| 2019-20            | float64    |             86 |          31 | 26.50%    |            85 | 786398.249 | 4152714.183 | 1.000  | 242.025 | 6101.500 | 53138.750 | 30757539.000 | 6.475      | 42.268     | NaT       | NaT       | 472.0                      | 10145.0                       |
| 2020-21            | float64    |             96 |          21 | 17.95%    |            93 | 775784.802 | 4238797.961 | 1.000  | 173.275 | 4324.500 | 50618.750 | 33033662.000 | 6.829      | 47.143     | NaT       | NaT       | 460.0                      | 9586.0                        |
| 2021-22            | float64    |             94 |          23 | 19.66%    |            93 | 810517.463 | 4535732.373 | 1.000  | 194.725 | 5181.500 | 57422.250 | 34958781.000 | 6.781      | 46.318     | NaT       | NaT       | 428.0                      | 10191.0                       |
| 2022-23            | float64    |             92 |          25 | 21.37%    |            91 | 848604.926 | 4692516.555 | 2.000  | 230.725 | 7930.500 | 57706.250 | 35765658.000 | 6.708      | 45.274     | NaT       | NaT       | 428.0                      | 10024.0                       |
| 2023-24            | float64    |             91 |          26 | 22.22%    |            90 | 844143.309 | 4776543.078 | 1.000  | 220.250 | 5037.000 | 66468.000 | 35506571.000 | 6.618      | 43.745     | NaT       | NaT       | 428.0                      | 10371.0                       |
```


### High Correlation Pairs (|Correlation| > 0.8 between Numeric Analyzed Columns)

*Found 1248 pairs with absolute correlation > 0.8 (showing top 50):*
```
1997-98  1998-99    0.999967
1998-99  1999-00    0.999933
1995-96  1996-97    0.999933
1997-98  1999-00    0.999931
1999-00  2000-01    0.999928
2015-16  2016-17    0.999916
1966-67  1967-68    0.999913
1989-90  1990-91    0.999900
1998-99  2000-01    0.999867
2019-20  2020-21    0.999865
1987-88  1988-89    0.999860
1997-98  2000-01    0.999850
2000-01  2001-02    0.999848
1996-97  1997-98    0.999821
2001-02  2002-03    0.999818
2016-17  2017-18    0.999812
2000-01  2002-03    0.999808
1995-96  1997-98    0.999762
1999-00  2001-02    0.999757
1988-89  1989-90    0.999757
1967-68  1968-69    0.999738
1996-97  1998-99    0.999728
1990-91  1993-94    0.999727
1998-99  2001-02    0.999715
1994-95  1995-96    0.999711
         1996-97    0.999703
2016-17  2018-19    0.999688
1994-95  1997-98    0.999686
1995-96  1998-99    0.999675
1999-00  2002-03    0.999662
2019-20  2022-23    0.999651
1997-98  2001-02    0.999641
1994-95  1998-99    0.999638
2012-13  2013-14    0.999636
1992-93  1993-94    0.999627
1996-97  1999-00    0.999625
2018-19  2020-21    0.999600
2005-06  2006-07    0.999587
2004-05  2005-06    0.999578
2015-16  2017-18    0.999575
1966-67  1968-69    0.999568
1990-91  1992-93    0.999557
2017-18  2018-19    0.999557
1995-96  1999-00    0.999547
2015-16  2018-19    0.999527
1996-97  2000-01    0.999521
1998-99  2002-03    0.999517
1997-98  2002-03    0.999500
1994-95  1999-00    0.999489
2014-15  2015-16    0.999481
```


---
